import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:napp/screen/about.dart';

import '../services/googlesign.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});
  final username = FirebaseAuth.instance.currentUser!.displayName;
  final email = FirebaseAuth.instance.currentUser!.email;

  String aboutcontent =
      "Welcome to Articles Daily\n\nDiscover a new way to stay informed and engaged with Articles daily. Our intuitive and user-friendly news app is designed to bring you the latest and most relevant news from around the globe, all in one convenient place.\n\nOffline Reading:\nNo internet connection? No problem. Download your favorite articles to read offline, ensuring you're never out of touch even when you're on the go.\n \nStay Informed, Stay Updated:\nNever miss a beat with our comprehensive coverage of breaking news, top stories, and in-depth analyses across a diverse range of categories. From politics to technology, entertainment to science, we've got you covered.\n \nPersonalized for You:\nTailor your news experience to your interests. With our smart algorithms, Articles Daily learns from your reading habits and preferences, delivering content that matters most to you. Say goodbye to information overload and hello to a curated newsfeed made just for you.\n\nJoin us in experiencing a new era of news consumption. Download Articles Daily today and embark on a journey to discover the world's stories like never before.";
  String note =
      "Hello User! \n\nAtricles that you add for reading will be available to the current device .\n\nIf you delete the app from your device , read later articles will be vanished and it will not be the responsibility of developer.\n\nThank you";
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Stack(
              children: [
                Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: const Opacity(
                    opacity: .5,
                    child: Image(
                      image: AssetImage("images/articles.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 30,
                  right: 30,
                  left: 30,
                  child: Text(
                    "Articles Daily",
                    style: GoogleFonts.wixMadeforDisplay(
                      fontSize: 45,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text(
              username == null ? "No username added" : username!,
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 20),
            ),
            subtitle: Text(
              "Username",
              style: GoogleFonts.roboto(
                color: const Color.fromARGB(255, 168, 168, 168),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.white,
            ),
            title: Text(
              email!,
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 15),
            ),
            subtitle: Text(
              "email",
              style: GoogleFonts.roboto(
                  color: const Color.fromARGB(255, 168, 168, 168)),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.circle_notifications,
              color: Colors.white,
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              "About",
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 15),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) =>
                      About(title: "About", aboutcontent: aboutcontent),
                ),
              );
            },
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => About(title: "Note", aboutcontent: note),
                ),
              );
            },
            leading: Icon(
              Icons.error,
              color: Colors.white,
            ),
            title: Text(
              "Note",
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 15),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.white,
              size: 30,
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: const Text("Do you really want to sign out ?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Authgoogle().signout();
                            },
                            child: Text("Yes"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("No"),
                          )
                        ],
                      ));
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              "Log out",
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 15),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
