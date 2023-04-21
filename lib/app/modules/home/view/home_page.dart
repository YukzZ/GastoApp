
import 'package:flutter/material.dart';
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
                CustomButton(onPressed: (){}, label: 'Aceptar'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}