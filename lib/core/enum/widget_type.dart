enum ManifestWidgetType {
  toast,
  popup,
  modal,
  inline,
}

extension ManifestWidgetTypeName on ManifestWidgetType {
  String get label => name.toUpperCase();
}
