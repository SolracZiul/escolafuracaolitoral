import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/aluno_provider.dart';
import '../screens/aluno_details_screen.dart';

class AlunoListWidget extends StatelessWidget {
  final int turmaId;

  AlunoListWidget({required this.turmaId});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlunoProvider>(
      builder: (context, alunoProvider, child) {
        if (alunoProvider.alunos.isEmpty) {
          return Center(
            child: Text(
              'Nenhum aluno cadastrado nesta turma.',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return ListView.builder(
          itemCount: alunoProvider.alunos.length,
          itemBuilder: (context, index) {
            final aluno = alunoProvider.alunos[index];
            return ListTile(
              title: Text(aluno.nome, style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlunoDetailsScreen(aluno: aluno),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}