import 'package:test/test.dart';
import 'package:yacht_hive/yachts/domain/yacht_validator.dart';

void main() {
  group('Yacht validate name...', () {
    test('Empty name returns an error', () {
      var result = NameFieldValidator.validate('');
      expect(result, 'Please provide a name.');
    });

    test('Non-empty name returns null', () {
      var result = NameFieldValidator.validate('Terminator');
      expect(result, null);
    });
  });


  group('Yacht validate IMO...', () {
    test('Empty IMO returns an error', () {
      var result = ImoFieldValidator.validate('');
      expect(result, 'Please provide an IMO.');
    });

    test('Non-numeric IMO returns an error', () {
      var result = ImoFieldValidator.validate('abc');
      expect(result, 'Please enter a valid number.');
    });

    test('IMO of 0 returns an error', () {
      var result = ImoFieldValidator.validate('0');
      expect(result, 'Please enter a number greater than zero.');
    });

    test('Negative IMO returns an error', () {
      var result = ImoFieldValidator.validate('-123');
      expect(result, 'Please enter a number greater than zero.');
    });

    test('Numeric IMO returns null', () {
      var result = ImoFieldValidator.validate('123456789');
      expect(result, null);
    });
  });


    group('Yacht validate length...', () {
    test('Empty length returns an error', () {
      var result = LengthFieldValidator.validate('');
      expect(result, 'Please provide a length.');
    });

    test('Non-numeric length returns an error', () {
      var result = LengthFieldValidator.validate('abc');
      expect(result, 'Please enter a valid number.');
    });

    test('Length of 0 returns an error', () {
      var result = LengthFieldValidator.validate('0');
      expect(result, 'Please enter a number greater than zero.');
    });

    test('Negative length returns an error', () {
      var result = LengthFieldValidator.validate('-12');
      expect(result, 'Please enter a number greater than zero.');
    });
    
    test('Numeric length returns null', () {
      var result = LengthFieldValidator.validate('45.5');
      expect(result, null);
    });
  });

}
