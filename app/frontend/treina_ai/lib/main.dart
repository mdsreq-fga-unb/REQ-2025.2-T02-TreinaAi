import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;
import 'ui/register_page.dart';
import 'ui/student_search_screen.dart';
import 'ui/periodo_page.dart'; // adicionei sua página
import 'data/users_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inicializa sqflite (para rodar no desktop)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // checa se o usuário está registrado antes de rodar o app
  final user = await DatabaseHelper.instance.getFirstUser();
  final bool registered = user != null;

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
      // troquei o home para a página de teste
      home: TestPages(isUserRegistered: isUserRegistered),
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
