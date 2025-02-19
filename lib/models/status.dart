class Status {
  int? id;
  String? nom_status;
  String? createdAt;
  String? updatedAt;

  Status({this.id, this.nom_status, this.createdAt, this.updatedAt});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom_status = json['nom_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom_status'] = this.nom_status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
