import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastos_app/app/modules/gasto/cubit/gasto_cubit.dart';
import 'package:gastos_app/app/modules/gasto/view/detalle_gasto_page.dart';
import 'package:gastos_app/data/models/gasto_model.dart';
import 'package:gastos_app/widgets/custom_button.dart';
import 'package:intl/intl.dart';

class GastoPage extends StatefulWidget {
  const GastoPage({super.key, required this.categoriaGasto,});

  final String categoriaGasto;

  @override
  State<GastoPage> createState() => _GastoPageState();
}

class _GastoPageState extends State<GastoPage> {
  late DateTime _selectedDate;
  late GastoCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gasto Monetario'),
      ),
      body: BlocProvider(
        create: (context) => GastoCubit()..getByCategoria(
          categoriaGasto: widget.categoriaGasto,
        ),
        child: BlocBuilder<GastoCubit, GastoState>(
          builder: (context, state) {
            cubit = context.read<GastoCubit>();
            Widget widgetEstatus = const Center(child: Text('No hay datos'),);
            if(state.status == GastoEstatus.success){
              final lsGastos = state.lsGastos;
              for(final gasto in lsGastos){
                final lsNewGastos = <GastoModel>[];
                if(gasto.categoriaGasto == widget.categoriaGasto){
                  lsNewGastos.add(gasto);
                  widgetEstatus = listGastos(lsGastos: lsNewGastos);

                }
              }
            }else if(state.status == GastoEstatus.loading){
              widgetEstatus = const Center(child: CircularProgressIndicator());
            }else if(state.status == GastoEstatus.failure){
              widgetEstatus = const Center(child: Text('Error en la BD'));
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Nuevo gasto en categoria ${widget.categoriaGasto}'),
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
                      CustomButton(onPressed: () {
                          cubit.getByCategoria(categoriaGasto: 'Curso');
                        }, label: 'Categoria',),
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
    var cantidad = 0;
    return Column(
      children: [
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
          },
        ),
        
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Fecha del Gasto',
          ),
          controller: controllerFechaGasto,
          keyboardType: TextInputType.datetime,
        ),
        ListTile(
                    title: const Text('Seleccionar fecha'),
                    subtitle: _selectedDate == null
                        ? const Text('Seleccione una fecha')
                        : Text(DateFormat.yMd().format(_selectedDate)),
                    onTap: () {
                      _selectDate(context);
                    },
                  ),
        const SizedBox(height: 20,),
        CustomButton(
          onPressed: (){
            cubit.save(
              nombreGasto: controllerNombreGasto.text, 
              descripcionGasto: controllerDescripcionGasto.text, 
              cantidadGasto: cantidad, 
              categoriaGasto: widget.categoriaGasto, 
              fechaGasto: controllerFechaGasto.text,
            );
            controllerNombreGasto.clear();
            controllerDescripcionGasto.clear();
            controllerCantidadGasto.clear();
            controllerCategoriaGasto.clear();
            controllerFechaGasto.clear();
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

      // Aquí puedes hacer lo que quieras con la fecha seleccionada,
      // como imprimirla en la consola o enviarla a un servidor.
      final formattedDate = DateFormat.yMd().format(_selectedDate);
      print('El usuario seleccionó la fecha $formattedDate');
    }
  }
}
