import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/aluno.dart';
import '../models/chamada.dart';
import '../models/turma.dart';
import '../providers/aluno_provider.dart';
import '../providers/chamada_provider.dart';

class HistoricoChamadasScreen extends StatefulWidget {
  final Turma turma;

  HistoricoChamadasScreen({required this.turma});

  @override
  _HistoricoChamadasScreenState createState() =>
      _HistoricoChamadasScreenState();
}

class _HistoricoChamadasScreenState extends State<HistoricoChamadasScreen> {
  List<Chamada> chamadas = [];
  List<Aluno> alunos = [];

  @override
  void initState() {
    super.initState();
    _loadChamadas();
  }

  Future<void> _loadChamadas() async {
    await Provider.of<ChamadaProvider>(context, listen: false).fetchChamadas(
        widget.turma.id!);
    await Provider.of<AlunoProvider>(context, listen: false).fetchAlunos(
        widget.turma.id!);
    setState(() {
      chamadas = Provider
          .of<ChamadaProvider>(context, listen: false)
          .chamadas;
      alunos = Provider
          .of<AlunoProvider>(context, listen: false)
          .alunos;
    });
  }

  String getAlunoName(int alunoId) {
    final aluno = alunos.firstWhere((a) => a.id == alunoId,
        orElse: () => Aluno(nome: 'Aluno não encontrado', turmaId: -1));
    return aluno.nome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Chamadas - ${widget.turma.nome}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: chamadas.isEmpty
          ? Center(
        child: Text(
          'Nenhuma chamada registrada para esta turma.',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: chamadas.length,
        itemBuilder: (context, index) {
          final chamada = chamadas[index];
          return Card(
            color: Colors.grey[800],
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data: ${DateFormat('dd/MM/yyyy').format(
                        DateFormat('dd/MM/yyyy').parse(chamada.data))}',
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  ...chamada.presencas.map((presenca) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(
                            presenca.presente ? Icons.check_circle : Icons
                                .cancel,
                            color: presenca.presente ? Colors.green : Colors
                                .red,
                          ),
                          SizedBox(width: 10),
                          Text(
                            getAlunoName(presenca.alunoId),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}