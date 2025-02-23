part of "store.dart";

/// Obtain a refresh token for store billing on Google Play.
///
/// GooglePlayでストア課金を行うためのリフレッシュトークンを取得します。
@Deprecated("サービスアカウントを使用する方法に変更されました。")
class StoreAndroidTokenCliCommand extends CliCommand {
  /// Obtain a refresh token for store billing on Google Play.
  ///
  /// GooglePlayでストア課金を行うためのリフレッシュトークンを取得します。
  const StoreAndroidTokenCliCommand();

  @override
  String get description =>
      "Obtain a refresh token for store billing on Google Play. GooglePlayでストア課金を行うためのリフレッシュトークンを取得します。";

  @override
  String? get example => "katana store android_token";

  @override
  Future<void> exec(ExecContext context) async {
    final bin = context.yaml.getAsMap("bin");
    final commandArg = context.args.get(2, "");
    final firebaseCommand = bin.get("firebase", "firebase");
    final purchase = context.yaml.getAsMap("purchase");
    final googlePlay = purchase.getAsMap("google_play");
    final enableGooglePlay = googlePlay.get("enable", false);
    final googlePlayClientId = googlePlay.get("oauth_client_id", "");
    final googlePlayClientSecret = googlePlay.get("oauth_client_secret", "");
    final firebase = context.yaml.getAsMap("firebase");
    final projectId = firebase.get("project_id", "");
    final function = firebase.getAsMap("functions");
    final enableFunctions = function.get("enable", false);
    final region = function.get("region", "");
    if (!enableGooglePlay) {
      error(
        "The item [purchase]->[google_play]->[enable] is false. Please set it to true.",
      );
      return;
    }
    if (!enableFunctions) {
      error(
        "The item [firebase]->[functions]->[enable] is false. Please set it to true.",
      );
      return;
    }
    if (googlePlayClientId.isEmpty || googlePlayClientSecret.isEmpty) {
      error(
        "The item [purchase]->[google_play]->[oauth_client_id] or [purchase]->[google_play]->[oauth_client_secret] is empty. Please set it.",
      );
      return;
    }
    if (projectId.isEmpty) {
      error(
        "The item [firebase]->[project_id] is missing. Please provide the Firebase project ID for the configuration.",
      );
      return;
    }
    if (region.isEmpty) {
      error(
        "The item [firebase]->[functions]->[region] is missing. Please provide the region for the configuration.",
      );
      return;
    }
    final firebaseDir = Directory("firebase");
    if (!firebaseDir.existsSync()) {
      error(
        "The directory `firebase` does not exist. Initialize Firebase by executing Firebase init.",
      );
      return;
    }
    final functionsDir = Directory("firebase/functions");
    if (!functionsDir.existsSync()) {
      error(
        "The directory `firebase/functions` does not exist. Initialize Firebase by executing Firebase init.",
      );
      return;
    }
    if (commandArg != "-d") {
      label("Add firebase functions");
      final functions = Fuctions();
      await functions.load();
      if (!functions.functions.any((e) => e.startsWith("androidAuthCode"))) {
        functions.functions.add("androidAuthCode()");
      }
      if (!functions.functions.any((e) => e.startsWith("androidToken"))) {
        functions.functions.add("androidToken()");
      }
      await functions.save();
      label("Set firebase functions config.");
      final env = FunctionsEnv();
      await env.load();
      env["PURCHASE_ANDROID_CLIENTID"] = googlePlayClientId;
      env["PURCHASE_ANDROID_CLIENTSECRET"] = googlePlayClientSecret;
      env["PURCHASE_ANDROID_REDIRECTURI"] =
          "https://$region-$projectId.cloudfunctions.net/android_token";
      await env.save();
      await command(
        "Deploy firebase functions.",
        [
          firebaseCommand,
          "deploy",
          "--only",
          "functions",
        ],
        workingDirectory: "firebase",
      );
    }
    await _runBrowser(
      "https://$region-$projectId.cloudfunctions.net/android_auth_code?id=$googlePlayClientId",
    );
  }

  Future<void> _runBrowser(String url) async {
    switch (Platform.operatingSystem) {
      case "linux":
        await Process.run("x-www-browser", [url]);
        break;
      case "macos":
        await Process.run("open", [url]);
        break;
      case "windows":
        await Process.run("explorer", [url]);
        break;
    }
  }
}
