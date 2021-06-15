part of masamune;

class InlinePageBuilder extends StatefulWidget {
  InlinePageBuilder({
    this.initialRoute,
    this.controller,
    this.routes,
    this.prefix = "",
    this.suffix = "",
  }) : assert(
          initialRoute != null || controller?._route != null,
          "Either [initialRoute] or [initialRoute] of [controller] must be specified.",
        );
  final String? initialRoute;
  final NavigatorController? controller;
  final Map<String, RouteConfig>? routes;
  final String prefix;
  final String suffix;

  @override
  State<StatefulWidget> createState() => _InlinePageBuilderState();
}

class _InlinePageBuilderState extends State<InlinePageBuilder> {
  NavigatorController? _controller;
  Widget? _cache;

  NavigatorController? get _effectiveController =>
      widget.controller ?? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = NavigatorController(widget.initialRoute);
    }
    if (widget.routes.isNotEmpty) {
      RouteConfig.addRoutes(
        widget.routes!.map(
          (key, value) =>
              MapEntry("${widget.prefix}$key${widget.suffix}", value),
        ),
      );
    }
  }

  @override
  void didUpdateWidget(InlinePageBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.routes != oldWidget.routes) {
      if (oldWidget.routes.isNotEmpty) {
        RouteConfig.removeRoutes(
          oldWidget.routes!.map(
            (key, value) =>
                MapEntry("${widget.prefix}$key${widget.suffix}", value),
          ),
        );
      }
      if (widget.routes.isNotEmpty) {
        RouteConfig.addRoutes(
          widget.routes!.map(
            (key, value) =>
                MapEntry("${widget.prefix}$key${widget.suffix}", value),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.routes.isNotEmpty) {
      RouteConfig.removeRoutes(
        widget.routes!.map(
          (key, value) =>
              MapEntry("${widget.prefix}$key${widget.suffix}", value),
        ),
      );
    }
  }

  /// Keys for the navigator.
  NavigatorState get navigator => _effectiveController!.navigator;

  /// Creating a body.
  ///
  /// [context]: Build context.
  @override
  Widget build(BuildContext context) {
    if (_cache != null) {
      return _cache!;
    }
    return _cache = WillPopScope(
      onWillPop: () async {
        return !await navigator.maybePop();
      },
      child: InlineNavigator(
        observers: [_effectiveController!.observer],
        key: _effectiveController!._navigatorKey,
        prefix: widget.prefix,
        suffix: widget.suffix,
        initialRoute: _effectiveController?._route,
        onGenerateRoute: (settings) => RouteConfig.onGenerateRoute(settings),
        onGenerateInitialRoutes: (state, initialRouteName) {
          return [
            RouteConfig.onGenerateRoute(
                  RouteSettings(
                    name: initialRouteName,
                    arguments: ModalRoute.of(context)?.settings.arguments,
                  ),
                ) ??
                UIPageRoute(
                  builder: (_) => const Empty(),
                  settings: RouteSettings(
                    name: initialRouteName,
                    arguments: ModalRoute.of(context)?.settings.arguments,
                  ),
                ),
          ];
        },
      ),
    );
  }
}

class InlineNavigator extends Navigator {
  InlineNavigator({
    Key? key,
    List<Page<dynamic>> pages = const <Page<dynamic>>[],
    bool Function(Route<dynamic>, dynamic)? onPopPage,
    String? initialRoute,
    List<Route<dynamic>> Function(NavigatorState, String)
        onGenerateInitialRoutes = Navigator.defaultGenerateInitialRoutes,
    Route<dynamic>? Function(RouteSettings)? onGenerateRoute,
    Route<dynamic>? Function(RouteSettings)? onUnknownRoute,
    TransitionDelegate<dynamic> transitionDelegate =
        const DefaultTransitionDelegate<dynamic>(),
    bool reportsRouteUpdateToEngine = false,
    List<NavigatorObserver> observers = const <NavigatorObserver>[],
    String? restorationScopeId,
    this.prefix = "",
    this.suffix = "",
  }) : super(
          key: key,
          pages: pages,
          onPopPage: onPopPage,
          initialRoute: "$prefix$initialRoute$suffix",
          onGenerateInitialRoutes: onGenerateInitialRoutes,
          onGenerateRoute: onGenerateRoute,
          onUnknownRoute: onUnknownRoute,
          transitionDelegate: transitionDelegate,
          reportsRouteUpdateToEngine: reportsRouteUpdateToEngine,
          observers: observers,
          restorationScopeId: restorationScopeId,
        );

  final String prefix;
  final String suffix;
  @override
  InlineNavigatorState createState() => InlineNavigatorState();
}

class InlineNavigatorState extends NavigatorState {
  @override
  InlineNavigator get widget => super.widget as InlineNavigator;

  @override
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      super.popAndPushNamed<T, TO>(
        "${widget.prefix}$routeName${widget.suffix}",
        result: result,
        arguments: arguments,
      );

  @override
  Future<T?> pushNamed<T extends Object?>(String routeName,
          {Object? arguments}) =>
      super.pushNamed<T>(
        "${widget.prefix}$routeName${widget.suffix}",
        arguments: arguments,
      );

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
          String newRouteName, RoutePredicate predicate,
          {Object? arguments}) =>
      super.pushNamedAndRemoveUntil<T>(
        "${widget.prefix}$newRouteName${widget.suffix}",
        predicate,
        arguments: arguments,
      );

  @override
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      super.pushReplacementNamed<T, TO>(
        "${widget.prefix}$routeName${widget.suffix}",
        result: result,
        arguments: arguments,
      );

  @override
  String restorablePopAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      super.restorablePopAndPushNamed<T, TO>(
        "${widget.prefix}$routeName${widget.suffix}",
        result: result,
        arguments: arguments,
      );

  @override
  String restorablePushNamed<T extends Object?>(String routeName,
          {Object? arguments}) =>
      super.restorablePushNamed<T>(
        "${widget.prefix}$routeName${widget.suffix}",
        arguments: arguments,
      );

  @override
  String restorablePushNamedAndRemoveUntil<T extends Object?>(
          String newRouteName, RoutePredicate predicate,
          {Object? arguments}) =>
      super.restorablePushNamedAndRemoveUntil<T>(
        "${widget.prefix}$newRouteName${widget.suffix}",
        predicate,
        arguments: arguments,
      );

  @override
  String restorablePushReplacementNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      super.restorablePushReplacementNamed<T, TO>(
        "${widget.prefix}$routeName${widget.suffix}",
        result: result,
        arguments: arguments,
      );
}

