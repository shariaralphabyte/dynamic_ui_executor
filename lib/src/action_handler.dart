import 'package:flutter/material.dart';

/// Type definition for action handler functions
typedef ActionHandler = void Function(String action, [Map<String, dynamic>? params]);

/// Built-in action types that can be handled by the system
class ActionTypes {
  static const String navigate = 'navigate';
  static const String showSnackBar = 'showSnackBar';
  static const String showDialog = 'showDialog';
  static const String setState = 'setState';
  static const String custom = 'custom';
}

/// Default action handler that provides common functionality
class DefaultActionHandler {
  final BuildContext context;
  final VoidCallback? onRefresh;

  DefaultActionHandler(this.context, {this.onRefresh});

  void handle(String action, [Map<String, dynamic>? params]) {
    switch (action) {
      case ActionTypes.navigate:
        _handleNavigation(params);
        break;
      case ActionTypes.showSnackBar:
        _handleSnackBar(params);
        break;
      case ActionTypes.showDialog:
        _handleDialog(params);
        break;
      case ActionTypes.setState:
        _handleSetState(params);
        break;
      default:
        debugPrint('Unhandled action: $action with params: $params');
    }
  }

  void _handleNavigation(Map<String, dynamic>? params) {
    if (params == null || !params.containsKey('route')) return;
    
    final String route = params['route'];
    Navigator.of(context).pushNamed(route, arguments: params['arguments']);
  }

  void _handleSnackBar(Map<String, dynamic>? params) {
    final String message = params?['message'] ?? 'Action executed';
    final Duration duration = Duration(
      milliseconds: params?['duration'] ?? 3000,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }

  void _handleDialog(Map<String, dynamic>? params) {
    final String title = params?['title'] ?? 'Alert';
    final String message = params?['message'] ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _handleSetState(Map<String, dynamic>? params) {
    // Trigger a refresh if callback is provided
    onRefresh?.call();
  }
}

/// Action context that provides information about the current state
class ActionContext {
  final BuildContext buildContext;
  final Map<String, dynamic> widgetData;
  final String widgetId;

  ActionContext({
    required this.buildContext,
    required this.widgetData,
    required this.widgetId,
  });
}

/// Enhanced action handler with context
typedef ContextualActionHandler = void Function(
  String action,
  ActionContext context, [
  Map<String, dynamic>? params,
]);
