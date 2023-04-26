
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text('Hola Mundo'),
            CustomButton(onPressed: (){}, label: 'Aceptar'),
            CustomCard(
              title: 'Ejemplo Titulo',               
              iconPath: 'assets/icons/money.svg', 
              children: [
                CustomButton(onPressed: ()async{
                  await Navigator.push(
                    context, 
                    MaterialPageRoute<void>(
                      builder: (context) => const GastoPage(),
                    ),
                  );
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
}