// ignore_for_file: public_member_api_docs, sort_constructors_first

class PokemonDetailModel {
  final int id;
  final String name;
  final List<String> abilities;
  final String urlFront;
  final String urlBack;
  final List<String> types;

  PokemonDetailModel(
      {required this.id,
      required this.name,
      required this.abilities,
      required this.urlFront,
      required this.urlBack,
      required this.types});

  factory PokemonDetailModel.empty() {
    return PokemonDetailModel(
        id: 0,
        name: '',
        abilities: List.empty(growable: true),
        urlFront: '',
        urlBack: '',
        types: List.empty(growable: true));
  }

  PokemonDetailModel copyWith({
    int? id,
    String? name,
    List<String>? abilities,
    String? urlFront,
    String? urlBack,
    List<String>? types,
  }) {
    return PokemonDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      abilities: abilities ?? this.abilities,
      urlFront: urlFront ?? this.urlFront,
      urlBack: urlBack ?? this.urlBack,
      types: types ?? this.types,
    );
  }

  @override
  String toString() {
    return 'PokemonDetailModel(id: $id, name: $name, abilities: $abilities, urlFront: $urlFront, urlBack: $urlBack, types: $types)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'abilities': abilities,
      'urlFront': urlFront,
      'urlBack': urlBack,
      'types': types,
    };
  }

  factory PokemonDetailModel.fromJson(dynamic json) {
    return PokemonDetailModel(
      id: json['id'] ?? 0,
      name: json['name'],
      abilities: List.empty(),
      urlFront: json['sprites']['front_default'],
      urlBack: json['sprites']['back_default'],
      types: List.empty(),
    );
  }
}

// List<String>.from(json['abilities'])
//List<String>.from((json['types']))
