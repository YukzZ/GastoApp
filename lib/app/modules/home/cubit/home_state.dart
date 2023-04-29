part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeEstatus.none,
    this.ingresoModel,
  });

  final HomeEstatus status;
  final IngresoModel? ingresoModel;

  HomeState copyWith({
    HomeEstatus? status,
    IngresoModel? ingresoModel,
  }){
    return HomeState(
      status: status ?? this.status,
      ingresoModel: ingresoModel ?? this.ingresoModel,
    );
  }

  @override
  List<Object> get props => [status];
}

enum HomeEstatus {none, loading, success, failure, }


