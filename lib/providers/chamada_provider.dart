import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/chamada.dart';

class ChamadaProvider with ChangeNotifier {
  List<Chamada> _chamadas = [];

  List<Chamada> get chamadas => [..._chamadas];

  Future<void> fetchChamadas(int turmaId) async {
    final dataList = await DatabaseHelper.instance.getChamadas(turmaId);
    _chamadas = dataList;
    notifyListeners();
  }

  Future<void> addChamada(Chamada chamada) async {
    await DatabaseHelper.instance.insertChamada(chamada);
    await fetchChamadas(chamada.turmaId);
  }

  Future<void> deleteChamada(int id, int turmaId) async {
    await DatabaseHelper.instance.deleteChamada(id);
    await fetchChamadas(turmaId);
  }
}