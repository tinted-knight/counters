import 'package:flutter/material.dart';

import 'light_theme.dart';

const _offset = 1.0;
const _blur = 1.5;
const _shadowLight = Color(0xffFFFFFF);
const _shadowDark = Color(0xffD1CDC7);

const neuOuterDecoration = BoxDecoration(
  color: ThemeLight.scaffoldBgColor,
  boxShadow: [
    // kind of neumorphism
    // top shadow - light
    BoxShadow(
      color: _shadowLight,
      offset: Offset(-_offset, -_offset),
      blurRadius: _blur,
    ),
    // botttom shadow - dark
    BoxShadow(
      color: _shadowDark,
      offset: Offset(_offset, _offset),
      blurRadius: _blur,
    ),
  ],
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
);

const _innerOffset = 1.0;
const _innerBlur = 1.0;

final neuInnerDecoration = BoxDecoration(
  color: Colors.black.withOpacity(0.075),
  boxShadow: [
    BoxShadow(
      color: Colors.white,
      offset: Offset(_innerOffset, _innerOffset),
      blurRadius: _innerBlur,
    ),
  ],
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
);
