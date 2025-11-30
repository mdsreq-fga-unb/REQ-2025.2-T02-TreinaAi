import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;
import 'ui/register_page.dart';
import 'ui/student_search_screen.dart';
import 'data/users_database.dart';
import 'package:window_manager/window_manager.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar tamanho da janela para simular celular em pé (portrait) - proporção 9:16
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    // 420px de largura = 9 unidades, então altura = 420 * 16 / 9 = 746.67px
    const windowSize = Size(420, 746);
    await windowManager.setSize(windowSize);
    await windowManager.setMinimumSize(const Size(360, 640));
    await windowManager.setMaximumSize(const Size(420, 746));
    await windowManager.center();
  }

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

