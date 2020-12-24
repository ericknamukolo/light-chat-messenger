import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lightning_messenger/components/legit_button.dart';
import 'package:lightning_messenger/screens/authentication_screen.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      lowerBound: 0.5,
    );
    animation = CurvedAnimation(
      curve: Curves.decelerate,
      parent: controller,
    );
    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    super.initState();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/illus.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image(
                        image: AssetImage('images/logobs.png'),
                      ),
                    ),
                    Text(
                      'Light Chat',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.novaFlat(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                      ),
                    ),
                    Text(
                      'Keeping the world connected',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.novaFlat(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    LegitButton(
                      click: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 2),
                            pageBuilder: (_, __, ___) => AuthenticationScreen(),
                          ),
                        );

                        // MaterialPageRoute(
                        //   builder: (context) => AuthenticationScreen(),
                        // ),

                        //);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
