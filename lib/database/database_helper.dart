import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/aluno.dart';
import '../models/chamada.dart';
import '../models/presenca.dart';
import '../models/turma.dart';

class DatabaseHelper {
  static const _databaseName = "ChamadaApp.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE turmas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        diasDeTreino TEXT NOT NULL,
        horario TEXT NOT NULL
      )
      ''');
    await db.execute('''
      CREATE TABLE alunos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        turmaId INTEGER NOT NULL,
        nome TEXT NOT NULL,
        FOREIGN KEY (turmaId) REFERENCES turmas(id) ON DELETE CASCADE
      )
      ''');
    await db.execute('''
      CREATE TABLE chamadas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        turmaId INTEGER NOT NULL,
        data TEXT NOT NULL,
        FOREIGN KEY (turmaId) REFERENCES turmas(id) ON DELETE CASCADE
      )
      ''');
    await db.execute('''
      CREATE TABLE presencas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chamadaId INTEGER NOT NULL,
        alunoId INTEGER NOT NULL,
        presente INTEGER NOT NULL,
        FOREIGN KEY (chamadaId) REFERENCES chamadas(id) ON DELETE CASCADE,
        FOREIGN KEY (alunoId) REFERENCES alunos(id) ON DELETE CASCADE
      )
      ''');
  }

  // Métodos para Turmas
  Future<int> insertTurma(Turma turma) async {
    Database db = await instance.database;
    return await db.insert('turmas', turma.toMap());
  }

  Future<List<Turma>> getTurmas() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('turmas');
    return List.generate(maps.length, (i) {
      return Turma.fromMap(maps[i]);
    });
  }

  Future<int> updateTurma(Turma turma) async {
    Database db = await instance.database;
    return await db.update('turmas', turma.toMap(),
        where: 'id = ?', whereArgs: [turma.id]);
  }

  Future<int> deleteTurma(int id) async {
    Database db = await instance.database;
    return await db.delete('turmas', where: 'id = ?', whereArgs: [id]);
  }

  // Métodos para Alunos
  Future<int> insertAluno(Aluno aluno) async {
    Database db = await instance.database;
    return await db.insert('alunos', aluno.toMap());
  }

  Future<List<Aluno>> getAlunos(int turmaId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
        'alunos', where: 'turmaId = ?', whereArgs: [turmaId]);
    return List.generate(maps.length, (i) {
      return Aluno.fromMap(maps[i]);
    });
  }

  Future<int> updateAluno(Aluno aluno) async {
    Database db = await instance.database;
    return await db.update('alunos', aluno.toMap(),
        where: 'id = ?', whereArgs: [aluno.id]);
  }

  Future<int> deleteAluno(int id) async {
    Database db = await instance.database;
    return await db.delete('alunos', where: 'id = ?', whereArgs: [id]);
  }

  // Métodos para Chamadas
  Future<int> insertChamada(Chamada chamada) async {
    Database db = await instance.database;
    int chamadaId = await db.insert('chamadas', chamada.toMap());
    for (Presenca presenca in chamada.presencas) {
      await insertPresenca(presenca.copyWith(chamadaId: chamadaId));
    }
    return chamadaId;
  }

  Future<List<Chamada>> getChamadas(int turmaId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
        'chamadas', where: 'turmaId = ?', whereArgs: [turmaId]);
    List<Chamada> chamadas = [];
    for (Map<String, dynamic> map in maps) {
      List<Presenca> presencas = await getPresencas(map['id'] as int);
      chamadas.add(Chamada.fromMap(map, presencas));
    }
    return chamadas;
  }

  Future<int> deleteChamada(int id) async {
    Database db = await instance.database;
    return await db.delete('chamadas', where: 'id = ?', whereArgs: [id]);
  }

  // Métodos para Presenças
  Future<int> insertPresenca(Presenca presenca) async {
    Database db = await instance.database;
    return await db.insert('presencas', presenca.toMap());
  }

  Future<List<Presenca>> getPresencas(int chamadaId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
        'presencas', where: 'chamadaId = ?', whereArgs: [chamadaId]);
    return List.generate(maps.length, (i) {
      return Presenca.fromMap(maps[i]);
    });
  }
}