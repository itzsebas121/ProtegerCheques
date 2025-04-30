import 'package:flutter/material.dart';

void main() => runApp(ChequeProtegidoApp());

class ChequeProtegidoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protección de Cheques',
      home: ChequeInputPage(),
    );
  }
}

class ChequeInputPage extends StatefulWidget {
  @override
  _ChequeInputPageState createState() => _ChequeInputPageState();
}

class _ChequeInputPageState extends State<ChequeInputPage> {
  final TextEditingController _importeController = TextEditingController();
  String? _chequeProtegido;

  void _protegerCheque() {
    setState(() {
      final valor = _importeController.text;
      _chequeProtegido = _formatearCheque(valor);
    });
  }

  String _formatearCheque(String valor) {
    try {
      double num = double.parse(valor);
      // Limita el número de caracteres si es demasiado grande
      if (num >= 1000000) return 'ERROR'; // Evita números más grandes de 8 caracteres

      // Formatea con 2 decimales y coma como separador decimal
      String str = num.toStringAsFixed(2).replaceAll('.', ',');

      // Asegura que el total tenga 8 caracteres con asteriscos a la izquierda
      return str.padLeft(8, '*');
    } catch (e) {
      return 'ERROR';
    }
  }

  void _reset() {
    setState(() {
      _importeController.clear();
      _chequeProtegido = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Protección de Cheques')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _importeController,
                decoration: InputDecoration(labelText: 'Importe del Cheque'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _protegerCheque,
                child: Text('Proteger Cheque'),
              ),
              if (_chequeProtegido != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    _chequeProtegido!,
                    style: TextStyle(fontSize: 32, letterSpacing: 4, fontFamily: 'Courier'),
                  ),
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _reset,
                child: Text('Limpiar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
