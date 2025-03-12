class Presenca {
  int? id;
  int chamadaId;
  int alunoId;
  bool presente;

  Presenca(
      {this.id, required this.chamadaId, required this.alunoId, required this.presente});

  Presenca copyWith({int? chamadaId}) {
    return Presenca(
      id: this.id,
      chamadaId: chamadaId ?? this.chamadaId,
      alunoId: this.alunoId,
      presente: this.presente,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chamadaId': chamadaId,
      'alunoId': alunoId,
      'presente': presente ? 1 : 0, // Convertendo bool para int
    };
  }

  factory Presenca.fromMap(Map<String, dynamic> map) {
    return Presenca(
      id: map['id'],
      chamadaId: map['chamadaId'],
      alunoId: map['alunoId'],
      presente: map['presente'] == 1, // Convertendo int para bool
    );
  }
}