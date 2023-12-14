class PokemonListModel {
  final int id;
  final String name;
  final String url;
  final String imgUrl;
  PokemonListModel({
    required this.id,
    required this.name,
    required this.url,
    required this.imgUrl,
  });

  factory PokemonListModel.fromJson(dynamic json) {
    return PokemonListModel(
        id: json["id"] ?? 0,
        name: json["name"],
        imgUrl:
            json["sprites"]?["other"]?["dream_world"]?["front_default"] ?? '',
        url: json["url"] ?? '');
  }

  PokemonListModel copyWith({
    String? name,
    String? url,
    String? imgUrl,
    String? type,
  }) {
    return PokemonListModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        imgUrl: imgUrl ?? this.imgUrl);
  }
}
