# Dynamic UI Executor

Build Flutter UIs dynamically at runtime from server-provided widget definitions (JSON or string), overcoming AOT compilation limits. Perfect for enterprise, CMS-driven apps, dashboards, and server-driven layouts.

## Features

- **Dynamic Widget Rendering**: Convert JSON or string-based widget definitions into live Flutter widgets
- **Comprehensive Widget Support**: Scaffold, AppBar, Column, Row, Stack, Text, Image, ListView, GridView, ElevatedButton, and more
- **Centralized Action Handling**: Handle button clicks, gestures, and navigation through a unified system
- **Advanced Styling**: Support for colors, fonts, themes, padding, margins, and custom styling
- **Server-Driven UI**: Update layouts without recompiling the app
- **Extensible Architecture**: Register custom widgets and parsers
- **Cross-Platform**: Works on iOS, Android, Web, and Desktop
- **Enterprise-Grade**: Includes error handling, logging, and validation

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  dynamic_ui_executor: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### String-Based UI Definition

```dart
import 'package:flutter/material.dart';
import 'package:dynamic_ui_executor/dynamic_ui_executor.dart';

class MyApp extends StatelessWidget {
  final String serverWidgetString = """
    Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Dynamic UI!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () { print('Button Pressed'); },
              child: Text('Click Me'),
            )
          ],
        ),
      ),
    )
  """;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DynamicWidgetExecutor(
        widgetDefinition: serverWidgetString,
        actionHandler: (action, [params]) {
          if (action == "showSnackBar") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Button Pressed!"))
            );
          }
        },
      ),
    );
  }
}
```

### JSON-Based UI Definition

```dart
final Map<String, dynamic> jsonUI = {
  "type": "scaffold",
  "properties": {
    "appBar": {
      "type": "appbar",
      "properties": {
        "title": {
          "type": "text",
          "properties": {"text": "JSON UI Demo"}
        }
      }
    },
    "body": {
      "type": "center",
      "children": [
        {
          "type": "column",
          "children": [
            {
              "type": "text",
              "properties": {
                "text": "Hello from JSON!",
                "style": {
                  "fontSize": 24,
                  "fontWeight": "bold",
                  "color": "Colors.blue"
                }
              }
            },
            {
              "type": "elevated_button",
              "properties": {
                "action": "showSnackBar",
                "actionParams": {"message": "JSON Button Clicked!"},
                "child": {
                  "type": "text",
                  "properties": {"text": "Click Me"}
                }
              }
            }
          ]
        }
      ]
    }
  }
};

// Use it in your widget
DynamicWidgetExecutor(
  widgetDefinition: jsonEncode(jsonUI),
  isJson: true,
  actionHandler: myActionHandler,
)
```

## Supported Widgets

### Layout Widgets
- **Scaffold**: Main app structure with AppBar, body, etc.
- **Column**: Vertical layout
- **Row**: Horizontal layout
- **Stack**: Overlapping widgets
- **Center**: Centers child widget
- **Container**: Box model with padding, margin, decoration
- **Padding**: Adds padding around child
- **Expanded**: Takes available space in Flex widgets
- **Flexible**: Flexible space allocation

### Display Widgets
- **Text**: Text display with styling
- **Image**: Network and asset images
- **Icon**: Material Design icons
- **Card**: Material Design card

### Interactive Widgets
- **ElevatedButton**: Raised button with elevation
- **TextButton**: Flat text button

### List Widgets
- **ListView**: Scrollable list of widgets

### Utility Widgets
- **SizedBox**: Fixed size spacing
- **AppBar**: Application bar for Scaffold

## Action Handling

The plugin provides a flexible action handling system:

```dart
void handleAction(String action, [Map<String, dynamic>? params]) {
  switch (action) {
    case 'navigate':
      Navigator.pushNamed(context, params?['route'] ?? '/');
      break;
    case 'showSnackBar':
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(params?['message'] ?? 'Action executed'))
      );
      break;
    case 'custom':
      // Handle custom actions
      break;
  }
}
```

### Built-in Actions
- `navigate`: Navigate to routes
- `showSnackBar`: Display snack bars
- `showDialog`: Show alert dialogs
- `setState`: Trigger UI refresh

## Styling and Theming

### Text Styling
```json
{
  "type": "text",
  "properties": {
    "text": "Styled Text",
    "style": {
      "fontSize": 18,
      "fontWeight": "bold",
      "color": "#FF5722",
      "fontFamily": "Roboto"
    }
  }
}
```

### Color Formats
- Hex: `"#FF5722"` or `"#FFFF5722"`
- Flutter Colors: `"Colors.blue"`
- RGBA: `{"r": 255, "g": 87, "b": 34, "a": 1.0}`
- Integer: `0xFF5722`

### Padding and Margins
```json
{
  "padding": {"all": 16},
  "margin": {
    "left": 8,
    "top": 16,
    "right": 8,
    "bottom": 16
  }
}
```

## Error Handling

The plugin includes comprehensive error handling:

```dart
DynamicWidgetExecutor(
  widgetDefinition: invalidDefinition,
  errorWidget: Container(
    child: Text('Custom error message'),
  ),
)
```

## Custom Widget Extensions

Extend the plugin with custom widgets:

```dart
final customParsers = {
  'myCustomWidget': (BuildContext context) {
    return MyCustomWidget();
  },
};

DynamicWidgetExecutor(
  widgetDefinition: definition,
  customParsers: customParsers,
)
```

## Validation

The plugin validates widget definitions before parsing:

```dart
import 'package:dynamic_ui_executor/dynamic_ui_executor.dart';

// Validate JSON
final result = DynamicUIValidator.validateJson(jsonData);
if (!result.isValid) {
  print('Validation errors: ${result.errors}');
}

// Validate string
final stringResult = DynamicUIValidator.validateString(stringDefinition);
if (stringResult.hasIssues) {
  print('Issues found: ${stringResult.message}');
}
```

## Use Cases

- **Enterprise Apps**: Dynamic dashboards and forms
- **CMS-Driven Apps**: Content-managed layouts
- **A/B Testing**: Runtime UI variations
- **Multi-tenant Apps**: Customizable interfaces per tenant
- **Remote Configuration**: Update UI without app store releases

## Example App

Run the example app to see the plugin in action:

```bash
cd example
flutter run
```

The example demonstrates both string and JSON-based dynamic UIs with interactive elements.

## Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests to our repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

