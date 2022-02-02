import 'package:flutter/material.dart';

class Contador extends StatefulWidget {
  const Contador({Key? key}) : super(key: key);

  @override
  _ContadorState createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int _counter = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${_counter}",
            style: TextStyle(color: Colors.grey, fontSize: 70),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter--;
                if (_counter == 0) {
                  _fimAlerta(context);
                }
              });
            },
            child: Text("Decrementar"),
          ),
        ],
      ),
    );
  }

  Future<void> _fimAlerta(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Alerta"),
            content: Text("o contador será reiniciado"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter = 10;
                  });
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              ),
            ],
          );
        });
  }
}
