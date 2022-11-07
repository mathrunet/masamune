part of katana_model;

/// Define a document model for storing [T] types that inherit from [ChangeNotifier].
///
/// Any changes made locally in the app will be notified and related objects will reflect the changes.
///
/// When a value is reflected by [save], [delete], [transaction], or updated in real time from outside, all listeners are notified of the change by [notifyListeners].
///
/// Define object conversion from [DynamicMap] to [T], which is output by decoding Json by implementing [DocumentBase.fromMap].
///
/// Implementing [DocumentBase.toMap] defines the conversion from a [T] object to a [DynamicMap] that can later be Json encoded.
///
/// By defining [DocumentBase.modelQuery], you can specify settings for loading, such as document paths.
///
/// The [value] value can be set and retrieved. In this case, no change notification is made as in the case of [ValueNotifier].
///
/// [ChangeNotifier]を継承した[T]型を保存するためのドキュメントモデルを定義します。
///
/// アプリのローカル内での変更はすべて通知され関連のあるオブジェクトは変更内容が反映されます。
///
/// [save]や[delete]、[transaction]での値反映、外部からのリアルタイム更新が行われた場合[notifyListeners]によって変更内容がすべてのリスナーに通知されます。
///
/// [DocumentBase.fromMap]を実装することでJsonをデコードして出力される[DynamicMap]から[T]へのオブジェクト変換を定義します。
///
/// [DocumentBase.toMap]を実装することで[T]のオブジェクトから後にJsonエンコード可能な[DynamicMap]への変換を定義します。
///
/// [DocumentBase.modelQuery]を定義することで、ドキュメントのパスなど読み込みを行うための設定を指定できます。
///
/// [value]値をセット、取得できます。その際[ValueNotifier]のように変更通知は行われません。
abstract class DocumentBase<T> extends ChangeNotifier
    implements ValueListenable<T?> {
  /// Define a document model for storing [T] types that inherit from [ChangeNotifier].
  ///
  /// Any changes made locally in the app will be notified and related objects will reflect the changes.
  ///
  /// When a value is reflected by [save], [delete], [transaction], or updated in real time from outside, all listeners are notified of the change by [notifyListeners].
  ///
  /// Define object conversion from [DynamicMap] to [T], which is output by decoding Json by implementing [DocumentBase.fromMap].
  ///
  /// Implementing [DocumentBase.toMap] defines the conversion from a [T] object to a [DynamicMap] that can later be Json encoded.
  ///
  /// By defining [DocumentBase.modelQuery], you can specify settings for loading, such as document paths.
  ///
  /// The [value] value can be set and retrieved. In this case, no change notification is made as in the case of [ValueNotifier].
  ///
  /// [ChangeNotifier]を継承した[T]型を保存するためのドキュメントモデルを定義します。
  ///
  /// アプリのローカル内での変更はすべて通知され関連のあるオブジェクトは変更内容が反映されます。
  ///
  /// [save]や[delete]、[transaction]での値反映、外部からのリアルタイム更新が行われた場合[notifyListeners]によって変更内容がすべてのリスナーに通知されます。
  ///
  /// [DocumentBase.fromMap]を実装することでJsonをデコードして出力される[DynamicMap]から[T]へのオブジェクト変換を定義します。
  ///
  /// [DocumentBase.toMap]を実装することで[T]のオブジェクトから後にJsonエンコード可能な[DynamicMap]への変換を定義します。
  ///
  /// [DocumentBase.modelQuery]を定義することで、ドキュメントのパスなど読み込みを行うための設定を指定できます。
  ///
  /// [value]値をセット、取得できます。その際[ValueNotifier]のように変更通知は行われません。
  DocumentBase(this.modelQuery, [this._value])
      : assert(
          !(modelQuery.path.splitLength() <= 0 ||
              modelQuery.path.splitLength() % 2 != 0),
          "The query path hierarchy must be an even number: ${modelQuery.path}",
        );

  /// Define a document model for storing [T] types that inherit from [ChangeNotifier].
  ///
  /// Any changes made locally in the app will be notified and related objects will reflect the changes.
  ///
  /// When a value is reflected by [save], [delete], [transaction], or updated in real time from outside, all listeners are notified of the change by [notifyListeners].
  ///
  /// Define object conversion from [DynamicMap] to [T], which is output by decoding Json by implementing [DocumentBase.fromMap].
  ///
  /// Implementing [DocumentBase.toMap] defines the conversion from a [T] object to a [DynamicMap] that can later be Json encoded.
  ///
  /// By defining [DocumentBase.modelQuery], you can specify settings for loading, such as document paths.
  ///
  /// The [value] value can be set and retrieved. In this case, no change notification is made as in the case of [ValueNotifier].
  ///
  /// [ChangeNotifier]を継承した[T]型を保存するためのドキュメントモデルを定義します。
  ///
  /// アプリのローカル内での変更はすべて通知され関連のあるオブジェクトは変更内容が反映されます。
  ///
  /// [save]や[delete]、[transaction]での値反映、外部からのリアルタイム更新が行われた場合[notifyListeners]によって変更内容がすべてのリスナーに通知されます。
  ///
  /// [DocumentBase.fromMap]を実装することでJsonをデコードして出力される[DynamicMap]から[T]へのオブジェクト変換を定義します。
  ///
  /// [DocumentBase.toMap]を実装することで[T]のオブジェクトから後にJsonエンコード可能な[DynamicMap]への変換を定義します。
  ///
  /// [DocumentBase.modelQuery]を定義することで、ドキュメントのパスなど読み込みを行うための設定を指定できます。
  ///
  /// [value]値をセット、取得できます。その際[ValueNotifier]のように変更通知は行われません。
  DocumentBase.unrestricted(this.modelQuery, [this._value]);

  /// Defines the object transformation from [DynamicMap] to [T], which is output by decoding Json.
  ///
  /// A [DynamicMap] decoded from Json, etc. is passed to [map].
  ///
  /// Jsonをデコードして出力される[DynamicMap]から[T]へのオブジェクト変換を定義します。
  ///
  /// [map]にJsonなどからデコード済みの[DynamicMap]が渡されます。
  @protected
  @mustCallSuper
  T fromMap(DynamicMap map);

  /// Defines the conversion from a [T] object to a [DynamicMap] that can later be Json encoded.
  ///
  /// The object [T] held by the document is passed to [value].
  ///
  /// [T]のオブジェクトから後にJsonエンコード可能な[DynamicMap]への変換を定義します。
  ///
  /// [value]にドキュメントが保持している[T]のオブジェクトが渡されます。
  @protected
  @mustCallSuper
  DynamicMap toMap(T value);

  /// The current value stored in this document.
  ///
  /// Unlike `ValueNotifer`, no notification is given even if the value is rewritten.
  ///
  /// このドキュメントに格納されている現在の値です。
  ///
  /// `ValueNotifer`と違って値を書き換えた場合でも通知は行いません。
  @override
  T? get value => _value;
  T? _value;

  /// The current value stored in this document.
  ///
  /// Unlike `ValueNotifer`, no notification is given even if the value is rewritten.
  ///
  /// このドキュメントに格納されている現在の値です。
  ///
  /// `ValueNotifer`と違って値を書き換えた場合でも通知は行いません。
  set value(T? newValue) {
    if (_value == newValue) {
      return;
    }
    _value = newValue;
  }

  /// Query for loading and saving documents.
  ///
  /// ドキュメントを読込・保存するためのクエリ。
  @protected
  final DocumentModelQuery modelQuery;

  /// Database queries for documents.
  ///
  /// ドキュメント用のデータベースクエリ。
  @protected
  ModelAdapterDocumentQuery get databaseQuery {
    return _databaseQuery ??= ModelAdapterDocumentQuery(
      query: modelQuery,
      callback: handledOnUpdate,
      origin: this,
    );
  }

  ModelAdapterDocumentQuery? _databaseQuery;

  /// List of currently subscribed notifications. All should be canceled when the object is destroyed.
  ///
  /// 現在購読中の通知一覧。オブジェクトの破棄時にすべてキャンセルするようにしてください。
  @protected
  List<StreamSubscription> get subscriptions => _subscriptions;
  final List<StreamSubscription> _subscriptions = [];

  /// Returns `true` if the data was successfully loaded by the [load] method.
  ///
  /// If this is set to `true`, the [load] method will not be loaded when executed.
  ///
  /// [load]メソッドでデータが読み込みに成功した場合`true`を返します。
  ///
  /// これが`true`になっている場合、[load]メソッドは実行しても読込は行われません。
  bool get loaded => _loaded;
  bool _loaded = false;

  /// If [load] or [reload] is executed, it waits until the loading process is completed.
  ///
  /// After reading is completed, a [T] object is returned.
  ///
  /// If neither [load] nor [reload] is in progress, [Null] is returned.
  ///
  /// [load]や[reload]を実行した場合、その読込処理が終わるまで待ちます。
  ///
  /// 読込終了後、[T]オブジェクトが返されます。
  ///
  /// [load]や[reload]を実行中でない場合、[Null]が返されます。
  Future<T>? get loading => _loadCompleter?.future;
  Completer<T>? _loadCompleter;

  /// If [save] or [delete] is executed, it waits until the read process is completed.
  ///
  /// [save]や[delete]を実行した場合、その読込処理が終わるまで待ちます。
  Future<void>? get saving => _saveCompleter?.future;
  Completer<T>? _saveCompleter;

  /// Reads documents corresponding to [modelQuery].
  ///
  /// The return value is a [T] object, and the loaded data is available as is.
  ///
  /// Set [listenWhenPossible] to `true` to monitor changes against change monitorable databases.
  ///
  /// Once content is loaded, no new loading is performed. Therefore, it can be used in a method that is read any number of times, such as in the `build` method of a `widget`.
  ///
  /// If you wish to reload the file, use the [reload] method.
  ///
  /// [modelQuery]に対応したドキュメントの読込を行います。
  ///
  /// 戻り値は[T]オブジェクトが返され、そのまま読込済みのデータの利用が可能になります。
  ///
  /// [listenWhenPossible]を`true`にすると変更監視可能なデータベースに対して変更を監視するように設定します。
  ///
  /// 一度読み込んだコンテンツに対しては、新しい読込は行われません。そのため`Widget`の`build`メソッド内など何度でも読み出されるメソッド内でも利用可能です。
  ///
  /// 再読み込みを行いたい場合は[reload]メソッドを利用してください。
  Future<T?> load([bool listenWhenPossible = true]) async {
    if (_loadCompleter != null) {
      return loading!;
    }
    try {
      final _value = value;
      _loadCompleter = Completer<T>();
      if (!loaded) {
        final res = await loadRequest(listenWhenPossible);
        if (res != null) {
          value = fromMap(filterOnLoad(res));
        }
        _loaded = true;
      }
      value = _filterOnDidLoad(value);
      if (_value != value) {
        notifyListeners();
      }
      _loadCompleter?.complete(value);
      _loadCompleter = null;
    } catch (e) {
      _loadCompleter?.completeError(e);
      _loadCompleter = null;
      rethrow;
    } finally {
      _loadCompleter?.complete();
      _loadCompleter = null;
    }
    return value;
  }

  /// Reload the document corresponding to [modelQuery].
  ///
  /// The return value is a [T] object, and the loaded data is available as is.
  ///
  /// Set [listenWhenPossible] to `true` to monitor changes against change monitorable databases.
  ///
  /// Unlike the [load] method, this method performs a new load each time it is executed. Therefore, do not use this method in a method that is read repeatedly, such as in the `build` method of a `widget`.
  ///
  /// [modelQuery]に対応したドキュメントの再読込を行います。
  ///
  /// 戻り値は[T]オブジェクトが返され、そのまま読込済みのデータの利用が可能になります。
  ///
  /// [listenWhenPossible]を`true`にすると変更監視可能なデータベースに対して変更を監視するように設定します。
  ///
  /// [load]メソッドとは違い実行されるたびに新しい読込を行います。そのため`Widget`の`build`メソッド内など何度でも読み出されるメソッド内では利用しないでください。
  Future<T?> reload([bool listenWhenPossible = true]) {
    _loaded = false;
    return load(listenWhenPossible);
  }

  /// After loading is complete, add data.
  ///
  /// After loading is completed, [onDidLoad] is always executed, and the return value of [onDidLoad] is the value of the list as it is.
  ///
  /// After the method execution completes, the object [T] is returned.
  ///
  /// ロード完了後、データを追加します。
  ///
  /// ロード完了後必ず[onDidLoad]が実行され、[onDidLoad]の戻り値がそのままリストの値となります。
  ///
  /// メソッド実行完了後[T]のオブジェクトが返されます。
  FutureOr<T?> append(
    T? Function(T? value) onDidLoad,
  ) async {
    if (_loadCompleter != null) {
      _onDidLoad = onDidLoad;
      return loading!;
    }
    try {
      final _value = value;
      _loadCompleter = Completer<T>();
      value = onDidLoad.call(value);
      if (_value != value) {
        notifyListeners();
      }
      _loadCompleter?.complete(value);
      _loadCompleter = null;
    } catch (e) {
      _loadCompleter?.completeError(e);
      _loadCompleter = null;
      rethrow;
    } finally {
      _loadCompleter?.complete();
      _loadCompleter = null;
    }
    return value;
  }

  T? _filterOnDidLoad(T? value) {
    if (_onDidLoad != null) {
      final val = _onDidLoad!.call(value);
      _onDidLoad = null;
      return val;
    }
    return value;
  }

  T? Function(T? value)? _onDidLoad;

  /// Data can be saved.
  ///
  /// Since it is only the content of [value] that is saved, it is necessary to change the content of [value] before saving.
  ///
  /// It is possible to wait for saving with `await`.
  ///
  /// データの保存を行うことができます。
  ///
  /// 保存を行うのはあくまで[value]の中身なので保存を行う前に[value]の中身を変更しておく必要があります。
  ///
  /// `await`で保存を待つことが可能です。
  Future<void> save() async {
    if (value == null) {
      throw Exception(
        "The value is not set. Please set the value and then execute `save`.",
      );
    }
    if (_saveCompleter != null) {
      return saving!;
    }
    try {
      _saveCompleter = Completer<T>();
      await saveRequest(filterOnSave(toMap(value as T)));
      _saveCompleter?.complete(value);
      _saveCompleter = null;
    } catch (e) {
      _saveCompleter?.completeError(e);
      _saveCompleter = null;
      rethrow;
    } finally {
      _saveCompleter?.complete();
      _saveCompleter = null;
    }
  }

  /// Data can be deleted.
  ///
  /// It is the data in his document that is deleted.
  ///
  /// After deletion, the data is empty, but the object itself is still valid.
  ///
  /// If the database allows it, the data can be restored by re-entering the data and executing [save].
  ///
  /// データの削除を行うことができます。
  ///
  /// 削除されるのは自身のドキュメントのデータです。
  ///
  /// 削除後はデータが空になりますが、このオブジェクト自体は有効になっています。
  ///
  /// データベース上可能な場合、再度データを入れ[save]を実行することでデータを復元できます。
  Future<void> delete() async {
    if (_saveCompleter != null) {
      return saving!;
    }
    try {
      _saveCompleter = Completer<T>();
      await deleteRequest();
      _saveCompleter?.complete(value);
      _saveCompleter = null;
    } catch (e) {
      _saveCompleter?.completeError(e);
      _saveCompleter = null;
      rethrow;
    } finally {
      _saveCompleter?.complete();
      _saveCompleter = null;
    }
  }

  /// Create a transaction builder.
  ///
  /// The invoked transaction can be `call` as is, and transaction processing can be performed by executing [ModelTransactionDocument.load], [ModelTransactionDocument.save], and [ModelTransactionDocument.delete].
  ///
  /// ModelTransactionRef.read] can be used to create a [ModelTransactionDocument] from another [DocumentBase] and describe the process to be performed together.
  ///
  /// トランザクションビルダーを作成します。
  ///
  /// 呼び出されたトランザクションはそのまま`call`することができ、その引数から与えられる[ModelTransactionDocument]を用いて[ModelTransactionDocument.load]、[ModelTransactionDocument.save]、[ModelTransactionDocument.delete]を実行することでトランザクション処理を行うことが可能です。
  ///
  /// [ModelTransactionRef.read]を用いて他の[DocumentBase]から[ModelTransactionDocument]を作成することができ、まとめて実行する処理を記述することができます。
  ///
  /// ```dart
  /// final transaction = sourceDocument.transaction();
  /// transaction((ref, doc){ // `doc`は`sourceDocument`の[ModelTransactionDocument]
  ///   doc.value = {"name": "test"}; // The same mechanism can be used to perform the same preservation method as usual.
  ///   doc.save();
  /// });
  /// ```
  ModelTransactionBuilder<T> transaction() {
    return ModelTransactionBuilder._(this);
  }

  /// Implement internal processing when [load] or [reload] is executed.
  ///
  /// If [listenWhenPossible] is `true`, set the database to monitor changes against change-monitorable databases.
  ///
  /// [load]や[reload]を実行した際の内部処理を実装します。
  ///
  /// [listenWhenPossible]が`true`な場合、変更監視可能なデータベースに対して変更を監視するように設定します。
  @protected
  @mustCallSuper
  Future<DynamicMap?> loadRequest(bool listenWhenPossible) async {
    if (subscriptions.isNotEmpty) {
      await Future.forEach<StreamSubscription>(
        subscriptions,
        (subscription) => subscription.cancel(),
      );
      subscriptions.clear();
    }
    if (listenWhenPossible && modelQuery.adapter.availableListen) {
      subscriptions.addAll(
        await modelQuery.adapter.listenDocument(databaseQuery),
      );
      return null;
    } else {
      return await modelQuery.adapter.loadDocument(databaseQuery);
    }
  }

  /// Implement internal processing when [save] is executed.
  ///
  ///　The data to be stored in [map] is decoded and passed to [DynamicMap].
  ///
  /// Keys with [Null] in the value of [map] will be deleted. If all keys are deleted, the document itself will be deleted.
  ///
  /// [save]を実行した際の内部処理を実装します。
  ///
  /// [map]に保存するためのデータが[DynamicMap]にデコードされ渡されます。
  ///
  /// [map]の値に[Null]が入っているキーは削除されます。すべてのキーが削除された場合、ドキュメント自体が削除されます。
  @protected
  Future<void> saveRequest(DynamicMap map) async {
    return await modelQuery.adapter.saveDocument(databaseQuery, map);
  }

  /// Implement internal processing when [delete] is executed.
  ///
  /// The deletion process is performed using its own [modelQuery] and other data.
  ///
  /// [delete]を実行した際の内部処理を実装します。
  ///
  /// 自身の[modelQuery]などのデータを用いて削除処理を行います。
  @protected
  Future<void> deleteRequest() async {
    return await modelQuery.adapter.deleteDocument(databaseQuery);
  }

  /// Implement filters when loading data.
  ///
  /// The original [DynamicMap] data is passed to [rawData].
  ///
  /// By returning a converted [DynamicMap] value in the return value, that value is passed as a parameter to [fromMap].
  ///
  /// データをロードする際のフィルターを実装します。
  ///
  /// [rawData]に元の[DynamicMap]のデータが渡されます。
  ///
  /// 戻り値に変換した[DynamicMap]の値を戻すことでその値が[fromMap]のパラメータとして渡されます。
  @protected
  @mustCallSuper
  DynamicMap filterOnLoad(DynamicMap rawData) {
    return rawData;
  }

  /// You can filter the data to be saved.
  ///
  /// [rawData] will be the data that will be decoded and stored in [DynamicMap].
  ///
  /// The value returned is stored as data.
  ///
  /// 保存するデータをフィルターすることができます。
  ///
  /// [rawData]が[DynamicMap]にデコードされた保存されるデータになります。
  ///
  /// 戻り値に返した値がデータとして保存されます。
  @protected
  @mustCallSuper
  DynamicMap filterOnSave(DynamicMap rawData) {
    return {
      ...rawData,
      kUidFieldKey: modelQuery.path.trimQuery().last(),
    };
  }

  /// Describe the callback process to be passed to [ModelAdapterDocumentQuery.callback].
  ///
  /// This is executed when there is a change in the associated collection or document.
  ///
  /// Please take appropriate action according to the contents of [update].
  ///
  /// [ModelAdapterDocumentQuery.callback]に渡すためのコールバック処理を記述します。
  ///
  /// 関連するコレクションやドキュメントに変更があった場合、こちらが実行されます。
  ///
  /// [update]の内容に応じて適切な処理を行ってください。
  @protected
  Future<void> handledOnUpdate(ModelUpdateNotification update) async {
    final _value = value;
    value = _filterOnDidLoad(fromMap(filterOnLoad(update.value)));
    if (_value != value) {
      notifyListeners();
    }
  }

  @override
  @protected
  @mustCallSuper
  void dispose() {
    super.dispose();
    modelQuery.adapter.disposeDocument(databaseQuery);
    subscriptions.forEach((subscription) => subscription.cancel());
    subscriptions.clear();
  }

  @override
  String toString() => "$runtimeType($value)";
}
