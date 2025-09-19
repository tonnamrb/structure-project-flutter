import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:app/presentation/widget/shared_widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('WG-01 shows as overlay with visible background', (tester) async {
    // Build a minimal app scaffold with a button that shows the consent popup
    await tester.pumpWidget(GetMaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => showGoogleConsentPopup(
              onContinue: () {},
              onCancel: () {},
            ),
            child: const Text('Sign up with Google'),
          ),
        ),
      ),
    ));

    // Tap to trigger WG-01
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // start dialog animation
    await tester.pump(const Duration(milliseconds: 200)); // finish animation

    // Expect the consent text and buttons
    expect(find.textContaining('wants to use'), findsOneWidget);
    expect(find.textContaining('share information'), findsOneWidget);
    expect(find.text('continue'.tr), findsOneWidget);
    expect(find.text('cancel'.tr), findsOneWidget);

    // Background should still be present (button behind dialog exists in tree)
    expect(find.text('Sign up with Google'), findsOneWidget);
  });
}
