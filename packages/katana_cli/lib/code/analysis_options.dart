part of katana_cli;

/// Contents of katana.yaml.
///
/// analysis_options.yamlの中身。
class AnalysisOptionsCliCode extends CliCode {
  /// Contents of katana.yaml.
  ///
  /// analysis_options.yamlの中身。
  const AnalysisOptionsCliCode();

  @override
  String get name => "analysis_options";

  @override
  String get prefix => "analysis_options";

  @override
  String get directory => "";

  @override
  String get description =>
      "Define `analysis_options.yaml` with additional settings. `analysis_options.yaml`を追加設定込で定義します。";

  @override
  String import(String path, String baseName, String className) {
    return "";
  }

  @override
  String header(String path, String baseName, String className) {
    return "";
  }

  @override
  String body(String path, String baseName, String className) {
    return r"""
# This file configures the analyzer, which statically analyzes Dart code to
# check for errors, warnings, and lints.
#
# The issues identified by the analyzer are surfaced in the UI of Dart-enabled
# IDEs (https://dart.dev/tools#ides-and-editors). The analyzer can also be
# invoked from the command line by running `flutter analyze`.

# The following line activates a set of recommended lints for Flutter apps,
# packages, and plugins designed to encourage good coding practices.
include: package:flutter_lints/flutter.yaml

linter:
  # The lint rules applied to this project can be customized in the
  # section below to disable rules from the `package:flutter_lints/flutter.yaml`
  # included above or to enable additional rules. A list of all available lints
  # and their documentation is published at
  # https://dart-lang.github.io/linter/lints/index.html.
  #
  # Instead of disabling a lint rule for the entire project in the
  # section below, it can also be suppressed for a single line of code
  # or a specific dart file by using the `// ignore: name_of_lint` and
  # `// ignore_for_file: name_of_lint` syntax on the line or in the file
  # producing the lint.
  rules:
    # avoid_print: false  # Uncomment to disable the `avoid_print` rule
    # prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule

# Additional information about this file can be found at
# https://dart.dev/guides/language/analysis-options

# Set to exclude json_serializable files.
# json_serializableのファイルを除外するための設定。
analyzer:
  exclude:
    - "**/*.g.dart"
""";
  }
}
