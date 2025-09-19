import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/config/app_color.dart';
import '../../core/enum/widget_type.dart';
import '../widget/manifest_widget_registry.dart';
import '../widget/manifest_widget_spec.dart';

class ManifestWidgetRenderer {
  ManifestWidgetRenderer._();

  static void show(
    String id, {
    Map<String, VoidCallback> actionHandlers = const {},
  }) {
    final spec = ManifestWidgetRegistry.find(id);
    if (spec == null) {
      Get.log('Manifest widget not found for id=$id');
      return;
    }
    switch (spec.type) {
      case ManifestWidgetType.toast:
        _showToast(spec);
        break;
      case ManifestWidgetType.popup:
        _showPopup(spec, actionHandlers);
        break;
      case ManifestWidgetType.modal:
      case ManifestWidgetType.inline:
        _showPopup(spec, actionHandlers);
        break;
    }
  }

  static void _showToast(ManifestWidgetSpec spec) {
    final theme = Get.theme;
    final tokens = theme.brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;
    final margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 20);
    Get.closeAllSnackbars();
    Get.rawSnackbar(
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: tokens.onPrimary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '?',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: tokens.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              spec.messageKey.tr,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: tokens.toastText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: tokens.toastBackground,
      margin: margin,
      borderRadius: 24,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  static void _showPopup(
    ManifestWidgetSpec spec,
    Map<String, VoidCallback> handlers,
  ) {
    final theme = Get.theme;
    final tokens = theme.brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        backgroundColor: tokens.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Get.back<void>(),
                  icon: const Icon(Icons.close),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                spec.messageKey.tr,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (spec.actions.isNotEmpty) ...[
                const SizedBox(height: 24),
                for (final action in spec.actions)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final handler = handlers[action.id];
                          if (handler != null) {
                            handler();
                          }
                          if (Get.isDialogOpen ?? false) {
                            Get.back<void>();
                          }
                        },
                        child: Text(action.labelKey.tr),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
      barrierColor: tokens.overlay,
    );
  }
}
