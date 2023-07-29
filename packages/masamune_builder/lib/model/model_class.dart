part of masamune_builder;

final _regExpModelRef = RegExp(r"ModelRef(Base)?<([^>]+)>");
final _regExpRef = RegExp(r"(.+)Ref");

/// Create document and collection models.
///
/// ドキュメントモデルやコレクションモデルを作成します。
List<Spec> modelClass(
  ClassValue model,
  AnnotationValue annotation,
  PathValue path,
  PathValue? mirror,
) {
  final searchable = model.parameters.where((e) => e.isSearchable).toList();
  final jsonSerarizable =
      model.parameters.where((e) => e.isJsonSerializable).toList();
  return [
    Extension(
      (e) => e
        ..on = Reference(model.name)
        ..methods.addAll([
          Method(
            (m) => m
              ..name = "rawValue"
              ..type = MethodType.getter
              ..returns = const Reference("Map<String, dynamic>")
              ..body = Code(
                jsonSerarizable.isEmpty
                    ? "return toJson();"
                    : "final map = toJson(); return { ...map, ${jsonSerarizable.map((e) => "\"${e.jsonKey}\": ${_jsonValue(e)}").join(",")}};",
              ),
          ),
        ]),
    ),
    Class(
      (c) => c
        ..name = "${model.name}Path"
        ..extend = Reference("ModelRefPath<${model.name}>")
        ..annotations.addAll([const Reference("immutable")])
        ..constructors.addAll([
          Constructor(
            (c) => c
              ..constant = true
              ..requiredParameters.addAll([
                Parameter(
                  (p) => p
                    ..name = "path"
                    ..type = const Reference("String"),
                )
              ])
              ..optionalParameters.addAll([
                Parameter(
                  (p) => p
                    ..name = "adapter"
                    ..type = const Reference("ModelAdapter?"),
                ),
              ])
              ..initializers.addAll([
                const Code("super(path, adapter)"),
              ]),
          ),
        ])
        ..fields.addAll([
          Field(
            (f) => f
              ..name = "_path"
              ..static = true
              ..modifier = FieldModifier.constant
              ..type = const Reference("String")
              ..assignment = Code(
                "\"${path.path.replaceAllMapped(_pathRegExp, (m) => "\$_${m.group(1)?.toCamelCase() ?? ""}")}\"",
              ),
          ),
        ])
        ..methods.addAll(
          [
            Method(
              (m) => m
                ..name = "modelQuery"
                ..annotations.addAll([
                  const Reference("override"),
                ])
                ..returns = const Reference("DocumentModelQuery")
                ..type = MethodType.getter
                ..body = const Code(
                  "return DocumentModelQuery( \"\$_path/\${path.trimQuery().trimString(\"/\")}\", adapter: adapter, );",
                ),
            )
          ],
        ),
    ),
    Class(
      (c) => c
        ..name = "${model.name}DataCollection"
        ..annotations.addAll([const Reference("immutable")])
        ..extend = Reference("ModelDataCollection<${model.name}>")
        ..mixins.addAll([
          if (searchable.isNotEmpty)
            Reference("SearchableDataCollectionMixin<${model.name}>"),
        ])
        ..constructors.addAll([
          Constructor(
            (c) => c
              ..constant = true
              ..requiredParameters.addAll([
                Parameter(
                  (p) => p
                    ..name = "value"
                    ..toSuper = true,
                )
              ])
              ..optionalParameters.addAll([
                ...path.parameters.map((param) {
                  return Parameter(
                    (p) => p
                      ..name = param.camelCase
                      ..named = true
                      ..required = true
                      ..type = const Reference("String"),
                  );
                }),
              ])
              ..initializers.addAll([
                ...path.parameters.map((param) {
                  return Code("_${param.camelCase} = ${param.camelCase}");
                }),
              ]),
          ),
        ])
        ..fields.addAll([
          ...path.parameters.map((param) {
            return Field(
              (f) => f
                ..name = "_${param.camelCase}"
                ..modifier = FieldModifier.final$
                ..type = const Reference("String"),
            );
          }),
        ])
        ..methods.addAll([
          Method(
            (m) => m
              ..name = "path"
              ..annotations.addAll([
                const Reference("override"),
              ])
              ..type = MethodType.getter
              ..lambda = true
              ..returns = const Reference("String")
              ..body = Code(
                "\"${path.path.replaceAllMapped(_pathRegExp, (m) => "\$_${m.group(1)?.toCamelCase() ?? ""}")}\"",
              ),
          ),
          Method(
            (m) => m
              ..name = "toMap"
              ..requiredParameters.addAll([
                Parameter(
                  (p) => p
                    ..name = "value"
                    ..type = Reference(model.name),
                )
              ])
              ..annotations.addAll([
                const Reference("override"),
              ])
              ..returns = const Reference("DynamicMap")
              ..lambda = true
              ..body = const Code("value.rawValue"),
          ),
          if (searchable.isNotEmpty)
            Method(
              (m) => m
                ..name = "buildSearchText"
                ..lambda = true
                ..returns = const Reference("String")
                ..annotations.addAll([const Reference("override")])
                ..requiredParameters.addAll([
                  Parameter(
                    (p) => p
                      ..name = "value"
                      ..type = Reference(model.name),
                  )
                ])
                ..body = Code(
                  searchable.map((e) {
                    if (e.type.toString().endsWith("?")) {
                      return "(value.${e.name}?.toString() ?? \"\")";
                    } else {
                      return "value.${e.name}.toString()";
                    }
                  }).join(" + "),
                ),
            ),
        ]),
    ),
    if (mirror != null) ...[
      Class(
        (c) => c
          ..name = "${model.name}MirrorPath"
          ..annotations.addAll([const Reference("immutable")])
          ..extend = Reference("ModelRefPath<${model.name}>")
          ..constructors.addAll([
            Constructor(
              (c) => c
                ..constant = true
                ..requiredParameters.addAll([
                  Parameter(
                    (p) => p
                      ..name = "path"
                      ..type = const Reference("String"),
                  )
                ])
                ..optionalParameters.addAll([
                  Parameter(
                    (p) => p
                      ..name = "adapter"
                      ..type = const Reference("ModelAdapter?"),
                  ),
                ])
                ..initializers.addAll([
                  const Code("super(path, adapter)"),
                ]),
            ),
          ])
          ..fields.addAll([
            Field(
              (f) => f
                ..name = "_path"
                ..static = true
                ..modifier = FieldModifier.constant
                ..type = const Reference("String")
                ..assignment = Code(
                  "\"${mirror.path.replaceAllMapped(_pathRegExp, (m) => "\$_${m.group(1)?.toCamelCase() ?? ""}")}\"",
                ),
            ),
          ])
          ..methods.addAll(
            [
              Method(
                (m) => m
                  ..name = "modelQuery"
                  ..annotations.addAll([
                    const Reference("override"),
                  ])
                  ..returns = const Reference("DocumentModelQuery")
                  ..type = MethodType.getter
                  ..body = const Code(
                    "return DocumentModelQuery( \"\$_path/\${path.trimQuery().trimString(\"/\")}\", adapter: adapter, );",
                  ),
              )
            ],
          ),
      ),
      Class(
        (c) => c
          ..name = "${model.name}MirrorDataCollection"
          ..annotations.addAll([const Reference("immutable")])
          ..extend = Reference("ModelDataCollection<${model.name}>")
          ..mixins.addAll([
            if (searchable.isNotEmpty)
              Reference("SearchableDataCollectionMixin<${model.name}>"),
          ])
          ..constructors.addAll([
            Constructor(
              (c) => c
                ..constant = true
                ..requiredParameters.addAll([
                  Parameter(
                    (p) => p
                      ..name = "value"
                      ..toSuper = true,
                  )
                ])
                ..optionalParameters.addAll([
                  ...mirror.parameters.map((param) {
                    return Parameter(
                      (p) => p
                        ..name = param.camelCase
                        ..named = true
                        ..required = true
                        ..type = const Reference("String"),
                    );
                  }),
                ])
                ..initializers.addAll([
                  ...mirror.parameters.map((param) {
                    return Code("_${param.camelCase} = ${param.camelCase}");
                  }),
                ]),
            ),
          ])
          ..fields.addAll([
            ...mirror.parameters.map((param) {
              return Field(
                (f) => f
                  ..name = "_${param.camelCase}"
                  ..modifier = FieldModifier.final$
                  ..type = const Reference("String"),
              );
            }),
          ])
          ..methods.addAll([
            Method(
              (m) => m
                ..name = "path"
                ..annotations.addAll([
                  const Reference("override"),
                ])
                ..type = MethodType.getter
                ..lambda = true
                ..returns = const Reference("String")
                ..body = Code(
                  "\"${mirror.path.replaceAllMapped(_pathRegExp, (m) => "\$_${m.group(1)?.toCamelCase() ?? ""}")}\"",
                ),
            ),
            Method(
              (m) => m
                ..name = "toMap"
                ..requiredParameters.addAll([
                  Parameter(
                    (p) => p
                      ..name = "value"
                      ..type = Reference(model.name),
                  )
                ])
                ..annotations.addAll([
                  const Reference("override"),
                ])
                ..returns = const Reference("DynamicMap")
                ..lambda = true
                ..body = const Code("value.rawValue"),
            ),
            if (searchable.isNotEmpty)
              Method(
                (m) => m
                  ..name = "buildSearchText"
                  ..lambda = true
                  ..returns = const Reference("String")
                  ..annotations.addAll([const Reference("override")])
                  ..requiredParameters.addAll([
                    Parameter(
                      (p) => p
                        ..name = "value"
                        ..type = Reference(model.name),
                    )
                  ])
                  ..body = Code(
                    searchable.map((e) {
                      if (e.type.toString().endsWith("?")) {
                        return "(value.${e.name}?.toString() ?? \"\")";
                      } else {
                        return "value.${e.name}.toString()";
                      }
                    }).join(" + "),
                  ),
              ),
          ]),
      ),
    ],
  ];
}

String _jsonValue(ParamaterValue param) {
  if (param.type.isDartCoreList) {
    if (param.type.toString().endsWith("?")) {
      return "${param.name}?.map((e) => e.toJson()).toList()";
    } else {
      return "${param.name}.map((e) => e.toJson()).toList()";
    }
  } else if (param.type.isDartCoreMap) {
    if (param.type.toString().endsWith("?")) {
      return "${param.name}?.map((k, v) => MapEntry(k, v.toJson()))";
    } else {
      return "${param.name}.map((k, v) => MapEntry(k, v.toJson()))";
    }
  } else {
    if (param.type.toString().endsWith("?")) {
      return "${param.name}?.toJson()";
    } else {
      return "${param.name}.toJson()";
    }
  }
}
