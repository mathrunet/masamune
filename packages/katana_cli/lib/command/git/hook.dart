part of katana_cli.github;

/// Add a Git hook for Flutter using Lefthook.
///
/// Lefthookを用いてFlutter用のGit hookを追加します。
class GitHookCliCommand extends CliCommand {
  /// Add a Git hook for Flutter using Lefthook.
  ///
  /// Lefthookを用いてFlutter用のGit hookを追加します。
  const GitHookCliCommand();

  @override
  String get description =>
      "Add a Git hook for Flutter using Lefthook. Check for Linter, sort imports, and run the formatter when staging. Please install lefthook beforehand. Lefthookを用いてFlutter用のGit hookを追加します。ステージング時にLinterのチェックとインポートのソート、フォーマッターの実行を行うようにします。事前にlefthookをインストールしておいてください。";

  @override
  Future<void> exec(ExecContext context) async {
    final bin = context.yaml.getAsMap("bin");
    final flutter = bin.get("flutter", "flutter");
    final lefthook = bin.get("lefthook", "lefthook");
    await command(
      "Import import_sorter packages.",
      [
        flutter,
        "pub",
        "add",
        "--dev",
        "import_sorter",
      ],
    );
    label("Create lefthook.yaml");
    await const LefthookCliCode().generateFile("lefthook.yaml");
    await command(
      "Install lefthook.",
      [
        lefthook,
        "install",
      ],
    );
  }
}

/// Contents of lefthook.yaml.
///
/// lefthook.yamlの中身。
class LefthookCliCode extends CliCode {
  /// Contents of lefthook.yaml.
  ///
  /// lefthook.yamlの中身。
  const LefthookCliCode();

  @override
  String get name => "lefthook";

  @override
  String get prefix => "lefthook";

  @override
  String get directory => "";

  @override
  String get description =>
      "Create lefthook.yaml for itHook. GitHook用ののlefthook.yamlを作成します。";

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
pre-commit:
  parallel: false
  commands:
    linter:
      run: dart fix --apply lib && git add {staged_files}
    import_sorter:
      glob: "*.dart"
      run: flutter pub run import_sorter:main {staged_files} && git add {staged_files}
    formatter:
      glob: "*.dart"
      run: dart format {staged_files} && git add {staged_files}
    analyzer:
      run: flutter analyze
""";
  }
}
