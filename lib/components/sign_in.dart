import 'package:flutter/material.dart';
import 'package:lightning_messenger/components/input_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lightning_messenger/components/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lightning_messenger/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _auth = FirebaseAuth.instance;
String email;
String password;
bool showSpinner = false;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('images/logobs.png'),
                  ),
                ),
                Text(
                  'Sign In',
                  style: GoogleFonts.novaFlat(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome back',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.novaFlat(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            //TWO TEXT WIDGETS

            //TWO ETXT FIELDS
            Column(
              children: [
                InputTextField(
                  obs: false,
                  hint: 'Email',
                  icon: Icons.mail,
                  input: (value) {
                    email = value;
                  },
                ),
                InputTextField(
                  obs: true,
                  hint: 'Password',
                  icon: Icons.lock,
                  input: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                AuthButton(
                  text: 'Sign In',
                  click: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final existingUser =
                          await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (existingUser != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(),
                            ));
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
            //second one

            //BUTTON AND A TEXT WIDGET
            Text(
              'Don\'t have an Account? Sign up',
              textAlign: TextAlign.center,
              style: GoogleFonts.novaFlat(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
