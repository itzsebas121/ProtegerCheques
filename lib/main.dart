import 'package:flutter/material.dart';

void main() => runApp(ChequeProtegidoApp());

class ChequeProtegidoApp extends StatelessWidget {
  const ChequeProtegidoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Protección de Cheques', home: ChequeInputPage());
  }
}

class ChequeInputPage extends StatefulWidget {
  const ChequeInputPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      if (num >= 1000000) return 'Numeros hasta 9999';

      // Redondear a 2 decimales y separar parte entera y decimal
      String entero = num.truncate().toString();
      String decimal = (num - num.truncate()).toStringAsFixed(2).split('.')[1];

      // Insertar puntos de miles manualmente
      StringBuffer buffer = StringBuffer();
      int count = 0;
      for (int i = entero.length - 1; i >= 0; i--) {
        buffer.write(entero[i]);
        count++;
        if (count % 3 == 0 && i != 0) {
          buffer.write('.');
        }
      }

      String enteroFormateado = buffer.toString().split('').reversed.join();

      String finalString = '$enteroFormateado,$decimal';

      if (finalString.length > 8) return 'Numeros hasta 9999';

      return finalString.padLeft(8, '*');
    } catch (e) {
      return 'Ingrese un numero valido';
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
                    style: TextStyle(
                      fontSize: 32,
                      letterSpacing: 4,
                      fontFamily: 'Courier',
                    ),
                  ),
                ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: _reset, child: Text('Limpiar')),
            ],
          ),
        ),
      ),
    );
  }
}
