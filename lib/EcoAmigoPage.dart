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
              _buildStatsSection(),
            ],
          ),
        ),
      ),
    );
  }

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
                labelText: 'Cantidad (kg)',
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

  Widget _buildStatsSection() {
    return Card(
      color: Colors.lightGreen[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Tus Estadísticas de Reciclaje',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800]),
            ),
            SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildStatItem('📈', 'Puntos Totales', '1,250'),
                _buildStatItem('📅', 'Días Consecutivos', '15'),
                _buildStatItem('🌎', 'CO2 Ahorrado (kg)', '75.3'),
                _buildStatItem('🏆', 'Ranking', '#42'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String icon, String label, String value) {
    return Card(
      color: Colors.green[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 14)),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900]),
            ),
          ],
        ),
      ),
    );
  }
}
