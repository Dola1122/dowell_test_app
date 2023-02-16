import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ImagesHelper imagesHelper = ImagesHelper();
  String? imagePath;
  List<String> images = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            imagePath = await imagesHelper.takePhoto();
            setState(() {});
            if (imagePath != null) {
              var data = await imagesHelper.createFormData(imagePath!);
              var imgs = (await imagesHelper.uploadFormData(data))!;
              images.addAll(imgs);
              setState(() {});
            }
          },
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 200, child: centerWidget(imagePath)),
              SizedBox(
                height: 30,
              ),
              ImagesListView(imagesUrls: images),
            ],
          ),

          //         Column(
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     Padding(
          //       padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         children: [
          //           Expanded(
          //             child: Stack(
          //               children: [
          //                 imagePath == null
          //                     ? Center(child: CircularProgressIndicator())
          //                     : Align(
          //                         alignment: AlignmentDirectional(0, 0),
          //                         child: Image.file(
          //                           File(imagePath!),
          //                           width: 207.7,
          //                           height: 315.7,
          //                           fit: BoxFit.fill,
          //                         ),
          //                       ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Row(
          //       mainAxisSize: MainAxisSize.max,
          //       children: [
          //         Expanded(
          //           child: Align(
          //             alignment: AlignmentDirectional(0, 0),
          //             child: Text(
          //               'Select a matching logo',
          //               style: TextStyle(
          //                 color: Color(0xFFB00000),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     ImagesListView(imagesUrls: images),
          //     Align(
          //       alignment: AlignmentDirectional(0, 0),
          //       child: Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          //         child: Stack(
          //           children: [
          //             Align(
          //               alignment: AlignmentDirectional(0.9, 0.05),
          //               child: MaterialButton(
          //                 onPressed: () async {
          //                   images = await ImagesHelper().takePhoto();
          //                   imagePath = images[0];
          //                   images.removeAt(0);
          //                   setState(() {});
          //                 },
          //                 child: Text('Select logo'),
          //                 minWidth: 165.4,
          //                 height: 55.4,
          //                 color: Color(0xFFD7CC00),
          //                 shape: RoundedRectangleBorder(
          //                   side: BorderSide(
          //                     color: Colors.transparent,
          //                     width: 1,
          //                   ),
          //                   borderRadius: BorderRadius.circular(8),
          //                 ),
          //               ),
          //             ),
          //             Align(
          //               alignment: AlignmentDirectional(-0.95, 0),
          //               child: IconButton(
          //                 icon: Icon(
          //                   Icons.help,
          //                   color: Color(0xFFF1E100),
          //                   size: 30,
          //                 ),
          //                 onPressed: () {
          //                   print('IconButton pressed ...');
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // )),
        ),
      ),
    );
  }
}

class ImagesListView extends StatelessWidget {
  const ImagesListView({
    super.key,
    required this.imagesUrls,
  });

  final List<String> imagesUrls;

  @override
  Widget build(BuildContext context) {
    return imagesUrls.isNotEmpty
        ? Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagesUrls.length,
              itemBuilder: (context, index) {
                return  CachedNetworkImage(
                  imageUrl: imagesUrls[index],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  httpHeaders: {
                    "Authorization": "Token 53b43d479ddae2307e8d53bd069a884098ba07b9",
                  },
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                );
              },
            ),
          )
        : Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/666/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/831/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/168/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/336/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/122/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}

Widget centerWidget(String? imagePath) {
  if (imagePath == null) {
    return const Center(child: CircularProgressIndicator());
  } else {
    return Image.file(File(imagePath!));
  }
}
