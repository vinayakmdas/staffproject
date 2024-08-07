import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Apptext extends StatelessWidget {
  final double? fontSize;
  final Color? Colors;
  final FontWeight? fontweight;
  final String? data;

  const Apptext(this.data,
      {super.key, this.fontweight, this.Colors, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      data.toString(),
      style:
          TextStyle(color: Colors, fontWeight: fontweight, fontSize: fontSize),
    );
  }
}
// ===========================================================================

