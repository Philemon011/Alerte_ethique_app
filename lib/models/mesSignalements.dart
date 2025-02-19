class MesSignalements {
  int? id;
  String? description;
  String? piecejointe;
  String? codedesuivi;
  String? createdAt;
  String? dateEvenement;
  String? cloturerVerification;
  String? libelle;
  String? nomStatus;

  MesSignalements({this.id, this.description, this.piecejointe,this.codedesuivi, this.createdAt, this.dateEvenement, this.cloturerVerification, this.libelle, this.nomStatus});

  MesSignalements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    piecejointe = json['piece_jointe'];
    codedesuivi = json['code_de_suivi'];
    createdAt = json['created_at'];
    dateEvenement = json['date_evenement'];
    cloturerVerification = json['cloturer_verification'];
    libelle = json['libelle'];
    nomStatus = json['nom_status'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['description'] = this.description;
  //   data['piece_jointe'] = this.piece_jointe;
  //   data['code_de_suivi'] = this.code_de_suivi;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}
