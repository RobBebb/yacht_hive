import '../domain/yacht.dart';

abstract class YachtRepository {
  Future<List<Yacht>> selectYachts();
  Future<Yacht> insertYacht(Yacht yacht);
  Future<Yacht> selectYacht(int id);
  Future<void> updateYacht(int id, Yacht yacht);
  Future<void> deleteYacht(int id);
}