import 'package:chat_app/chat_page.dart';
import 'package:chat_app/models/constants.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void signOut() {
    final authState = AuthService();

    authState.signOut();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kSecondary,
        title: Text(
          "CHIT CHAT",
          style: GoogleFonts.bebasNeue(
            fontWeight: FontWeight.w600,
            fontSize: 40,
            letterSpacing: 2,
            color: kText
          ),
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            color: kBackground,
          )
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading...');
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //displaying all users except the logged in user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email'], style: GoogleFonts.bebasNeue(color: kText, letterSpacing: 1, fontSize: 20),),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                    receiverUserEmail: data['email'],
                    receiverUserId: data['uid']),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
