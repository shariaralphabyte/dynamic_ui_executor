import 'package:flutter/foundation.dart';

/// Validation utilities for dynamic UI definitions
class DynamicUIValidator {
  /// Validate JSON widget definition
  static ValidationResult validateJson(Map<String, dynamic> json) {
    final errors = <String>[];
    final warnings = <String>[];

    // Check required fields
    if (!json.containsKey('type')) {
      errors.add('Missing required field: type');
    }

    final String type = json['type']?.toString() ?? '';
    if (type.isEmpty) {
      errors.add('Widget type cannot be empty');
    }

    // Validate widget-specific requirements
    _validateWidgetSpecific(type, json, errors, warnings);

    // Validate children if present
    if (json.containsKey('children')) {
      final children = json['children'];
      if (children is List) {
        for (int i = 0; i < children.length; i++) {
          if (children[i] is Map<String, dynamic>) {
            final childResult = validateJson(children[i]);
            errors.addAll(childResult.errors.map((e) => 'Child $i: $e'));
            warnings.addAll(childResult.warnings.map((w) => 'Child $i: $w'));
          }
        }
      }
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  /// Validate string widget definition (basic validation)
  static ValidationResult validateString(String definition) {
    final errors = <String>[];
    final warnings = <String>[];

    if (definition.trim().isEmpty) {
      errors.add('Widget definition cannot be empty');
      return ValidationResult(isValid: false, errors: errors, warnings: warnings);
    }

    // Check for balanced parentheses
    if (!_hasBalancedParentheses(definition)) {
      errors.add('Unbalanced parentheses in widget definition');
    }

    // Check for basic widget syntax
    if (!_hasValidWidgetSyntax(definition)) {
      warnings.add('Widget definition may not follow expected syntax patterns');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  static void _validateWidgetSpecific(
    String type, 
    Map<String, dynamic> json, 
    List<String> errors, 
    List<String> warnings
  ) {
    final props = json['properties'] as Map<String, dynamic>? ?? {};

    switch (type.toLowerCase()) {
      case 'scaffold':
        // Scaffold should have either body or children
        if (!props.containsKey('body') && !json.containsKey('children')) {
          warnings.add('Scaffold should have a body or children');
        }
        break;
        
      case 'text':
        // Text should have text content
        if (!props.containsKey('text')) {
          errors.add('Text widget must have text property');
        }
        break;
        
      case 'image':
        // Image should have url or asset
        if (!props.containsKey('url') && !props.containsKey('asset')) {
          errors.add('Image widget must have either url or asset property');
        }
        break;
        
      case 'elevatedbutton':
      case 'textbutton':
        // Buttons should have child
        if (!props.containsKey('child')) {
          warnings.add('Button should have a child widget');
        }
        break;
        
      case 'column':
      case 'row':
        // Layout widgets should have children
        if (!json.containsKey('children')) {
          warnings.add('$type should have children');
        }
        break;
    }

    // Validate color properties
    _validateColorProperties(props, errors, warnings);
    
    // Validate numeric properties
    _validateNumericProperties(props, errors, warnings);
  }

  static void _validateColorProperties(
    Map<String, dynamic> props, 
    List<String> errors, 
    List<String> warnings
  ) {
    final colorProps = ['color', 'backgroundColor', 'foregroundColor'];
    
    for (final prop in colorProps) {
      if (props.containsKey(prop)) {
        final colorValue = props[prop];
        if (colorValue is String && 
            !colorValue.startsWith('#') && 
            !colorValue.startsWith('Colors.') &&
            !colorValue.startsWith('0x')) {
          warnings.add('Color property "$prop" may not be in a recognized format');
        }
      }
    }
  }

  static void _validateNumericProperties(
    Map<String, dynamic> props, 
    List<String> errors, 
    List<String> warnings
  ) {
    final numericProps = ['width', 'height', 'fontSize', 'elevation', 'flex'];
    
    for (final prop in numericProps) {
      if (props.containsKey(prop)) {
        final value = props[prop];
        if (value != null && 
            value is! num && 
            (value is! String || double.tryParse(value) == null)) {
          errors.add('Property "$prop" must be a valid number');
        }
        
        if (value is num && value < 0 && prop != 'elevation') {
          warnings.add('Property "$prop" should not be negative');
        }
      }
    }
  }

  static bool _hasBalancedParentheses(String text) {
    int count = 0;
    for (int i = 0; i < text.length; i++) {
      if (text[i] == '(') {
        count++;
      } else if (text[i] == ')') {
        count--;
        if (count < 0) return false;
      }
    }
    return count == 0;
  }

  static bool _hasValidWidgetSyntax(String definition) {
    // Basic check for widget-like patterns
    final widgetPattern = RegExp(r'\w+\s*\(');
    return widgetPattern.hasMatch(definition);
  }

  /// Get supported widget types
  static List<String> getSupportedWidgetTypes() {
    return [
      'scaffold',
      'appbar',
      'column',
      'row',
      'stack',
      'center',
      'container',
      'text',
      'elevatedbutton',
      'textbutton',
      'sizedbox',
      'padding',
      'listview',
      'image',
      'icon',
      'card',
      'expanded',
      'flexible',
    ];
  }

  /// Check if a widget type is supported
  static bool isWidgetTypeSupported(String type) {
    return getSupportedWidgetTypes().contains(type.toLowerCase());
  }
}

/// Result of validation operation
class ValidationResult {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  const ValidationResult({
    required this.isValid,
    required this.errors,
    required this.warnings,
  });

  /// Check if there are any issues (errors or warnings)
  bool get hasIssues => errors.isNotEmpty || warnings.isNotEmpty;

  /// Get formatted message for display
  String get message {
    final buffer = StringBuffer();
    
    if (errors.isNotEmpty) {
      buffer.writeln('Errors:');
      for (final error in errors) {
        buffer.writeln('  • $error');
      }
    }
    
    if (warnings.isNotEmpty) {
      if (buffer.isNotEmpty) buffer.writeln();
      buffer.writeln('Warnings:');
      for (final warning in warnings) {
        buffer.writeln('  • $warning');
      }
    }
    
    return buffer.toString().trim();
  }

  @override
  String toString() => message;
}

/// Logger for dynamic UI operations
class DynamicUILogger {
  static bool _debugMode = kDebugMode;
  
  static void setDebugMode(bool enabled) {
    _debugMode = enabled;
  }

  static void info(String message) {
    if (_debugMode) {
      debugPrint('[DynamicUI] INFO: $message');
    }
  }

  static void warning(String message) {
    if (_debugMode) {
      debugPrint('[DynamicUI] WARNING: $message');
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (_debugMode) {
      debugPrint('[DynamicUI] ERROR: $message');
      if (error != null) {
        debugPrint('[DynamicUI] Error details: $error');
      }
      if (stackTrace != null) {
        debugPrint('[DynamicUI] Stack trace: $stackTrace');
      }
    }
  }
}
