import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../../../core/data/mock_data_initializer.dart';
import '../../../user/presentation/providers/user_provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final currentUserAsync = ref.watch(currentUserProvider);
    final currentUser = currentUserAsync.valueOrNull;

    return SafeArea(
      child: settingsAsync.when(
        data: (settings) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingH,
            vertical: AppDimensions.spacingLg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
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
                  const SizedBox(width: 16),
                  const Text(
                    AppStrings.settings,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spacingXl),

              // Profile Card
              if (currentUser != null)
                // Logged in - show user info
                GlassPanel(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.accent,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.darkBg,
                          ),
                          child: currentUser.avatarUrl != null
                              ? ClipOval(
                                  child: Image.network(
                                    currentUser.avatarUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(
                                  Icons.person,
                                  color: AppColors.textSecondary,
                                  size: 32,
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              currentUser.email,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textMuted.withValues(alpha: 0.7),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.cloud_done,
                                  size: 14,
                                  color: AppColors.primary.withValues(alpha: 0.8),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Syncing to cloud',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Logout button
                      GestureDetector(
                        onTap: () => _showLogoutDialog(context, ref),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.error.withValues(alpha: 0.1),
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: AppColors.error,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                // Not logged in - show sign in prompt
                GestureDetector(
                  onTap: () => context.push('/auth'),
                  child: GlassPanel(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // Cloud icon
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(alpha: 0.1),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Icon(
                            Icons.cloud_outlined,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sign in to sync',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'Backup your data across devices',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textMuted.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primary,
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkBg,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: AppDimensions.spacingXl),

              // Integrations Section
              _SectionHeader(title: AppStrings.integrations),
              const SizedBox(height: AppDimensions.spacingSm),
              GlassPanel(
                padding: EdgeInsets.zero,
                child: _SettingsToggle(
                  icon: Icons.favorite,
                  iconColor: Colors.redAccent,
                  title: AppStrings.healthSync,
                  value: settings.healthSyncEnabled,
                  onChanged: (value) {
                    ref.read(settingsProvider.notifier).toggleHealthSync(value);
                  },
                ),
              ),
              const SizedBox(height: AppDimensions.spacingXl),

              // Notifications Section
              _SectionHeader(title: AppStrings.notifications),
              const SizedBox(height: AppDimensions.spacingSm),
              GlassPanel(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _SettingsTimePicker(
                      icon: Icons.format_quote,
                      iconColor: Colors.amber,
                      title: AppStrings.dailyQuoteTime,
                      hour: settings.dailyQuoteHour,
                      minute: settings.dailyQuoteMinute,
                      onChanged: (hour, minute) {
                        ref
                            .read(settingsProvider.notifier)
                            .updateDailyQuoteTime(hour, minute);
                      },
                    ),
                    Container(
                      height: 1,
                      color: AppColors.glassHighlight,
                    ),
                    _SettingsTimePicker(
                      icon: Icons.mood,
                      iconColor: Colors.purple,
                      title: AppStrings.moodReminder,
                      hour: settings.moodReminderHour,
                      minute: settings.moodReminderMinute,
                      onChanged: (hour, minute) {
                        ref
                            .read(settingsProvider.notifier)
                            .updateMoodReminderTime(hour, minute);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spacingXl),

              // Data & Privacy Section
              _SectionHeader(title: AppStrings.dataPrivacy),
              const SizedBox(height: AppDimensions.spacingSm),
              GlassPanel(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _SettingsButton(
                      icon: Icons.download,
                      iconColor: Colors.blue,
                      title: AppStrings.exportData,
                      onTap: () => _exportData(context),
                    ),
                    Container(
                      height: 1,
                      color: AppColors.glassHighlight,
                    ),
                    _SettingsButton(
                      icon: Icons.cleaning_services,
                      iconColor: AppColors.textMuted,
                      title: AppStrings.clearCache,
                      trailing: '14 MB',
                      onTap: () => _clearCache(context, ref),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spacingXl),

              // Developer Section
              _SectionHeader(title: 'DEVELOPER'),
              const SizedBox(height: AppDimensions.spacingSm),
              GlassPanel(
                padding: EdgeInsets.zero,
                child: _SettingsButton(
                  icon: Icons.science,
                  iconColor: Colors.orange,
                  title: 'Load Demo Data',
                  onTap: () => _loadDemoData(context, ref),
                ),
              ),
              const SizedBox(height: AppDimensions.spacingXxl),

              // Version
              Center(
                child: Text(
                  '${AppStrings.appName} ${AppStrings.appVersion}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted.withValues(alpha: 0.4),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacingXl),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.sage500),
        ),
        error: (error, stackTrace) => const Center(
          child: Text(
            'Failed to load settings',
            style: TextStyle(color: AppColors.textMuted),
          ),
        ),
      ),
    );
  }

  Future<void> _exportData(BuildContext context) async {
    HapticFeedback.lightImpact();

    try {
      final buffer = StringBuffer();
      buffer.writeln('Type,Date,Time,Value,Note');
      buffer.writeln('// Export feature - connect to API when ready');

      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/mood_holder_export.csv');
      await file.writeAsString(buffer.toString());

      await Share.shareXFiles([XFile(file.path)], text: 'Mood Holder Data Export');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _loadDemoData(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.darkBgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Load Demo Data?',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'This will add sample moods, activities, and gratitude entries to help you explore the app.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Load',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    HapticFeedback.mediumImpact();

    // Show loading snackbar instead of dialog to avoid navigator issues
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 16),
            Text('Loading demo data...'),
          ],
        ),
        backgroundColor: AppColors.sage600,
        duration: Duration(seconds: 10),
      ),
    );

    try {
      await initializeMockData();

      if (context.mounted) {
        // Clear loading snackbar and show success
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        // Invalidate providers to refresh data
        ref.invalidate(settingsProvider);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Demo data loaded successfully!'),
            backgroundColor: AppColors.sage600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load demo data: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _clearCache(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkBgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Clear Cache?',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'This will clear temporary data. Your mood logs and settings will be preserved.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Clear',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Cache cleared'),
          backgroundColor: AppColors.sage600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.darkBgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Sign Out?',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'Your data will still be stored locally. Sign in again to sync across devices.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Sign Out',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      HapticFeedback.mediumImpact();
      await ref.read(currentUserProvider.notifier).signOut();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Signed out successfully'),
            backgroundColor: AppColors.sage600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textMuted.withValues(alpha: 0.6),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  const _SettingsToggle({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: iconColor.withValues(alpha: 0.1),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primary;
              }
              return Colors.grey;
            }),
          ),
        ],
      ),
    );
  }
}

class _SettingsTimePicker extends StatelessWidget {
  const _SettingsTimePicker({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.hour,
    required this.minute,
    required this.onChanged,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final int hour;
  final int minute;
  final void Function(int hour, int minute) onChanged;

  String get _formattedTime {
    final h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final m = minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $period';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: hour, minute: minute),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primary,
                  surface: AppColors.darkBgSecondary,
                ),
              ),
              child: child!,
            );
          },
        );
        if (time != null) {
          onChanged(time.hour, time.minute);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: iconColor.withValues(alpha: 0.1),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _formattedTime,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: iconColor.withValues(alpha: 0.1),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted.withValues(alpha: 0.5),
                ),
              )
            else
              const Icon(
                Icons.chevron_right,
                color: AppColors.textMuted,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
