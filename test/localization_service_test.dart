import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/local/my_shared_pref.dart';
import 'package:getx_skeleton/config/translations/localization_service.dart';
import 'package:getx_skeleton/config/translations/strings_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Get.testMode = true;
  });

  SharedPreferences.setMockInitialValues(<String, Object>{});
  await MySharedPref.init();

  test('check if language is supported', () {
    expect(LocalizationService.isLanguageSupported('en'), true);
    expect(LocalizationService.isLanguageSupported('ja'), true);
    expect(LocalizationService.isLanguageSupported('fr'), false);
  });

  test('check getting and updating current locale', () async {
    await LocalizationService.updateLanguage('en');
    Locale currentLocale = LocalizationService.getCurrentLocal();
    expect(currentLocale.languageCode, 'en');

    await LocalizationService.updateLanguage('ja');
    Locale currentLocaleAfterUpdate = LocalizationService.getCurrentLocal();
    expect(currentLocaleAfterUpdate.languageCode, 'ja');
  });

  test('check if current language is English', () async {
    await LocalizationService.updateLanguage('en');
    expect(LocalizationService.isItEnglish(), true);

    await LocalizationService.updateLanguage('ja');
    expect(LocalizationService.isItEnglish(), false);
  });

  testWidgets('check translation', (tester) async {
    Get.testMode = false;
    await tester.pumpWidget(GetMaterialApp(
      locale: MySharedPref.getCurrentLocal(),
      translations: LocalizationService.getInstance(),
      home: const Scaffold(
        body: Center(child: Text('Testing..')),
      ),
    ));
    await tester.pumpAndSettle();

    await LocalizationService.updateLanguage('en');
    await tester.pumpAndSettle();
    expect(Strings.hello.tr, 'Hello!');

    await LocalizationService.updateLanguage('ja');
    await tester.pumpAndSettle();
    expect(Strings.hello.tr, jaHelloTranslation());
  });
}

String jaHelloTranslation() {
  return LocalizationService.getInstance().keys['ja_JP']![Strings.hello]!;
}
