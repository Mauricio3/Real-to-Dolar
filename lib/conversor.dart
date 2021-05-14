import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Conversor extends StatefulWidget {
  @override
  _ConversorState createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
  final TextEditingController _reaisController = TextEditingController();
  final TextEditingController _cotacaoController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();
  var mensagem = "";

  void limpar() {
    setState(() {
      _reaisController.clear();
      _cotacaoController.clear();
      mensagem = "";
    });
  }

  void calcular() {
    if(_reaisController.text.isEmpty || _cotacaoController.text.isEmpty) {
        key.currentState.showSnackBar(SnackBar(
            content: Text("Campos quantidade em reais e cotacao para dólar são obrigatórios")
        ));
    } else {
      try {
        setState(() {
          var reais = double.parse(_reaisController.text);
          var cotacao = double.parse(_cotacaoController.text);
          var dolares = reais / cotacao;
          mensagem = "Com ${reais.toStringAsFixed(2)} reais é possível comprar ${dolares.toStringAsFixed(2)} dólares a"
              " ${cotacao.toStringAsFixed(2)} cada";
        });
      } catch(e) {
        key.currentState.showSnackBar(
            SnackBar(
                content: Text("Informe os campos corretamente"),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Reais para Dólares"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/cifrao.jpg", width: 80),
          TextField(
            controller: _reaisController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: "Quantidade em reais",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          TextField(
            controller: _cotacaoController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: "Cotação para dólar",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Text("$mensagem",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: limpar,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  "Limpar",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blueAccent,
              ),
              RaisedButton(
                onPressed: calcular,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blueAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

