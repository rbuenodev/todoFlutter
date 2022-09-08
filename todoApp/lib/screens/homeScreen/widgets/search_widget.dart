import 'package:flutter/material.dart';
import '../../../models/todo.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Todo> searchTerms = [];

  CustomSearchDelegate(List<Todo> lista) {
    searchTerms.addAll(lista);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.cyan,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.cyan,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Todo> matchQuery = [];
    for (var todo in searchTerms) {
      if (todo.description.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(todo);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: ((context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.description),
          onTap: () {
            close(context, result);
          },
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Todo> matchQuery = [];
    for (var todo in searchTerms) {
      matchQuery.add(todo);
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: ((context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.description),
          subtitle: Text(result.status.toString()),
          onTap: () {
            close(context, result);
          },
        );
      }),
    );
  }
}
