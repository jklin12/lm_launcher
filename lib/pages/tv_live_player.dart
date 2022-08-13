import 'package:flutter/material.dart';
import 'package:lm_launcher/channel/live_stream.dart';
import 'package:lm_launcher/player/controller.dart';
import 'package:lm_launcher/player/tv_player.dart';
import 'package:flutter_common/utils.dart';

class TvLivePlayerPage extends StatefulWidget {
  final LiveStream channel;

  const TvLivePlayerPage(this.channel);

  @override
  _TvLivePlayerPageState createState() => _TvLivePlayerPageState();
}

class _TvLivePlayerPageState extends PlayerPageTVState<TvLivePlayerPage> {
  late BasePlayerController<LiveStream> _controller;

  @override
  BasePlayerController<LiveStream> get controller => _controller;

  @override
  String get name => widget.channel.displayName();

  @override
  void initPlayer() {
    _controller = BasePlayerController<LiveStream>(widget.channel);
  }

  @override
  KeyEventResult onPlayer(RawKeyEvent event, BuildContext ctx) {
    return onKey(event, (keyCode) {
      switch (keyCode) {
        case ENTER:
        case KEY_CENTER:
        case PAUSE:
          if (_controller.isPlaying()) {
            _controller.pause();
          } else {
            _controller.play();
          }
          toggleSnackBar(ctx);
          return KeyEventResult.handled;

        case BACK:
        case BACKSPACE:
          _controller.sendRecent(widget.channel);
          Navigator.of(context).pop();
          return KeyEventResult.handled;
        case MENU:
          toggleSnackBar(ctx);
          return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    });
  }
}
