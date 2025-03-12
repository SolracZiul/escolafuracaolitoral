import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/aluno.dart';
import '../providers/aluno_provider.dart';

class AlunoFormScreen extends StatefulWidget {
  final Aluno? aluno;
  final int turmaId;

  AlunoFormScreen({this.aluno, required this.turmaId});

  @override
  _AlunoFormScreenState createState() => _AlunoFormScreenState();
}

class _AlunoFormScreenState extends State<AlunoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.aluno != null) {
      _nomeController.text = widget.aluno!.nome;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final aluno = Aluno(
        id: widget.aluno?.id,
        nome: _nomeController.text,
        turmaId: widget.turmaId,
      );

      if (widget.aluno == null) {
        Provider.of<AlunoProvider>(context, listen: false).addAluno(aluno);
      } else {
        Provider.of<AlunoProvider>(context, listen: false).updateAluno(aluno);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.aluno == null ? 'Novo Aluno' : 'Editar Aluno'),
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
                  labelText: 'Nome do Aluno',
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
                    return 'Por favor, insira o nome do aluno';
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