import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProvider();

  String seleccion = '';
  final peliculas = [
    "Spiderman",
    "Batman",
    "Iron Man",
    "Shazam",
    "Wonder Woman",
    "Capitan America",
  ];
  final peliculasRecientes = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultado que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Las sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            return ListView(
                children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/img/no-image.jpg',
                        fit: BoxFit.fitWidth);
                  },
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  pelicula.uniqueId = '';
                  close(context, null);
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

//buildSuggestions
//  @override
//     Widget buildSuggestions(BuildContext context) {
// final listaSugerida = ( query.isEmpty )
//                           ? peliculasRecientes
//                           : peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase() )
//                           ).toList();

//     return ListView.builder(
//       itemCount: listaSugerida.length,
//       itemBuilder: (context,i ){
//         return ListTile(
//           leading: Icon(Icons.movie),
//           title: Text(listaSugerida[i]),
//           onTap: (){
//             seleccion = listaSugerida[i];
//             showResults(context);
//           },
//         );
//       },
//       );
}
