import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:napp/provider/newsprovider.dart';

class DetailScreen extends ConsumerStatefulWidget {
  DetailScreen({super.key, required this.data, required this.index});
  List<dynamic> data;
  int index;

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor:
            const Color.fromARGB(255, 255, 255, 255).withOpacity(.2),
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: .75,
                fit: BoxFit.cover,
                image: NetworkImage(widget.data[widget.index]["urlToImage"] ==
                        null
                    ? "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"
                    : widget.data[widget.index]["urlToImage"]),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(children: [
              Positioned(
                bottom: 30,
                left: 10,
                right: 10,
                child: Text(
                  widget.data[widget.index]["title"],
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(newsprovider.notifier).add(
                          widget.data[widget.index]["source"]["name"],
                          widget.data[widget.index]["title"],
                          widget.data[widget.index]["urlToImage"],
                          widget.data[widget.index]["description"]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          elevation: 10,
                          content: Text("Article added to read later"),
                        ),
                      );
                    },
                    label: Text(
                      "Read Later",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                    ),
                    icon: Icon(Icons.timer_sharp),
                  ),
                  Text(
                    widget.data[widget.index]["description"] == null
                        ? "No description available"
                        : widget.data[widget.index]["description"],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
