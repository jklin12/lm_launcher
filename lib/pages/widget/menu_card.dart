import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuCard extends StatefulWidget {
  final FocusNode? focusNode;
  final String? image;
  final String? title;
  final String? body;
  final String? url;
  final List<String>? listImage;
  const MenuCard(
      {Key? key,
      this.focusNode,
      this.image,
      this.title,
      this.url,
      this.body,
      this.listImage})
      : super(key: key);

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool _focused = false;
  late FocusAttachment _nodeAttachment;
  Color _color = Colors.white;

  @override
  void initState() {
    super.initState();
    //widget.focusNode = FocusNode(debugLabel: 'Button')
    //widget.focusNode!.requestFocus();
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
                    image: NetworkImage(widget.image!), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                widget.title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.0,
                    color: Color(_focused ? 0XFFFFFFFF : 0XFFAB8C56)),
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

        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration( 
              image: DecorationImage(
                  image: NetworkImage('http://202.169.224.46/lm_launcher' +
                      widget.listImage![0]))),
          child: Stack(children: [
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: MediaQuery.of(context).size.width /3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const Padding(
                      padding:   EdgeInsets.symmetric(horizontal:8.0),
                      child:  Text(
                         "Scan QR \n untuk memesan", 
                          textAlign: TextAlign.end, 
                          style:  TextStyle(
                              fontSize: 15.0, 
                              fontFamily: 'Roboto Condensed',
                              color: Colors.white),
                        ),
                    ),
                    Image.network("http://202.169.224.46/lm_launcher/files/food/QR-Code.png",width: 100,),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.title!,
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto Condensed',
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 210,
                      height: 338,
                      child: Text(
                        widget.body!, 
                        textAlign: TextAlign.justify, 
                        style: const TextStyle(
                            fontSize: 18.0, 
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
