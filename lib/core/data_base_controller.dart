import 'package:gastos_app/objectbox.g.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class DataBaseController{
  static late final Store store;
  Future<void> initDataBase() async{
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    store = Store(
      getObjectBoxModel(),
      directory: path.join(appDocumentsDirectory.path, 'test_db'),
    );
  }
}
