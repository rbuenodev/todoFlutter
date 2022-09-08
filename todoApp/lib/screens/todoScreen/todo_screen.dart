import 'package:flutter/material.dart';
import 'package:todoapp/models/status.dart';
import 'package:todoapp/notifier/todo_notifier.dart';
import 'package:todoapp/utils/formated_date.dart';
import '../../models/todo.dart';

class TodoScreen extends StatefulWidget {
  final Todo? todo;
  const TodoScreen({this.todo, super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final notifier = TodoNotifier();
  final descriptionController = TextEditingController();
  final statusController = TextEditingController();
  final createdAtController = TextEditingController();
  final completionDateController = TextEditingController();
  final dateUtils = DateTimeUtils();
  int statusSelected = 0;
  int idUpdateTodo = 0;

  @override
  void initState() {
    idUpdateTodo = 0;
    if (widget.todo != null) {
      idUpdateTodo = widget.todo!.id!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.todo == null ? "Adicionar Tarefa" : "Alterar Tarefa",
          style: const TextStyle(
            color: Colors.cyan,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
          children: [
            Container(
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                controller: descriptionController,
                style: const TextStyle(
                  backgroundColor: Colors.transparent,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  label: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Tarefa",
                      style: TextStyle(
                        backgroundColor: Colors.transparent,
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  hintText: "Tarefa",
                  hintStyle: TextStyle(
                      color: Colors.cyan, fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.only(left: 10),
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ValueListenableBuilder<List<Status>>(
                  valueListenable: notifier.statusListController,
                  builder: (_, statusList, __) {
                    return Container(
                      height: 60,
                      decoration: const BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: DropdownButtonFormField<Status>(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            dropdownColor: Colors.black54,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              label: Text(
                                "Status",
                                style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              hintText: "Status",
                              hintStyle: TextStyle(
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold),
                            ),
                            onChanged: ((value) {
                              if (value != null) {
                                statusSelected = value.id;
                              }
                            }),
                            items: statusList
                                .map(
                                    (Status status) => DropdownMenuItem<Status>(
                                          value: status,
                                          child: SizedBox(
                                              width: 250,
                                              child: Text(
                                                status.description,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ))
                                .toList(),
                            value: (widget.todo != null) &&
                                    (widget.todo!.status > 0) &&
                                    (statusList.isNotEmpty)
                                ? statusList
                                    .where((c) => c.id == widget.todo!.status)
                                    .first
                                : null,
                          )),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextFormField(
                  validator: (value) {
                    if ((value == null) || (value.isEmpty)) {
                      return "Campo obrigatório";
                    }

                    if (!dateUtils.validateDateTime(value)) {
                      return "Informar uma data válida";
                    }
                    return null;
                  },
                  controller: createdAtController,
                  keyboardType: TextInputType.datetime,
                  style: const TextStyle(
                    backgroundColor: Colors.transparent,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    label: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Data de início",
                        style: TextStyle(
                          backgroundColor: Colors.transparent,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    hintText: "Data de início",
                    hintStyle: TextStyle(
                        color: Colors.cyan, fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.only(left: 10),
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextFormField(
                  controller: completionDateController,
                  validator: ((value) {
                    if ((value == null) || (value.isEmpty)) {
                      return "Campo obrigatório";
                    }

                    if (!dateUtils.validateDateTime(value)) {
                      return "Informar uma data válida";
                    }
                    return null;
                  }),
                  keyboardType: TextInputType.datetime,
                  style: const TextStyle(
                    backgroundColor: Colors.transparent,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    label: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Data de término",
                        style: TextStyle(
                          backgroundColor: Colors.transparent,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    hintText: "Data de término",
                    hintStyle: TextStyle(
                        color: Colors.cyan, fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.only(left: 10),
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.cyan),
              onPressed: (() async => saveTodo(context)),
              child: const Text(
                "Confirmar",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancelar",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future saveTodo(BuildContext context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        Todo todo = Todo(
            id: widget.todo?.id ?? 0,
            description: descriptionController.text,
            createdAt:
                DateTimeUtils.convertStringToDateJson(createdAtController.text),
            completionDate: DateTimeUtils.convertStringToDateJson(
                completionDateController.text),
            status: statusSelected);
        try {
          var result = await notifier.saveTodo(todo);
          if (result != null) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context, result);
          } else {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        } catch (e) {
          _showDialod(
              "Falha ao gravar, verifique as informaões:${e.toString()}");
          return;
        }
      }
    }
  }

  void _showDialod(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            msg,
            style:
                TextStyle(color: Colors.cyan[900], fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
