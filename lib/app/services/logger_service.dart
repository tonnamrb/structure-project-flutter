class LoggerService {
  void log(String message, {Object? error, StackTrace? stackTrace}) {
    // Using print for simplicity; in production integrate with a logging backend.
    final buffer = StringBuffer('[LOG] $message');
    if (error != null) {
      buffer.write(' | error: $error');
    }
    if (stackTrace != null) {
      buffer.write(' | stackTrace: $stackTrace');
    }
    // ignore: avoid_print
    print(buffer.toString());
  }
}
