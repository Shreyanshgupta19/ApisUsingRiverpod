
class getUi4Model {
  int id;
  String name;
  String breedGroup;
  String size;
  String lifespan;
  String origin;
  String temperament;
  List<String> colors;
  String description;
  String image;

  getUi4Model(
      {required this.id,
        required this.name,
        required this.breedGroup,
        required this.size,
        required this.lifespan,
        required this.origin,
        required this.temperament,
        required this.colors,
        required this.description,
        required this.image});

  factory getUi4Model.fromJson(Map<String, dynamic> json) {
    return getUi4Model(
    id : json['id'] as int? ?? 0,
    name : json['name'] as String? ?? '',
    breedGroup : json['breed_group'] as String? ?? '',
    size : json['size'] as String? ?? '',
    lifespan : json['lifespan'] as String? ?? '',
    origin : json['origin'] as String? ?? '',
    temperament : json['temperament'] as String? ?? '',
    colors : json['colors'].cast<String>(),
    description : json['description'] as String? ?? '',
    image : json['image'] as String? ?? '',
    );
  }

}
