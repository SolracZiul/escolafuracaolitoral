import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/aluno.dart';
import '../providers/aluno_provider.dart';
import 'aluno_form_screen.dart';

class AlunoDetailsScreen extends StatelessWidget {
  final Aluno aluno;

  AlunoDetailsScreen({required this.aluno});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Aluno'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AlunoFormScreen(aluno: aluno, turmaId: aluno.turmaId),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${aluno.nome}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<AlunoProvider>(context, listen: false).deleteAluno(
                    aluno.id!, aluno.turmaId);
                Navigator.pop(context);
              },
              child: Text('Deletar Aluno'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}