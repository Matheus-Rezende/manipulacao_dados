import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _controllerField = TextEditingController();
  String _textSave = "Nada Salvo!";

  _save() async {
    String valueTyped = _controllerField.text;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("value", valueTyped);

    debugPrint("operação(SALVAR): $valueTyped");
  }

  _recover() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textSave = prefs.getString("value") ?? "Sem valor";
    });
    
    debugPrint("operação(RECUPERAR): $_textSave");
  }

  _remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("value");

    debugPrint("operação(REMOVER)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manipulação de dados"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              _textSave,
              style: const TextStyle(
                fontSize: 20
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Digite algo",
                suffixIcon: Icon(Icons.keyboard)
              ),
              controller: _controllerField,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan[900]
                  ),
                  onPressed: _save, 
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple[900]
                  ),
                  onPressed: _recover, 
                  child: const Text(
                    "Recuperar",
                    style: TextStyle(
                      fontSize: 16
                    ),
                  )
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[900]
                  ),
                  onPressed: _remove, 
                  child: const Text(
                    "Remover",
                    style: TextStyle(
                      fontSize: 16
                    ),
                  )
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}