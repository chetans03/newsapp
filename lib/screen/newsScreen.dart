import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:napp/Widgets/headlineWid.dart';
import 'package:napp/Widgets/topnews.dart';
import 'package:napp/screen/authscreen.dart';
import 'package:napp/screen/filteredscreen.dart';
import 'package:napp/services/googlesign.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

enum filtercountry {
  India,
  USA,
  Canada,
  Australia,
  Russia,
  Britain,
  China,
  UAE,
}

enum Category {
  General,
  Business,
  Technology,
  Science,
  Health,
  Entertainment,
  Sports,
}

class _NewsScreenState extends State<NewsScreen> {
  filtercountry? selectedmenu;
  String country = "in";
  String selectedcountry = "India";

  Category? selectedCategorymenu;
  String selectedcategory = "general";
  String onscategory = "General";
  String source = "cnn";
  @override
  Widget build(BuildContext context) {
    var selecetdpage = "newspage";

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopupMenuButton<filtercountry>(
                    initialValue: selectedmenu,
                    elevation: 50,
                    onSelected: (filtercountry item) {
                      if (filtercountry.India.name == item.name) {
                        country = "in";
                        source = "cnn";
                        setState(() {
                          selectedcountry = "India";
                        });
                      }
                      if (filtercountry.USA.name == item.name) {
                        country = "us";
                        source = "bbc-news";
                        setState(() {
                          selectedcountry = "USA";
                        });
                      }
                      if (filtercountry.Canada.name == item.name) {
                        country = "ca";
                        source = "fox-news";
                        setState(() {
                          selectedcountry = "Canada";
                        });
                      }
                      if (filtercountry.Australia.name == item.name) {
                        country = "au";
                        source = "nbc-news";
                        setState(() {
                          selectedcountry = "Australia";
                        });
                      }
                      if (filtercountry.Russia.name == item.name) {
                        country = "rs";
                        source = "reuters";
                        setState(() {
                          selectedcountry = "Russia";
                        });
                      }
                      if (filtercountry.Britain.name == item.name) {
                        country = "gb";
                        source = "nbc-news";
                        setState(() {
                          selectedcountry = "Britain";
                        });
                      }
                      if (filtercountry.China.name == item.name) {
                        country = "ch";
                        setState(() {
                          selectedcountry = "China";
                        });
                      }
                      if (filtercountry.UAE.name == item.name) {
                        country = "ae";
                        setState(() {
                          selectedcountry = "UAE";
                        });
                      }
                      setState(() {
                        selectedmenu = item;
                      });
                    },
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => <PopupMenuEntry<filtercountry>>[
                      const PopupMenuItem(
                        value: filtercountry.India,
                        child: Text("India"),
                      ),
                      const PopupMenuItem(
                        value: filtercountry.USA,
                        child: Text("USA"),
                      ),
                      const PopupMenuItem(
                        value: filtercountry.Australia,
                        child: Text("Australia"),
                      ),
                      const PopupMenuItem(
                        value: filtercountry.Russia,
                        child: Text("Russia"),
                      ),
                      const PopupMenuItem(
                        value: filtercountry.Britain,
                        child: Text("Britain"),
                      ),
                      const PopupMenuItem(
                        value: filtercountry.China,
                        child: Text("China"),
                      ),
                      const PopupMenuItem(
                        value: filtercountry.UAE,
                        child: Text("UAE"),
                      ),
                    ],
                  ),
                  Text(
                    selectedcountry,
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 254, 254),
                        fontSize: 23,
                        fontWeight: FontWeight.w400),
                  ),
                  PopupMenuButton<Category>(
                    initialValue: selectedCategorymenu,
                    onSelected: (Category item) {
                      if (Category.General.name == item.name) {
                        selectedcategory = "general";
                        setState(() {
                          onscategory = "General";
                        });
                      }
                      if (Category.Business.name == item.name) {
                        onscategory = "Business";
                        setState(() {
                          selectedcategory = "business";
                        });
                      }
                      if (Category.Technology.name == item.name) {
                        selectedcategory = "technology";
                        setState(() {
                          onscategory = "Technology";
                        });
                      }
                      if (Category.Science.name == item.name) {
                        selectedcategory = "science";
                        setState(() {
                          onscategory = "Science";
                        });
                      }
                      if (Category.Health.name == item.name) {
                        selectedcategory = "health";
                        setState(() {
                          onscategory = "Health";
                        });
                      }
                      if (Category.Entertainment.name == item.name) {
                        selectedcategory = "entertainment";
                        setState(() {
                          onscategory = "Entertainment";
                        });
                      }
                      if (Category.Sports.name == item.name) {
                        selectedcategory = "sports";
                        setState(() {
                          onscategory = "Sports";
                        });
                      }
                      setState(() {
                        selectedCategorymenu = item;
                      });
                    },
                    icon: Icon(
                      Icons.category,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => const <PopupMenuEntry<Category>>[
                      PopupMenuItem(
                        value: Category.General,
                        child: Text("General"),
                      ),
                      PopupMenuItem(
                        value: Category.Business,
                        child: Text("Business"),
                      ),
                      PopupMenuItem(
                        value: Category.Technology,
                        child: Text("Technology"),
                      ),
                      PopupMenuItem(
                        value: Category.Science,
                        child: Text("Science"),
                      ),
                      PopupMenuItem(
                        value: Category.Health,
                        child: Text("Health"),
                      ),
                      PopupMenuItem(
                        value: Category.Entertainment,
                        child: Text("Entertainment"),
                      ),
                      PopupMenuItem(
                        value: Category.Sports,
                        child: Text("Sports"),
                      ),
                    ],
                  )
                ],
              ),
              Text(
                "Top Headlines",
                style: TextStyle(
                    color: Color.fromARGB(255, 241, 242, 244),
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
              HeadlLineWidget(
                source: source,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Articles",
                    style: TextStyle(
                        color: Color.fromARGB(255, 215, 219, 226),
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    onscategory,
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 23,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              TopNews(country: country, category: selectedcategory),
            ],
          ),
        ),
      ),
    );
  }
}
