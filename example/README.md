# Dynamic UI Executor Example

This example demonstrates the comprehensive capabilities of the Dynamic UI Executor plugin, showcasing how to create dynamic user interfaces from both JSON and string definitions.

## Features Demonstrated

### 🎨 Widget Showcase
- **Layout Widgets**: Scaffold, Column, Row, Stack, Container, Padding
- **Interactive Elements**: Buttons, TextField, Switch, FloatingActionButton
- **Display Components**: Text, Icons, Images, Cards, CircleAvatar
- **Scrollable Content**: SingleChildScrollView, ListView, GridView

### 🔄 Dual Format Support
- **String-based UI**: Dart-like syntax for familiar Flutter developers
- **JSON-based UI**: Structured data format perfect for server-driven UIs

### ⚡ Action Handling
- Button interactions with custom action handlers
- State management integration
- Event parameter passing

## Running the Example

1. Navigate to the example directory:
```bash
cd example
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the example:
```bash
flutter run
```

## Code Structure

### Main Components

- `main.dart` - Entry point and main app structure
- `DemoHomePage` - Tabbed interface showcasing different UI formats
- Action handlers for user interactions

### UI Definitions

The example includes comprehensive UI definitions demonstrating:

#### String Format Dashboard
```dart
String stringWidgetDefinition = '''
Scaffold(
  appBar: AppBar(
    title: Text('Full Widget Demo'),
    backgroundColor: Colors.teal,
  ),
  body: SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        // Interactive cards, lists, grids, and form elements
      ],
    ),
  ),
)
''';
```

#### JSON Format Structure
```dart
Map<String, dynamic> jsonWidgetDefinition = {
  "type": "scaffold",
  "properties": {
    "appBar": {
      "type": "appbar",
      "properties": {
        "title": {"type": "text", "properties": {"data": "JSON Demo"}},
        "backgroundColor": "teal"
      }
    },
    // Nested widget definitions
  }
};
```

## Key Learning Points

### 1. Widget Parsing
Learn how different Flutter widgets are parsed from string and JSON formats:
- Layout widgets with children arrays
- Properties and styling options
- Event handling integration

### 2. Action System
Understand the action handling mechanism:
```dart
actionHandler: (String action, Map<String, dynamic> params) {
  switch (action) {
    case 'increment':
      setState(() => _counter++);
      break;
    case 'showSnackBar':
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Action triggered!')),
      );
      break;
  }
}
```

### 3. State Management
See how dynamic UIs integrate with Flutter's state management:
- StatefulWidget integration
- State updates from dynamic actions
- UI rebuilding with new definitions

## Customization

### Adding New Widgets
The example shows how the plugin handles various widget types. You can extend this by:
1. Adding new widget definitions to the UI strings/JSON
2. Implementing custom action handlers
3. Integrating with your app's state management

### Styling Options
Explore different styling approaches:
- Predefined colors (`Colors.teal`, `Colors.blue`)
- Layout properties (`mainAxisAlignment`, `crossAxisAlignment`)
- Spacing and padding options

## Best Practices Demonstrated

1. **Error Handling**: Graceful fallbacks for unsupported widgets
2. **Performance**: Efficient parsing and rendering
3. **Maintainability**: Clean separation of UI definitions and logic
4. **Flexibility**: Easy switching between different UI configurations

## Next Steps

After exploring this example:
1. Try modifying the UI definitions
2. Add your own custom actions
3. Integrate with your app's data layer
4. Experiment with different widget combinations

For more advanced usage, check out the main plugin documentation.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
