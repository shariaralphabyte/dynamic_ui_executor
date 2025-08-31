import 'package:flutter/material.dart';
import 'dart:convert';
import 'widget_parser.dart';
import 'action_handler.dart';
import 'validator.dart';

/// A widget that executes dynamic UI definitions from strings or JSON
class DynamicWidgetExecutor extends StatefulWidget {
  /// The widget definition as a string (Dart-like syntax) or JSON
  final String widgetDefinition;
  
  /// Optional action handler for button clicks and other interactions
  final ActionHandler? actionHandler;
  
  /// Whether the widget definition is JSON format (default: false for string format)
  final bool isJson;
  
  /// Custom widget parsers for extending functionality
  final Map<String, WidgetBuilder>? customParsers;
  
  /// Error widget to show when parsing fails
  final Widget? errorWidget;

  const DynamicWidgetExecutor({
    Key? key,
    required this.widgetDefinition,
    this.actionHandler,
    this.isJson = false,
    this.customParsers,
    this.errorWidget,
  }) : super(key: key);

  @override
  State<DynamicWidgetExecutor> createState() => _DynamicWidgetExecutorState();
}

class _DynamicWidgetExecutorState extends State<DynamicWidgetExecutor> {
  late WidgetParser _parser;
  Widget? _parsedWidget;
  String? _error;

  @override
  void initState() {
    super.initState();
    _parser = WidgetParser(
      actionHandler: widget.actionHandler,
      customParsers: widget.customParsers,
    );
    _parseWidget();
  }

  @override
  void didUpdateWidget(DynamicWidgetExecutor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.widgetDefinition != widget.widgetDefinition ||
        oldWidget.isJson != widget.isJson) {
      _parseWidget();
    }
  }

  void _parseWidget() {
    try {
      setState(() {
        _error = null;
        
        if (widget.isJson) {
          final Map<String, dynamic> jsonData = json.decode(widget.widgetDefinition);
          
          // Validate JSON before parsing
          final validationResult = DynamicUIValidator.validateJson(jsonData);
          if (!validationResult.isValid) {
            throw Exception('Validation failed: ${validationResult.message}');
          }
          
          if (validationResult.warnings.isNotEmpty) {
            DynamicUILogger.warning('Validation warnings: ${validationResult.warnings.join(', ')}');
          }
          
          _parsedWidget = _parser.parseFromJson(jsonData);
        } else {
          // Validate string before parsing
          final validationResult = DynamicUIValidator.validateString(widget.widgetDefinition);
          if (!validationResult.isValid) {
            throw Exception('Validation failed: ${validationResult.message}');
          }
          
          if (validationResult.warnings.isNotEmpty) {
            DynamicUILogger.warning('Validation warnings: ${validationResult.warnings.join(', ')}');
          }
          
          _parsedWidget = _parser.parseFromString(widget.widgetDefinition);
        }
        
        DynamicUILogger.info('Successfully parsed dynamic widget');
      });
    } catch (e, stackTrace) {
      DynamicUILogger.error('Failed to parse widget definition', e, stackTrace);
      setState(() {
        _error = e.toString();
        _parsedWidget = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorWidget ?? 
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Failed to parse dynamic UI',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
    }

    return _parsedWidget ?? const CircularProgressIndicator();
  }
}
