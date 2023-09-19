import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'detailscreen.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key, required this.title, required this.link});

  String link;
  String title;

  List<dynamic> filternews = [];

  Future<List<dynamic>> gettdata() async {
    print("method called");
    final response;
    print("calling again");
    try {
      response = await http.get(
        Uri.parse(link),
      );
    } catch (e) {
      return filternews;
    }

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      filternews = data["articles"];
      return filternews;
    } else {
      return filternews;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ]),
            FutureBuilder(
              future: gettdata(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Color.fromARGB(255, 255, 248, 248),
                      size: 40,
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: filternews.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (x) =>
                                DetailScreen(data: filternews, index: index),
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
                                      imageUrl: filternews[index]
                                                  ["urlToImage"] ==
                                              null
                                          ? "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"
                                          : filternews[index]["urlToImage"]),
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
                                          filternews[index]["title"],
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
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
                                filternews[index]["source"]["name"],
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
                } else {
                  return Center(
                    child: Text(
                      "Please check your interner connecton",
                      style: GoogleFonts.raleway(
                          color: Color.fromARGB(255, 249, 249, 249),
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                  );
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
