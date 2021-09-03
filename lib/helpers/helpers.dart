import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:tec_pass/bloc/bloc.dart';

part 'sms.dart';
part 'orientations.dart';
part 'rut.dart';
part 'confirmation_popup.dart';

void cacheImages(BuildContext context) async {
  await precacheImage(AssetImage('assets/Logo-tecpass-s.png'), context);
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/Check.svg'), context);
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/Cancelar.svg'), context);
}
