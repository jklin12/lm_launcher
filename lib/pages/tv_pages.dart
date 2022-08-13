import 'package:flutter/material.dart';
import 'package:lm_launcher/base/add_stream/m3u_to_channel.dart';
import 'package:lm_launcher/channel/live_stream.dart';

class TvPages extends StatefulWidget {
  final String? url;
  const TvPages({Key? key, this.url}) : super(key: key);

  @override
  State<TvPages> createState() => _TvPagesState();
}

class _TvPagesState extends State<TvPages> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onAdd() async { 
      final AddStreamResponse? response = AddStreamResponse(type: StreamType.Live,channels: LiveStream(channel, epg));
      if (response != null) {
        addStreams(response);
      } 
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Video Demo',
        home: Scaffold(
          body: Center(child: Container()),
        ));
  }
}
