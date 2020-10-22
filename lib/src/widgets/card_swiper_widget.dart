import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;
  CardSwiper({ @required this.peliculas});
  @override
  Widget build(BuildContext context) {

    final _screensize = MediaQuery.of(context).size;

     return Container(
     padding: EdgeInsets.only(top:10.0),
        child: new Swiper(
          itemWidth: _screensize.width*0.7,
          itemHeight:_screensize.height*0.5,
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context,int index){
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              // child: Image.network("http://via.placeholder.com/350x150",
            // fit: BoxFit.cover),
            child: Text(peliculas[index].toString()),
            );
            
          },
          itemCount: peliculas.length,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        ),
   );
  }
}
