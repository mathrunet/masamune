part of masamune_builder;

Field linkedPathField(ClassModel model, PathModel? linkedPath) {
  return Field(
    (f) => f
      ..name = "_linked${model.name}Path"
      ..modifier = FieldModifier.constant
      ..type = const Reference("String?")
      ..assignment = Code(
        linkedPath == null ? "null" : "\"${linkedPath.path}\"",
      ),
  );
}
