enum ManifestWidgetPlacement {
  top,
  centerOverlay,
  centerModal,
  fieldInline,
}

extension ManifestWidgetPlacementName on ManifestWidgetPlacement {
  String get label {
    switch (this) {
      case ManifestWidgetPlacement.top:
        return 'top';
      case ManifestWidgetPlacement.centerOverlay:
        return 'center-overlay';
      case ManifestWidgetPlacement.centerModal:
        return 'center-modal';
      case ManifestWidgetPlacement.fieldInline:
        return 'field-inline';
    }
  }
}
