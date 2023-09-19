import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:napp/screen/detailscreen.dart';

class HeadlLineWidget extends StatefulWidget {
  HeadlLineWidget({super.key, required this.source});

  String source;
  @override
  State<HeadlLineWidget> createState() => _HeadlLineWidgetState();
}

class _HeadlLineWidgetState extends State<HeadlLineWidget> {
  List<dynamic> headdata = [];
  Future<List<dynamic>> gethead() async {
    final response;
    try {
      response = await http.get(
        Uri.parse(
            "https://newsapi.org/v2/top-headlines?sources=${widget.source}&apiKey=b2341dbf30e642e696d122a0bee05c26"),
      );
    } catch (e) {
      return headdata;
    }

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // for (Map i in data) {
      //   headdata.add(Headline.fromJson(i["articles"]));
      //   print(headdata);
      // }

      headdata = data["articles"];

      return headdata;
    }
    return headdata;
  }

  // @override
  // void dispose() {
  //   headdata = [];
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 65, 65, 57)),
      child: FutureBuilder(
        future: gethead(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: headdata.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) =>
                          DetailScreen(data: headdata, index: index),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  width: 400,
                  margin: EdgeInsets.only(right: 10),
                  color: Color.fromARGB(255, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 20,
                        child: SizedBox(
                          height: 300,
                          width: 200,
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: headdata[index]["urlToImage"] == null
                                  ? "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"
                                  : headdata[index]["urlToImage"]),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                headdata[index]["title"] == null
                                    ? ""
                                    : headdata[index]["title"],
                                style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                              Expanded(
                                child: Text(
                                  headdata[index]["source"]["name"],
                                  style: GoogleFonts.aBeeZee(
                                      color: Color.fromARGB(255, 189, 190, 191),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text("something went wrong");
          }
          return const Center(
            child: SpinKitCircle(
              color: Colors.black,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
