import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../domain/entities/user.dart';
import '../providers/user_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isSignUp = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleAuth() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    if (_isSignUp && _nameController.text.isEmpty) {
      _showError('Please enter your name');
      return;
    }

    setState(() => _isLoading = true);
    HapticFeedback.mediumImpact();

    try {
      // Create a user (in a real app, this would call an auth service)
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: _emailController.text.trim(),
        name: _isSignUp ? _nameController.text.trim() : _emailController.text.split('@').first,
        createdAt: DateTime.now(),
      );

      // Login the user
      await ref.read(currentUserProvider.notifier).login(user);

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      _showError('Authentication failed: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // Background gradients
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.sage500.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.screenPaddingH),
              child: Column(
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.glassBackground,
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.textMuted,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Auth Card
                  GlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Logo
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primary.withValues(alpha: 0.2),
                                Colors.transparent,
                              ],
                            ),
                            border: Border.all(
                              color: AppColors.glassBorder,
                            ),
                          ),
                          child: const Icon(
                            Icons.spa,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Title
                        const Text(
                          'Mood Holder',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isSignUp
                              ? 'Create an account to sync your data'
                              : 'Sign in to sync across devices',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textMuted.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Name field (only for sign up)
                        if (_isSignUp) ...[
                          _buildTextField(
                            controller: _nameController,
                            icon: Icons.person_outline,
                            hint: 'Your name',
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Email field
                        _buildTextField(
                          controller: _emailController,
                          icon: Icons.mail_outline,
                          hint: 'name@example.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        // Password field
                        _buildTextField(
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          hint: 'Enter your password',
                          isPassword: true,
                          isPasswordVisible: _isPasswordVisible,
                          onTogglePassword: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),

                        // Forgot password
                        if (!_isSignUp) ...[
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                // TODO: Implement forgot password
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary.withValues(alpha: 0.9),
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),

                        // Primary button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleAuth,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.darkBg,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.darkBg,
                                    ),
                                  )
                                : Text(
                                    _isSignUp ? 'Create Account' : 'Log In',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Secondary button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _isSignUp = !_isSignUp;
                                    });
                                  },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: BorderSide(
                                color: AppColors.glassBorder,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              _isSignUp ? 'Already have an account' : 'Create Account',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Terms
                        Text.rich(
                          TextSpan(
                            text: 'By signing in, you agree to our ',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted.withValues(alpha: 0.5),
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms',
                                style: TextStyle(
                                  color: AppColors.textMuted.withValues(alpha: 0.7),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: AppColors.textMuted.withValues(alpha: 0.7),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withValues(alpha: 0.2),
        border: Border.all(
          color: AppColors.glassBorder,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword && !isPasswordVisible,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.textMuted.withValues(alpha: 0.5),
            fontWeight: FontWeight.w300,
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.textMuted.withValues(alpha: 0.5),
            size: 20,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.textMuted.withValues(alpha: 0.5),
                    size: 20,
                  ),
                  onPressed: onTogglePassword,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
