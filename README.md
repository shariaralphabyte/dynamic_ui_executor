# Dynamic UI Executor

[![pub package](https://img.shields.io/pub/v/dynamic_ui_executor.svg)](https://pub.dev/packages/dynamic_ui_executor)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A powerful Flutter plugin that enables you to build beautiful, interactive user interfaces dynamically at runtime from JSON or String definitions. Perfect for server-driven UI, A/B testing, and rapid prototyping.

## Features

- **Dynamic Widget Creation**: Build Flutter widgets from JSON or string definitions
- **Runtime UI Generation**: Create and modify UI components on the fly
- **Server-Driven UI**: Update your app's interface without app store releases
- **50+ Supported Widgets**: Comprehensive support for Flutter's most common widgets
- **Action Handling**: Built-in support for user interactions and callbacks
- **Theme Integration**: Seamless integration with Flutter's theming system
- **Cross-Platform**: Works on Android, iOS, Web, Windows, macOS, and Linux
- **A/B Testing Ready**: Perfect for testing different UI configurations
- **Easy Integration**: Simple API with minimal setup required

## Quick Start

### Installation
- `Scaffold`, `AppBar`, `Column`, `Row`, `Stack`, `Positioned`
- `Container`, `SizedBox`, `Padding`, `Center`, `Expanded`, `Flexible`
- `Wrap`, `SingleChildScrollView`, `ListView`, `GridView`

### Material Widgets
- `Card`, `ListTile`, `Divider`, `Chip`
- `ElevatedButton`, `TextButton`, `OutlinedButton`, `IconButton`
- `FloatingActionButton`, `Switch`, `TextField`

### Display Widgets
- `Text`, `Icon`, `Image.network`, `Image.asset`
- `CircleAvatar`

### Advanced Features
- **Color Support** - 20+ predefined colors plus custom hex colors
- **Icon Library** - 25+ commonly used Material icons
- **Image Handling** - Network and asset images with error handling
- **Responsive Layouts** - Flexible and expanded widgets
- **Action System** - Custom event handling with parameter passing
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

