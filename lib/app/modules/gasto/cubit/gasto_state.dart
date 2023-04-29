part of 'gasto_cubit.dart';

class GastoState extends Equatable {
  const GastoState({
    this.status = GastoEstatus.none,
    this.lsGastos = const <GastoModel>[],
    this.gastoModel,
  });

  final GastoEstatus status;
  final List<GastoModel> lsGastos;
  final GastoModel? gastoModel;

  GastoState copyWith({
    GastoEstatus? status,
    List<GastoModel>? lsGastos,
    GastoModel? gastoModel,
  }){
    return GastoState(
      status: status ?? this.status,
      lsGastos: lsGastos ?? this.lsGastos,
      gastoModel: gastoModel ?? this.gastoModel,
    );
  }

  @override
  List<Object> get props => [status];
}

enum GastoEstatus { none, loading, success, failure, saveOk, saveError, empty ,}


