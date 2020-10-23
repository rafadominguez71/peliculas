import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
class HomePage extends StatelessWidget {
    final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
           _popular(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
  return FutureBuilder(
    future:  peliculasProvider.getEnCines(),
    builder: (BuildContext context, AsyncSnapshot <List> snapshot) {
      if(snapshot.hasData){
         return CardSwiper(peliculas: snapshot.data);
      }else{
        return Container(
          height: 400.0,
          child: Center(
            child: CircularProgressIndicator()
          )
        );
      }
     
    },
  );
  }


  Widget _popular(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text('Populares', style: Theme.of(context).textTheme.subtitle1),
          // Text('Populares', style: Theme.of(context).textTheme.headline6)
          FutureBuilder(
            future: peliculasProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              snapshot.data.forEach((p)=>print(p.title));
              return Container(

              );
            },
          ),
        ],
      ),
    );
  }
}