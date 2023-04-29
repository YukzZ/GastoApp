import 'package:objectbox/objectbox.dart';

@Entity()
class IngresoModel{
  IngresoModel({
    this.id = 0,
    required this.ingreso,
  });

  @Id(assignable: true)
  int id;
  final int ingreso;
}
