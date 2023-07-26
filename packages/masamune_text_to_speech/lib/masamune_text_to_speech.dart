// Copyright 2023 mathru. All rights reserved.

/// Masamune plug-in adapter for use with Text-to-Speech. Provides a controller.
///
/// To use, import `package:masamune_text_to_speech/masamune_text_to_speech.dart`.
///
/// [mathru.net]: https://mathru.net
/// [YouTube]: https://www.youtube.com/c/mathrunetchannel
library masamune_text_to_speech;

// Flutter imports:
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

// Package imports:
import 'package:masamune/masamune.dart';
import 'package:universal_platform/universal_platform.dart';

part 'adapter/text_to_speech_masamune_adapter.dart';
part 'src/text_to_speech_controller.dart';
