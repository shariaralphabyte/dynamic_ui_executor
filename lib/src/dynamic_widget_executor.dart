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
    print('🔥 DEBUG: Starting widget parsing, isJson: ${widget.isJson}');
    print('🔥 DEBUG: Widget definition: ${widget.widgetDefinition.substring(0, 200)}...');
    
    try {
      setState(() {
        _error = null;
        
        if (widget.isJson) {
          print('🔥 DEBUG: Parsing JSON widget');
          final Map<String, dynamic> jsonData = json.decode(widget.widgetDefinition);
          print('🔥 DEBUG: JSON decoded successfully: ${jsonData.keys}');
          
          // Validate JSON before parsing
          final validationResult = DynamicUIValidator.validateJson(jsonData);
          print('🔥 DEBUG: JSON validation result: ${validationResult.isValid}');
          if (!validationResult.isValid) {
            throw Exception('Validation failed: ${validationResult.message}');
          }
          
          if (validationResult.warnings.isNotEmpty) {
            print('🔥 DEBUG: JSON validation warnings: ${validationResult.warnings}');
            DynamicUILogger.warning('Validation warnings: ${validationResult.warnings.join(', ')}');
          }
          
          _parsedWidget = _parser.parseFromJson(jsonData);
          print('🔥 DEBUG: JSON widget parsed successfully');
        } else {
          print('🔥 DEBUG: Parsing String widget');
          // Validate string before parsing
          final validationResult = DynamicUIValidator.validateString(widget.widgetDefinition);
          print('🔥 DEBUG: String validation result: ${validationResult.isValid}');
          if (!validationResult.isValid) {
            throw Exception('Validation failed: ${validationResult.message}');
          }
          
          if (validationResult.warnings.isNotEmpty) {
            print('🔥 DEBUG: String validation warnings: ${validationResult.warnings}');
            DynamicUILogger.warning('Validation warnings: ${validationResult.warnings.join(', ')}');
          }
          
          _parsedWidget = _parser.parseFromString(widget.widgetDefinition);
          print('🔥 DEBUG: String widget parsed successfully');
        }
        
        DynamicUILogger.info('Successfully parsed dynamic widget');
        print('🔥 DEBUG: Widget parsing completed successfully');
      });
    } catch (e, stackTrace) {
      print('🔥 DEBUG: Widget parsing failed: $e');
      print('🔥 DEBUG: Stack trace: $stackTrace');
      DynamicUILogger.error('Failed to parse widget definition', e, stackTrace);
      setState(() {
        _error = e.toString();
        _parsedWidget = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('🔥 DEBUG: DynamicWidgetExecutor build called');
    print('🔥 DEBUG: Error: $_error');
    print('🔥 DEBUG: ParsedWidget is null: ${_parsedWidget == null}');
    
    if (_error != null) {
      print('🔥 DEBUG: Showing error widget');
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

    if (_parsedWidget == null) {
      print('🔥 DEBUG: Showing loading indicator');
      return const Center(child: CircularProgressIndicator());
    }
    
    print('🔥 DEBUG: Showing parsed widget');
    return _parsedWidget!;
  }
}
