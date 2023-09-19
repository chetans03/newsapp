import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:napp/screen/detailscreen.dart';

class TopNews extends StatefulWidget {
  TopNews({super.key, required this.country, required this.category});
  String country;
  String category;
  @override
  State<TopNews> createState() => _TopNewsState();
}

class _TopNewsState extends State<TopNews> {
  List<dynamic> topnews = [];

  Future<List<dynamic>> gettdata() async {
    final response;
    print("calling again");
    try {
      response = await http.get(
        Uri.parse(
            "https://newsapi.org/v2/top-headlines?country=${widget.country}&category=${widget.category}&apiKey=b2341dbf30e642e696d122a0bee05c26"),
      );
    } catch (e) {
      return topnews;
    }

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      topnews = data["articles"];
      return topnews;
    } else {
      return topnews;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: gettdata(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: topnews.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (x) => DetailScreen(data: topnews, index: index),
                    ),
                  );
                },
                child: Card(
                  elevation: 30,
                  color: Color.fromARGB(255, 0, 0, 0),
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Opacity(
                            opacity: .8,
                            child: CachedNetworkImage(
                                imageUrl: topnews[index]["urlToImage"] == null
                                    ? "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"
                                    : topnews[index]["urlToImage"]),
                          ),
                          Positioned(
                            left: 5,
                            right: 40,
                            bottom: 10,
                            top: 130,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(.5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Expanded(
                                  child: Text(
                                    topnews[index]["title"],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          topnews[index]["source"]["name"],
                          style: GoogleFonts.raleway(
                              color: Color.fromARGB(255, 249, 249, 249),
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text(
              "Something went wrong",
              style: TextStyle(color: Colors.white),
            );
          }
          return const Center(
            child: SpinKitCircle(
              color: Color.fromARGB(255, 255, 255, 255),
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