class NavigatorController extends Listenable {
  NavigatorController([String? initialRoute]) : _route = initialRoute;
  final String? _route;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  final InternalNavigatorObserver observer = InternalNavigatorObserver._();
  NavigatorState get navigator => _navigatorKey.currentState!;

  RouteSettings? get route =>
      observer._current?.settings ?? RouteSettings(name: _route);

  @override
  void addListener(VoidCallback listener) {
    observer._addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    observer._removeListener(listener);
  }
}

/// Observer to be able to catch the navigation movement inside.
///
/// You can describe what to do
/// when the internal page changes by [subscribe] and listen for changes.
class InternalNavigatorObserver extends NavigatorObserver {
  InternalNavigatorObserver._();
  final List<VoidCallback> _listener = [];
  Route? _current;

  void _addListener(VoidCallback listener) {
    if (_listener.contains(listener)) {
      return;
    }
    _listener.add(listener);
  }

  void _removeListener(VoidCallback listener) {
    _listener.remove(listener);
  }

  /// The [Navigator] replaced oldRoute with newRoute.
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (_current == newRoute) {
      return;
    }
    if (_current == null) {
      _current = newRoute;
    } else {
      _current = newRoute;
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        _listener.forEach((element) => element.call());
      });
    }
  }

  /// The [Navigator] pushed route.
  ///
  /// The route immediately below that one, and thus the previously active route, is previousRoute.
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (_current == route) {
      return;
    }
    if (_current == null) {
      _current = route;
    } else {
      _current = route;
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        _listener.forEach((element) => element.call());
      });
    }
  }

  /// The [Navigator] popped route.
  ///
  /// The route immediately below that one, and thus the newly active route, is previousRoute.
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (_current == previousRoute) {
      return;
    }
    if (_current == null) {
      _current = previousRoute;
    } else {
      _current = previousRoute;
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        _listener.forEach((element) => element.call());
      });
    }
  }
}
