part of masamune_text_to_speech;

/// [MasamuneAdapter], which is the initial setup for handling Text-to-Speech.
///
/// Text-to-Speechを取り扱うための初期設定を行う[MasamuneAdapter]。
class TextToSpeechMasamuneAdapter extends MasamuneAdapter {
  /// [MasamuneAdapter], which is the initial setup for handling Text-to-Speech.
  ///
  /// Text-to-Speechを取り扱うための初期設定を行う[MasamuneAdapter]。
  const TextToSpeechMasamuneAdapter({
    required this.defaultLocale,
    this.defaultSpeechRate = 1.0,
    this.defaultVolume = 1.0,
    this.defaultPitch = 1.0,
  })  : assert(
          defaultPitch > 0.0 && defaultPitch <= 1.0,
          "defaultPitch must be greater than 0.0 and less than or equal to 1.0.",
        ),
        assert(
          defaultVolume > 0.0 && defaultVolume <= 1.0,
          "defaultVolume must be greater than 0.0 and less than or equal to 1.0.",
        ),
        assert(
          defaultSpeechRate > 0.0 && defaultSpeechRate <= 1.0,
          "defaultSpeechRate must be greater than 0.0 and less than or equal to 1.0.",
        );

  /// Default language.
  ///
  /// デフォルトの言語。
  final Locale defaultLocale;

  /// Default reading speed.
  ///
  /// デフォルトの読み上げ速度。
  final double defaultSpeechRate;

  /// Default volume.
  ///
  /// デフォルトの音量。
  final double defaultVolume;

  /// Default vocal pitch.
  /// 
  /// デフォルトの発声ピッチ。
  final double defaultPitch;

  /// You can retrieve the [TextToSpeechMasamuneAdapter] first given by [MasamuneAdapterScope].
  ///
  /// 最初に[MasamuneAdapterScope]で与えた[TextToSpeechMasamuneAdapter]を取得することができます。
  static TextToSpeechMasamuneAdapter get primary {
    assert(
      _primary != null,
      "TextToSpeechMasamuneAdapter is not set. Place [MasamuneAdapterScope] widget closer to the root.",
    );
    return _primary!;
  }

  static TextToSpeechMasamuneAdapter? _primary;

  @override
  void onInitScope(MasamuneAdapter adapter) {
    super.onInitScope(adapter);
    if (adapter is! TextToSpeechMasamuneAdapter) {
      return;
    }
    _primary = adapter;
  }

  @override
  Widget onBuildApp(BuildContext context, Widget app) {
    return MasamuneAdapterScope<TextToSpeechMasamuneAdapter>(
      adapter: this,
      child: app,
    );
  }
}
