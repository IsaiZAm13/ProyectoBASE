import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserAdminPage extends StatefulWidget {
  @override
  _UserAdminPageState createState() => _UserAdminPageState();
}

class _UserAdminPageState extends State<UserAdminPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();
  final _passwordController = TextEditingController();

  // Lista de usuarios que se mostrarán en el front-end
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();  // Cargar la lista de usuarios al iniciar
  }

  // Obtener la lista de usuarios de la API
  Future<void> _fetchUsers() async {
    try {
      final url = Uri.parse('http://localhost:8080/api/usuarios/todos');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          users = data.map((user) => User.fromJson(user)).toList();
        });
      } else {
        throw Exception('Error al cargar los usuarios');
      }
    } catch (error) {
      print('Error fetching users: $error');
    }
  }

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

  // Tabla para mostrar los usuarios
  Widget _buildUserTable() {
    return Card(
      child: DataTable(
        columns: [
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Rol')),
          DataColumn(label: Text('Pass')),
        ],
        rows: users.map((user) {
          return DataRow(cells: [
            DataCell(Text(user.name)),
            DataCell(Text(user.apellido)),
            DataCell(Text(user.role)),
            DataCell(Text(user.password)),
      
          ]);
        }).toList(),
      ),
    );
  }

  // Formulario para agregar un nuevo usuario
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
              SizedBox(height: 10),
              TextFormField(
                controller: _roleController,
                decoration: InputDecoration(
                  labelText: 'Rol',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un rol';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
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

  // Llamada a la API para crear el usuario
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Crear el nuevo usuario
      final newUser = User(
        name: _nameController.text,
        apellido: _emailController.text,
        role: _roleController.text,
        password: _passwordController.text,
      );

      // Llamar al método para crear el usuario en la API
      await _createUser(newUser);

      // Limpiar el formulario
      _nameController.clear();
      _emailController.clear();
      _roleController.clear();
      _passwordController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario creado exitosamente')),
      );
    }
  }

  // Método para enviar los datos a la API
  Future<void> _createUser(User user) async {
    final url = Uri.parse('http://localhost:8080/api/usuarios/agregar'); // Cambia esto si es necesario

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nombre': user.name,
        'apellido': user.apellido,
        'rol': user.role,
        'password': user.password,
      }),
    );

    if (response.statusCode == 200) {
      print('Usuario creado exitosamente');
      setState(() {
        users.add(user);  // Agregar usuario al front-end
      });
    } else {
      print('Error al crear el usuario: ${response.statusCode}');
      print('Detalles: ${response.body}');
    }
  }
}

// Definición de la clase User
class User {
  final String name;
  final String apellido;
  final String role;
  final String password;

  User({
    required this.name,
    required this.apellido,
    required this.role,
    required this.password,
  });

  // Convertir el objeto User a un mapa para enviarlo como JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': name,
      'apellido': apellido,
      'rol': role,
      'password': password,
    };
  }

  // Crear un User desde un mapa (por ejemplo, el recibido de la API)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['nombre'],
      apellido: json['email'],
      role: json['rol'],
      password: json['password'],  // Considera si lo necesitas o no
    );
  }
}






