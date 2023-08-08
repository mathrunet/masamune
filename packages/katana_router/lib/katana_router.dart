// Copyright 2023 mathru. All rights reserved.

/// A package to automatically create routing configurations with build_runner to enable type-safe routing.
///
/// To use, import `package:katana_router/katana_router.dart`.
///
/// [mathru.net]: https://mathru.net
/// [YouTube]: https://www.youtube.com/c/mathrunetchannel
library katana_router;

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:katana_logger/katana_logger.dart';

import 'src/others/others.dart'
    if (dart.library.io) 'src/others/others.dart'
    if (dart.library.js) 'src/web/web.dart'
    if (dart.library.html) 'src/web/web.dart' as url_strategy;

export 'package:katana/katana.dart';
export 'package:katana_logger/katana_logger.dart';
export 'package:katana_router_annotation/katana_router_annotation.dart';

part "src/extensions.dart";
part 'src/route_query.dart';
part 'src/route_query_builder.dart';
part 'src/app_page_route.dart';
part 'src/redirect_query.dart';
part 'src/transition_query.dart';
part 'src/transition_query_type.dart';
part 'src/app_router.dart';
part 'src/app_route_information_parser.dart';
part 'src/app_router_delegate.dart';
part 'src/app_route_information_provider.dart';
part 'src/route_logger_event.dart';
