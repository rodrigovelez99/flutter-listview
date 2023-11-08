// ignore_for_file: file_names, library_private_types_in_public_api, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:practicalistwidget/model/backend.dart';
import 'package:practicalistwidget/model/email.dart';
import 'package:practicalistwidget/screens/DetailScreen.dart';
import 'package:practicalistwidget/widgets/EmailWidget.dart';
class ListScreen extends StatefulWidget {
  const ListScreen({Key? key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Email> emails = []; // Lista de emails

  @override
  void initState() {
    super.initState();
    // Obtener los emails al inicio
    emails = Backend().getEmails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mock mail'),
      ),
      body: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(emails[index].id.toString()),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              // Eliminar email al hacer swipe
              setState(() {
                Backend().deleteEmail(emails[index].id);
                emails.removeAt(index);
              });
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(email: emails[index]),
                  ),
                );
              },
              onLongPress: () {
                setState(() {
                  Backend().markEmailAsRead(emails[index].id);
                  emails[index].read = true;
                });
              },
              child: EmailWidget(
                email: emails[index],
                onTap: () {
                  // Marcar como leído con tap
                  setState(() {
                    Backend().markEmailAsRead(emails[index].id);
                    emails[index].read = true;
                  });

                  // Navegar a la pantalla de detalle
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(email: emails[index]),
                    ),
                  );
                },
                onLongPress: () {
                  // Marcar como leído con Long Press
                  setState(() {
                    Backend().markEmailAsRead(emails[index].id);
                    emails[index].read = true;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}