import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TvPages extends StatefulWidget {
  const TvPages({Key? key}) : super(key: key);

  @override
  State<TvPages> createState() => _TvPagesState();
}

class _TvPagesState extends State<TvPages> {
  final videoPlayerController = VideoPlayerController.network(
      'https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8');
  ChewieController? chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Video Demo',
        home: Scaffold(
          body: Center(
              child: Container(
            child: Chewie(controller: chewieController!),
          )),
        ));
  }
}
