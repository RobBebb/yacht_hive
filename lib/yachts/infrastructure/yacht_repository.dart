import '../domain/yacht.dart';

abstract class YachtRepository {
  Future<List<Yacht>> selectYachts();
  Future<int> insertYacht(Yacht yacht);
  Future<Yacht> selectYacht(int id);
  Future<void> updateYacht(Yacht yacht);
  Future<void> deleteYacht(int id);
}