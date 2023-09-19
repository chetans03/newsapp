import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:napp/Widgets/drawer.dart';
import 'package:napp/screen/newsScreen.dart';
import 'package:napp/screen/readlater.dart';
import 'package:napp/services/googlesign.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int selectedpage = 0;
  Widget activePage = NewsScreen();

  void changescreen(int index) {
    setState(() {
      selectedpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedpage == 0) {
      activePage = NewsScreen();
    } else {
      activePage = ReadLater();
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Atricles Daily",
            style: GoogleFonts.kanit(color: Colors.white, fontSize: 38),
          ),
          backgroundColor: Colors.black,
        ),
        drawer: DrawerScreen(),
        body: activePage,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.zero,
          child: BottomNavigationBar(
              elevation: 20,
              selectedItemColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              currentIndex: selectedpage,
              onTap: changescreen,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.newspaper_outlined,
                      color: Colors.grey,
                    ),
                    label: "News"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.timer,
                      color: Colors.grey,
                    ),
                    label: "Read later"),
              ]),
        ),
      ),
    );
  }
}
