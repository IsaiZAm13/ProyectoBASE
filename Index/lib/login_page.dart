import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo.jpg', height: 50),
            SizedBox(width: 10),
            Text('TechRecycler'),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo_logging.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Inicio de Sesión',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Iniciar Sesión'),
                    onPressed: () {
                      // Para llegar a productos
                      Navigator.pushReplacementNamed(context, '/EcoAmigoPage');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    child: Text('¿No tienes una cuenta? Regístrate aquí'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/UserAdminPage');
                      // Para ir al registro
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
