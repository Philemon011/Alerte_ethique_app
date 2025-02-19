import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnb_ethique_app/authentication/controllers/authentication.dart';
import 'package:lnb_ethique_app/authentication/login_page.dart';
import 'package:lnb_ethique_app/authentication/widgets/input_widget.dart';
import 'package:lnb_ethique_app/utility/constants.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final AuthenticationController _authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
             Text("Création de Compte", style: GoogleFonts.poppins(fontSize: size * 0.080),),
            const SizedBox(
              height: 30,
            ),
            InputWidget(
              hintText: 'Nom',
              controller: _nameController,
              isObscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            // InputWidget(
            //   hintText: 'Nom d\'utilisateur',
            //   controller: _usernameController,
            //   isObscureText: false,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            InputWidget(
              hintText: 'Email',
              controller: _emailController,
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
              height: 20,
            ),
            InputWidget(
              hintText: 'Confirmez le Mot de passe',
              controller: _cpasswordController,
              isObscureText: false,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),            
                ),
                onPressed: () async {
                  await _authenticationController.register(
                    name: _nameController.text.trim(),
                    // username: _usernameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                    cpassword: _cpasswordController.text.trim(),
                  );
                },
                child: Obx(() {
                  return _authenticationController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Créer mon compte',
                          style: GoogleFonts.poppins(
                            fontSize: size * 0.040,
                            color: Colors.white
                          ),
                        );
                }),
              ),
                const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Get.to(() => const LoginPage());
                },
                child: Text(
                  "Se connecter",
                  style: GoogleFonts.poppins(
                      fontSize: size * 0.040, color: Colors.black),
                ))
          ]),
        ),
      ),
    );
  }
}
