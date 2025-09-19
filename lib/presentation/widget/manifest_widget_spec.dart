import '../../core/enum/widget_placement.dart';
import '../../core/enum/widget_type.dart';

class ManifestWidgetAction {
  const ManifestWidgetAction({required this.id, required this.labelKey});

  final String id;
  final String labelKey;
}

class ManifestWidgetSpec {
  const ManifestWidgetSpec({
    required this.id,
    required this.type,
    required this.placement,
    required this.messageKey,
    this.iconAsset,
    this.actions = const <ManifestWidgetAction>[],
  });

  final String id;
  final ManifestWidgetType type;
  final ManifestWidgetPlacement placement;
  final String messageKey;
  final String? iconAsset;
  final List<ManifestWidgetAction> actions;
}
