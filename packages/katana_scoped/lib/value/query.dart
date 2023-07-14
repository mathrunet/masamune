part of katana_scoped.value;

/// Provides an extension method for [Ref] to manage state using [ScopedQuery].
///
/// [ScopedQuery]を用いた状態管理を行うための[Ref]用の拡張メソッドを提供します。
extension RefQueryExtensions on Ref {
  /// It is possible to manage the status by passing [query].
  ///
  /// Defining [ScopedQuery] in a global scope allows you to manage state individually and safely.
  ///
  /// [ScopedQuery] allows you to cache all values, while [ChangeNotifierScopedQuery] monitors values and notifies updates when they change.
  ///
  /// [query]を渡して状態を管理することが可能です。
  ///
  /// [ScopedQuery]をグローバルなスコープに定義しておくことで状態を個別に安全に管理することができます。
  ///
  /// [ScopedQuery]を使うとすべての値をキャッシュすることができ、[ChangeNotifierScopedQuery]を使うと値を監視して変更時に更新通知を行います。
  ///
  /// ```dart
  /// final valueNotifierQuery = ChangeNotifierScopedQuery(
  ///   () => ValueNotifier(0),
  /// );
  ///
  /// class TestPage extends PageScopedWidget {
  ///   @override
  ///   Widget build(BuildContext context, PageRef ref) {
  ///     final valueNotifier = ref.page.query(valueNotifierQuery);
  ///
  ///     return Scaffold(
  ///       body: Center(child: Text("${valueNotifier.value}")),
  ///     );
  ///   }
  /// }
  /// ```
  T query<T>(ScopedQuery<T> query) {
    return getScopedValue<T, _QueryValue<T>>(
      (ref) => _QueryValue<T>(
        callback: query.call(ref),
        ref: ref,
        listen: query.listen,
        autoDisposeWhenUnreferenced: query.autoDisposeWhenUnreferenced,
      ),
      listen: query.listen,
      name: query.name,
    );
  }
}

/// Provides an extension method for [RefHasApp] to manage state using [ScopedQuery].
///
/// [ScopedQuery]を用いた状態管理を行うための[RefHasApp]用の拡張メソッドを提供します。
extension RefHasAppQueryExtensions on RefHasApp {
  /// It is possible to manage the status by passing [query].
  ///
  /// Defining [ScopedQuery] in a global scope allows you to manage state individually and safely.
  ///
  /// [ScopedQuery] allows you to cache all values, while [ChangeNotifierScopedQuery] monitors values and notifies updates when they change.
  ///
  /// [query]を渡して状態を管理することが可能です。
  ///
  /// [ScopedQuery]をグローバルなスコープに定義しておくことで状態を個別に安全に管理することができます。
  ///
  /// [ScopedQuery]を使うとすべての値をキャッシュすることができ、[ChangeNotifierScopedQuery]を使うと値を監視して変更時に更新通知を行います。
  ///
  /// ```dart
  /// final valueNotifierQuery = ChangeNotifierScopedQuery(
  ///   () => ValueNotifier(0),
  /// );
  ///
  /// class TestPage extends PageScopedWidget {
  ///   @override
  ///   Widget build(BuildContext context, PageRef ref) {
  ///     final valueNotifier = ref.query(valueNotifierQuery);
  ///
  ///     return Scaffold(
  ///       body: Center(child: Text("${valueNotifier.value}")),
  ///     );
  ///   }
  /// }
  /// ```
  T query<T>(ScopedQuery<T> query) {
    return app.query(query);
  }
}

@immutable
class _QueryValue<T> extends ScopedValue<T> {
  const _QueryValue({
    required this.callback,
    required this.ref,
    this.listen = false,
    this.autoDisposeWhenUnreferenced = false,
  });

  final T Function() callback;
  final bool listen;
  final Ref ref;
  final bool autoDisposeWhenUnreferenced;

  @override
  ScopedValueState<T, ScopedValue<T>> createState() => _QueryValueState<T>();
}

class _QueryValueState<T> extends ScopedValueState<T, _QueryValue<T>> {
  _QueryValueState();

  late T _value;

  @override
  bool get autoDisposeWhenUnreferenced => value.autoDisposeWhenUnreferenced;

  @override
  void initValue() {
    super.initValue();
    _value = value.callback.call();
    final val = _value;
    if (val is Listenable) {
      val.addListener(_handledOnUpdate);
    }
    if (!value.listen) {
      final ref = value.ref;
      if (ref is ListenableRef) {
        ref.addListener(_handledOnUpdateByRef);
      }
    }
  }

  void _handledOnUpdate() {
    setState(() {});
  }

  void _handledOnUpdateByRef() {
    _value = value.callback.call();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    final val = _value;
    if (val is Listenable) {
      val.removeListener(_handledOnUpdate);
      if (val is ChangeNotifier) {
        val.dispose();
      }
    }
    final ref = value.ref;
    if (ref is ListenableRef) {
      ref.removeListener(_handledOnUpdateByRef);
    }
  }

  @override
  T build() => _value;
}
