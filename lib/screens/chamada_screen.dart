import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/aluno.dart';
import '../models/chamada.dart';
import '../models/presenca.dart';
import '../models/turma.dart';
import '../providers/aluno_provider.dart';
import '../providers/chamada_provider.dart';

class ChamadaScreen extends StatefulWidget {
  final Turma turma;

  ChamadaScreen({required this.turma});

  @override
  _ChamadaScreenState createState() => _ChamadaScreenState();
}

class _ChamadaScreenState extends State<ChamadaScreen> {
  List<Presenca> presencas = [];
  late DateTime selectedDate;
  List<Aluno> alunos = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _loadChamada();
  }

  Future<void> _loadChamada() async {
    await Provider.of<AlunoProvider>(context, listen: false).fetchAlunos(
        widget.turma.id!);
    alunos = Provider
        .of<AlunoProvider>(context, listen: false)
        .alunos;
    await Provider.of<ChamadaProvider>(context, listen: false).fetchChamadas(
        widget.turma.id!);
    final chamadas = Provider
        .of<ChamadaProvider>(context, listen: false)
        .chamadas;
    final chamadaExistente = chamadas.firstWhere(
          (c) =>
      c.turmaId == widget.turma.id &&
          c.data == DateFormat('dd/MM/yyyy').format(selectedDate),
      orElse: () => Chamada(turmaId: -1, data: '', presencas: []),
    );

    if (chamadaExistente.turmaId != -1) {
      setState(() {
        presencas = chamadaExistente.presencas;
      });
    } else {
      setState(() {
        presencas = alunos.map((aluno) =>
            Presenca(alunoId: aluno.id!, presente: false, chamadaId: -1))
            .toList();
      });
    }
  }

  void _togglePresenca(int alunoId) {
    setState(() {
      final index = presencas.indexWhere((p) => p.alunoId == alunoId);
      if (index != -1) {
        presencas[index].presente = !presencas[index].presente;
      }
    });
  }

  void _saveChamada() {
    final chamada = Chamada(
      id: presencas.any((p) => p.presente) ? null : null,
      turmaId: widget.turma.id!,
      data: DateFormat('dd/MM/yyyy').format(selectedDate),
      presencas: presencas,
    );
    Provider.of<ChamadaProvider>(context, listen: false).addChamada(chamada);
    Navigator.pop(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _loadChamada();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chamada - ${widget.turma.nome}'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Consumer<AlunoProvider>(
        builder: (context, alunoProvider, child) {
          if (alunoProvider.alunos.isEmpty) {
            return Center(
              child: Text(
                'Nenhum aluno cadastrado nesta turma.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Data: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Selecionar Data'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: alunoProvider.alunos.length,
                  itemBuilder: (context, index) {
                    final aluno = alunoProvider.alunos[index];
                    final isPresente = presencas.any((p) =>
                    p.alunoId == aluno.id && p.presente);
                    return ListTile(
                      title: Text(aluno.nome, style: TextStyle(color: Colors
                          .white)),
                      trailing: Checkbox(
                        value: isPresente,
                        onChanged: (value) => _togglePresenca(aluno.id!),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _saveChamada,
                  child: Text('Salvar Chamada'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}