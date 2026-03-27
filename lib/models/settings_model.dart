class SettingsModel {
  bool runOnStartUp;
  String position;
  String showEvery;
  String imageSize;
  String sessionLength;
  String audioOptions;

  SettingsModel({
    this.runOnStartUp = false,
    this.position = 'Centre',
    this.showEvery = '3 s',
    this.imageSize = 'Small',
    this.sessionLength = 'Auto',
    this.audioOptions = 'Frequency',
  });

  // Copy with method for updating settings
  SettingsModel copyWith({
    bool? runOnStartUp,
    String? position,
    String? showEvery,
    String? imageSize,
    String? sessionLength,
    String? audioOptions,
  }) {
    return SettingsModel(
      runOnStartUp: runOnStartUp ?? this.runOnStartUp,
      position: position ?? this.position,
      showEvery: showEvery ?? this.showEvery,
      imageSize: imageSize ?? this.imageSize,
      sessionLength: sessionLength ?? this.sessionLength,
      audioOptions: audioOptions ?? this.audioOptions,
    );
  }
}