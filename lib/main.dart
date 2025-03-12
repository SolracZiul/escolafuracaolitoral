import 'package:escolafuracaolitoral/providers/aluno_provider.dart';
import 'package:escolafuracaolitoral/providers/chamada_provider.dart';
import 'package:escolafuracaolitoral/providers/turma_provider.dart';
import 'package:escolafuracaolitoral/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TurmaProvider()),
        ChangeNotifierProvider(create: (_) => AlunoProvider()),
        ChangeNotifierProvider(create: (_) => ChamadaProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Adicione esta linha
        title: 'Escola Furacão Litoral',
        theme: ThemeData(
          primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red,
          ),
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}