import 'package:flutter/material.dart';
import 'components.dart';

class StudentSearchScreen extends StatefulWidget {
  const StudentSearchScreen({super.key});

  @override
  _StudentSearchScreenState createState() => _StudentSearchScreenState();
}

class _StudentSearchScreenState extends State<StudentSearchScreen> {
  final List<Student> activeStudents = [
    Student(name: 'Maria Fernandes', isActive: true),
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
  TextEditingController searchController = TextEditingController();
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
            .where((student) => student.name.toLowerCase().contains(query))
            .toList();
        filteredInactiveStudents = inactiveStudents
            .where((student) => student.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _addNewStudent() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Aluno'),
        content: const Text('Funcionalidade de adicionar aluno será implementada com integração ao banco de dados.'),
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
        content: Text('Aluno ${student.isActive ? 'Ativo' : 'Inativo'}\n\nDetalhes do aluno serão exibidos aqui quando integrado com o banco de dados.'),
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
      appBar: AppBar(
        title: const Text('Oiá, Gustavo', style: titleText),
        backgroundColor: primaryRed,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            // Adicione itens do menu aqui
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: searchInputDecoration('Pesquisar aluno...'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GradientButton(
              text: '+',
              onPressed: _addNewStudent,
              width: 60,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Alunos Ativos (sempre visíveis)
                  if (filteredActiveStudents.isNotEmpty) ...[
                    SectionHeader(
                      title: 'Alunos Ativos',
                      itemCount: filteredActiveStudents.length,
                    ),
                    ...filteredActiveStudents.map((student) => StudentCard(
                          name: student.name,
                          isActive: student.isActive,
                          onTap: () => _onStudentTap(student),
                        )),
                  ],

                  // Linha divisória e botão de alunos inativos
                  if (filteredInactiveStudents.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          color: Colors.grey[300],
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            onPressed: _toggleInactiveStudents,
                            child: Text(
                              _showInactiveStudents ? 'Ocultar Alunos Inativos' : 'Alunos Inativos',
                              style: inactiveStudentsButtonStyle, // ← TROQUEI PARA O NOVO ESTILO
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),

                  // Alunos Inativos (apenas quando _showInactiveStudents for true)
                  if (_showInactiveStudents && filteredInactiveStudents.isNotEmpty) ...[
                    ...filteredInactiveStudents.map((student) => StudentCard(
                          name: student.name,
                          isActive: student.isActive,
                          onTap: () => _onStudentTap(student),
                        )),
                  ],

                  // Mensagem quando não há resultados
                  if (filteredActiveStudents.isEmpty && filteredInactiveStudents.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          'Nenhum aluno encontrado',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
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