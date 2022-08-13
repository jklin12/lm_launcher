 
import 'package:flutter/material.dart';
import 'package:flutter_common/localization.dart';

class PlayerSnackbarTV extends SnackBar {
  PlayerSnackbarTV(BuildContext context, String title, bool isPlaying)
      : super(content: _content(context, title, isPlaying), backgroundColor: _backColor(context));

  static Color _backColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? Colors.black87 : Colors.white70;
  }

  static Widget _content(BuildContext context, String title, bool isPlaying) {
    final contentColor = Colors.black;
    return Row(children: <Widget>[
      const SizedBox(width: 16),
      Expanded(
          child: Text(AppLocalizations.toUtf8(title),
              style: TextStyle(fontSize: 36, color: contentColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false)),
      Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 48, color: contentColor)
    ]);
  }
}
