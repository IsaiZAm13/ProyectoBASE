import 'package:flutter/material.dart';

class UserAdminPage extends StatefulWidget {
  @override
  _UserAdminPageState createState() => _UserAdminPageState();
}

class _UserAdminPageState extends State<UserAdminPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  List<User> users = [
    User(name: 'Juan Pérez', email: 'juan@example.com', isActive: true),
    User(name: 'María García', email: 'maria@example.com', isActive: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administración de Usuarios'),
        backgroundColor: Color(0xFF3498db),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildUserTable(),
              SizedBox(height: 20),
              _buildNewUserForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserTable() {
    return Card(
      child: DataTable(
        columns: [
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Estado')),
        ],
        rows: users.map((user) {
          return DataRow(cells: [
            DataCell(Text(user.name)),
            DataCell(Text(user.email)),
            DataCell(Switch(
              value: user.isActive,
              onChanged: (bool value) {
                setState(() {
                  user.isActive = value;
                });
              },
              activeColor: Color(0xFF2ecc71),
            )),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildNewUserForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Crear Nuevo Usuario',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un email';
                  }
                  if (!value.contains('@')) {
                    return 'Por favor ingrese un email válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Crear Usuario'),
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3498db),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        users.add(User(
          name: _nameController.text,
          email: _emailController.text,
          isActive: true,
        ));
      });
      _nameController.clear();
      _emailController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario creado exitosamente')),
      );
    }
  }


  

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

class User {
  final String name;
  final String email;
  bool isActive;

  User({required this.name, required this.email, required this.isActive});
}
