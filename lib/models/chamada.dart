import 'package:escolafuracaolitoral/models/presenca.dart';

class Chamada {
  int? id;
  int turmaId;
  String data;
  List<Presenca> presencas;

  Chamada(
      {this.id, required this.turmaId, required this.data, required this.presencas});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'turmaId': turmaId,
      'data': data,
    };
  }

  factory Chamada.fromMap(Map<String, dynamic> map, List<Presenca> presencas) {
    return Chamada(
      id: map['id'],
      turmaId: map['turmaId'],
      data: map['data'],
      presencas: presencas,
    );
  }
}