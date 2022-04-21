import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/screens/video_play.dart';
import 'package:status_saver/screens/viewphotos.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../helpers/thumbnailrequest.dart';

final Directory whatsappbusiness = Directory(
    '/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses');

class StatusforWB extends StatefulWidget {
  const StatusforWB({Key? key}) : super(key: key);

  @override
  State<StatusforWB> createState() => _StatusforWBState();
}

class _StatusforWBState extends State<StatusforWB> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("bb");
    var imageList = whatsappbusiness.listSync().map((item) {
      print(item.path);
      return item.path;
    }).where((element) {
      return element.endsWith(".jpg");
    }).toList(growable: false);
    var videoList = whatsappbusiness.listSync().map((item) {
      print(item.path);
      return item.path;
    }).where((element) {
      return element.endsWith(".mp4");
    }).toList(growable: false);
    var alllist = whatsappbusiness.listSync().map((e) {
      return e.path;
    }).where((element) {
      return element.endsWith(".mp4") || element.endsWith(".jpg");
    }).toList();
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shape: RoundedRectangleBorder(),
          elevation: 0,
          backgroundColor: Color(0xff25D366),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          automaticallyImplyLeading: false,
          title: Text(
            "Recent Status",
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 18.sm,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.sm),
            child: AppBar(
              shape: RoundedRectangleBorder(),
              elevation: 0,
              backgroundColor: Color(0xff25D366),
              centerTitle: true,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                padding: EdgeInsets.zero,
                indicatorColor: Colors.transparent,
                labelPadding: EdgeInsets.only(left: 20.r),
                isScrollable: true,
                labelColor: Color(0xff25D366),
                unselectedLabelColor: Color(0xff25D366),
                tabs: [
                  Tab(
                    child: Container(
                      height: 30.sm,
                      width: 80.sm,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "ALL",
                          style: GoogleFonts.montserrat(fontSize: 12.sm),
                        ),
                      ),
                    ),
                    // text: "ALL",
                  ),
                  Tab(
                    child: Container(
                      height: 30.sm,
                      width: 80.sm,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "IMAGES",
                          style: GoogleFonts.montserrat(fontSize: 12.sm),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 30.sm,
                      width: 80.sm,
                      padding: EdgeInsets.only(left: 6.r, right: 6.r),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "VIDEOS",
                          style: GoogleFonts.montserrat(fontSize: 12.sm),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              alllist.length > 0
                  ? Container(
                      margin: EdgeInsets.all(13.r),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.sm,
                            mainAxisSpacing: 10.sm,
                            mainAxisExtent: 250.sm),
                        itemCount: alllist.length,
                        itemBuilder: (context, index) {
                          final imgPath = alllist[index];
                          return getvideoandimage(
                              alllist: alllist, index: index, imgPath: imgPath);
                        },
                      ),
                    )
                  : Scaffold(
                      body: Center(
                        child: Container(
                            padding: const EdgeInsets.only(bottom: 60.0),
                            child: const Text(
                              'Sorry, No Data Found!',
                              style: TextStyle(fontSize: 18.0),
                            )),
                      ),
                    ),
              imageList.length > 0
                  ? Container(
                      margin: EdgeInsets.all(13.r),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.sm,
                            mainAxisSpacing: 10.sm,
                            mainAxisExtent: 250.sm),
                        itemCount: imageList.length,
                        itemBuilder: (context, index) {
                          final imgPath = imageList[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewPhotos(
                                      imgPath: imgPath,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                  tag: imgPath,
                                  child: Image.file(
                                    File(imgPath),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          );
                        },
                      ),
                    )
                  : Scaffold(
                      body: Center(
                        child: Container(
                            padding: const EdgeInsets.only(bottom: 60.0),
                            child: const Text(
                              'Sorry, No Image Found!',
                              style: TextStyle(fontSize: 18.0),
                            )),
                      ),
                    ),
              videoList.length > 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 13.r, vertical: 13.r),
                      child: GridView.builder(
                        itemCount: videoList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.sm,
                            mainAxisSpacing: 10.sm,
                            mainAxisExtent: 250.sm),
                        itemBuilder: (context, index) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlayStatus(
                                        videoFile: videoList[index],
                                      ),
                                    ),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: FutureBuilder<ThumbnailResult>(
                                        future: genThumbnail(ThumbnailRequest(
                                            video: videoList.elementAt(index),
                                            imageFormat: ImageFormat.PNG,
                                            maxHeight: 200,
                                            maxWidth: 200,
                                            timeMs: 20,
                                            quality: 100)),
                                        builder: (context, snapshot) {
                                          print(snapshot.connectionState);
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            print(snapshot.hasData);
                                            if (snapshot.hasData) {
                                              final _image =
                                                  snapshot.data!.image;

                                              return Column(
                                                children: [
                                                  _image,
                                                ],
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          } else {
                                            return Hero(
                                              tag: videoList[index],
                                              child: SizedBox(
                                                height: 280.0,
                                                child: Image.asset(
                                                    'assets/images/video-placeholder.webp'),
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  height: 50.sm,
                                  width: 50.sm,
                                  child: Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.black,
                                      size: 30.sm,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  : Scaffold(
                      body: Center(
                        child: Container(
                            padding: const EdgeInsets.only(bottom: 60.0),
                            child: const Text(
                              'Sorry, No Video Found!',
                              style: TextStyle(fontSize: 18.0),
                            )),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getvideoandimage(
      {required List alllist, required int index, required imgPath}) {
    if (alllist.elementAt(index).endsWith(".jpg")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewPhotos(
                  imgPath: imgPath,
                ),
              ),
            );
          },
          child: Hero(
              tag: imgPath,
              child: Image.file(
                File(imgPath),
                fit: BoxFit.fill,
              )),
        ),
      );
    } else if (alllist.elementAt(index).endsWith(".mp4")) {
      return Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayStatus(
                    videoFile: alllist[index],
                  ),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.fill,
                child: FutureBuilder<ThumbnailResult>(
                    future: genThumbnail(ThumbnailRequest(
                        video: alllist.elementAt(index),
                        imageFormat: ImageFormat.PNG,
                        maxHeight: 200,
                        maxWidth: 200,
                        timeMs: 20,
                        quality: 100)),
                    builder: (context, snapshot) {
                      print(snapshot.connectionState);
                      if (snapshot.connectionState == ConnectionState.done) {
                        print(snapshot.hasData);
                        if (snapshot.hasData) {
                          final _image = snapshot.data!.image;

                          return Column(
                            children: [
                              _image,
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      } else {
                        return Hero(
                          tag: alllist[index],
                          child: SizedBox(
                            height: 280.0,
                            child: Image.asset(
                                'assets/images/video-placeholder.webp'),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 50.sm,
              width: 50.sm,
              child: Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                  size: 30.sm,
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade400,
              ),
            ),
          )
        ],
      );
    }
    return SizedBox();
  }
}
