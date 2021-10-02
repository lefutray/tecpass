import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_pass/features/profile/view/crop_image_view.dart';
import 'package:tec_pass/features/user/bloc/user_bloc.dart';
import 'package:tec_pass/features/visits/bloc/contacts_bloc.dart';

part 'sms.dart';
part 'orientations.dart';
part 'rut.dart';
part 'confirmation_popup.dart';
part 'photo_picker.dart';
part 'phone_to_string.dart';

void cacheImages(BuildContext context) async {
  await precacheImage(AssetImage('assets/Logo-tecpass-s.png'), context);
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/Check.svg'), context);
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/Cancelar.svg'), context);
}
