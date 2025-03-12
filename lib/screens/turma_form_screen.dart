import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/turma.dart';
import '../providers/turma_provider.dart';

class TurmaFormScreen extends StatefulWidget {
  final Turma? turma;

  TurmaFormScreen({this.turma});

  @override
  _TurmaFormScreenState createState() => _TurmaFormScreenState();
}

class _TurmaFormScreenState extends State<TurmaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _diasDeTreinoController = TextEditingController();
  final _horarioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.turma != null) {
      _nomeController.text = widget.turma!.nome;
      _diasDeTreinoController.text = widget.turma!.diasDeTreino;
      _horarioController.text = widget.turma!.horario;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _diasDeTreinoController.dispose();
    _horarioController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final turma = Turma(
        id: widget.turma?.id,
        nome: _nomeController.text,
        diasDeTreino: _diasDeTreinoController.text,
        horario: _horarioController.text,
      );

      if (widget.turma == null) {
        Provider.of<TurmaProvider>(context, listen: false).addTurma(turma);
      } else {
        Provider.of<TurmaProvider>(context, listen: false).updateTurma(turma);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.turma == null ? 'Nova Turma' : 'Editar Turma'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nome da Turma',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da turma';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _diasDeTreinoController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Dias de Treino',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira os dias de treino';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _horarioController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Horário',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o horário';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}