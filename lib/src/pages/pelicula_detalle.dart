
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
class PeliculaDetalle extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget> [
            _crearAppbar(pelicula),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height:10.0),
                  _posterTitulo(context, pelicula),
                  _descripcion(pelicula),
                   _crearCasting(pelicula),
                ]
 
              ),
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
     padding: EdgeInsets.symmetric(horizontal:20.0),
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
         SizedBox(width: 20.0,),
         Flexible(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(pelicula.title, style: Theme.of(context).textTheme.headline6,overflow: TextOverflow.ellipsis,),
               Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.ellipsis,),
               Row(
                 children: [
                   Icon(Icons.star_border),
                   Text(pelicula.voteAverage.toString(),style: Theme.of(context).textTheme.subtitle1)
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
     padding: EdgeInsets.symmetric(horizontal: 10.0, vertical:20.0),
     child: Text(
       pelicula.overview,
       textAlign: TextAlign.justify,
     ),
   );
 }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider  = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return _crearActoresPageView(snapshot.data);
        }else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _crearActoresPageView(List <Actor>actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
         pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
       itemCount: actores.length,
       itemBuilder: (context,i) => _actorTarjeta(actores[i]),

      ),
    );

  }
  Widget _actorTarjeta(Actor actor){
    return Container(
      child: Column(
       mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius : BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder:  AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
             )
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

  }
}