import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:structure_project_flutter/app/controllers/set_password_controller.dart';
import 'package:structure_project_flutter/core/config/app_translation.dart';
import 'package:structure_project_flutter/presentation/page/set_password/set_password_page.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('SetPasswordPage shows requirements and PDPA controls', (tester) async {
    final controller = Get.put(SetPasswordController());

    await tester.pumpWidget(
      GetMaterialApp(
        translations: AppTranslation(),
        locale: const Locale('en', 'US'),
        home: const SetPasswordPage(),
      ),
    );

    expect(find.text('password.conditions.title'.tr), findsOneWidget);
    expect(find.text('password.conditions.length'.tr), findsOneWidget);
    expect(find.text('password.conditions.mix'.tr), findsOneWidget);
    expect(find.text('password.acceptPolicy'.tr), findsOneWidget);
    expect(find.text('password.viewPdpa'.tr), findsOneWidget);

    // Initially requirements not satisfied.
    expect(find.byIcon(Icons.radio_button_unchecked), findsNWidgets(2));

    final passwordField = find.byType(TextField).first;
    await tester.enterText(passwordField, 'Ab1!pass');
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.check_circle), findsNWidgets(2));

    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();
    expect(controller.isPdpaAccepted.value, isTrue);
  });
}
