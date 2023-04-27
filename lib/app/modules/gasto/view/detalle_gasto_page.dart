
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastos_app/app/modules/gasto/cubit/gasto_cubit.dart';

class DetalleGastoPage extends StatefulWidget {
  const DetalleGastoPage({
    super.key, 
    this.id = 0, 
    required this.nombreGasto, 
    required this.descripcionGasto, 
    required this.cantidadGasto, 
    required this.categoriaGasto, 
    required this.fechaGasto,
  });

  final int id;
  final String nombreGasto;
  final String descripcionGasto;
  final int cantidadGasto;
  final String categoriaGasto;
  final String fechaGasto;
  @override
  State<DetalleGastoPage> createState() => _DetalleGastoPageState();
}

class _DetalleGastoPageState extends State<DetalleGastoPage> {
  @override
  Widget build(BuildContext context) {
    late GastoCubit _cubit;
    return  Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${widget.nombreGasto}'),
      ),
      body: BlocProvider(
        create: (context) => GastoCubit()..init(idGasto: widget.id),
        child: BlocBuilder<GastoCubit, GastoState>(
          builder: (context, state) {
            _cubit = context.read<GastoCubit>();
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child:  Text(
                        'Datos del Gasto',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox( height: 10,),
                    const Divider(),
                    Text(
                      'Nombre: ${widget.nombreGasto}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    const Divider(),
                    Text(
                      'Descripcion: ${widget.descripcionGasto}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    const Divider(),
                    Text(
                      'Cantidad: ${widget.cantidadGasto}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    const Divider(),
                    Text(
                      'Categoria: ${widget.categoriaGasto}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    const Divider(),
                    Text(
                      'Fecha: ${widget.fechaGasto}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    const Divider(),
                    
                  ],
                ),
              ),
            ); 
          },
        ),
      ),
    );
  }
}
