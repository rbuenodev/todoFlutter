import 'package:flutter/material.dart';
import 'package:todoapp/screens/homeScreen/widgets/configuration_widget.dart';
import 'package:todoapp/screens/homeScreen/widgets/search_widget.dart';
import 'package:todoapp/screens/todoScreen/todo_screen.dart';
import '../../models/todo.dart';
import '../../notifier/home_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final notifier = HomeNotifier();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Todo>>(
        valueListenable: notifier.todoListController,
        builder: (context, todoList, _) {
          return Scaffold(
            backgroundColor: Colors.grey[400],
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: const ShowConfiguration(),
              title: const Text(
                "Lista de Tarefas",
                style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                    color: Colors.cyan,
                    onPressed: () async {
                      var result = await showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(todoList),
                      );
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.cyan,
                  ),
                  onPressed: (() {}),
                )
              ],
            ),
            body: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text(todoList[index].description),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(todoList[index].statusDescription),
                        Text(todoList[index].formattedCompletionDate),
                        Text(todoList[index].formattedCreatedAt),
                      ]),
                  trailing: PopupMenuButton<String>(
                    itemBuilder: (context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem(value: "Edit", child: Text("Editar")),
                      const PopupMenuItem(
                          value: "Delete", child: Text("Deletar")),
                    ],
                    onSelected: (value) {},
                  ),
                );
              }),
            ),
            bottomNavigationBar: Container(
              color: Colors.black,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (() async {
                      _showTodoPage(context, null);
                    }),
                    child: const Text(
                      "Adicionar Nova Tarefa",
                      style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.add,
                    color: Colors.cyan,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showTodoPage(BuildContext context, Todo? todo) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TodoScreen(todo: todo)));
  }
}
