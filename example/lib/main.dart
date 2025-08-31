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
  padding: EdgeInsets.all(16),
  child: Column(
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

  // JSON UI Example
  Map<String, dynamic> get jsonExample => {
    "type": "Container",
    "properties": {
      "padding": "EdgeInsets.all(16)",
      "child": {
        "type": "Column",
        "properties": {
          "children": [
            {
              "type": "Card",
              "properties": {
                "elevation": 4,
                "child": {
                  "type": "Padding",
                  "properties": {
                    "padding": "EdgeInsets.all(20)",
                    "child": {
                      "type": "Column",
                      "properties": {
                        "children": [
                          {
                            "type": "Icon",
                            "properties": {
                              "icon": "Icons.dashboard",
                              "size": 48,
                              "color": "Colors.purple"
                            }
                          },
                          {
                            "type": "SizedBox",
                            "properties": {"height": 12}
                          },
                          {
                            "type": "Text",
                            "properties": {
                              "data": "JSON UI Demo",
                              "style": {
                                "fontSize": 24,
                                "fontWeight": "FontWeight.bold"
                              }
                            }
                          },
                          {
                            "type": "SizedBox",
                            "properties": {"height": 8}
                          },
                          {
                            "type": "Text",
                            "properties": {"data": "Beautiful UI from JSON definitions"}
                          },
                          {
                            "type": "SizedBox",
                            "properties": {"height": 16}
                          },
                          {
                            "type": "ElevatedButton",
                            "properties": {
                              "onPressed": "showJsonMessage",
                              "child": {
                                "type": "Text",
                                "properties": {"data": "JSON Action"}
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                }
              }
            },
            {
              "type": "SizedBox",
              "properties": {"height": 16}
            },
            {
              "type": "Container",
              "properties": {
                "height": 150,
                "child": {
                  "type": "GridView.count",
                  "properties": {
                    "crossAxisCount": 2,
                    "children": [
                      {
                        "type": "Card",
                        "properties": {
                          "color": "Colors.red.shade100",
                          "child": {
                            "type": "Center",
                            "properties": {
                              "child": {
                                "type": "Column",
                                "properties": {
                                  "mainAxisAlignment": "MainAxisAlignment.center",
                                  "children": [
                                    {
                                      "type": "Icon",
                                      "properties": {
                                        "icon": "Icons.home",
                                        "size": 32
                                      }
                                    },
                                    {
                                      "type": "Text",
                                      "properties": {"data": "Home"}
                                    }
                                  ]
                                }
                              }
                            }
                          }
                        }
                      },
                      {
                        "type": "Card",
                        "properties": {
                          "color": "Colors.blue.shade100",
                          "child": {
                            "type": "Center",
                            "properties": {
                              "child": {
                                "type": "Column",
                                "properties": {
                                  "mainAxisAlignment": "MainAxisAlignment.center",
                                  "children": [
                                    {
                                      "type": "Icon",
                                      "properties": {
                                        "icon": "Icons.settings",
                                        "size": 32
                                      }
                                    },
                                    {
                                      "type": "Text",
                                      "properties": {"data": "Settings"}
                                    }
                                  ]
                                }
                              }
                            }
                          }
                        }
                      }
                    ]
                  }
                }
              }
            }
          ]
        }
      }
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
