import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowConfiguration extends StatelessWidget {
  const ShowConfiguration({super.key});

  @override
  Widget build(BuildContext context) {
    final configController = TextEditingController();
    return IconButton(
      color: Colors.cyan,
      icon: const Icon(Icons.settings),
      onPressed: (() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.black12,
                scrollable: true,
                title: const Text(
                  "Configurações",
                  style: TextStyle(
                      color: Colors.cyan, fontWeight: FontWeight.bold),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FutureBuilder<String>(
                      future: getUrl(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          configController.text = snapshot.data ?? "";
                        }
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(7)),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: configController,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        );
                      }),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.cyan),
                    onPressed: () async =>
                        saveConfig(context, configController.text),
                    child: const Text(
                      "Confirmar",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async =>
                        saveConfig(context, configController.text),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            });
      }),
    );
  }

  Future<void> saveConfig(BuildContext context, String url) async {
    if (url.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('todoUrl', url);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  Future<String> getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getString('todoUrl');
    if (result != null) return result;

    return "";
  }
}
