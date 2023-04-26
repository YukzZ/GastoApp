import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastos_app/app/modules/gasto/cubit/gasto_cubit.dart';

class GastoPage extends StatefulWidget {
  const GastoPage({super.key});

  @override
  State<GastoPage> createState() => _GastoPageState();
}

class _GastoPageState extends State<GastoPage> {
  late GastoCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gasto Monetario'),
      ),
      body: BlocProvider(
        create: (context) => GastoCubit()..getAll(),
        child: BlocBuilder<GastoCubit, GastoState>(
          builder: (context, state) {
            cubit = context.read<GastoCubit>();
            const widgetEstatus = Center(child: Text('No hay datos'),);
            if(state.status == GastoEstatus.success){
              
            }
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Agregar nuevo gasto'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
