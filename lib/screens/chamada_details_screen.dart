import 'package:flutter/material.dart';
import '../models/chamada.dart';

class ChamadaDetailsScreen extends StatelessWidget {
  final Chamada chamada;

  ChamadaDetailsScreen({required this.chamada});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Chamada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data: ${chamada.data}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Alunos Presentes:',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chamada.presencas.length,
                itemBuilder: (context, index) {
                  final presenca = chamada.presencas[index];
                  return ListTile(
                    title: Text(
                      'Aluno ID: ${presenca.alunoId}',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      presenca.presente ? Icons.check : Icons.close,
                      color: presenca.presente ? Colors.green : Colors.red,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}