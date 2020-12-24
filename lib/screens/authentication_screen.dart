import 'package:flutter/material.dart';
import 'package:lightning_messenger/components/sign_in.dart';
import 'package:lightning_messenger/components/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Center(
              child: Text(
                'Light Chat',
                style: GoogleFonts.novaFlat(
                  fontSize: 20,
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
            ),
            bottom: TabBar(
              indicatorColor: Color(0xFF00AEE0),
              // indicator: BoxDecoration(
              //   color: Color(0xFF00AEE0),
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              //Color(0xFF02294D)
              tabs: [
                Tab(
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.novaFlat(
                      fontSize: 20,
                      color: Colors.grey,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.novaFlat(
                      fontSize: 20,
                      color: Colors.grey,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SignIn(),
              SignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
