import 'package:escolafuracaolitoral/screens/turma_details_screen.dart';
import 'package:escolafuracaolitoral/screens/turma_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/turma_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TurmaProvider>(context, listen: false).fetchTurmas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escola Furacão Litoral'),
      ),
      body: Consumer<TurmaProvider>(
        builder: (context, turmaProvider, child) {
          if (turmaProvider.turmas.isEmpty) {
            return Center(
              child: Text(
                'Nenhuma turma cadastrada.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ListView.builder(
            itemCount: turmaProvider.turmas.length,
            itemBuilder: (context, index) {
              final turma = turmaProvider.turmas[index];
              return ListTile(
                title: Text(turma.nome, style: TextStyle(color: Colors.white)),
                subtitle: Text('${turma.diasDeTreino} - ${turma.horario}',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TurmaDetailsScreen(turma: turma),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TurmaFormScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}