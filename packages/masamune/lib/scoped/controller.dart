part of '/masamune.dart';

/// Create an extension method for [AppScopedValueOrAppRef] to handle Query for controllers and controller groups.
///
/// コントローラーやコントローラーグループ用のQueryを処理するための[AppScopedValueOrAppRef]の拡張メソッドを作成します。
extension MasamuneControllerAppScopedValueOrAppRefExtensions
    on AppScopedValueOrAppRef {
  /// A [TController] whose state is retained is obtained by passing the [ControllerQueryBase] generated by the builder.
  ///
  /// ビルダーによりコード生成された[ControllerQueryBase]を渡すことにより状態を保持された[TController]を取得します。
  ///
  /// ```dart
  /// final userController = appRef.controller(UserController.query()); // Get the user controller.
  /// final userControllerGroup = appRef.controller(UserControllerGroup.query()); // Get the user controller group.
  /// ```
  TController controller<TController extends Listenable>(
    ControllerQueryBase<TController> query, {
    bool? autoDisposeWhenUnreferenced,
  }) {
    return this.query(
      query,
      autoDisposeWhenUnreferenced: autoDisposeWhenUnreferenced,
    );
  }
}

/// Create an extension method for [QueryScopedValueRef] to handle Query for controllers and controller groups.
///
/// コントローラーやコントローラーグループ用のQueryを処理するための[QueryScopedValueRef]の拡張メソッドを作成します。
extension MasamuneControllerQueryScopedValueRefExtensions
    on QueryScopedValueRef<AppScopedValueOrAppRef> {
  /// A [TController] whose state is retained is obtained by passing the [ControllerQueryBase] generated by the builder.
  ///
  /// ビルダーによりコード生成された[ControllerQueryBase]を渡すことにより状態を保持された[TController]を取得します。
  ///
  /// ```dart
  /// final userController = appRef.controller(UserController.query()); // Get the user controller.
  /// final userControllerGroup = appRef.controller(UserControllerGroup.query()); // Get the user controller group.
  /// ```
  TController controller<TController extends Listenable>(
    ControllerQueryBase<TController> query, {
    bool? autoDisposeWhenUnreferenced,
  }) {
    return this.query(
      query,
      autoDisposeWhenUnreferenced: autoDisposeWhenUnreferenced,
    );
  }
}

/// Create an extension method for [RefHasApp] to handle Query for controllers and controller groups.
///
/// コントローラーやコントローラーグループ用のQueryを処理するための[RefHasApp]の拡張メソッドを作成します。
extension MasamuneControllerRefHasAppExtensions on RefHasApp {
  @Deprecated(
    "It is no longer possible to use [controller] by directly specifying [PageRef] or [WidgetRef]. Instead, use [ref.app.controller] to specify the scope. [PageRef]や[WidgetRef]を直接指定しての[controller]の利用はできなくなります。代わりに[ref.app.controller]でスコープを指定しての利用を行ってください。",
  )
  TController controller<TController extends Listenable>(
    ControllerQueryBase<TController> query, {
    bool? autoDisposeWhenUnreferenced,
  }) {
    return app.query(
      query,
      autoDisposeWhenUnreferenced: autoDisposeWhenUnreferenced,
    );
  }
}

/// Create extension methods for [PageRef] and [WidgetRef] in **Page Scope** to handle Query for controllers and controller groups.
///
/// コントローラーやコントローラーグループ用のQueryを処理するための**ページスコープ**の[PageRef]や[WidgetRef]の拡張メソッドを作成します。
extension MasamuneControllerPageScopedValueRefExtensions on PageScopedValueRef {
  @Deprecated(
    "[controller] with page scope is no longer available. Please use [ref.app.controller] instead. ページスコープを指定しての[controller]は利用できなくなります。代わりに[ref.app.controller]を利用してください。Appスコープのみでの利用となります。",
  )
  TController controller<TController extends Listenable>(
    ScopedQueryBase<TController, PageScopedValueRef> query, {
    bool? autoDisposeWhenUnreferenced,
  }) {
    return this.query(
      query,
      autoDisposeWhenUnreferenced: autoDisposeWhenUnreferenced,
    );
  }
}

/// Base class for creating state-to-state usage queries for controllers that are code-generated by the builder.
///
/// Basically, you can get a class that inherits from [ChangeNotifier].
///
/// ビルダーによりコード生成するコントローラーの状態間利用クエリを作成するためのベースクラス。
///
/// 基本的には[ChangeNotifier]を継承したクラスを取得することが出来ます。
abstract class ControllerQueryBase<TController extends Listenable>
    extends ChangeNotifierScopedQueryBase<TController, AppScopedValueOrAppRef> {
  /// Base class for creating state-to-state usage queries for controllers that are code-generated by the builder.
  ///
  /// Basically, you can get a class that inherits from [ChangeNotifier].
  ///
  /// ビルダーによりコード生成するコントローラーの状態間利用クエリを作成するためのベースクラス。
  ///
  /// 基本的には[ChangeNotifier]を継承したクラスを取得することが出来ます。
  const ControllerQueryBase()
      : super(
          _provider,
        );

  static TController _provider<TController extends Listenable>(Ref ref) {
    throw UnimplementedError();
  }
}
