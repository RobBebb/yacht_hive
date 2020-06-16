import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Yacht App...', () {
    // final titleText = find.byValueKey('title');
    // final addIconButtonFinder = find.byValueKey('add_IconButton');
    // final fabFinder = find.byValueKey('fab');
    String screenshotDirectory = 'screenshots';

    FlutterDriver driver;

    setUpAll(() async {
      Directory(screenshotDirectory).create();
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    takeScreenshot(FlutterDriver driver, String filename) async {
      final List<int> pixels = await driver.screenshot();
      final File file = File(screenshotDirectory + '/' + filename + '.png');
      print(file);
      await file.writeAsBytes(pixels);
    }

    test('Check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('Starts on Yachts page', () async {
      expect(await driver.getText(find.byValueKey('title')), 'Yachts');
      await takeScreenshot(driver, '1 Starting Yachts page');
    });

    test('Click add icon to go to add a new yacht page', () async {
      await driver.tap(find.byValueKey('add_IconButton'));
    });

    test('Now on Add Yacht page', () async {
      expect(await driver.getText(find.byValueKey('title')), 'Add Yacht');
      await takeScreenshot(driver, '2 Add Yacht page');
    });

    test('Enter yacht name', () async {
      await driver.tap(find.byValueKey('nameTextFormField'));
      await driver.enterText('Hake');
      await driver.waitFor(find.text('Hake'));
      print('Hake');
    });

    test('Enter yacht imo', () async {
      await driver.tap(find.byValueKey('imoTextFormField'));
      await driver.enterText('3333333');
      await driver.waitFor(find.text('3333333'));
    });

    test('Enter yacht length', () async {
      await driver.tap(find.byValueKey('lengthTextFormField'));
      await driver.enterText('55.5');
      await driver.waitFor(find.text('55.5'));
    });

    test('Enter yacht build date', () async {
      await driver.tap(find.byValueKey('buildDatePicker'));
      await driver.waitFor(find.text('SELECT DATE'));
      await driver.tap(find.text('18'));
      await takeScreenshot(driver, '3 DatePicker');
      await driver.tap(find.text('OK'));
    });

    test('Save the yacht', () async {
      await takeScreenshot(driver, '4 Before save of yacht');
      await driver.tap(find.byValueKey('saveIcon'));
    });

    test('Back on Yachts page', () async {
      expect(await driver.getText(find.byValueKey('title')), 'Yachts');
      await takeScreenshot(driver, '5 Ending Yachts page');
    });
  });
}
