import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:structure_project_flutter/app/controllers/register_controller.dart';
import 'package:structure_project_flutter/app/services/auth_service.dart';
import 'package:structure_project_flutter/core/config/app_translation.dart';
import 'package:structure_project_flutter/presentation/page/register/register_page.dart';

import '../../../mocks.dart';

const _kTransparentImage = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
];
final ByteData _transparentImageData =
    ByteData.view(Uint8List.fromList(_kTransparentImage).buffer);
final StandardMessageCodec _standardCodec = const StandardMessageCodec();
final StringCodec _stringCodec = const StringCodec();
final Map<String, List<Map<String, Object?>>> _assetManifest = <String, List<Map<String, Object?>>>{
  'assets/images/logo_ams.png': <Map<String, Object?>>[{'asset': 'assets/images/logo_ams.png', 'dpr': 1.0}],
  'assets/icons/ic_google.png': <Map<String, Object?>>[{'asset': 'assets/icons/ic_google.png', 'dpr': 1.0}],
  'assets/icons/ic_facebook.png': <Map<String, Object?>>[{'asset': 'assets/icons/ic_facebook.png', 'dpr': 1.0}],
};

Future<ByteData?> _mockAssetHandler(ByteData? message) async {
  final assetKey = _stringCodec.decodeMessage(message) as String?;
  if (assetKey == null) {
    return null;
  }
  if (assetKey.endsWith('.png')) {
    return _transparentImageData;
  }
  if (assetKey == 'AssetManifest.bin') {
    return _standardCodec.encodeMessage(_assetManifest);
  }
  if (assetKey == 'AssetManifest.json') {
    final bytes = utf8.encode(json.encode(_assetManifest));
    return ByteData.view(Uint8List.fromList(bytes).buffer);
  }
  if (assetKey == 'FontManifest.json') {
    final bytes = utf8.encode('[]');
    return ByteData.view(Uint8List.fromList(bytes).buffer);
  }
  if (assetKey == 'NOTICES.Z') {
    return ByteData(0);
  }
  return _transparentImageData;
}

late BinaryMessenger _binaryMessenger;

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    _binaryMessenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    _binaryMessenger.setMockMessageHandler('flutter/assets', _mockAssetHandler);
    Get.testMode = true;
  });

  tearDown(() {
    _binaryMessenger.setMockMessageHandler('flutter/assets', null);
    Get.reset();
  });

  testWidgets('RegisterPage renders channel toggle and social actions', (tester) async {
    final mockAuth = MockAuthService();
    when(() => mockAuth.sendOtp(channel: any(named: 'channel'), value: any(named: 'value')))
        .thenAnswer((_) async {});

    Get.put<AuthService>(mockAuth);
    Get.put(RegisterController(authService: mockAuth));
    Get.updateLocale(const Locale('en', 'US'));

    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      GetMaterialApp(
        translations: AppTranslation(),
        locale: const Locale('en', 'US'),
        home: const RegisterPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('register.email'.tr), findsWidgets);
    expect(find.text('register.phone'.tr), findsWidgets);
    expect(find.text('register.sendOtp'.tr), findsOneWidget);
    expect(find.text('register.google'.tr), findsOneWidget);
    expect(find.text('register.facebook'.tr), findsOneWidget);
  });
}

