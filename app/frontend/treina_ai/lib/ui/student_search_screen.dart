import 'package:flutter/material.dart';
import 'components.dart';
import 'student_register_page.dart';
import 'student_page.dart';
import 'edit_user_page.dart';
import '../data/users_database.dart';
import '../data/clients_database.dart';
import '../models/user.dart';
import '../models/client.dart';


class StudentSearchScreen extends StatefulWidget {
  const StudentSearchScreen({super.key});

  @override
  State<StudentSearchScreen> createState() => _StudentSearchScreenState();
}

class _StudentSearchScreenState extends State<StudentSearchScreen> {
  List<Student> activeStudents = [];
  List<Student> inactiveStudents = [];

  List<Student> filteredActiveStudents = [];
  List<Student> filteredInactiveStudents = [];
  final TextEditingController searchController = TextEditingController();
  bool _showInactiveStudents = false;
  User? _primeiroUsuario;
  bool _loadingUsuario = true;
  bool _loadingStudents = true;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterStudents);
    _loadFirstUser();
    _loadStudentsFromDatabase();
  }

  Future<void> _loadStudentsFromDatabase() async {
    try {
      final clients = await ClientsDatabase.instance.getClients();
      
      setState(() {
        activeStudents = clients
            .map((client) => Student(
                  name: client.name,
                  isActive: true,
                  client: client,
                ))
            .toList();
        inactiveStudents = [];
        filteredActiveStudents = activeStudents;
        filteredInactiveStudents = inactiveStudents;
        _loadingStudents = false;
      });
    } catch (e) {
      debugPrint('Erro ao carregar alunos: $e');
      setState(() {
        _loadingStudents = false;
      });
    }
  }

  Future<void> _loadFirstUser() async {
    try {
      final user = await DatabaseHelper.instance.getFirstUser();
      setState(() {
        _primeiroUsuario = user;
        _loadingUsuario = false;
      });
    } catch (e) {
      setState(() {
        _primeiroUsuario = null;
        _loadingUsuario = false;
      });
    }
  }

  void _filterStudents() {
    final query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredActiveStudents = activeStudents;
        filteredInactiveStudents = inactiveStudents;
      } else {
        filteredActiveStudents = activeStudents
            .where((s) => s.name.toLowerCase().contains(query))
            .toList();
        filteredInactiveStudents = inactiveStudents
            .where((s) => s.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _addNewStudent() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentRegisterPage(
          onSuccess: () {
            // Recarregar a lista de alunos após o cadastro
            _loadStudentsFromDatabase();
          },
        ),
      ),
    );
  }

  void _onStudentTap(Student student) {
    if (student.client != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentPage(
            studentName: student.client!.name,
            studentDescription: student.client!.desc ?? 'Sem descrição',
            studentImageUrl: student.client!.photoPath,
            periodosAtivos: [],
            periodosFechados: [],
            client: student.client!,
            onEditProfile: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Editar perfil em desenvolvimento')),
              );
            },
            onAddPeriodo: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Adicionar período em desenvolvimento')),
              );
            },
            onTapPeriodoAtivo: (periodo) {
            },
            onTapPeriodoFechado: (periodo) {
            },
          ),
        ),
      ).then((value) {
        // Recarregar alunos quando voltar da StudentPage
        if (value == true) {
          _loadStudentsFromDatabase();
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar dados do aluno')),
      );
    }
  }

  void _toggleInactiveStudents() {
    setState(() {
      _showInactiveStudents = !_showInactiveStudents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gradientStart, gradientEnd],
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: primaryRed),
              title: const Text('Editar Usuário'),
              onTap: () {
                Navigator.pop(context); // Fecha a drawer
                if (_primeiroUsuario != null && _primeiroUsuario!.codUser != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUserPage(
                        user: _primeiroUsuario!,
                        codUser: _primeiroUsuario!.codUser.toString(),
                      ),
                    ),
                  ).then((value) {
                    if (value == true) {
                      // Recarregar os dados do usuário após edição
                      _loadFirstUser();
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro: Usuário não encontrado'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Olá, ${_loadingUsuario ? '...' : (_primeiroUsuario?.name ?? 'Visitante')}', style: titleText),
            const SizedBox(height: 16),
            TextField(
              controller: searchController,
              decoration: searchInputDecoration('Pesquisar aluno...'),
            ),
            const SizedBox(height: 16),

            //"+" Button to add new student
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                width: double.infinity,
                child: BorderedButton(
                text: '+',
                onPressed: _addNewStudent,
             ),
           ),
          ),


            const SizedBox(height: 16),

            // List of students
            Expanded(
              child: _loadingStudents
                  ? const Center(
                      child: CircularProgressIndicator(color: primaryRed),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ...filteredActiveStudents.map(
                            (s) => StudentCard(
                              name: s.name,
                              isActive: s.isActive,
                              onTap: () => _onStudentTap(s),
                            ),
                          ),
                          if (_showInactiveStudents) ...[
                            const SizedBox(height: 16),
                            ...filteredInactiveStudents.map(
                              (s) => StudentCard(
                                name: s.name,
                                isActive: s.isActive,
                                onTap: () => _onStudentTap(s),
                              ),
                            ),
                          ],
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
            ),

            //Inactive Students Button
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: DarkRoundedButton(
                  text: _showInactiveStudents
                      ? 'Ocultar alunos inativos'
                      : 'Alunos inativos',
                  onPressed: _toggleInactiveStudents,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class Student {
  final String name;
  final bool isActive;
  final Client? client;
  
  Student({
    required this.name,
    required this.isActive,
    this.client,
  });
}