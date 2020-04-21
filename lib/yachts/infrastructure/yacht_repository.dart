import '../domain/yacht.dart';

abstract class YachtRepository {
  Future<List<Yacht>> selectYachts();
  Future<Yacht> insertYacht(Yacht yacht);
  Future<Yacht> selectYacht(int id);
  Future<Yacht> updateYacht(Yacht yacht);
  Future<Yacht> deleteYacht(int id);
}