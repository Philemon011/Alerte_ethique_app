import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alerte_ethique/authentication/controllers/authentication.dart';
import 'package:alerte_ethique/authentication/login_page.dart';
import 'package:alerte_ethique/utility/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    // final token = box.read('token');
    final name = box.read('name') ?? 'Nom non disponible';
    final email = box.read('email') ?? 'Nom non disponible';
    final token = box.read('token') ?? 'Nom non disponible';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/assets/image/profil.jpg'), // Image de profil par défaut
            ),
            const SizedBox(height: 16),
            Text(
              name, // Nom de l'utilisateur (Remplace par les données dynamiques)
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              email, // Email utilisateur
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final response =
                      await await _authenticationController.logout();

                  if (response != null &&
                      response['message'] == 'User logged out successfully') {
                    // Supprimer les données de l'utilisateur dans GetStorage
                    box.erase();
                    // print(box.read('name'));
                    // print(box.read('user_id'));
                    // print(box.read('token));

                    // Rediriger vers la page de connexion
                    Get.offAll(() => LoginPage());
                  } else {
                    // Afficher un message d'erreur
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erreur de déconnexion')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Text(
                  "Se Déconnecter",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
