import 'package:flutter/material.dart';

class EcoAmigoPage extends StatefulWidget {
  @override
  _EcoAmigoPageState createState() => _EcoAmigoPageState();
}

class _EcoAmigoPageState extends State<EcoAmigoPage> {
  String? selectedMaterial;
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('♻Green Cycle'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildPointsSection(),
              SizedBox(height: 20),
              _QuitarPuntos(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

// Widget para otorgar puntos
  Widget _buildPointsSection() {
    return Card(
      color: Colors.lightGreen[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Otorgar Puntos por Reciclaje',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800]),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedMaterial,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              hint: Text('Selecciona el material'),
              items: ['Plástico', 'Papel', 'Vidrio', 'Metal']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedMaterial = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Puntos (kg)',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
             SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Id',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Otorgar Puntos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                // Aquí iría la lógica para otorgar puntos
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Puntos otorgados')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget para quitar puntos

   Widget _QuitarPuntos() {
    return Card(
      color: Colors.lightGreen[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Quitar Puntos por Reciclaje',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800]),
            ),
            SizedBox(height: 16),
            
        
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Cantidad de Puntos',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
             SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Id',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Quitar Puntos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                // Aquí iría la lógica para otorgar puntos
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Puntos otorgados')),
                );
              },
            ),
          ],
        ),
      ),
    );
  } 
}
