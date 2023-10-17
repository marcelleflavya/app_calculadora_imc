import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IMCCalculadora(),
    );
  }
}

class IMCCalculadora extends StatefulWidget {
  @override
  _IMCCalculadoraState createState() => _IMCCalculadoraState();
}

class _IMCCalculadoraState extends State<IMCCalculadora> {
  List<IMCData> imcDataList = [];
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  void _calcularIMC() {
    double? peso = double.tryParse(pesoController.text);
    double? altura = double.tryParse(alturaController.text);

    if (peso != null && altura != null) {
      double imc = peso / (altura * altura);

      String imcStatus;

      if (imc < 16) {
        imcStatus = "Magreza grave";
      } else if (imc >= 16 && imc < 17) {
        imcStatus = "Magreza moderada";
      } else if (imc >= 17 && imc < 18.5) {
        imcStatus = "Magreza leve";
      } else if (imc >= 18.5 && imc < 25) {
        imcStatus = "Saudável";
      } else if (imc >= 25 && imc < 30) {
        imcStatus = "Sobrepeso";
      } else if (imc >= 30 && imc < 35) {
        imcStatus = "Obesidade Grau I";
      } else if (imc >= 35 && imc < 40) {
        imcStatus = "Obesidade Grau II (severa)";
      } else {
        imcStatus = "Obesidade Grau III (mórbida)";
      }

      IMCData newIMCData =
          IMCData(peso: peso, altura: altura, imc: imc, status: imcStatus);

      setState(() {
        imcDataList.add(newIMCData);
      });
      pesoController.clear();
      alturaController.clear();
    } else {
      print("Peso ou altura inválidos.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Peso (kg)'),
                ),
                TextField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Altura (m)'),
                ),
                ElevatedButton(
                  onPressed: _calcularIMC,
                  child: Text('Calcular IMC'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: imcDataList.length,
              itemBuilder: (context, index) {
                IMCData data = imcDataList[index];
                return ListTile(
                  title:
                      Text('Peso: ${data.peso} kg, Altura: ${data.altura} m'),
                  subtitle: Text('IMC: ${data.imc.toStringAsFixed(2)}, ${data.status}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IMCData {
  final double peso;
  final double altura;
  final double imc;
  final String status;

  IMCData(
      {required this.peso,
      required this.altura,
      required this.imc,
      required this.status});
}
