import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _infoText = "MAGREZA (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "NORMAL (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25.0 && imc < 29.9) {
        _infoText = "SOBREPESO (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30.0 && imc < 39.9) {
        _infoText = "OBESO (${imc.toStringAsPrecision(3)})";
      } else if (imc > 40.0) {
        _infoText = "OBESIDADE GRAVE (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(60, 166, 116, 65),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline,
                      size: 120.0, color: Color.fromRGBO(7, 115, 75, 45)),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso em (Kg)",
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(60, 166, 116, 65))),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(7, 115, 75, 45), fontSize: 25.0),
                    controller: weightController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return "insira seu peso";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(60, 166, 116, 65))),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(7, 115, 75, 45), fontSize: 25.0),
                    controller: heightController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return "insira sua altura";
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(70, 8, 70, 0),
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Color.fromRGBO(60, 166, 116, 65),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(7, 115, 75, 45), fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
