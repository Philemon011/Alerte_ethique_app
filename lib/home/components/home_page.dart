import 'package:flutter/material.dart';
import 'package:lnb_ethique_app/home/components/status_page.dart';
import 'package:lnb_ethique_app/home/provider/home_screen_provider.dart';
import 'package:lnb_ethique_app/models/typeSignalement.dart';
import 'package:lnb_ethique_app/utility/constants.dart';
import 'package:lnb_ethique_app/utility/extensions.dart';
import 'package:lnb_ethique_app/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeScreenProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            const Text(
              'Veuillez remplir le formulaire suivant',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Consumer<HomeScreenProvider>(
              builder: (context, homeScreenProvider, child) {
                return CustomDropdown(
                  hintText: 'Type de Signalement',
                  initialValue: homeScreenProvider.selectedTypeSignalement,
                  items: context.dataProvider.typeSignalements,
                  displayItem: (TypeSignalement? typeSignalement) =>
                      typeSignalement?.libelle ?? '',
                  onChanged: (newValue) {
                    if (newValue != null) {
                      homeScreenProvider.selectedTypeSignalement = newValue;
                      homeScreenProvider.updateUI();
                    } else {
                      print('newValue est nul');
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Veuillez sélectionner un type de Signalement';
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: homeProvider.descriptionCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description...',
              ),
              maxLines: 6,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: homeProvider.dateCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
                labelText: 'Date de l\'événement',
                hintText: 'Sélectionnez la date',
              ),
              readOnly: true,
              onTap: ()=>homeProvider.selectDate(context),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () => homeProvider.pickFile(),
              icon: const Icon(Icons.attach_file, color: primaryColor),
              label: Text(
                homeProvider.selectedFile != null
                    ? 'Fichier sélectionné'
                    : 'Cliquez ici pour sélectionner une Pièce jointe',
                style: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 60,
              child: ElevatedButton(
                onPressed: () => homeProvider.submitForm(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                child: homeProvider.isloading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text('Envoyer',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
              ),
            ),
            const SizedBox(height: 30),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => StatusPage()));
            //   },
            //   child: const Text(
            //     'Vérifier le statut d\'un signalement',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         color: primaryColor,
            //         decoration: TextDecoration.underline,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
