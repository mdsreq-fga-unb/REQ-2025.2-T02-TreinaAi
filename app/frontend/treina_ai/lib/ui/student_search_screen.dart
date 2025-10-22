import 'package:flutter/material.dart';
import 'components.dart';

class StudentSearchScreen extends StatefulWidget {
  const StudentSearchScreen({super.key});

  @override
  State<StudentSearchScreen> createState() => _StudentSearchScreenState();
}

class _StudentSearchScreenState extends State<StudentSearchScreen> {
  final List<Student> activeStudents = [
    Student(name: 'Maria Fernandez', isActive: true),
    Student(name: 'Eduardo Menezes', isActive: true),
    Student(name: 'Mateus Fernandes', isActive: true),
    Student(name: 'João Gabriel Freitas', isActive: true),
  ];

  final List<Student> inactiveStudents = [
    Student(name: 'Carlos Silva', isActive: false),
    Student(name: 'Ana Oliveira', isActive: false),
    Student(name: 'Pedro Santos', isActive: false),
  ];

  List<Student> filteredActiveStudents = [];
  List<Student> filteredInactiveStudents = [];
  final TextEditingController searchController = TextEditingController();
  bool _showInactiveStudents = false;

  @override
  void initState() {
    super.initState();
    filteredActiveStudents = activeStudents;
    filteredInactiveStudents = inactiveStudents;
    searchController.addListener(_filterStudents);
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Aluno'),
        content: const Text(
            'Integrar com o backEnd..'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onStudentTap(Student student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(student.name),
        content: Text(
            'Aluno ${student.isActive ? 'Ativo' : 'Inativo'}\n\nIntegrar com o backEnd.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('FECHAR'),
          ),
        ],
      ),
    );
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
        child: ListView(children: const []),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Olá, Gustavo', style: titleText),
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

            //lIST OF STUDENTS
            Expanded(
              child: SingleChildScrollView(
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
              child: DarkRoundedButton(
                text: _showInactiveStudents
                    ? 'Ocultar alunos inativos'
                    : 'Alunos inativos',
                onPressed: _toggleInactiveStudents,
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
  
  Student({required this.name, required this.isActive});
}