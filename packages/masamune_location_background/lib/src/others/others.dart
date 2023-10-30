// For others.
library masamune_location_background.others;

// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:masamune/masamune.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';

// Project imports:
import 'package:masamune_location_background/masamune_location_background.dart';

import 'package:background_locator_2/settings/locator_settings.dart'
    as locator_settings;

part 'background_location.dart';
part 'background_location_callback_handler.dart';
part 'background_location_repository.dart';
