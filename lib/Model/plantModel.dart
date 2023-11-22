// ignore: file_names
// ignore: file_names
class PlantModel {
  int? id;
  String? title;
  String? description;

  PlantModel({this.id, this.title, this.description});

  PlantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    return data;
  }

  static jsonData(PlantModel Function(dynamic pokemonData) param0) {}
}