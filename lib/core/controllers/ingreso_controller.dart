import 'package:gastos_app/core/data_base_controller.dart';
import 'package:gastos_app/data/models/ingreso_model.dart';
import 'package:gastos_app/objectbox.g.dart';

class IngresoController{
  IngresoModel? getById(int id){
    final box = DataBaseController.store.box<IngresoModel>();
    final ingreso = box.get(id);
    return ingreso;
  }

  Future<bool> update({required IngresoModel ingresoModel})async{
    final box = DataBaseController.store.box<IngresoModel>();
    final result = box.put(ingresoModel, mode: PutMode.update);
    return result > 0;
  } 
  Future<bool> insert({required IngresoModel ingresoModel})async{
    final box = DataBaseController.store.box<IngresoModel>();
    final result = box.put(ingresoModel);
    return result > 0;
  }
}
