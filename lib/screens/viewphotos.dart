import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

class ViewPhotos extends StatefulWidget {
  final String imgPath;
  const ViewPhotos({
    Key? key,
    required this.imgPath,
  }) : super(key: key);

  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
  var filePath;
  final String imgShare = 'Image.file(File(widget.imgPath),)';

  final LinearGradient backgroundGradient = const LinearGradient(
    colors: [
      Color(0x00000000),
      Color(0x00333333),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  void _onLoading(bool t, String str) {
    if (t) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const CircularProgressIndicator()),
                ),
              ],
            );
          });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Image Downloaded Successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "VIEW PHOTO",
          style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 18.sm,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: widget.imgPath,
                child: Image.file(File(widget.imgPath), fit: BoxFit.fill),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                bottom: 30.r,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          _onLoading(true, '');

                          final myUri = Uri.parse(widget.imgPath);
                          final originalImageFile = File.fromUri(myUri);
                          Uint8List bytes;
                          await originalImageFile
                              .readAsBytes()
                              .then((value) async {
                            bytes = Uint8List.fromList(value);
                            final result = await ImageGallerySaver.saveImage(
                                Uint8List.fromList(bytes));
                            print(result);

                            print('reading of bytes is completed');
                          }).catchError((onError) {
                            print(
                                'Exception Error while reading audio from path:' +
                                    onError.toString());
                          });

                          _onLoading(false,
                              'If Image not available in gallary\n\nYou can find all images at');
                        },
                        child: Container(
                          height: 60.sm,
                          child: Center(
                            child: Icon(
                              Icons.cloud_download_outlined,
                              color: Colors.black,
                              size: 30.sm,
                            ),
                          ),
                          width: 60.sm,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Share.shareFiles([widget.imgPath]);
                        },
                        child: Container(
                          height: 60.sm,
                          child: Center(
                            child: Icon(
                              Icons.share,
                              color: Colors.black,
                              size: 30.sm,
                            ),
                          ),
                          width: 60.sm,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            //  FabDialer(_fabMiniMenuItemList, Colors.teal, const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
