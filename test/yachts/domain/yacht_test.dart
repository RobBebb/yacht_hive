import 'package:test/test.dart';
import '../../../lib/yachts/domain/yacht.dart';

void main() {
  group('Yacht...', () {
    test('Create a yacht', () {
      final Yacht yacht = Yacht(
        name: 'Aaa',
        imo: 1111111,
        length: 111,
      );

      expect(yacht.name, 'Aaa');
      expect(yacht.imo, 1111111);
      expect(yacht.length, 111);

      print(yacht);
    });

    test('Create a yacht from a map', () {
      Map<String, dynamic> map = {
        'name': 'Bbb',
        'imo': 2222222,
        'length': 222.2,
      };
      final Yacht yacht = Yacht.fromMap(map);

      expect(yacht.name, 'Bbb');
      expect(yacht.imo, 2222222);
      expect(yacht.length, 222.2);

      print(yacht);
    });

    test('Convert a yacht to a map', () {
      final Yacht yacht = Yacht(
        name: 'Ccc',
        imo: 3333333,
        length: 333.3,
      );
      var map = yacht.toMap();
      expect(map['name'], 'Ccc');
      expect(map['imo'], 3333333);
      expect(map['length'], 333.3);
    });

    test('Convert a yacht to a string', () {
      final Yacht yacht = Yacht(
        name: 'Ddd',
        imo: 4444444,
        length: 444.4,
      );
      String stringYacht = yacht.toString();

      expect(stringYacht, 'Yacht(name: Ddd, imo: 4444444, length: 444.4)');
    });
  });
}
