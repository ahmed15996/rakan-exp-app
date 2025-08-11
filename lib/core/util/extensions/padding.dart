import 'package:flutter/material.dart';





extension ExtensionWidget on Widget {
  Widget get center => Align(alignment: Alignment.center, child: this);

  Widget withPadding({
    double all = 0.0,
    double vertical = 0.0,
    double horizontal = 0.0,
    double top = 0.0,
    double bottom = 0.0,
    double start = 0.0,
    double end = 0.0,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: all + vertical + top,
        bottom: all + vertical + bottom,
        start: all + horizontal + start,
        end: all + horizontal + end,
      ),
      child: this,
    );
  }

  Widget get toEnd => Align(alignment: AlignmentDirectional.centerEnd, child: this);
  Widget get toStart => Align(alignment: AlignmentDirectional.centerStart, child: this);
  Widget get toBottom => Align(alignment: Alignment.bottomCenter, child: this);
  Widget get toBottomEnd => Align(alignment: AlignmentDirectional.bottomEnd, child: this);
  Widget get toBottomStart => Align(alignment: AlignmentDirectional.bottomStart, child: this);
  Widget get toTopEnd => Align(alignment: AlignmentDirectional.topEnd, child: this);
  Widget get toTopStart => Align(alignment: AlignmentDirectional.topStart, child: this);
  Widget get toTop => Align(alignment: Alignment.topCenter, child: this);
}




