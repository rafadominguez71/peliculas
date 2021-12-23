import 'dart:convert';
class VideoModel{
  // ignore: deprecated_member_use
  List<Video> videos=new List();
  VideoModel.fromJsonList(List <dynamic> jsonList){
    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final video = new Video.fromMap(item);
      videos.add( video );
    }
  }
}
class Video {
    Video({
        this.iso6391,
        this.iso31661,
        this.name,
        this.key,
        this.publishedAt,
        this.site,
        this.size,
        this.type,
        this.official,
        this.id,
    });

    String iso6391;
    String iso31661;
    String name;
    String key;
    String publishedAt;
    String site;
    int size;
    String type;
    bool official;
    String id;

    factory Video.fromJson(String str) => Video.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Video.fromMap(Map<String, dynamic> json) => Video(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        publishedAt: json["published_at"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "published_at": publishedAt,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "id": id,
    };
}
