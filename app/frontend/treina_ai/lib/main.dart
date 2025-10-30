import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;
import 'ui/register_page.dart';
import 'ui/student_search_screen.dart';
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
      home: isUserRegistered ? StudentSearchScreen() : RegisterPage(), // vai pra register_page se não registrado else vai pra student_search_screen
    );
  }
}
