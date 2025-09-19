import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/config/app_color.dart';
import '../../core/config/app_image.dart';

// Shared Widgets for WG-xx types

// App logo with consistent sizing and crisp scaling
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 56});
  final double height;

  @override
  Widget build(BuildContext context) {
    // WG-xx: Use PNG logo directly without extra processing
    return Image.asset(
      AppImage.logo,
      height: height,
      fit: BoxFit.contain,
    );
  }
}

// Centered page container with max width, consistent outer padding
class PageContainer extends StatelessWidget {
  const PageContainer({
    super.key,
    required this.child,
    this.maxWidth = 480,
    this.padding = const EdgeInsets.all(24),
    this.centerVertically = false,
  });
  final Widget child;
  final double maxWidth;
  final EdgeInsets padding;
  final bool centerVertically;

  @override
  Widget build(BuildContext context) {
    final constrained = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );

    if (centerVertically) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: padding,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(child: constrained),
            ),
          );
        },
      );
    }

    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}

// Card-like section with surface/background, border and radius
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
  });
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.divider),
      ),
      child: child,
    );
  }
}

// Simple placeholder square icon used in wireframes
class PlaceholderBoxIcon extends StatelessWidget {
  const PlaceholderBoxIcon({super.key, this.size = 20, this.color});
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.onSurface;
    final c = color ?? base.withValues(alpha: 0.6);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: c),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// Google auth style button (white surface, thin border, left icon)
class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key, required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(
        AppImage.googleSignup,
        width: 18,
        height: 18,
        filterQuality: FilterQuality.high,
      ),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: t.surface,
        foregroundColor: t.textPrimary,
        alignment: Alignment.centerLeft,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

enum ToastIcon { check, close }

// WG-02/03/04 toast helper
void showToast(
  String message, {
  String? title,
  ToastIcon icon = ToastIcon.close,
}) {
  final ctx = Get.context;
  if (ctx == null) {
    // Fallback
    Get.snackbar(title ?? 'Info', message);
    return;
  }
  final t = tokensOf(ctx);
  Get.showSnackbar(
    GetSnackBar(
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      backgroundColor: t.toastBg,
      messageText: Row(
        children: [
          Image.asset(
            icon == ToastIcon.check ? AppImage.check : AppImage.close,
            width: 20,
            height: 20,
            colorBlendMode: BlendMode.srcIn,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message, style: TextStyle(color: t.onToast)),
          ),
        ],
      ),
    ),
  );
}

// WG-05 popup: Cancel (left) + Try again (right)
Future<void> showPopupTryAgainCancel({
  String? title,
  required String message,
  String cancelText = 'Cancel',
  String confirmText = 'Try again',
  VoidCallback? onConfirm,
}) async {
  final ctx = Get.context;
  if (ctx == null) return;
  await Get.dialog(
    AlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text(cancelText)),
        FilledButton(
          onPressed: () {
            Get.back();
            onConfirm?.call();
          },
          child: Text(confirmText),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}

// WG-09 popup: OK (single centered)
Future<void> showOkPopup({
  String? title,
  required String message,
  String okText = 'OK',
}) async {
  final ctx = Get.context;
  if (ctx == null) return;
  await Get.dialog(
    AlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actionsAlignment: MainAxisAlignment.center,
      actions: [FilledButton(onPressed: () => Get.back(), child: Text(okText))],
    ),
    barrierDismissible: true,
  );
}

// WG-08 processing modal
void showProcessingModal(String message) {
  final ctx = Get.context;
  if (ctx == null) return;
  final t = tokensOf(ctx);
  Get.dialog(
    Dialog(
      insetPadding: const EdgeInsets.all(40),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Per spec: WG-08 uses close icon (PNG asset)
            Image.asset(
              AppImage.close,
              width: 20,
              height: 20,
              colorBlendMode: BlendMode.srcIn,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(message, style: TextStyle(color: t.textPrimary)),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

void hideDialogIfAny() {
  if (Get.isDialogOpen == true) Get.back();
}

// WG-04 (Toast with Retry button on the right, no icon)
void showAuthFailedToastWithRetry(String message, {VoidCallback? onRetry}) {
  final ctx = Get.context;
  if (ctx == null) {
    Get.snackbar('Error', message);
    return;
  }
  final t = tokensOf(ctx);
  Get.showSnackbar(
    GetSnackBar(
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      backgroundColor: t.toastBg,
      messageText: Row(
        children: [
          // Per spec: WG-04 still no icon; keep as-is
          Expanded(
            child: Text(message, style: TextStyle(color: t.onToast)),
          ),
          TextButton(
            onPressed: onRetry ?? () {},
            style: TextButton.styleFrom(foregroundColor: t.onToast),
            child: Text('retry'.tr),
          ),
        ],
      ),
    ),
  );
}

// Convenience wrapper for WG-02 success toast
void showSuccessToast(String message) =>
    showToast(message, icon: ToastIcon.check);

// WG-01: Google Sign-In Consent popup (overlay with fade scrim)
Future<void> showGoogleConsentPopup({
  required VoidCallback onContinue,
  required VoidCallback onCancel,
}) async {
  final ctx = Get.context;
  if (ctx == null) return;
  final t = tokensOf(ctx);
  await Get.generalDialog(
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    barrierDismissible: true,
    barrierLabel: 'consent',
    barrierColor: t.overlayScrim,
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: (context, animation, _, __) {
      final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return FadeTransition(
        opacity: fade,
        child: Center(
          child: Material(
            color: Theme.of(ctx).colorScheme.surface,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '“Re:Play” wants to use “Google.com” to Sign Up',
                      textAlign: TextAlign.center,
                      style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This allows the app and website to share information about you',
                      textAlign: TextAlign.center,
                      style: Theme.of(ctx)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: t.textSecondary),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Get.back();
                              onCancel();
                            },
                            child: Text('cancel'.tr),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              onContinue();
                            },
                            child: Text('continue'.tr),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

// end WG-01 popup
