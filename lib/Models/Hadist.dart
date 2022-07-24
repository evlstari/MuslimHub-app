class HadistModel {
  String name, id, arab;
  String number;

  HadistModel({required this.name, required this.id, required this.arab,  required this.number});

  factory HadistModel.fromJson(Map<String, dynamic> json) => HadistModel(
      name: json['name'] == null ? "":json['name'],
      id: json['id'] == null ? "":json['id'],
      arab: json['arab'] == null ? "":json['arab'],
      number: json['number'].toString() == null ? "":json['number'].toString());
}
