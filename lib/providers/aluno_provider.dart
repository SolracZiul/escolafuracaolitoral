import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/aluno.dart';

class AlunoProvider with ChangeNotifier {
  List<Aluno> _alunos = [];

  List<Aluno> get alunos => [..._alunos];

  Future<void> fetchAlunos(int turmaId) async {
    final dataList = await DatabaseHelper.instance.getAlunos(turmaId);
    _alunos = dataList;
    notifyListeners();
  }

  Future<void> addAluno(Aluno aluno) async {
    await DatabaseHelper.instance.insertAluno(aluno);
    await fetchAlunos(aluno.turmaId);
  }

  Future<void> updateAluno(Aluno aluno) async {
    await DatabaseHelper.instance.updateAluno(aluno);
    await fetchAlunos(aluno.turmaId);
  }

  Future<void> deleteAluno(int id, int turmaId) async {
    await DatabaseHelper.instance.deleteAluno(id);
    await fetchAlunos(turmaId);
  }
}