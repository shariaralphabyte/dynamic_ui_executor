import 'package:flutter/material.dart';

/// Parser for theme-related properties and styling
class ThemeParser {
  /// Parse a complete theme from JSON
  static ThemeData? parseTheme(Map<String, dynamic>? themeData) {
    if (themeData == null) return null;
    
    return ThemeData(
      primarySwatch: _parseMaterialColor(themeData['primarySwatch']),
      primaryColor: parseColor(themeData['primaryColor']),
      scaffoldBackgroundColor: parseColor(themeData['scaffoldBackgroundColor']),
      appBarTheme: _parseAppBarTheme(themeData['appBarTheme']),
      textTheme: _parseTextTheme(themeData['textTheme']),
      elevatedButtonTheme: _parseElevatedButtonTheme(themeData['elevatedButtonTheme']),
      cardTheme: _parseCardTheme(themeData['cardTheme']),
    );
  }

  /// Parse AppBar theme
  static AppBarTheme? _parseAppBarTheme(Map<String, dynamic>? data) {
    if (data == null) return null;
    
    return AppBarTheme(
      backgroundColor: parseColor(data['backgroundColor']),
      foregroundColor: parseColor(data['foregroundColor']),
      elevation: parseDouble(data['elevation']),
      centerTitle: data['centerTitle'],
      titleTextStyle: parseTextStyle(data['titleTextStyle']),
    );
  }

  /// Parse text theme
  static TextTheme? _parseTextTheme(Map<String, dynamic>? data) {
    if (data == null) return null;
    
    return TextTheme(
      displayLarge: parseTextStyle(data['displayLarge']),
      displayMedium: parseTextStyle(data['displayMedium']),
      displaySmall: parseTextStyle(data['displaySmall']),
      headlineLarge: parseTextStyle(data['headlineLarge']),
      headlineMedium: parseTextStyle(data['headlineMedium']),
      headlineSmall: parseTextStyle(data['headlineSmall']),
      titleLarge: parseTextStyle(data['titleLarge']),
      titleMedium: parseTextStyle(data['titleMedium']),
      titleSmall: parseTextStyle(data['titleSmall']),
      bodyLarge: parseTextStyle(data['bodyLarge']),
      bodyMedium: parseTextStyle(data['bodyMedium']),
      bodySmall: parseTextStyle(data['bodySmall']),
    );
  }

  /// Parse elevated button theme
  static ElevatedButtonThemeData? _parseElevatedButtonTheme(Map<String, dynamic>? data) {
    if (data == null) return null;
    
    return ElevatedButtonThemeData(
      style: parseButtonStyle(data['style']),
    );
  }

  /// Parse card theme
  static CardTheme? _parseCardTheme(Map<String, dynamic>? data) {
    if (data == null) return null;
    
    return CardTheme(
      color: parseColor(data['color']),
      elevation: parseDouble(data['elevation']),
      margin: parseEdgeInsets(data['margin']),
      shape: _parseShapeBorder(data['shape']),
    );
  }

  /// Parse text style
  static TextStyle? parseTextStyle(Map<String, dynamic>? data) {
    if (data == null) return null;
    
    return TextStyle(
      fontSize: parseDouble(data['fontSize']),
      fontWeight: parseFontWeight(data['fontWeight']),
      fontStyle: parseFontStyle(data['fontStyle']),
      color: parseColor(data['color']),
      fontFamily: data['fontFamily'],
      letterSpacing: parseDouble(data['letterSpacing']),
      wordSpacing: parseDouble(data['wordSpacing']),
      height: parseDouble(data['height']),
      decoration: parseTextDecoration(data['decoration']),
      decorationColor: parseColor(data['decorationColor']),
    );
  }

