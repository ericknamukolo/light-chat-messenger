import 'package:flutter/material.dart';
import 'package:lightning_messenger/components/auth_button.dart';
import 'package:lightning_messenger/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ThemeData theme = ThemeData.dark();
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(
          message.data(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: SafeArea(
            child: Container(
              width: 230,
              child: Drawer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            maxRadius: 80,
                            backgroundColor: Colors.blueAccent,
                            child: Text('profile pic'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AuthButton(
                            text: 'Sign Out',
                            click: () {
                              Navigator.pop(context);
                              _auth.signOut();
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                            child: Divider(
                              thickness: 2,
                              endIndent: 50,
                              indent: 50,
                            ),
                          ),
                          Text(
                            'Theme',
                            style: GoogleFonts.novaFlat(
                              fontSize: 20,
                              color: Colors.grey,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AuthButton(
                            text: 'Light',
                            click: () {
                              setState(() {
                                theme = ThemeData.light();
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AuthButton(
                            text: 'Dark',
                            click: () {
                              setState(() {
                                theme = ThemeData.dark();
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 40),
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
                    'Messages',
                    style: GoogleFonts.novaFlat(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Video',
                    style: GoogleFonts.novaFlat(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Profile',
                    style: GoogleFonts.novaFlat(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MessageStream(),
                  Container(
                    decoration: kMessageContainerDecoration,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: messageTextController,
                            onChanged: (value) {
                              messageText = value;
                              //Do something with the user input.
                            },
                            decoration: kMessageTextFieldDecoration,
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            messageTextController.clear();
                            _firestore.collection('messages').add({
                              'text': messageText,
                              'sender': loggedInUser.email,
                            });

                            //Implement send functionality.
                          },
                          child: Text(
                            'Send',
                            style: kSendButtonTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //VIDEO
              Center(
                child: Text('VIDEO CHAT FUNCTIONALITY'),
              ),
              Center(
                child: Text('PROFILE PAGE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFF00AEE0),
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];
          final currentUser = loggedInUser.email;

          if (currentUser == messageSender) {}
          final messageBubble = MessageBubble(
            text: '$messageText',
            sender: '$messageSender',
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            scrollDirection: Axis.vertical,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isMe});

  final String text;
  final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
            elevation: 6.0,
            color: isMe ? Color(0xFF00AEE0) : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
