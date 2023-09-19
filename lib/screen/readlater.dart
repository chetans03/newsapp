import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:napp/Widgets/detailformriverpod.dart';

import 'package:napp/model/curatedlink.dart';
import 'package:napp/model/rlMoel.dart';
import 'package:napp/provider/newsprovider.dart';

import 'detailscreen.dart';

class ReadLater extends ConsumerWidget {
  const ReadLater({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(newsprovider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Articles",
          style: GoogleFonts.lato(
            fontSize: 25,
            fontWeight: FontWeight.w300,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Color.fromARGB(255, 2, 2, 2),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Read later",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            list.isEmpty
                ? const Center(
                    child: Text(
                      "Please add a article to read later",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w200,
                        color: Color.fromARGB(255, 255, 251, 251),
                      ),
                    ),
                  )
                : Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) => SingleChildScrollView(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (x) => LaterDRiverpod(
                                  later: Later(
                                      list[index].name,
                                      list[index].title,
                                      list[index].url,
                                      list[index].description),
                                ),
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
                                          imageUrl: list[index].url!),
                                    ),
                                    Positioned(
                                      left: 5,
                                      right: 40,
                                      bottom: 10,
                                      top: 130,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(.5),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Expanded(
                                            child: Text(
                                              list[index].title!,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 255, 251, 251),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    list[index].name!,
                                    style: GoogleFonts.raleway(
                                        color:
                                            Color.fromARGB(255, 227, 242, 255),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ]),
    );
  }
}
