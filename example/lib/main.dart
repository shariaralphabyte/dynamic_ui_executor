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
  bool _switchValue = false;
  bool _checkboxValue = false;

  // Beautiful String-based UI Examples
  String get basicLayoutExample => """
Scaffold(
  appBar: AppBar(
    title: Text('Basic Layout Demo'),
    backgroundColor: Colors.indigo,
    elevation: 4,
  ),
  body: SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 8,
          margin: EdgeInsets.only(bottom: 16),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.deepPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.star, size: 48, color: Colors.white),
                SizedBox(height: 12),
                Text('Welcome to Dynamic UI!', 
                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 8),
                Text('Build beautiful UIs from strings and JSON', 
                     style: TextStyle(fontSize: 16, color: Colors.white70)),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () { showWelcomeDialog() },
                  child: Text('Get Started'),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.widgets, size: 32, color: Colors.blue),
                      SizedBox(height: 8),
                      Text('Widgets', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('50+ Supported'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.platform, size: 32, color: Colors.green),
                      SizedBox(height: 8),
                      Text('Platforms', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('All Supported'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
)
""";

  String get interactiveWidgetsExample => """
Container(
  padding: EdgeInsets.all(16),
  child: Column(
    children: [
      Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Interactive Elements', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () { showSuccessMessage() },
                      child: Text('Success'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () { showInfoMessage() },
                      child: Text('Info'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextButton(
                      onPressed: () { showWarningMessage() },
                      child: Text('Warning'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Switch(value: true, onChanged: (v) { toggleSwitch() }),
                  SizedBox(width: 8),
                  Text('Enable notifications'),
                  Spacer(),
                  Checkbox(value: false, onChanged: (v) { toggleCheckbox() }),
                  Text('Agree to terms'),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)
""";

  String get listAndGridExample => """
Container(
  height: 400,
  child: Column(
    children: [
      Text('Horizontal List', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Container(
        height: 120,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              width: 100,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('Item 1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            ),
            Container(
              width: 100,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('Item 2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            ),
            Container(
              width: 100,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('Item 3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
      SizedBox(height: 16),
      Text('Grid Layout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dashboard, size: 32, color: Colors.white),
                  Text('Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              )),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics, size: 32, color: Colors.white),
                  Text('Analytics', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              )),
            ),
          ],
        ),
      ),
    ],
  ),
)
""";

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

  // Comprehensive JSON UI Examples
  Map<String, dynamic> get dashboardJsonExample => {
    "type": "Container",
    "padding": {"all": 16.0},
    "child": {
      "type": "Column",
      "children": [
        {
          "type": "Card",
          "elevation": 8.0,
          "margin": {"bottom": 16.0},
          "child": {
            "type": "Container",
            "padding": {"all": 20.0},
            "decoration": {
              "color": "teal",
              "borderRadius": 12.0
            },
            "child": {
              "type": "Column",
              "children": [
                {
                  "type": "Icon",
                  "icon": "dashboard",
                  "size": 48.0,
                  "color": "white"
                },
                {"type": "SizedBox", "height": 12.0},
                {
                  "type": "Text",
                  "data": "Dashboard Overview",
                  "style": {
                    "fontSize": 24.0,
                    "fontWeight": "bold",
                    "color": "white"
                  }
                },
                {"type": "SizedBox", "height": 8.0},
                {
                  "type": "Text",
                  "data": "Real-time analytics and insights",
                  "style": {
                    "fontSize": 16.0,
                    "color": "white70"
                  }
                },
                {"type": "SizedBox", "height": 16.0},
                {
                  "type": "ElevatedButton",
                  "onPressed": "viewAnalytics",
                  "child": {"type": "Text", "data": "View Analytics"}
                }
              ]
            }
          }
        },
        {
          "type": "Row",
          "children": [
            {
              "type": "Expanded",
              "child": {
                "type": "Card",
                "child": {
                  "type": "Padding",
                  "padding": {"all": 16.0},
                  "child": {
                    "type": "Column",
                    "children": [
                      {
                        "type": "Icon",
                        "icon": "trending_up",
                        "size": 32.0,
                        "color": "green"
                      },
                      {"type": "SizedBox", "height": 8.0},
                      {
                        "type": "Text",
                        "data": "Sales",
                        "style": {"fontWeight": "bold"}
                      },
                      {
                        "type": "Text",
                        "data": "+15.3%",
                        "style": {"color": "green"}
                      }
                    ]
                  }
                }
              }
            },
            {"type": "SizedBox", "width": 8.0},
            {
              "type": "Expanded",
              "child": {
                "type": "Card",
                "child": {
                  "type": "Padding",
                  "padding": {"all": 16.0},
                  "child": {
                    "type": "Column",
                    "children": [
                      {
                        "type": "Icon",
                        "icon": "people",
                        "size": 32.0,
                        "color": "blue"
                      },
                      {"type": "SizedBox", "height": 8.0},
                      {
                        "type": "Text",
                        "data": "Users",
                        "style": {"fontWeight": "bold"}
                      },
                      {
                        "type": "Text",
                        "data": "1,234",
                        "style": {"color": "blue"}
                      }
                    ]
                  }
                }
              }
            }
          ]
        }
      ]
    }
  };

  Map<String, dynamic> get formJsonExample => {
    "type": "Card",
    "margin": {"all": 16.0},
    "child": {
      "type": "Padding",
      "padding": {"all": 20.0},
      "child": {
        "type": "Column",
        "crossAxisAlignment": "start",
        "children": [
          {
            "type": "Text",
            "data": "User Registration",
            "style": {
              "fontSize": 24.0,
              "fontWeight": "bold",
              "color": "deepPurple"
            }
          },
          {"type": "SizedBox", "height": 20.0},
          {
            "type": "TextField",
            "decoration": {
              "labelText": "Full Name",
              "border": "outline",
              "prefixIcon": "person"
            }
          },
          {"type": "SizedBox", "height": 16.0},
          {
            "type": "TextField",
            "decoration": {
              "labelText": "Email Address",
              "border": "outline",
              "prefixIcon": "email"
            }
          },
          {"type": "SizedBox", "height": 16.0},
          {
            "type": "Row",
            "children": [
              {
                "type": "Switch",
                "value": true,
                "onChanged": "toggleNotifications"
              },
              {"type": "SizedBox", "width": 8.0},
              {
                "type": "Text",
                "data": "Enable push notifications"
              }
            ]
          },
          {"type": "SizedBox", "height": 16.0},
          {
            "type": "Row",
            "children": [
              {
                "type": "Checkbox",
                "value": false,
                "onChanged": "acceptTerms"
              },
              {"type": "SizedBox", "width": 8.0},
              {
                "type": "Expanded",
                "child": {
                  "type": "Text",
                  "data": "I agree to the terms and conditions"
                }
              }
            ]
          },
          {"type": "SizedBox", "height": 24.0},
          {
            "type": "Row",
            "children": [
              {
                "type": "Expanded",
                "child": {
                  "type": "ElevatedButton",
                  "onPressed": "registerUser",
                  "child": {"type": "Text", "data": "Register"}
                }
              },
              {"type": "SizedBox", "width": 16.0},
              {
                "type": "Expanded",
                "child": {
                  "type": "OutlinedButton",
                  "onPressed": "cancelRegistration",
                  "child": {"type": "Text", "data": "Cancel"}
                }
              }
            ]
          }
        ]
      }
    }
  };

  Map<String, dynamic> get mediaJsonExample => {
    "type": "Column",
    "children": [
      {
        "type": "Card",
        "margin": {"all": 16.0},
        "child": {
          "type": "Column",
          "children": [
            {
              "type": "Container",
              "height": 200.0,
              "decoration": {
                "color": "grey300",
                "borderRadius": 12.0
              },
              "child": {
                "type": "Center",
                "child": {
                  "type": "Column",
                  "mainAxisAlignment": "center",
                  "children": [
                    {
                      "type": "Icon",
                      "icon": "image",
                      "size": 64.0,
                      "color": "grey600"
                    },
                    {"type": "SizedBox", "height": 8.0},
                    {
                      "type": "Text",
                      "data": "Beautiful Landscape",
                      "style": {"color": "grey600"}
                    }
                  ]
                }
              }
            },
            {
              "type": "Padding",
              "padding": {"all": 16.0},
              "child": {
                "type": "Column",
                "crossAxisAlignment": "start",
                "children": [
                  {
                    "type": "Text",
                    "data": "Nature Photography",
                    "style": {
                      "fontSize": 20.0,
                      "fontWeight": "bold"
                    }
                  },
                  {"type": "SizedBox", "height": 8.0},
                  {
                    "type": "Text",
                    "data": "A stunning view of nature's beauty captured in this amazing photograph.",
                    "style": {"color": "grey"}
                  },
                  {"type": "SizedBox", "height": 16.0},
                  {
                    "type": "Row",
                    "children": [
                      {
                        "type": "IconButton",
                        "icon": "favorite_border",
                        "onPressed": "likePhoto"
                      },
                      {
                        "type": "IconButton",
                        "icon": "share",
                        "onPressed": "sharePhoto"
                      },
                      {
                        "type": "IconButton",
                        "icon": "bookmark_border",
                        "onPressed": "bookmarkPhoto"
                      }
                    ]
                  }
                ]
              }
            }
          ]
        }
      }
    ]
  };
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
      case 'showWelcomeDialog':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Welcome!'),
            content: const Text('Welcome to Dynamic UI Executor! This plugin lets you build beautiful UIs from JSON and String definitions.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Got it!'),
              ),
            ],
          ),
        );
        break;
      case 'showSuccessMessage':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Success! This action was triggered from a dynamic UI.'),
            backgroundColor: Colors.green,
          ),
        );
        break;
      case 'showInfoMessage':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Info: Dynamic UI actions work seamlessly!'),
            backgroundColor: Colors.blue,
          ),
        );
        break;
      case 'showWarningMessage':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Warning: This is a demo warning message.'),
            backgroundColor: Colors.orange,
          ),
        );
        break;
      case 'toggleSwitch':
        setState(() {
          _switchValue = !_switchValue;
        });
        break;
      case 'toggleCheckbox':
        setState(() {
          _checkboxValue = !_checkboxValue;
        });
        break;
      case 'viewAnalytics':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Analytics dashboard would open here!'),
            backgroundColor: Colors.teal,
          ),
        );
        break;
      case 'registerUser':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registration'),
            content: const Text('User registration would be processed here!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        break;
      case 'cancelRegistration':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration cancelled')),
        );
        break;
      case 'toggleNotifications':
        setState(() {
          _switchValue = !_switchValue;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Notifications ${_switchValue ? 'enabled' : 'disabled'}')),
        );
        break;
      case 'acceptTerms':
        setState(() {
          _checkboxValue = !_checkboxValue;
        });
        break;
      case 'likePhoto':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❤️ Photo liked!'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case 'sharePhoto':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('📤 Photo shared!')),
        );
        break;
      case 'bookmarkPhoto':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🔖 Photo bookmarked!'),
            backgroundColor: Colors.amber,
          ),
        );
        break;
      default:
        defaultHandler.handle(action, params);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Basic Layout Example
      Scaffold(
        appBar: AppBar(
          title: const Text('Basic Layout'),
          backgroundColor: Colors.indigo,
        ),
        body: DynamicWidgetExecutor.fromString(
          basicLayoutExample,
          actionHandler: _handleAction,
        ),
      ),
      // Interactive Widgets Example
      Scaffold(
        appBar: AppBar(
          title: const Text('Interactive Widgets'),
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          child: DynamicWidgetExecutor.fromString(
            interactiveWidgetsExample,
            actionHandler: _handleAction,
          ),
        ),
      ),
      // List & Grid Example
      Scaffold(
        appBar: AppBar(
          title: const Text('Lists & Grids'),
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DynamicWidgetExecutor.fromString(
            listAndGridExample,
            actionHandler: _handleAction,
          ),
        ),
      ),
      // JSON Dashboard Example
      Scaffold(
        appBar: AppBar(
          title: const Text('JSON Dashboard'),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: DynamicWidgetExecutor.fromJson(
            dashboardJsonExample,
            actionHandler: _handleAction,
          ),
        ),
      ),
      // JSON Form Example
      Scaffold(
        appBar: AppBar(
          title: const Text('JSON Form'),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: DynamicWidgetExecutor.fromJson(
            formJsonExample,
            actionHandler: _handleAction,
          ),
        ),
      ),
      // JSON Media Example
      Scaffold(
        appBar: AppBar(
          title: const Text('JSON Media'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: DynamicWidgetExecutor.fromJson(
            mediaJsonExample,
            actionHandler: _handleAction,
          ),
        ),
      ),
      // Documentation page
      Scaffold(
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
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Basic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Interactive',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.form_select),
            label: 'Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Media',
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
