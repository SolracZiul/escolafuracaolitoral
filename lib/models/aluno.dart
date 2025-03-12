class Aluno {
  int? id;
  int turmaId;
  String nome;

  Aluno({this.id, required this.turmaId, required this.nome});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'turmaId': turmaId,
      'nome': nome,
    };
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'],
      turmaId: map['turmaId'],
      nome: map['nome'],
    );
  }
}