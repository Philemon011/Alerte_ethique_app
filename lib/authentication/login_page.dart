import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnb_ethique_app/authentication/controllers/authentication.dart';
import 'package:lnb_ethique_app/authentication/register_page.dart';
import 'package:lnb_ethique_app/authentication/widgets/input_widget.dart';
import 'package:lnb_ethique_app/utility/constants.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Connexion",
              style: GoogleFonts.poppins(fontSize: size * 0.080),
            ),
            const SizedBox(
              height: 30,
            ),
            InputWidget(
              hintText: 'Email',
              controller: _mailController,
              isObscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            InputWidget(
              hintText: 'Mot de passe',
              controller: _passwordController,
              isObscureText: true,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () async {
                  await _authenticationController.login(
                      mail: _mailController.text.trim(),
                      password: _passwordController.text.trim());
                },
                child: Obx(() {
                  return _authenticationController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Se Connecter",
                          style: GoogleFonts.poppins(
                              fontSize: size * 0.040, color: Colors.white),
                        );
                })),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Get.to(() => const RegisterPage());
                },
                child: Text(
                  "créer un compte",
                  style: GoogleFonts.poppins(
                      fontSize: size * 0.040, color: Colors.black),
                ))
          ]),
        ),
      ),
    );
  }
}
