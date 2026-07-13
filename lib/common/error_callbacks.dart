class ErrorCallbacks {
  Function()? onTokenExpired;
  Function(String message)? onAuthError;
  Function()? onRateLimit;
  Function(String permission)? onPermissionMissing;
}
