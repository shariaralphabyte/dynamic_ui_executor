import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dynamic_ui_executor/dynamic_ui_executor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic UI Executor Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  int _selectedIndex = 0;

  // String UI Examples - Simplified for guaranteed display
  String get stringExample => """
Column(
  children: [
    Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.star, size: 48, color: Colors.orange),
            SizedBox(height: 12),
            Text('String UI Demo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Beautiful UI from String definitions'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () { _handleAction('showMessage'); },
              child: Text('Click Me'),
            ),
          ],
        ),
      ),
    ),
    SizedBox(height: 16),
    Text('✅ String UI Working!', style: TextStyle(fontSize: 18, color: Colors.green)),
    SizedBox(height: 16),
    Container(
      height: 100,
      color: Colors.blue,
      child: Center(
        child: Text('Blue Container', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    ),
  ],
)
""";

  // JSON UI Example - Simplified for guaranteed display
  Map<String, dynamic> get jsonExample => {
    "type": "Column",
    "children": [
      {
        "type": "Card",
        "child": {
          "type": "Padding",
          "padding": "EdgeInsets.all(20)",
          "child": {
            "type": "Column",
            "children": [
              {
                "type": "Icon",
                "icon": "Icons.dashboard",
                "size": 48,
                "color": "Colors.purple"
              },
              {
                "type": "SizedBox",
                "height": 12
              },
              {
                "type": "Text",
                "text": "JSON UI Demo",
                "style": {
                  "fontSize": 24,
                  "fontWeight": "FontWeight.bold"
                }
              },
              {
                "type": "SizedBox",
                "height": 8
              },
              {
                "type": "Text",
                "text": "Beautiful UI from JSON definitions"
              },
              {
                "type": "SizedBox",
                "height": 16
              },
              {
                "type": "ElevatedButton",
                "onPressed": "showJsonMessage",
                "child": {
                  "type": "Text",
                  "text": "JSON Action"
                }
              }
            ]
          }
        }
      },
      {
        "type": "SizedBox",
        "height": 16
      },
      {
        "type": "Text",
        "text": "✅ JSON UI Working!",
        "style": {
          "fontSize": 18,
          "color": "Colors.green"
        }
      },
      {
        "type": "SizedBox",
        "height": 16
      },
      {
        "type": "Container",
        "height": 100,
        "color": "Colors.purple",
        "child": {
          "type": "Center",
          "child": {
            "type": "Text",
            "text": "Purple Container",
            "style": {
              "color": "Colors.white",
              "fontSize": 16
            }
          }
        }
      }
    ]
  };

  void _handleAction(String action, [Map<String, dynamic>? params]) {
    print('🔥 DEBUG: Action triggered: $action with params: $params');
    switch (action) {
      case 'showMessage':
        print('🔥 DEBUG: Showing string UI message');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hello from String UI!')),
        );
        break;
      case 'showJsonMessage':
        print('🔥 DEBUG: Showing JSON UI message');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hello from JSON UI!')),
        );
        break;
      default:
        print('🔥 DEBUG: Unknown action: $action');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action: $action')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('🔥 DEBUG: Building main widget, selectedIndex: $_selectedIndex');
    print('🔥 DEBUG: String example length: ${stringExample.length}');
    print('🔥 DEBUG: JSON example: ${jsonEncode(jsonExample)}');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic UI Executor'),
        backgroundColor: Colors.deepPurple,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // String UI Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Builder(
              builder: (context) {
                print('🔥 DEBUG: Building String UI tab');
                try {
                  return DynamicWidgetExecutor(
                    widgetDefinition: stringExample,
                    actionHandler: _handleAction,
                    errorWidget: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(Icons.warning, color: Colors.orange, size: 48),
                          SizedBox(height: 16),
                          Text('String UI Parse Error', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Check console for details'),
                        ],
                      ),
                    ),
                  );
                } catch (e) {
                  print('🔥 DEBUG: Exception creating String UI: $e');
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 48),
                        SizedBox(height: 16),
                        Text('String UI Exception: $e'),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          // JSON UI Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Builder(
              builder: (context) {
                print('🔥 DEBUG: Building JSON UI tab');
                try {
                  return DynamicWidgetExecutor(
                    widgetDefinition: jsonEncode(jsonExample),
                    isJson: true,
                    actionHandler: _handleAction,
                    errorWidget: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(Icons.warning, color: Colors.orange, size: 48),
                          SizedBox(height: 16),
                          Text('JSON UI Parse Error', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Check console for details'),
                        ],
                      ),
                    ),
                  );
                } catch (e) {
                  print('🔥 DEBUG: Exception creating JSON UI: $e');
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 48),
                        SizedBox(height: 16),
                        Text('JSON UI Exception: $e'),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          // Info Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Builder(
              builder: (context) {
                print('🔥 DEBUG: Building Info tab');
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dynamic UI Executor',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Build Flutter UIs dynamically from JSON or String definitions at runtime.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Features:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('• Runtime UI generation from JSON/String'),
                    Text('• 50+ supported Flutter widgets'),
                    Text('• Action handling for interactions'),
                    Text('• Server-driven UI capabilities'),
                    Text('• Cross-platform support'),
                    SizedBox(height: 20),
                    Text(
                      'Supported Widgets:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('• Layout: Scaffold, Column, Row, Container, Card'),
                    Text('• Text: Text with styling'),
                    Text('• Buttons: ElevatedButton, TextButton, OutlinedButton'),
                    Text('• Input: TextField, Switch, Checkbox'),
                    Text('• Lists: ListView, GridView'),
                    Text('• Icons: Icon with customization'),
                    Text('• Spacing: SizedBox, Padding'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          print('🔥 DEBUG: Tab tapped: $index');
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'String UI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_object),
            label: 'JSON UI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}
