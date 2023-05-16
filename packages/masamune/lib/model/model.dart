part of masamune;

/// Create an extension method for [AppRef] to handle the Query for the model.
///
/// モデル用のQueryを処理するための[AppRef]の拡張メソッドを作成します。
extension MasamuneModelAppRefExtensions on AppRef {
  /// Retrieve the state-preserved [TModel] by passing the [ModelQueryBase] code generated by the builder.
  ///
  /// ビルダーによりコード生成された[ModelQueryBase]を渡すことにより状態を保持された[TModel]を取得します。
  ///
  /// ```dart
  /// final document = appRef.model(UserModel.document()); // Get the user document.
  /// final collection = appRef.model(UserModel.collection()); // Get the user collection.
  /// ```
  TModel model<TModel extends Listenable>(
    ModelQueryBase<TModel> query,
  ) {
    return this.query(query);
  }
}

/// Create extension methods for [PageRef] and [WidgetRef] to handle Query for models.
///
/// モデル用のQueryを処理するための[PageRef]や[WidgetRef]の拡張メソッドを作成します。
extension MasamuneModelExtensions on RefHasApp {
  /// Retrieve the state-preserved [TModel] by passing the [ModelQueryBase] code generated by the builder.
  ///
  /// Any changes to the model are monitored and the widgets used are updated when changes are made.
  ///
  /// ビルダーによりコード生成された[ModelQueryBase]を渡すことにより状態を保持された[TModel]を取得します。
  ///
  /// モデルの変更はすべて監視され、変更が行われた際、利用したウィジェットは更新されます。
  ///
  /// ```dart
  /// final document = ref.model(UserModel.document()); // Get the user document.
  /// final collection = ref.model(UserModel.collection()); // Get the user collection.
  /// ```
  TModel model<TModel extends Listenable>(
    ModelQueryBase<TModel> query,
  ) {
    return app.query(query);
  }
}

/// Base class for creating state-to-state usage queries for the model to be code-generated by the builder.
///
/// Basically, you can get classes that inherit from [DocumentBase] or [CollectionBase].
///
/// ビルダーによりコード生成するモデルの状態間利用クエリを作成するためのベースクラス。
///
/// 基本的には[DocumentBase]や[CollectionBase]を継承したクラスを取得することが出来ます。
abstract class ModelQueryBase<TModel extends Listenable>
    extends ChangeNotifierScopedQuery<TModel> {
  /// Base class for creating state-to-state usage queries for the model to be code-generated by the builder.
  ///
  /// Basically, you can get classes that inherit from [DocumentBase] or [CollectionBase].
  ///
  /// ビルダーによりコード生成するモデルの状態間利用クエリを作成するためのベースクラス。
  ///
  /// 基本的には[DocumentBase]や[CollectionBase]を継承したクラスを取得することが出来ます。
  const ModelQueryBase()
      : super(
          _provider,
        );

  static TModel _provider<TModel extends Listenable>(Ref ref) {
    throw UnimplementedError();
  }

  @override
  bool get autoDisposeWhenUnreferenced => false;
}
