import 'package:test/test.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';

void main() {
  group('Yacht...', () {
    test('Create a yacht', () {
      final Yacht yacht = Yacht(
        id: '1',
        name: 'Aaa',
        imo: 1111111,
        length: 111,
        buildDate: DateTime(2000, 1, 1),
      );

      expect(yacht.id, '1');
      expect(yacht.name, 'Aaa');
      expect(yacht.imo, 1111111);
      expect(yacht.length, 111);
      expect(yacht.buildDate, DateTime(2000, 1, 1));

      // print(yacht);
    });

    test('Instantiate a yacht from a map', () {
      Map<String, dynamic> map = {
        'id': '2',
        'name': 'Bbb',
        'imo': 2222222,
        'length': 222.2,
        'buildDate': DateTime(2002, 1, 1),
      };
      final Yacht yacht = Yacht.fromMap(map);

      expect(yacht.id, '2');
      expect(yacht.name, 'Bbb');
      expect(yacht.imo, 2222222);
      expect(yacht.length, 222.2);
      expect(yacht.buildDate, DateTime(2002, 1, 1));

      //print(yacht);
    });

    test('Convert a yacht to a map', () {
      final Yacht yacht = Yacht(
        id: '3',
        name: 'Ccc',
        imo: 3333333,
        length: 333.3,
        buildDate: DateTime(2003, 1, 1),
      );
      var map = yacht.toMap();

      expect(map['id'], '3');
      expect(map['name'], 'Ccc');
      expect(map['imo'], 3333333);
      expect(map['length'], 333.3);
      expect(map['buildDate'], DateTime(2003, 1, 1));
    });

    test('Convert a yacht to a string', () {
      final Yacht yacht = Yacht(
        id: '4',
        name: 'Ddd',
        imo: 4444444,
        length: 444.4,
        buildDate: DateTime(2004, 1, 1),
      );
      String stringYacht = yacht.toString();

      expect(stringYacht, 'Yacht(id: 4, name: Ddd, imo: 4444444, length: 444.4, buildDate: 2004-01-01T00:00:00.000)');
    });
  });
}
