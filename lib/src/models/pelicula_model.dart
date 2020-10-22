class Peliculas{
  List<Pelicula> items = new List();
  Peliculas();
  Peliculas.fromJsonList(List<dynamic> jsonlist){
  if(jsonlist==null) return ;
    for (var item in jsonlist) {
      final pelicula = Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }

}

}
class Pelicula {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });
  Pelicula.fromJsonMap(Map<String,dynamic> json){
    popularity          = json['popularity']/1;
    voteCount           = json['vote_count'];
    video               = json['video'];
    posterPath          = json['poster_path'];
    id                  = json['id'];
    adult               = json['adult'];
    backdropPath        = json['backdrop_path'];
    originalLanguage    = json['original_language'];
    originalTitle       = json['original_title'];
    genreIds            = json['genre_ids'].cast<int>();
    title               = json['title'];
    voteAverage         = json['vote_average']/1;
    overview            = json['overview'];
    releaseDate         = json['release_date'];
  }
   getPosterImg(){
     if(posterPath==null){
       return 'data:image/jpeg;base64,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';
     }else{
       return 'https://image.tmdb.org/t/p/w500/$posterPath';
     }
    

  }
}
