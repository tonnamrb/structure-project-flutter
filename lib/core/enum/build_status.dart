enum BuildStatus {
  built,
  skipped,
  failed,
  insufficientSpec,
}

extension BuildStatusName on BuildStatus {
  String get label {
    switch (this) {
      case BuildStatus.built:
        return 'BUILT';
      case BuildStatus.skipped:
        return 'SKIPPED';
      case BuildStatus.failed:
        return 'FAILED';
      case BuildStatus.insufficientSpec:
        return 'INSUFFICIENT_SPEC';
    }
  }
}
