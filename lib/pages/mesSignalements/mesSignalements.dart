import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alerte_ethique/core/data/data_provider.dart';
import 'package:alerte_ethique/home/provider/mesSignalements_provider.dart';
import 'package:alerte_ethique/models/mesSignalements.dart';
import 'package:alerte_ethique/utility/constants.dart';
import 'package:provider/provider.dart';



class MesSignalementspage extends StatefulWidget {
  const MesSignalementspage({super.key});

  

  @override
  State<MesSignalementspage> createState() => _MesSignalementspageState();
}

class _MesSignalementspageState extends State<MesSignalementspage> {

  @override
  void initState() {
    super.initState();
    
    // Récupérer le Provider et charger les signalements au démarrage
    Future.delayed(Duration.zero, () {
      Provider.of<MessignalementsProvider>(context, listen: false).getAllSignalement();
    });
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mes Signalements"),
          // backgroundColor: Colors.blueAccent,
        ),
        body: RefreshIndicator(
          color: primaryColor,
          onRefresh: () =>  Provider.of<MessignalementsProvider>(context, listen: false).getAllSignalement(),
          child: Consumer<MessignalementsProvider>(builder: (context, dataProvider, child) {
            return ListView.builder(
              itemCount: dataProvider.signalements.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(dataProvider.signalements[index].description ??
                          "Non trouvé",
                      maxLines: 1, // Nombre max de lignes affichées
                      overflow:
                          TextOverflow.ellipsis, // Coupe le texte avec "..."
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      dataProvider.signalements[index].libelle ??
                          "Non trouvé",
                      maxLines: 1, // Nombre max de lignes affichées
                      overflow:
                          TextOverflow.ellipsis, // Coupe le texte avec "..."
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(signalementsInfo: dataProvider.signalements[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }),
        ));
  }
}

class DetailScreen extends StatelessWidget {
  MesSignalements signalementsInfo;

  DetailScreen({required this.signalementsInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
                    signalementsInfo.description ??
                        "Non trouvé",
                    maxLines: 1, // Nombre max de lignes affichées
                    overflow:
                        TextOverflow.ellipsis, // Coupe le texte avec "..."
                  ),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Status:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                color: getColorForStatus(signalementsInfo.nomStatus?? "Non trouvé"),
                child: Text(signalementsInfo.nomStatus?? "Non trouvé", style: TextStyle(fontSize: 16))),
                SizedBox(height: 10,),
              Text("Etat:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text(signalementsInfo.cloturerVerification =="non"? "Non Clôturé":"Clôturé", style: TextStyle(fontSize: 16)),
              SizedBox(height: 10,),
              Text("Type de Signalement:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text(signalementsInfo.libelle?? "Non trouvé", style: TextStyle(fontSize: 16)),
              SizedBox(height: 10,),
              Text("Description:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text(signalementsInfo.description?? "Non trouvé", style: TextStyle(fontSize: 16)),
              SizedBox(height: 10,),
              Text("Date de l'évènement:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text(signalementsInfo.dateEvenement.toString(), style: TextStyle(fontSize: 16)),
              SizedBox(height: 10,),
              Text("Date de création:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text(signalementsInfo.createdAt?? "Non trouvé", style: TextStyle(fontSize: 16)),
              
            ],
          ),
        ),
      ),
    );
  }
}

Color getColorForStatus(String status) {
  switch (status) {
    case 'Non traité':
      return Color(0xFFFF3B30); // Rouge
    case 'En cours':
      return Color(0xFF007BFF); // Bleu clair
    case 'Résolu':
      return Color(0xFF28A745); // Vert
    case 'Rejeté':
      return Color(0xFFFFC107); // Orange
    default:
      return Colors.grey; // Couleur par défaut si le statut est inconnu
  }
}
