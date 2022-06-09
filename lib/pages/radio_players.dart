import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radio_player/radio_player.dart';

class RadioPlayers extends StatefulWidget {
  final String? title;
  final String? image;
  final String? url;
  const RadioPlayers({Key? key, this.image, this.title, this.url})
      : super(key: key);

  @override
  State<RadioPlayers> createState() => _RadioPlayersState();
}

class _RadioPlayersState extends State<RadioPlayers> {
  RadioPlayer _radioPlayer = RadioPlayer();
  late FocusAttachment _nodeAttachment;
  bool isPlaying = false;
  bool _focused = false;
  List<String>? metadata;
  FocusNode playBtn = FocusNode();

  @override
  void initState() {
    super.initState();
    initRadioPlayer();
    playBtn.addListener(_handleFocusChange);
    _nodeAttachment = playBtn.attach(context, onKey: _handleKeyPress);
  }

  void _handleFocusChange() {
    if (playBtn.hasFocus != _focused) {
      setState(() {
        _focused = playBtn.hasFocus;
      });
    }
  }

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: widget.title ?? '',
      url: 'http://stream-uk1.radioparadise.com/aac-320',
      imagePath: 'assets/images/logo.png',
    );

    _radioPlayer.stateStream.listen((value) {
      print(value);
      setState(() {
        isPlaying = value;
      });
    });

    _radioPlayer.metadataStream.listen((value) {
      print(value);
      setState(() {
        metadata = value;
      });
    });
  }

  KeyEventResult _handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      print('Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.select) {
        isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "http://202.169.224.46/lm_launcher/files/images/home_bg.webp"),
                        fit: BoxFit.cover,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(177, 0, 0, 0),
                          Color.fromARGB(124, 31, 5, 5),
                          Color(0x00000000),
                          Color.fromARGB(164, 0, 0, 0),
                        ],
                      ),
                    ),
                  
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder(
                  future: _radioPlayer.getArtworkImage(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    /*Image artwork;
                    if (snapshot.hasData) {
                      artwork = snapshot.data;
                    } else {
                      artwork = Image.network(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      );
                    }*/
                    return SizedBox(
                      height: 180,
                      width: 180,
                      child: ClipRRect(
                        child: Image.network(
                          widget.image!,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  metadata?[0] ?? 'Metadata',
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  metadata?[1] ?? '',
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          focusNode: playBtn,
          onPressed: () {
            isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
          },
          tooltip: 'Control button',
          backgroundColor: _focused ? Colors.red : Colors.blue,
          child: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          ),
        ));
  }
}
