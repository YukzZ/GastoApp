import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastos_app/app/modules/gasto/cubit/gasto_cubit.dart';
import 'package:gastos_app/app/modules/gasto/view/detalle_gasto_page.dart';
import 'package:gastos_app/app/modules/home/cubit/home_cubit.dart';
import 'package:gastos_app/data/models/gasto_model.dart';
import 'package:gastos_app/widgets/custom_button.dart';
import 'package:intl/intl.dart';

class GastoPage extends StatefulWidget {
  const GastoPage({
    super.key, 
    // required this.categoriaGasto,
    required this.cantidadDinero,
    
  });

  final int cantidadDinero;
  

  // final String categoriaGasto;

  @override
  State<GastoPage> createState() => _GastoPageState();
}

class _GastoPageState extends State<GastoPage> {
  Key insert = const Key('1');
  Key search = const Key('2');
  DateTime _selectedDate= DateTime.now();
  String fecha = '';
  late GastoCubit cubit;
  late HomeCubit cubitHome;
  int cantidad = 0;
  String _selectedItem=items.first;
  static const List<String> items = <String>[
    'Curso',
    'Comida',
    'Entretenimiento',
    'Hogar',
    'Otros',
  ];
  String _searchItem=itemsSearch.first;
  static const List<String> itemsSearch = <String>[
    'Curso',
    'Comida',
    'Entretenimiento',
    'Hogar',
    'Otros',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gasto Monetario'),
      ),
      body: BlocProvider(
        create: (context) => GastoCubit()..getAll(
          
        ),
        child: BlocBuilder<GastoCubit, GastoState>(
          builder: (context, state) {
            cubit = context.read<GastoCubit>();
            Widget widgetEstatus = const Center(child: Text('No hay datos'),);
            if(state.status == GastoEstatus.success){
              final lsGastos = state.lsGastos;
              widgetEstatus = listGastos(lsGastos: lsGastos);
              // for(final gasto in lsGastos){
              //   final lsNewGastos = <GastoModel>[];
              //   if(gasto.categoriaGasto == _selectedItem){
              //     lsNewGastos.add(gasto);
              //     widgetEstatus = listGastos(lsGastos: lsNewGastos);

              //   }
              // }
            }else if(state.status == GastoEstatus.loading){
              widgetEstatus = const Center(child: CircularProgressIndicator());
            }else if(state.status == GastoEstatus.failure){
              widgetEstatus = const Center(child: Text('Error en la BD'));
            }else if(state.status == GastoEstatus.empty){
              widgetEstatus = const Center(child: Text('No hay datos'),);
            }
            // cubitHome = context.read<HomeCubit>();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Nuevo gasto en categoria, cantidad ${widget.cantidadDinero}'),
                    Card(
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Agregar nuevo gasto'),
                            formNuevoGasto(cubit: cubit),
                            const SizedBox(
                        height: 10,
                                          ),
                          ],
                        ),
                      ),
                    ),
                    
                    
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Elija una categoria'),
                        DropdownButton(
                          value: _searchItem,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          items: itemsSearch.map((String item) {
                            return DropdownMenuItem(
                              key: search,
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? selectedItem) {
                            setState(() {
                              
                              _searchItem = selectedItem!;
                              cubit.getByCategoria(categoriaGasto: _searchItem);
                            });
                          },
                        ),
                      // CustomButton(onPressed: () {
                      //     cubit.getByCategoria(categoriaGasto: 'Curso');
                      //   }, label: 'Categoria',),
                        CustomButton(onPressed: () {
                
                        }, label: 'Fecha',),
                              ],),

                        widgetEstatus,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  final controllerNombreGasto = TextEditingController();
  final controllerDescripcionGasto = TextEditingController();
  final controllerCantidadGasto = TextEditingController();
  final controllerCategoriaGasto = TextEditingController();
  final controllerFechaGasto = TextEditingController();
  Widget formNuevoGasto ({required GastoCubit cubit}){
    
    return Column(
      children: [
        const Text('Elija una categoria'),
        DropdownButton(
          key: insert,
          value: _selectedItem,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? selectedItem) {
            setState(() {
              _selectedItem = selectedItem!;
            });
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre del Gasto',
          ),
          controller: controllerNombreGasto,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Descripcion del Gasto',
          ),
          controller: controllerDescripcionGasto,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Cantidad del Gasto',
          ),
          keyboardType: TextInputType.number,
          controller: controllerCantidadGasto,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            cantidad = int.parse(value);
            log('############ $cantidad');
          },
        ),
        ListTile(
          title: const Text('Seleccionar fecha'),
          subtitle: _selectedDate == null
              ? const Text('Seleccione una fecha')
              : Text(DateFormat.yMd().format(_selectedDate)),
          onTap: () {
            _selectDate(context);
            log('######### $cantidad');
          },
        ),
        const SizedBox(height: 20,),
        CustomButton(
          onPressed: (){
            log('################ $cantidad');
            
            if(cantidad < widget.cantidadDinero){
              final ingreso = widget.cantidadDinero - cantidad;
            cubit.save(
              nombreGasto: controllerNombreGasto.text, 
              descripcionGasto: controllerDescripcionGasto.text, 
              cantidadGasto: cantidad, 
              categoriaGasto: _selectedItem, 
              fechaGasto: fecha,
            );
            controllerNombreGasto.clear();
            controllerDescripcionGasto.clear();
            controllerCantidadGasto.clear();
            controllerCategoriaGasto.clear();
            controllerFechaGasto.clear();
              cubit.updateIngreso(id: 1, ingreso: ingreso);
            }else{
              showDialogCantidad(context: context);
            }
            
          }, 
          label: 'Aceptar',
        ),
      ],
    );
  }

  Widget listGastos({required List<GastoModel> lsGastos,}){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: lsGastos.length,
      itemBuilder: (context, index) {
        
        return Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context, 
                MaterialPageRoute<void>(
                  builder: (context) => DetalleGastoPage(
                    id: lsGastos[index].id,
                    nombreGasto: lsGastos[index].nombreGasto, 
                    descripcionGasto: lsGastos[index].descripcionGasto, 
                    cantidadGasto: lsGastos[index].cantidadGasto, 
                    categoriaGasto: lsGastos[index].categoriaGasto, 
                    fechaGasto: lsGastos[index].fechaGasto,
                  ),
                ),
              );
            },
            child: Card(
              color: Colors.grey,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      lsGastos[index].nombreGasto,
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(lsGastos[index].categoriaGasto),
                  ),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );

    if (selected != null) {
      setState(() {
        _selectedDate = selected;
      });
      final formattedDate = DateFormat.yMd().format(_selectedDate);
      fecha = formattedDate;
      log('###############El usuario seleccionó la fecha $formattedDate $cantidad');
    }
  }
  Future<void> showDialogCantidad({required BuildContext context}) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No puedes gastar esta cantidad'),
          content: const Text(
            'Debes realizar un gasto menor a esto',
          ),
          actions: [
            
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
