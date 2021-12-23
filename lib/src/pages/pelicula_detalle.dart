// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/models/video_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _crearAppbar(pelicula),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 10.0),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _crearLinkTrailer(pelicula),
                _crearCasting(pelicula),
                // SizedBox(height: 10.0),
   
              ]),
            )
          ];
        },
        body: Text(''),
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 144.3,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(fontFamily: 'descripcion', fontSize: 14.0),
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(actor.getFoto()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                height: 150.0,
                fit: BoxFit.cover,
              )),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: 'nombreactor'),
          )
        ],
      ),
    );
  }

  Widget _crearBotonVerTrailer(Video video, BuildContext context, Pelicula pelicula) {
    // ignore: duplicate_ignore
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 140.0, vertical: 10.0),
      // ignore: deprecated_member_use
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90.0),
        child: FlatButton(
          onPressed: () {
            final trailer = "https://www.youtube.com/watch?v=" + video.key;
            _launchURL(trailer);
          },
          padding: EdgeInsets.zero,
          child: Text(
            'VER TRAILER',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.indigoAccent,
        ),
      ),
    );
  }

  

  Widget _crearLinkTrailer(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.trailerPelicula(pelicula.id.toString()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _crearBotonVerTrailer(snapshot.data, context, pelicula);
        } else
          return Container();
      },
    );
  }
 void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
  }
}
