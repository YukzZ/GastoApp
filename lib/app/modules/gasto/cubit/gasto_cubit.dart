import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gastos_app/core/controllers/gasto_controller.dart';
import 'package:gastos_app/core/controllers/ingreso_controller.dart';
import 'package:gastos_app/data/models/gasto_model.dart';
import 'package:gastos_app/data/models/ingreso_model.dart';

part 'gasto_state.dart';

class GastoCubit extends Cubit<GastoState> {
  GastoCubit() : super(const GastoState());

  final ctrl = GastoController();
  final _ingresoController = IngresoController();

  Future<void> getAll() async{
    emit(state.copyWith(status: GastoEstatus.loading));

    try{
      await Future<void>.delayed(const Duration(seconds: 1));
      final lsGastos = await ctrl.getAll();

      emit(state.copyWith(
        status: GastoEstatus.success,
        lsGastos: lsGastos,
      ),);
    }catch (e){
      emit(state.copyWith(status: GastoEstatus.failure));
    }
  }

  Future<void> updateIngreso({
    required int id,
    required int ingreso,
  }) async{
    emit(state.copyWith(status: GastoEstatus.loading));
    await Future<void>.delayed(const Duration(seconds: 1));

    final ingresoModel = IngresoModel(
      id: id,
      ingreso: ingreso,
    );

    final result = await _ingresoController.update(ingresoModel: ingresoModel);

    if(result){
      emit(state.copyWith(status: GastoEstatus.success));
      // await getById(id: id);
    }else{
      emit(state.copyWith(status: GastoEstatus.failure));
    }
  }

  Future<void> init({required int idGasto})async{
    final gasto = GastoController().getById(idGasto);
    emit(state.copyWith(gastoModel: gasto));
    await getAll();
  }

  Future<void> getByCategoria({required String categoriaGasto})async{
    emit(state.copyWith(status: GastoEstatus.loading));
    try{
      await Future<void>.delayed(const Duration(seconds: 1));
      final gasto = GastoController().getByCategoria(categoriaGasto);
      if(gasto!.isNotEmpty){
        emit(state.copyWith(
         lsGastos: gasto,
          status: GastoEstatus.success,
          
        ),
      );
      }else{
        emit(state.copyWith(
          status: GastoEstatus.empty,
        ),
      );
      }
      
    }catch(e){
      emit(state.copyWith(status: GastoEstatus.failure));
    }
    
    
  }

  Future<void> save({
    required String nombreGasto,
    required String descripcionGasto,
    required int cantidadGasto,
    required String categoriaGasto,
    required String fechaGasto,
  }) async {
    emit(state.copyWith(status: GastoEstatus.loading));

    final gasto = GastoModel(
      nombreGasto: nombreGasto, 
      descripcionGasto: descripcionGasto, 
      cantidadGasto: cantidadGasto, 
      categoriaGasto: categoriaGasto, 
      fechaGasto: fechaGasto,
    );
    final result = await ctrl.insert(gastoModel: gasto);
    if(result){
      await getAll();
    }
    else{
      emit(state.copyWith(status: GastoEstatus.failure));
    }
  }
}
