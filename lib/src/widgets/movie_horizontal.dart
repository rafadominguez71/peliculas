import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  MovieHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize= MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height*0.3,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        children: _tarjetas(),
      ),
    );
  }

  List<Widget>_tarjetas() {
    return peliculas.map((peliculas) {
      return Container(
        margin: EdgeInsets.only(right:15.0),
        child: Column(
          children:<Widget> [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(peliculas.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 170.0,
                ),
              )
          ],
        ),
      );
    }).toList();
  }
}