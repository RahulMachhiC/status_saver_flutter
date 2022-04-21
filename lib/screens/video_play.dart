import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../helpers/video_controller.dart';

class PlayStatus extends StatefulWidget {
  final String? videoFile;
  const PlayStatus({
    Key? key,
    this.videoFile,
  }) : super(key: key);
  @override
  _PlayStatusState createState() => _PlayStatusState();
}

class _PlayStatusState extends State<PlayStatus> {
  @override
  void initState() {
    super.initState();
    print('Video file you are looking for:' + widget.videoFile!);
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      Fluttertoast.showToast(msg: "Video Downloaded Successfully");
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
      ),
      body: StatusVideo(
        videoPlayerController:
            VideoPlayerController.file(File(widget.videoFile!)),
        looping: true,
        videoSrc: widget.videoFile,
      ),
      // ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade400,
          child: const Icon(
            Icons.download,
            color: Colors.black,
          ),
          onPressed: () async {
            _onLoading(true, '');

            final originalVideoFile = File(widget.videoFile!);
            final directory = await getExternalStorageDirectory();
            print('directory: $directory');
            if (!Directory('/storage/emulated/0/wa_status_saver')
                .existsSync()) {
              Directory('/storage/emulated/0/wa_status_saver')
                  .createSync(recursive: true);
            }
            // final path = directory.path;
            final curDate = DateTime.now().toString();
            final newFileName =
                '/storage/emulated/0/wa_status_saver/VIDEO-$curDate.mp4';
            print(newFileName);
            await GallerySaver.saveVideo(originalVideoFile.path);

            _onLoading(
              false,
              'If Video not available in gallary\n\nYou can find all videos at',
            );
          }),
    );
  }
}
