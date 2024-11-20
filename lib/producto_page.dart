import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  int _currentIndex = 0;
  List<String> productTitles = ['Producto 1', 'Producto 2', 'Producto 3', 'Producto 4', 'Producto 5'];
  List<String> productAvailability = ['7 unidades disponibles', '5 unidades disponibles', '10 unidades disponibles', '3 unidades disponibles', '8 unidades disponibles'];
  List<String> productCosts = ['Costo: 500 pts', 'Costo: 750 pts', 'Costo: 1000 pts', 'Costo: 1500 pts', 'Costo: 2000 pts'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo.jpg', height: 50),
            SizedBox(width: 10),
            Text('Green Cycle'),
          ],
        ),
        backgroundColor: Colors.green,
        actions: [
          Center(child: Text('Puntos: 0')),
          TextButton(
            child: Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
            onPressed: () {
              // Para Volver a inicio de sesion
                      Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildWelcomeSection(),
            _buildRecyclableMaterialsSection(),
            _buildLocationSection(),
            _buildProductCarousel(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          // Scroll to top
        },
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bienvenidos a TechRecycler', 
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Nuestro propósito', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'En TechRecycler buscamos fomentar el reciclaje en la gente, queremos que vean que hay valor en los objetos que ellos llaman basura, por esto mismo y a raiz de un pequeño producto desarrollado en la universidad estamos implementando un sistema de reciclaje que permita a los usuarios canjear sus materiales de reciclaje por puntos que pueden ser canjeados por productos comunes, entre dichos productos comunes encontramos la canasta basica que puede ser desde rollo hasta aceite de cocina, y en casos de mas puntos tenemos un premio mayor, un Playstation 5',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildRecyclableMaterialsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Materiales que puedes reciclar', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Image.asset('assets/producto_imagen_de_reciclaje1.jpg'),
          SizedBox(height: 18),
          Text('Materiales admitidos:', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Botellas de plastico',
              'Tapas y tapones de plastico',
              'Latas de aluminio',
              'Carton',
              'Papel',
            ].map((item) => Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Row(
                children: [
                  Icon(Icons.eco, color: Colors.green),
                  SizedBox(width: 8),
                  Text(item),
                ],
              ),
            )).toList(),
          ),
          SizedBox(height: 16),
          Text(
            'Con nuestra iniciativa buscamos reciclar y reutilizar materiales para reducir el impacto ambiental, por ello establecimos varios puntos en la ciudad donde se pueden depositar materiales reciclables, estos materiales seran evaluados por nuestros dependientes y se añadiran puntos en funcion del tipo de material y el gramaje de este.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text('Tipo de conversión:', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Botellas de plastico: 10 puntos por cada 500 gramos',
              'Tapas y tapones de plastico: 10 puntos por cada 50 gramos',
              'Aluminio: 10 puntos cada 50 gramos',
              'Carton: 10 puntos por cada 500 gramos',
              'Vidrio: 10 puntos por cada 300 gramos',
            ].map((item) => Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Row(
                children: [
                  Icon(Icons.recycling, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nuestras sucursales:', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Dirección: Ave. Cristóbal Colón 2059 Esq, 20 de Noviembre, 64480 Monterrey, Nuevo León'),
          Text('81 3402 2994'),
          Text('Lunes a viernes de 8am a 6pm'),
        ],
      ),
    );
  }

  Widget _buildProductCarousel() {
  return Column(
    children: [
      Text('Algunos productos que puedes canjear son:', 
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      SizedBox(height: 16),
      Container(
        height: 250, // Altura para el espacio de img
        width: double.infinity, // Asegura que el contenedor tome todo el ancho disponible
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Fondo gris claro para las imágenes
              ),
              child: Image.asset(
                'assets/producto${index + 1}.jpg',
                fit: BoxFit.contain, // Cambiamos a 'contain' para mostrar la imagen completa
              ),
            );
          },
          itemCount: 5,
          pagination: SwiperPagination(),
          control: SwiperControl(),
          onIndexChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      SizedBox(height: 16),
      Text(productTitles[_currentIndex], 
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Text(productAvailability[_currentIndex]),
      Text(productCosts[_currentIndex]),
    ],
  );
}
}