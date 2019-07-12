import 'package:flutter/material.dart';
import 'package:ree_tpa/models/ree_video_model.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  final ReeVideoModel reeVideoModel;
  PlayVideo({Key key, this.reeVideoModel}) : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  // Explicit

  ReeVideoModel reeVideoModel;
  ChewieController chewieController;
  VideoPlayerController videoPlayerController;
  String urlVideo;

  // Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      reeVideoModel = widget.reeVideoModel;
      urlVideo = reeVideoModel.pathVideo;
      videoPlayerController = VideoPlayerController.network(urlVideo);
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 3 / 2,
        autoPlay: false,
        looping: true,
      );
    });
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Video ${reeVideoModel.name}'),
      ),
      body: Center(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
