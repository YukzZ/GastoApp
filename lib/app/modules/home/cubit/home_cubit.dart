
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gastos_app/core/controllers/ingreso_controller.dart';
import 'package:gastos_app/data/models/ingreso_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final _ingresoController = IngresoController();

  Future<void> init({required int idGasto})async{
    final ingreso = IngresoController().getById(idGasto);
    emit(state.copyWith(ingresoModel: ingreso));
    await getById(id: idGasto);
  }

  Future<void> getById({required int id})async{
    emit(state.copyWith(status: HomeEstatus.loading));

    try{
      await Future<void>.delayed(const Duration(seconds: 1));
      final ingreso = _ingresoController.getById(id);

      emit(state.copyWith(
        status: HomeEstatus.success,
        ingresoModel: ingreso,
      ),);

    } catch(e){
      emit(state.copyWith(status: HomeEstatus.failure));
    }
  }

  Future<void> update({
    required int id,
    required int ingreso,
  }) async{
    emit(state.copyWith(status: HomeEstatus.loading));
    await Future<void>.delayed(const Duration(seconds: 1));

    final ingresoModel = IngresoModel(
      id: id,
      ingreso: ingreso,
    );

    final result = await _ingresoController.update(ingresoModel: ingresoModel);

    if(result){
      emit(state.copyWith(status: HomeEstatus.success));
      await getById(id: id);
    }else{
      emit(state.copyWith(status: HomeEstatus.failure));
    }
  }

  Future<void> insert({
    required int ingreso
  })async{
    emit(state.copyWith(status: HomeEstatus.loading));
    final ingresoModel = IngresoModel(
      ingreso: ingreso,
    );
    final result = await _ingresoController.insert(ingresoModel: ingresoModel);

    if(result){
      emit(state.copyWith(status: HomeEstatus.success));
    }else{
      emit(state.copyWith(status: HomeEstatus.failure));
    }
  }
}
