part of katana_annotation;

/// Gives DynamicCollectionModel functionality to the objects generated by the Builder.
mixin DynamicDocumentModelGeneratedWrapperMixin {
  /// Returns the DynamicDocumentModel entity.
  DynamicDocumentModel document();

  /// Provides the best data acquisition method to implement during screen build.
  ///
  /// Data loading does not occur in duplicate when a screen is built multiple times.
  ///
  /// Basically, it listens for data.
  /// If [listen] is set to `false`, load only.
  Future<void> fetch([bool listen = true]) {
    return document().fetch(listen);
  }

  /// Data stored in the model is stored in a database external to the app that is tied to the model.
  ///
  /// The updated [Result] can be obtained at the stage where the loading is finished.
  Future<void> save() {
    return document().save();
  }

  /// Reload data and updates the data in the model.
  ///
  /// It is basically the same as the [load] method,
  /// but combining it with [loadOnce] makes it easier to manage the data.
  Future<void> reload() {
    return document().reload();
  }

  /// Deletes the document.
  ///
  /// Deleted documents are immediately reflected and removed from related collections, etc.
  Future<void> delete() {
    return document().delete();
  }

  /// Returns itself after the load finishes.
  Future<void>? get loading {
    return document().loading;
  }

  /// Returns itself after the save/delete finishes.
  Future<void>? get saving {
    return document().saving;
  }
}
