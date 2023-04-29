import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gastos_app/app/modules/gasto/gasto_page.dart';
import 'package:gastos_app/app/modules/home/cubit/home_cubit.dart';
import 'package:gastos_app/widgets/custom_button.dart';
import 'package:gastos_app/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cantidadDinero = 0;
  int newCantidad = 0;
  final controllerCantidadDinero = TextEditingController();
  bool isFirstI = true;
  late HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    if (isFirstI) {
      isFirstI = false;
      // HomeCubit().insert(ingreso: cantidadDinero);
    }
    HomeCubit().getById(id: 1);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..init(idGasto: 1),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            Widget widgetEstatus = const Center(child: Text('No hay datos'),);
            if(state.status == HomeEstatus.failure){
              widgetEstatus = const Center(child: Text('No hay datos'),);
            }else if(state.status == HomeEstatus.success){
              widgetEstatus =const Center(child: Text('Hay datos'),);
              cantidadDinero = state.ingresoModel!.ingreso;
            }else if(state.status == HomeEstatus.loading){
              widgetEstatus = const Center(child: CircularProgressIndicator());
            }
            cubit = context.read<HomeCubit>();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    widgetEstatus,
                    CustomCard(
                      title: 'Bienvenido, cantidad actual $cantidadDinero',
                      iconPath: 'assets/icons/money.svg',
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Ingrese la cantidad de dinero de hoy'),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Cantidad de hoy',
                          ),
                          controller: controllerCantidadDinero,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            newCantidad = int.parse(value);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onPressed: () async {
                            var insertCantidad = 0;
                            insertCantidad = newCantidad + cantidadDinero;
                            await cubit.update(id: 1, ingreso: insertCantidad);
                            if (cantidadDinero == 0) {
                              await showDialogCantidad(context: context);
                            } else {
                              // ignore: use_build_context_synchronously
                              await Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) => GastoPage(
                                      // categoriaGasto: _selectedItem,
                                      cantidadDinero: insertCantidad,
                                      
                                      ),
                                ),
                              );
                            }
                            
                            controllerCantidadDinero.clear();
                          },
                          label: 'Aceptar',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Card(
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                'assets/icons/money.svg',
                width: 32,
                height: 32,
                color: Colors.white,
              ),
              SvgPicture.asset(
                'assets/icons/money.svg',
                width: 32,
                height: 32,
                color: Colors.white,
              ),
              SvgPicture.asset(
                'assets/icons/money.svg',
                width: 32,
                height: 32,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDialogCantidad({required BuildContext context}) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No ha ingresado una cantidad'),
          content: const Text(
            'No ha ingresado una cantidad, desea ingresar a la aplicacion sin una cantidad el dia de hoy?',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => GastoPage(
                        // categoriaGasto: _selectedItem,
                        cantidadDinero: cantidadDinero,
                        ),
                  ),
                ).then((value) => Navigator.pop(context));
              },
              child: const Text('Si'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
