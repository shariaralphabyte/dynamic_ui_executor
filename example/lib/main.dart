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

  // String UI Examples
  String get stringExample => """
Container(
  width: double.infinity,
  padding: EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Card(
        elevation: 4,
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
      Row(
        children: [
          Expanded(
            child: Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.speed, color: Colors.blue, size: 32),
                    SizedBox(height: 8),
                    Text('Fast', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Runtime generation'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.extension, color: Colors.green, size: 32),
                    SizedBox(height: 8),
                    Text('Flexible', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('50+ widgets'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 16),
      TextField(
        decoration: InputDecoration(
          labelText: 'Enter text',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.edit),
        ),
      ),
      SizedBox(height: 16),
      Container(
        width: double.infinity,
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(width: 80, height: 80, color: Colors.red, margin: EdgeInsets.all(4)),
            Container(width: 80, height: 80, color: Colors.green, margin: EdgeInsets.all(4)),
            Container(width: 80, height: 80, color: Colors.blue, margin: EdgeInsets.all(4)),
            Container(width: 80, height: 80, color: Colors.yellow, margin: EdgeInsets.all(4)),
          ],
        ),
      ),
    ],
  ),
)
""";

  // JSON UI Example - Fixed structure for proper parsing
  Map<String, dynamic> get jsonExample => {
    "type": "Container",
    "width": "double.infinity",
    "padding": "EdgeInsets.all(16)",
    "child": {
      "type": "Column",
      "crossAxisAlignment": "CrossAxisAlignment.stretch",
      "children": [
        {
          "type": "Card",
          "elevation": 4,
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
                  "data": "JSON UI Demo",
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
                  "data": "Beautiful UI from JSON definitions"
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
                    "data": "JSON Action"
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
          "type": "Row",
          "children": [
            {
              "type": "Expanded",
              "child": {
                "type": "Card",
                "color": "Colors.red.shade100",
                "child": {
                  "type": "Padding",
                  "padding": "EdgeInsets.all(16)",
                  "child": {
                    "type": "Column",
                    "children": [
                      {
                        "type": "Icon",
                        "icon": "Icons.home",
                        "size": 32,
                        "color": "Colors.red"
                      },
                      {
                        "type": "SizedBox",
                        "height": 8
                      },
                      {
                        "type": "Text",
                        "data": "Home",
                        "style": {
                          "fontWeight": "FontWeight.bold"
                        }
                      }
                    ]
                  }
                }
              }
            },
            {
              "type": "SizedBox",
              "width": 8
            },
            {
              "type": "Expanded",
              "child": {
                "type": "Card",
                "color": "Colors.blue.shade100",
                "child": {
                  "type": "Padding",
                  "padding": "EdgeInsets.all(16)",
                  "child": {
                    "type": "Column",
                    "children": [
                      {
                        "type": "Icon",
                        "icon": "Icons.settings",
                        "size": 32,
                        "color": "Colors.blue"
                      },
                      {
                        "type": "SizedBox",
                        "height": 8
                      },
                      {
                        "type": "Text",
                        "data": "Settings",
                        "style": {
                          "fontWeight": "FontWeight.bold"
                        }
                      }
                    ]
                  }
                }
              }
            }
          ]
        },
        {
          "type": "SizedBox",
          "height": 16
        },
        {
          "type": "TextField",
          "decoration": {
            "labelText": "JSON TextField",
            "border": "OutlineInputBorder()",
            "prefixIcon": "Icon(Icons.message)"
          }
        }
      ]
    }
  };

  void _handleAction(String action, [Map<String, dynamic>? params]) {
    switch (action) {
      case 'showMessage':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hello from String UI!')),
        );
        break;
      case 'showJsonMessage':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hello from JSON UI!')),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action: $action')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: DynamicWidgetExecutor(
              widgetDefinition: stringExample,
              actionHandler: _handleAction,
            ),
          ),
          // JSON UI Tab
          SingleChildScrollView(
            child: DynamicWidgetExecutor(
              widgetDefinition: jsonEncode(jsonExample),
              isJson: true,
              actionHandler: _handleAction,
            ),
          ),
          // Info Tab
          const SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
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
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
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
