import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AtractionCard extends StatefulWidget {
  final FocusNode? focusNode;
  final String? image;
  final String? title;
  final String? url;
  final List<String>? listImage;
  const AtractionCard(
      {Key? key,
      this.focusNode,
      this.image,
      this.title,
      this.url,
      this.listImage})
      : super(key: key);

  @override
  State<AtractionCard> createState() => _AtractionCardState();
}

class _AtractionCardState extends State<AtractionCard> {
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
        showDialog(
            context: context,
            builder: (_) => imageDialog(widget.title, widget.image, context));

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
            Container(
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.image!),
                    fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                widget.title!,
                textAlign: TextAlign.center,
                style:   TextStyle(fontSize: 12.0, color: Color(_focused ?   0XFFFFFFFF: 0XFFAB8C56)),
              ),
            )
          ],
        ),
        onPressed: () {
          print("create item");
        },
      ),
    );
  }

  Widget imageDialog(text, path, context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      // elevation: 0,

      child: CarouselSlider(
        items: widget.listImage!.map((e) {
          return Builder(
            builder: (context) {
              return Image.network('http://202.169.224.46/lm_launcher' + e);
            },
          );
        }).toList(),
        options: CarouselOptions(height: 400.0,autoPlay: true),
      ),
    );
  }
}
