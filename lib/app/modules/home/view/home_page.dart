
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gastos_app/app/modules/gasto/gasto_page.dart';
import 'package:gastos_app/widgets/custom_button.dart';
import 'package:gastos_app/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cantidadDinero = 0;
  final controllerCantidadDinero = TextEditingController();
  String _selectedItem=items.first;
  bool isFirstI = true;
  static const List<String> items = <String>[
    'Opción 1',
    'Opción 2',
    'Opción 3',
    'Opción 4',
    'Opción 5',
  ];
  
  @override
  Widget build(BuildContext context) {
    if (isFirstI){
      isFirstI = false;
      cantidadDinero = 0;
      
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            CustomCard(
              title: 'Bienvenido',               
              iconPath: 'assets/icons/money.svg', 
              children: [
                const Text('Elija una categoria'),
                DropdownButton(
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
                    cantidadDinero = int.parse(value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(onPressed: ()async{
                  if(cantidadDinero == 0){
                    await showDialogCantidad(context: context);
                  }else{
                    await Navigator.push(
                      context, 
                      MaterialPageRoute<void>(
                        builder: (context) =>  GastoPage(
                          categoriaGasto: _selectedItem,
                          
                        ),
                      ),
                    );
                  }
                  controllerCantidadDinero.clear();
                }, label: 'Aceptar',),
              ],
            ),
          ],
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
          ],),
        ),
      ),
    );
  }
  Future<void> showDialogCantidad ({required BuildContext context}) async{
    await showDialog<void>(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text('No ha ingresado una cantidad'),
          content: const Text(
            'No ha ingresado una cantidad, desea ingresar a la aplicacion sin una cantidad el dia de hoy?',
          ),
          actions: [
            TextButton(
              onPressed: ()async{
                await Navigator.push(
                  context, 
                  MaterialPageRoute<void>(
                    builder: (context) =>  GastoPage(
                      categoriaGasto: _selectedItem,
                      
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
