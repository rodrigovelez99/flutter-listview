
// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:practicalistwidget/model/backend.dart';
import 'package:practicalistwidget/model/email.dart';

class DetailScreen extends StatelessWidget {
  final Email email;

  const DetailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // Marcar como leído al abrir la pantalla de detalle
    Backend().markEmailAsRead(email.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(email.subject),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
            'From: ${email.from}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16), 

              Text(
              email.subject,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

             Text(
              email.dateTime.toString(),
              style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey, // Establece el color a gris
              ),
            ),

            // Separación de 8 puntos entre el primer y segundo Text

            const SizedBox(height: 16), // Separación de 8 puntos entre el segundo y tercer Text
            Text(
              email.body,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}