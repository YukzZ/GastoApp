
import 'package:flutter/material.dart';

class GastoPage extends StatefulWidget {
  const GastoPage({super.key});

  @override
  State<GastoPage> createState() => _GastoPageState();
}

class _GastoPageState extends State<GastoPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Gasto Monetario'),
      ),
      body: const Text('Hola'),
    );
  }
}
