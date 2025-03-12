import 'package:escolafuracaolitoral/screens/turma_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/turma.dart';
import '../providers/turma_provider.dart';
import '../widgets/aluno_list_widget.dart';
import 'aluno_form_screen.dart';
import 'chamada_screen.dart';
import 'historico_chamadas_screen.dart';

class TurmaDetailsScreen extends StatelessWidget {
  final Turma turma;

  TurmaDetailsScreen({required this.turma});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Turma'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TurmaFormScreen(turma: turma),
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
              'Nome: ${turma.nome}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Dias de Treino: ${turma.diasDeTreino}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Horário: ${turma.horario}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 8.0, // Espaçamento horizontal entre os botões
              runSpacing: 8.0, // Espaçamento vertical entre as linhas
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChamadaScreen(turma: turma),
                      ),
                    );
                  },
                  child: Text('Fazer Chamada'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoricoChamadasScreen(turma: turma),
                      ),
                    );
                  },
                  child: Text('Histórico de Chamadas'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlunoFormScreen(turmaId: turma.id!),
                      ),
                    );
                  },
                  child: Text('Adicionar Aluno'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Alunos:',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Expanded(
              child: AlunoListWidget(turmaId: turma.id!),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<TurmaProvider>(context, listen: false).deleteTurma(
                    turma.id!);
                Navigator.pop(context);
              },
              child: Text('Deletar Turma'),
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