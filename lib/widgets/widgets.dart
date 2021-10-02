import 'dart:math' as math;
import 'dart:convert';
import 'dart:typed_data';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octo_image/octo_image.dart';

import 'package:tec_pass/features/app/app.dart';
import 'package:tec_pass/features/home/cubit/navbar_cubit.dart';
import 'package:tec_pass/features/user/bloc/user_bloc.dart';
import 'package:tec_pass/models/models.dart';
import 'package:tec_pass/helpers/helpers.dart';

part 'contact_widget.dart';
part 'customappbar.dart';
part '../features/home/widgets/customnavbar.dart';
part '../features/auth/common/widgets/customtextfield.dart';
part 'feature_overlay.dart';
part 'invite_widget.dart';
part 'place_widget.dart';
part 'user_photo_widget.dart';