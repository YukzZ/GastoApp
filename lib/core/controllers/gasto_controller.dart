import 'package:gastos_app/core/data_base_controller.dart';
import 'package:gastos_app/data/models/gasto_model.dart';

class GastoController{
  Future<List<GastoModel>> getAll() async {
    final box = DataBaseController.store.box<GastoModel>();
    final lsGastos = box.getAll();
    return lsGastos;
  }

  GastoModel? getById(int id){
    final box = DataBaseController.store.box<GastoModel>();
    final gasto = box.get(id);
    return gasto;
  }

  Future<bool> insert ({required GastoModel gastoModel}) async{
    final box = DataBaseController.store.box<GastoModel>();
    final id = box.put(gastoModel);
    return id > 0;
  }
}
