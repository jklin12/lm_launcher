import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lm_launcher/utils/InfoArguments.dart';

class RadioCard extends StatefulWidget {
  final FocusNode? focusNode;
  final String? image;
  final String? title;
  final String? url;
  final String? devideId;
  const RadioCard(
      {Key? key,
      this.focusNode,
      this.image,
      this.title,
      this.url,
      this.devideId})
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
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  cekAppEstist(String packageName) async {
    print(packageName);
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
          children: [
            Image.network(widget.image!, width: 100,
                errorBuilder: (context, error, stackTrace) {
              return const Text("data");
            }),
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
          print("create item");
        },
      ),
    );
    ;
  }
}
