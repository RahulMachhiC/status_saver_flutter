import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class StatusVideo extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool? looping;
  final String? videoSrc;
  final double? aspectRatio;

  const StatusVideo({
    required this.videoPlayerController,
    this.looping,
    this.videoSrc,
    this.aspectRatio,
    Key? key,
  }) : super(key: key);

  @override
  _StatusVideoState createState() => _StatusVideoState();
}

class _StatusVideoState extends State<StatusVideo> {
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        autoInitialize: true,
        looping: widget.looping!,
        autoPlay: true,
        allowFullScreen: false,
        allowMuting: true,
        showOptions: false,
        fullScreenByDefault: false,
        aspectRatio: widget.videoPlayerController.value.aspectRatio,
        // autoPlay: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(errorMessage),
          );
        });
    print(' aspect ratio: ${widget.videoPlayerController.value}');
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(top: 0),
      child: Hero(
        tag: widget.videoSrc!,
        child: Chewie(
          controller: _chewieController!,
        ),
      ),
    );
    //     ],
    //   ),
    // );
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }
}