  /// Parse button style
  static ButtonStyle? parseButtonStyle(Map<String, dynamic>? data) {
    if (data == null) return null;
    
    return ButtonStyle(
      backgroundColor: _parseMaterialStateProperty(data['backgroundColor']),
      foregroundColor: _parseMaterialStateProperty(data['foregroundColor']),
      padding: _parseMaterialStateProperty(data['padding']),
      elevation: _parseMaterialStateProperty(data['elevation']),
      shape: _parseMaterialStateProperty(data['shape']),
    );
  }

  /// Parse material state property
  static MaterialStateProperty<T>? _parseMaterialStateProperty<T>(dynamic data) {
    if (data == null) return null;
    
    if (data is Map && data.containsKey('all')) {
      final value = data['all'];
      if (value is Color || T == Color) {
        return MaterialStateProperty.all(parseColor(value) as T);
      } else if (value is EdgeInsets || T == EdgeInsets) {
        return MaterialStateProperty.all(parseEdgeInsets(value) as T);
      } else if (value is double || T == double) {
        return MaterialStateProperty.all(parseDouble(value) as T);
      }
    }
    
    return null;
  }

  /// Parse shape border
  static ShapeBorder? _parseShapeBorder(Map<String, dynamic>? data) {
    if (data == null) return null;
    
    final String type = data['type'] ?? '';
    
    switch (type.toLowerCase()) {
      case 'roundedrectangle':
        return RoundedRectangleBorder(
          borderRadius: parseBorderRadius(data['borderRadius']) ?? BorderRadius.zero,
        );
      case 'circle':
        return const CircleBorder();
      default:
        return null;
    }
  }

  /// Parse edge insets
  static EdgeInsets? parseEdgeInsets(dynamic data) {
    if (data == null) return null;
    
    if (data is Map) {
      if (data.containsKey('all')) {
        return EdgeInsets.all(parseDouble(data['all']) ?? 0);
      } else if (data.containsKey('symmetric')) {
        final sym = data['symmetric'];
        return EdgeInsets.symmetric(
          horizontal: parseDouble(sym['horizontal']) ?? 0,
          vertical: parseDouble(sym['vertical']) ?? 0,
        );
      } else {
        return EdgeInsets.only(
          left: parseDouble(data['left']) ?? 0,
          top: parseDouble(data['top']) ?? 0,
          right: parseDouble(data['right']) ?? 0,
          bottom: parseDouble(data['bottom']) ?? 0,
        );
      }
    } else if (data is double || data is int) {
      return EdgeInsets.all(parseDouble(data)!);
    }
    
    return null;
  }

  /// Parse border radius
  static BorderRadius? parseBorderRadius(dynamic data) {
    if (data == null) return null;
    
    if (data is Map) {
      if (data.containsKey('all')) {
        return BorderRadius.circular(parseDouble(data['all']) ?? 0);
      } else {
        return BorderRadius.only(
          topLeft: Radius.circular(parseDouble(data['topLeft']) ?? 0),
          topRight: Radius.circular(parseDouble(data['topRight']) ?? 0),
          bottomLeft: Radius.circular(parseDouble(data['bottomLeft']) ?? 0),
          bottomRight: Radius.circular(parseDouble(data['bottomRight']) ?? 0),
        );
      }
    } else if (data is double || data is int) {
      return BorderRadius.circular(parseDouble(data)!);
    }
    
    return null;
  }

