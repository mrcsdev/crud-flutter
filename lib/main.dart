import 'package:banco_crud/editar_tarefa.dart';
import 'package:banco_crud/tarefa_model.dart';
import 'package:banco_crud/tarefa_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TarefaAdapter());
  await Hive.openBox<Tarefa>('tarefa');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController descricaoControler = TextEditingController();
  TarefaBox tarefaBox = TarefaBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de tarefas')),
      body: Column(
        children: [
          TextField(
              controller: descricaoControler,
              decoration: InputDecoration(label: Text('descrição'))),
          ElevatedButton(
              onPressed: () {
                var novaTarefa = Tarefa(descricaoControler.text);
                tarefaBox.addTarefa(novaTarefa);
                descricaoControler.clear();
                setState(() {});
              },
              child: Text('criar tarefa')),
          Expanded(
              child: ListView.builder(
                  itemCount: tarefaBox.mostrarTarefas().length,
                  itemBuilder: ((context, index) {
                    var tarefa = tarefaBox.mostrarTarefas()[index];
                    return ListTile(
                        title: Text(tarefa.descricao ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  tarefaBox.deletarTarefa(index);
                                  setState(() {});
                                },
                                icon: Icon(Icons.delete)),
                            IconButton(
                                onPressed: () async {
                                  var resultado = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => EditarTarefa(
                                              tarefa: tarefa, index: index)));
                                  if (resultado != null) {
                                    setState(() {});
                                  }
                                },
                                icon: Icon(Icons.edit))
                          ],
                        ));
                  }))),
        ],
      ),
    );
  }
}
