import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  String infoText = "Informe seus dados!";

  void resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      infoText = "Informe seus dados!";
      formKey = GlobalKey<FormState>();
    });
  }

  void calculateIMC(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.5){
        infoText = "Abaixo do peso! Seu imc é ${imc.toStringAsPrecision(3)}";
      }
      else if (imc > 18.5 && imc < 24.9){
        infoText = "Seu imc está normal! Seu imc é ${imc.toStringAsPrecision(3)}";
      }
      else if (imc > 24.9 && imc < 30){
        infoText = "Você está sobrepeso! Seu imc é ${imc.toStringAsPrecision(3)}";
      }
      else if (imc > 30 && imc < 34.9){
        infoText = "Obesidade grau 1! Seu imc é ${imc.toStringAsPrecision(3)}";
      }
      else if(imc > 34.9 && imc < 39.9){
        infoText = "Obesidade Grau 2! Seu imc é ${imc.toStringAsPrecision(3)}";
      }
      else if(imc > 39.9){
        infoText = "Obesidade Grau 3!!! Seu imc é ${imc.toStringAsPrecision(3)}";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              onPressed: resetFields,
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_outlined,
                  size: 160,
                  color: Colors.red,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  textAlign: TextAlign.center,
                  controller: weightController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  textAlign: TextAlign.center,
                  controller: heightController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Insira sua altura!";
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          calculateIMC();
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                      child: const Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ),
                ),
                Text(
                  infoText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
}
