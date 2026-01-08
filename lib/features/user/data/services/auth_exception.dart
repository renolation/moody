/// Exception thrown when an authentication operation fails.
class AppAuthException implements Exception {
  final String message;
  final String? code;

  AppAuthException(this.message, [this.code]);

  @override
  String toString() => 'AppAuthException: $message';

  /// Map error codes to user-friendly messages.
  static String friendlyMessage(dynamic error) {
    if (error is AppAuthException) {
      return _mapCodeToMessage(error.code, error.message);
    }

    final errorString = error.toString().toLowerCase();

    // Map common Supabase auth errors
    if (errorString.contains('invalid login credentials') ||
        errorString.contains('invalid_credentials')) {
      return 'Invalid email or password';
    }
    if (errorString.contains('user already registered') ||
        errorString.contains('user_already_exists')) {
      return 'An account with this email already exists';
    }
    if (errorString.contains('password') && errorString.contains('weak')) {
      return 'Password must be at least 6 characters';
    }
    if (errorString.contains('email') && errorString.contains('invalid')) {
      return 'Please enter a valid email address';
    }
    if (errorString.contains('network') ||
        errorString.contains('connection') ||
        errorString.contains('socket')) {
      return 'Unable to connect. Please check your internet connection';
    }
    if (errorString.contains('rate limit')) {
      return 'Too many attempts. Please try again later';
    }

    return 'An unexpected error occurred. Please try again';
  }

  static String _mapCodeToMessage(String? code, String fallback) {
    switch (code) {
      case 'invalid_credentials':
        return 'Invalid email or password';
      case 'user_already_exists':
        return 'An account with this email already exists';
      case 'weak_password':
        return 'Password must be at least 6 characters';
      case 'invalid_email':
        return 'Please enter a valid email address';
      case 'network_error':
        return 'Unable to connect. Please check your internet connection';
      case 'rate_limit':
        return 'Too many attempts. Please try again later';
      default:
        return fallback;
    }
  }
}
