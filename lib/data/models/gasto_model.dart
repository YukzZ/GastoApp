import 'package:objectbox/objectbox.dart';

@Entity()
class GastoModel{
  GastoModel({
    this.id = 0,
    required this.nombreGasto,
    required this.descripcionGasto,
    required this.cantidadGasto,
    required this.categoriaGasto,
    required this.fechaGasto, 
  });

  @Id(assignable: true)
  int id;
  String nombreGasto;
  String descripcionGasto;
  int cantidadGasto;
  String categoriaGasto;
  String fechaGasto;
}