  /// Parse color from various formats
  static Color? parseColor(dynamic colorValue) {
    if (colorValue == null) return null;
    
    if (colorValue is String) {
      if (colorValue.startsWith('#')) {
        final hexString = colorValue.substring(1);
        if (hexString.length == 6) {
          return Color(int.parse('FF$hexString', radix: 16));
        } else if (hexString.length == 8) {
          return Color(int.parse(hexString, radix: 16));
        }
      } else if (colorValue.startsWith('Colors.')) {
        return _parseColorFromName(colorValue);
      } else if (colorValue.startsWith('0x')) {
        return Color(int.parse(colorValue));
      }
    } else if (colorValue is int) {
      return Color(colorValue);
    } else if (colorValue is Map) {
      // RGBA format
      final r = parseDouble(colorValue['r']) ?? 0;
      final g = parseDouble(colorValue['g']) ?? 0;
      final b = parseDouble(colorValue['b']) ?? 0;
      final a = parseDouble(colorValue['a']) ?? 1.0;
      return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), a);
    }
    
    return null;
  }

  /// Parse color from Flutter Colors class names
  static Color? _parseColorFromName(String colorName) {
    final name = colorName.toLowerCase().replaceAll('colors.', '');
    
    switch (name) {
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'white': return Colors.white;
      case 'black': return Colors.black;
      case 'grey': return Colors.grey;
      case 'gray': return Colors.grey;
      case 'orange': return Colors.orange;
      case 'purple': return Colors.purple;
      case 'yellow': return Colors.yellow;
      case 'pink': return Colors.pink;
      case 'cyan': return Colors.cyan;
      case 'indigo': return Colors.indigo;
      case 'teal': return Colors.teal;
      case 'lime': return Colors.lime;
      case 'amber': return Colors.amber;
      case 'brown': return Colors.brown;
      case 'transparent': return Colors.transparent;
      default: return null;
    }
  }

  /// Parse material color (for primary swatch)
  static MaterialColor? _parseMaterialColor(dynamic colorValue) {
    if (colorValue == null) return null;
    
    if (colorValue is String) {
      switch (colorValue.toLowerCase().replaceAll('colors.', '')) {
        case 'red': return Colors.red;
        case 'blue': return Colors.blue;
        case 'green': return Colors.green;
        case 'orange': return Colors.orange;
        case 'purple': return Colors.purple;
        case 'pink': return Colors.pink;
        case 'cyan': return Colors.cyan;
        case 'indigo': return Colors.indigo;
        case 'teal': return Colors.teal;
        case 'lime': return Colors.lime;
        case 'amber': return Colors.amber;
        case 'brown': return Colors.brown;
        default: return Colors.blue;
      }
    }
    
    return Colors.blue;
  }

  /// Parse font weight
  static FontWeight? parseFontWeight(dynamic value) {
    if (value == null) return null;
    
    if (value is String) {
      switch (value.toLowerCase()) {
        case 'bold': return FontWeight.bold;
        case 'normal': return FontWeight.normal;
        case 'w100': return FontWeight.w100;
        case 'w200': return FontWeight.w200;
        case 'w300': return FontWeight.w300;
        case 'w400': return FontWeight.w400;
        case 'w500': return FontWeight.w500;
        case 'w600': return FontWeight.w600;
        case 'w700': return FontWeight.w700;
        case 'w800': return FontWeight.w800;
        case 'w900': return FontWeight.w900;
        default: return null;
      }
    } else if (value is int) {
      switch (value) {
        case 100: return FontWeight.w100;
        case 200: return FontWeight.w200;
        case 300: return FontWeight.w300;
        case 400: return FontWeight.w400;
        case 500: return FontWeight.w500;
        case 600: return FontWeight.w600;
        case 700: return FontWeight.w700;
        case 800: return FontWeight.w800;
        case 900: return FontWeight.w900;
        default: return null;
      }
    }
    
    return null;
  }

  /// Parse font style
  static FontStyle? parseFontStyle(dynamic value) {
    if (value == null) return null;
    
    switch (value.toString().toLowerCase()) {
      case 'italic': return FontStyle.italic;
      case 'normal': return FontStyle.normal;
      default: return null;
    }
  }

  /// Parse text decoration
  static TextDecoration? parseTextDecoration(dynamic value) {
    if (value == null) return null;
    
    switch (value.toString().toLowerCase()) {
      case 'underline': return TextDecoration.underline;
      case 'overline': return TextDecoration.overline;
      case 'linethrough': return TextDecoration.lineThrough;
      case 'none': return TextDecoration.none;
      default: return null;
    }
  }

  /// Parse double value
  static double? parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
