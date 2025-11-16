import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;
import 'ui/register_page.dart';
import 'ui/student_search_screen.dart';
import 'ui/periodo_page.dart'; 
import 'data/users_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inicializa sqflite (para rodar no desktop)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // DESCOMENTE a linha abaixo para resetar o banco DEPOIS que as tabelas foram criadas
  //await DatabaseHelper.instance.resetDatabase();

  // checa se o usuário está registrado antes de rodar o app
  bool registered = false;
  try {
    final user = await DatabaseHelper.instance.getFirstUser();
    registered = user != null;
  } catch (e, st) {
    debugPrint('Erro ao verificar usuário: $e\n$st');
    // Se houver erro ao ler DB, assume não registrado (irá resetar DB se necessário)
    registered = false;
  }

  runApp(MyApp(isUserRegistered: registered));
}

class MyApp extends StatelessWidget {
  final bool isUserRegistered;

  const MyApp({super.key, required this.isUserRegistered});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TreinaAí',
       home: isUserRegistered ? StudentSearchScreen() : RegisterPage(), // vai pra register_page se não registrado else vai pra student_search_screen
    );
  }
}

class TestPages extends StatelessWidget {
  final bool isUserRegistered;

  const TestPages({super.key, required this.isUserRegistered});

  @override
  Widget build(BuildContext context) {
    // mapa das páginas que quer testar
    final pages = {
      'Register Page': RegisterPage(),
      'Student Search': StudentSearchScreen(),
      'Periodo Page': PeriodoPage(),
      // adicione outras páginas aqui
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Test Pages')),
      body: ListView(
        children: pages.entries.map((entry) {
          return ListTile(
            title: Text(entry.key),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => entry.value),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
