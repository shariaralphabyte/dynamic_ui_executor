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
        primarySwatch: Colors.blue,
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
  int _counter = 0;

  // Example: Full Widget Demo UI as a string
  String get stringWidgetDefinition => """
Scaffold(
  appBar: AppBar(
    title: Text('Full Widget Demo'),
    backgroundColor: Colors.teal,
  ),
  body: SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          color: Colors.orangeAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to Full UI!'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () { showSnackBar() },
                child: Text('Click Me'),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 120,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 30),
                    SizedBox(height: 10),
                    Text('Item 1', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 300,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home, size: 40, color: Colors.red),
            Icon(Icons.person, size: 40, color: Colors.blue),
            Icon(Icons.settings, size: 40, color: Colors.green),
            Icon(Icons.message, size: 40, color: Colors.orange),
          ],
        ),
        SizedBox(height: 20),
        TextField(),
        SizedBox(height: 20),
        Row(
          children: [
            Text('Enable Feature:'),
            SizedBox(width: 10),
            Switch(value: true),
          ],
        ),
      ],
    ),
  ),
)
""";

  // Example 2: JSON-based widget definition
  Map<String, dynamic> get jsonWidgetDefinition => {
    "type": "scaffold",
    "properties": {
      "appBar": {
        "type": "appbar",
        "properties": {
          "title": {
            "type": "text",
            "properties": {"text": "JSON UI Demo"}
          },
          "backgroundColor": "Colors.purple"
        }
      },
      "body": {
        "type": "padding",
        "properties": {
          "padding": {"all": 16}
        },
        "children": [
          {
            "type": "column",
            "properties": {
              "mainAxisAlignment": "center",
              "crossAxisAlignment": "center"
            },
            "children": [
              {
                "type": "card",
                "properties": {
                  "elevation": 4,
                  "margin": {"all": 8}
                },
                "children": [
                  {
                    "type": "padding",
                    "properties": {
                      "padding": {"all": 16}
                    },
                    "children": [
                      {
                        "type": "column",
                        "children": [
                          {
                            "type": "text",
                            "properties": {
                              "text": "JSON-Powered UI",
                              "style": {
                                "fontSize": 24,
                                "fontWeight": "bold",
                                "color": "Colors.purple"
                              }
                            }
                          },
                          {
                            "type": "sized_box",
                            "properties": {"height": 16}
                          },
                          {
                            "type": "text",
                            "properties": {
                              "text": "This entire UI is built from JSON data!",
                              "style": {"fontSize": 16}
                            }
                          }
                        ]
                      }
                    ]
                  }
                ]
              },
              {
                "type": "sized_box",
                "properties": {"height": 20}
              },
              {
                "type": "row",
                "properties": {"mainAxisAlignment": "spaceEvenly"},
                "children": [
                  {
                    "type": "elevated_button",
                    "properties": {
                      "action": "showSnackBar",
                      "actionParams": {"message": "JSON Button Clicked!"},
                      "child": {
                        "type": "text",
                        "properties": {"text": "JSON Button"}
                      }
                    }
                  },
                  {
                    "type": "text_button",
                    "properties": {
                      "action": "showDialog",
                      "actionParams": {
                        "title": "JSON Dialog",
                        "message": "This dialog was triggered from JSON!"
                      },
                      "child": {
                        "type": "text",
                        "properties": {"text": "Show Dialog"}
                      }
                    }
                  }
                ]
              }
            ]
          }
        ]
      }
    }
  };

  void _handleAction(String action, [Map<String, dynamic>? params]) {
    final defaultHandler = DefaultActionHandler(context, onRefresh: () {
      setState(() {});
    });

    switch (action) {
      case 'increment':
        setState(() {
          _counter++;
        });
        break;
      case 'showSnackBar':
        defaultHandler.handle(action, params);
        break;
      case 'showDialog':
        defaultHandler.handle(action, params);
        break;
      default:
        defaultHandler.handle(action, params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // String-based UI
          DynamicWidgetExecutor(
            widgetDefinition: stringWidgetDefinition,
            actionHandler: _handleAction,
          ),
          // JSON-based UI
          DynamicWidgetExecutor(
            widgetDefinition: jsonEncode(jsonWidgetDefinition),
            isJson: true,
            actionHandler: _handleAction,
          ),
          // Documentation page
          _buildDocumentationPage(),
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

  Widget _buildDocumentationPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic UI Executor'),
        backgroundColor: Colors.green,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dynamic UI Executor Plugin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This plugin allows you to build Flutter UIs dynamically at runtime from server-provided widget definitions.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Convert JSON or string definitions into live Flutter widgets'),
            Text('• Support for common widgets: Scaffold, AppBar, Column, Row, etc.'),
            Text('• Centralized action handling for interactions'),
            Text('• Styling and theming support'),
            Text('• Server-driven UI updates without recompilation'),
            Text('• Extensible with custom widget parsers'),
            Text('• Cross-platform compatibility'),
            SizedBox(height: 20),
            Text(
              'Supported Widgets:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Layout: Scaffold, Column, Row, Stack, Center, Container'),
            Text('• Text: Text with styling options'),
            Text('• Buttons: ElevatedButton, TextButton'),
            Text('• Images: Image (network and asset)'),
            Text('• Lists: ListView'),
            Text('• Material: Card, AppBar'),
            Text('• Spacing: SizedBox, Padding'),
            Text('• Flex: Expanded, Flexible'),
            SizedBox(height: 20),
            Text(
              'Switch between the tabs above to see examples of string-based and JSON-based dynamic UIs!',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
