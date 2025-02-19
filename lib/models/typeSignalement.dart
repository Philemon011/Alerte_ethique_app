class TypeSignalement {
  int? id;
  String? libelle;
  String? createdAt;
  String? updatedAt;

  TypeSignalement({this.id, this.libelle, this.createdAt, this.updatedAt});

  TypeSignalement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['libelle'] = this.libelle;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
