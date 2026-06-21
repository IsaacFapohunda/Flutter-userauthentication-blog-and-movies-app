/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsPngsGen {
  const $AssetsPngsGen();

  /// File path: assets/pngs/Auto Layout Horizontal.png
  AssetGenImage get autoLayoutHorizontal =>
      const AssetGenImage('assets/pngs/Auto Layout Horizontal.png');

  /// File path: assets/pngs/Ellipse 124 (2).png
  AssetGenImage get ellipse1242 =>
      const AssetGenImage('assets/pngs/Ellipse 124 (2).png');

  /// File path: assets/pngs/Group 5310.png
  AssetGenImage get group5310 =>
      const AssetGenImage('assets/pngs/Group 5310.png');

  /// File path: assets/pngs/calendar-event 1.png
  AssetGenImage get calendarEvent1 =>
      const AssetGenImage('assets/pngs/calendar-event 1.png');

  /// File path: assets/pngs/calendar.png
  AssetGenImage get calendar => const AssetGenImage('assets/pngs/calendar.png');

  /// File path: assets/pngs/gift-2 1.png
  AssetGenImage get gift21 => const AssetGenImage('assets/pngs/gift-2 1.png');

  /// File path: assets/pngs/human-resources-search-team 1.png
  AssetGenImage get humanResourcesSearchTeam1 =>
      const AssetGenImage('assets/pngs/human-resources-search-team 1.png');

  /// File path: assets/pngs/megaphone 1.png
  AssetGenImage get megaphone1 =>
      const AssetGenImage('assets/pngs/megaphone 1.png');

  /// File path: assets/pngs/toggle-left.png
  AssetGenImage get toggleLeft =>
      const AssetGenImage('assets/pngs/toggle-left.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        autoLayoutHorizontal,
        ellipse1242,
        group5310,
        calendarEvent1,
        calendar,
        gift21,
        humanResourcesSearchTeam1,
        megaphone1,
        toggleLeft
      ];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// Directory path: assets/svgs/icons
  $AssetsSvgsIconsGen get icons => const $AssetsSvgsIconsGen();

  /// Directory path: assets/svgs/images
  $AssetsSvgsImagesGen get images => const $AssetsSvgsImagesGen();
}

class $AssetsSvgsIconsGen {
  const $AssetsSvgsIconsGen();

  /// File path: assets/svgs/icons/aboutus.svg
  String get aboutus => 'assets/svgs/icons/aboutus.svg';

  /// File path: assets/svgs/icons/contact_us.svg
  String get contactUs => 'assets/svgs/icons/contact_us.svg';

  /// File path: assets/svgs/icons/darkmode.svg
  String get darkmode => 'assets/svgs/icons/darkmode.svg';

  /// File path: assets/svgs/icons/noConnection.svg
  String get noConnection => 'assets/svgs/icons/noConnection.svg';

  /// File path: assets/svgs/icons/privacy.svg
  String get privacy => 'assets/svgs/icons/privacy.svg';

  /// File path: assets/svgs/icons/rateus.svg
  String get rateus => 'assets/svgs/icons/rateus.svg';

  /// List of all assets
  List<String> get values =>
      [aboutus, contactUs, darkmode, noConnection, privacy, rateus];
}

class $AssetsSvgsImagesGen {
  const $AssetsSvgsImagesGen();

  /// File path: assets/svgs/images/confetti-new.json
  String get confettiNew => 'assets/svgs/images/confetti-new.json';

  /// File path: assets/svgs/images/confetti.json
  String get confetti => 'assets/svgs/images/confetti.json';

  /// File path: assets/svgs/images/home_dark.json
  String get homeDark => 'assets/svgs/images/home_dark.json';

  /// File path: assets/svgs/images/home_light.json
  String get homeLight => 'assets/svgs/images/home_light.json';

  /// File path: assets/svgs/images/search_dark.json
  String get searchDark => 'assets/svgs/images/search_dark.json';

  /// File path: assets/svgs/images/search_light.json
  String get searchLight => 'assets/svgs/images/search_light.json';

  /// List of all assets
  List<String> get values =>
      [confettiNew, confetti, homeDark, homeLight, searchDark, searchLight];
}

class Assets {
  Assets._();

  static const $AssetsPngsGen pngs = $AssetsPngsGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
