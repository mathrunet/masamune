part of katana_annotation;

/// Annotation indicating a collection in Masamune.
class CollectionPath {
  const CollectionPath(this.path);

  /// Paths for models.
  final String path;
}

/// Annotation indicating a document in Masamune.
class DocumentPath {
  const DocumentPath(this.path);

  /// Paths for models.
  final String path;
}

/// Annotation indicating a page in Masamune.
class PagePath {
  const PagePath(this.path);

  /// Paths for models.
  final String path;
}
