import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
class HomePage extends StatelessWidget {
    final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
      final _screensize = MediaQuery.of(context).size;
    
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left:25.0),
             width: _screensize.width*0.7,
            height:_screensize.height*0.5,
            child: _swiperTarjetas(),
          )
        ],
      )
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
    // return 

  }
}