import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/turma.dart';

class TurmaProvider with ChangeNotifier {
  List<Turma> _turmas = [];

  List<Turma> get turmas => [..._turmas];

  Future<void> fetchTurmas() async {
    final dataList = await DatabaseHelper.instance.getTurmas();
    _turmas = dataList;
    notifyListeners();
  }

  Future<void> addTurma(Turma turma) async {
    await DatabaseHelper.instance.insertTurma(turma);
    await fetchTurmas();
  }

  Future<void> updateTurma(Turma turma) async {
    await DatabaseHelper.instance.updateTurma(turma);
    await fetchTurmas();
  }

  Future<void> deleteTurma(int id) async {
    await DatabaseHelper.instance.deleteTurma(id);
    await fetchTurmas();
  }
}