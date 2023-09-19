import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/rlMoel.dart';

class LaterDRiverpod extends ConsumerWidget {
  LaterDRiverpod({super.key, required this.later});

  final Later later;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                image: NetworkImage(later.url == null
                    ? "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"
                    : later.url!),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(children: [
              Positioned(
                bottom: 30,
                left: 10,
                right: 10,
                child: Text(
                  later.title!,
                  style: GoogleFonts.robotoCondensed(
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
                    onPressed: () {},
                    label: Text(
                      "Read Later",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                    ),
                    icon: Icon(Icons.timer_sharp),
                  ),
                  Text(
                    later.description!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
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
