import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  //resgata ou modifica as propriedades de um Wiget
  final _textControler = TextEditingController();

  //lista para preencher a listVIew
  List _todoList = [];

  //caso o usuário remova uma tarefa ele ficará em memória nessa variavél por um tempo
  late Map<String, dynamic> _ListaRemovida;

  late int _listaPosRemovido;

  void addTodo() {
    setState(() {
      Map<String, dynamic> novoTodo = Map();
      novoTodo["title"] = _textControler.text;
      novoTodo["ok"] = false;
      _todoList.add(novoTodo);
      _textControler.text = "";
    });
  }

  void _dismissTodo(DismissDirection direction, context, index) {
    setState(() {
      _ListaRemovida = Map.from(_todoList[index]);
      _listaPosRemovido = index;
      _todoList.removeAt(index);

      final snack = SnackBar(
        content: Text('Tarefa \"${_ListaRemovida["title"]}\" Removida!'),
        action: SnackBarAction(
          label: "Desfazer",
          onPressed: () {
            setState(() {
              _todoList.insert((_listaPosRemovido), _ListaRemovida);
            });
          },
        ),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[400],
        padding: EdgeInsets.only(right: 30, left: 30, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 500,
              height: 100,
              color: Colors.white,
              padding: EdgeInsets.all(14),
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: _textControler,
                decoration: InputDecoration(
                  label: Text(
                    "Nova Tarefa",
                  ),
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addTodo();
              },
              child: Text("Adcionar"),
            ),
            Container(
              width: 500,
              height: 500,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(50),
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: _todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _itemBuilder(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _itemBuilder(context, index) {
    //Widget responsável por permitir dismiss
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.redAccent,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.warning_outlined,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        onChanged: (c) {
          setState(() {
            _todoList[index]["ok"] = c;
          });
        },
        title: Text(_todoList[index]["title"]),
        value: _todoList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(_todoList[index]["ok"] ? Icons.check : Icons.error),
        ),
      ),
      onDismissed: (direction) {
        _dismissTodo(direction, context, index);
      },
    );
  }
}
