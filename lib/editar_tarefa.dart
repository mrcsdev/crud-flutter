import 'package:banco_crud/tarefa_model.dart';
import 'package:banco_crud/tarefa_repository.dart';
import 'package:flutter/material.dart';

class EditarTarefa extends StatefulWidget {
  final Tarefa tarefa;
  final int index;

  const EditarTarefa({required this.tarefa, required this.index});

  @override
  State<EditarTarefa> createState() => _EditarTarefaState();
}

class _EditarTarefaState extends State<EditarTarefa> {
  TextEditingController controllerDescricao = TextEditingController();
  TarefaBox tarefaBox = TarefaBox();

  @override
  void initState() {
    controllerDescricao.text = widget.tarefa.descricao.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Editar Tarefa')),
        body: Column(
          children: [
            TextField(
              controller: controllerDescricao,
              decoration: InputDecoration(label: Text('descrição')),
            ),
            ElevatedButton(
                onPressed: () {
                  var atualizarTarefa = Tarefa(controllerDescricao.text);
                  tarefaBox.editarTarefa(atualizarTarefa, widget.index);
                  Navigator.of(context).pop(atualizarTarefa);
                },
                child: Text('Atualizar'))
          ],
        ));
  }
}
