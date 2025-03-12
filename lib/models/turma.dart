class Turma {
  int? id;
  String nome;
  String diasDeTreino;
  String horario;

  Turma(
      {this.id, required this.nome, required this.diasDeTreino, required this.horario});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'diasDeTreino': diasDeTreino,
      'horario': horario,
    };
  }

  factory Turma.fromMap(Map<String, dynamic> map) {
    return Turma(
      id: map['id'],
      nome: map['nome'],
      diasDeTreino: map['diasDeTreino'],
      horario: map['horario'],
    );
  }
}