import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home: Home()
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();
  String _resultado = "Informe seus dados!";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    setState(() {
      peso.text = "";
      altura.text = "";
      _resultado = "Informe seus dados!";
    });
  }

  void _calculaIMC(){
    setState(() {
      double pes = double.parse(peso.text);
      double alt = double.parse(altura.text) / 100;
      double result = pes / (alt * alt);

      if(result < 18.6){
        _resultado = "Abaixo do peso (${result.toStringAsPrecision(3)})";
      } else if(result >= 18.6 && result < 24.9){
        _resultado = "Peso ideal (${result.toStringAsPrecision(3)})";
      } else if(result >= 24.9 && result < 29.9){
        _resultado = "Levemente acima do peso (${result.toStringAsPrecision(3)})";
      } else if(result >= 29.9 && result < 34.9){
        _resultado = "Obesidade grau I (${result.toStringAsPrecision(3)})";
      } else if(result >= 34.9 && result < 39.9){
        _resultado = "Obesidade grau II (${result.toStringAsPrecision(3)})";
      } else if(result >= 40){
        _resultado = "Obesidade grau III (${result.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(
                            color: Colors.green
                        )
                    ),
                    controller: peso,
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira seu peso!";
                      }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(
                          color: Colors.green
                      )
                  ),
                  controller: altura,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira seu altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            _calculaIMC();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25
                          ),
                        ),
                        color: Colors.green,
                      )
                  ),
                ),
                Text(
                    _resultado,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 25
                    )
                )
              ],
            ),
          )
        ),
      )
    );
  }
}
