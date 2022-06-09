import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lm_launcher/pages/radio_players.dart';
import 'package:lm_launcher/pages/tv_pages.dart';

class RadioCard extends StatefulWidget {
  final FocusNode? focusNode;
  final String? image;
  final String? title;
  final String? url;
  final String? devideId;
  final String? type;
  const RadioCard(
      {Key? key,
      this.focusNode,
      this.image,
      this.title,
      this.url,
      this.devideId,
      this.type})
      : super(key: key);

  @override
  State<RadioCard> createState() => _RadioCardState();
}

class _RadioCardState extends State<RadioCard> {
  bool _focused = false;
  late FocusAttachment _nodeAttachment;
  Color _color = Colors.white;

  @override
  void initState() {
    super.initState();
    //widget.focusNode = FocusNode(debugLabel: 'Button');
    widget.focusNode?.addListener(_handleFocusChange);
    _nodeAttachment = widget.focusNode!.attach(context, onKey: _handleKeyPress);
  }

  void _handleFocusChange() {
    print(widget.focusNode?.hasFocus);
    if (widget.focusNode?.hasFocus != _focused) {
      setState(() {
        _focused = widget.focusNode!.hasFocus;
        _color = Colors.white;
      });
    }
  }

  KeyEventResult _handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      print('Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.select) {
        if (widget.type == 'tv') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TvPages()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RadioPlayers(
                      image: widget.image,
                      title: widget.title,
                      url: widget.url,
                    )),
          );
        }
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  cekAppEstist(String packageName) async {
    //print(packageName);
    bool isexsit = await DeviceApps.isAppInstalled('com.frandroid.app');
    return isexsit;
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocusChange);
    // The attachment will automatically be detached in dispose().
    widget.focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        focusNode: widget.focusNode,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return Color(_focused ? 0XFFAB8C56 : 0XFFFFFFFF);
          }),
          elevation: MaterialStateProperty.resolveWith<double?>(
              (Set<MaterialState> states) {
            return 0;
          }),
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
              (Set<MaterialState> states) {
            return EdgeInsets.symmetric(
                horizontal: 10, vertical: _focused ? 10 : 0);
          }),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Image.network(widget.image!, width: 100,
                errorBuilder: (context, error, stackTrace) {
              return const Text("data");
            }),*/
            SizedBox(
              width: 150,
              height: 150,
              child: Image.network(
                widget.url!, // this image doesn't exist
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: const Text(
                      'Whoops!',
                      style: TextStyle(fontSize: 30),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text((widget.title!.toUpperCase()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Roboto Condensed',
                      color: Color(_focused ? 0XFFFFFFFF : 0XFFAB8C56))),
            )
          ],
        ),
        onPressed: () {
          //print("create item");
        },
      ),
    );
  }
}
