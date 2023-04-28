import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gastos_app/core/controllers/gasto_controller.dart';
import 'package:gastos_app/data/models/gasto_model.dart';

part 'gasto_state.dart';

class GastoCubit extends Cubit<GastoState> {
  GastoCubit() : super(const GastoState());

  final ctrl = GastoController();

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

  Future<void> init({required int idGasto})async{
    final gasto = GastoController().getById(idGasto);
    emit(state.copyWith(gastoModel: gasto));
    await getAll();
  }

  Future<void> getByCategoria({required String categoriaGasto})async{
    final gasto = GastoController().getByCategoria(categoriaGasto);
    emit(state.copyWith(lsGastos: gasto));
    await getAll();
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
