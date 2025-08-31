import 'package:flutter/material.dart';
import 'action_handler.dart';
import 'theme_parser.dart';

/// Parser that converts string or JSON widget definitions into Flutter widgets
class WidgetParser {
  final ActionHandler? actionHandler;
  final Map<String, WidgetBuilder>? customParsers;

  WidgetParser({
    this.actionHandler,
    this.customParsers,
  });

  /// Parse widget from JSON definition
  Widget parseFromJson(Map<String, dynamic> json) {
    return _parseJsonWidget(json);
  }

  /// Parse widget from string definition (Dart-like syntax)
  Widget parseFromString(String definition) {
    // Clean and prepare the string
    final cleanDef = definition.trim();
    return _parseStringWidget(cleanDef);
  }

  Widget _parseJsonWidget(Map<String, dynamic> json) {
    final String type = json['type'] ?? '';
    final Map<String, dynamic> props = json['properties'] ?? {};
    final List<dynamic>? children = json['children'];

    switch (type.toLowerCase()) {
      case 'scaffold':
        return _buildScaffold(props, children);
      case 'appbar':
        return _buildAppBar(props);
      case 'column':
        return _buildColumn(props, children);
      case 'row':
        return _buildRow(props, children);
      case 'stack':
        return _buildStack(props, children);
      case 'center':
        return _buildCenter(props, children);
      case 'container':
        return _buildContainer(props, children);
      case 'text':
        return _buildText(props);
      case 'elevatedbutton':
      case 'elevated_button':
        return _buildElevatedButton(props);
      case 'textbutton':
      case 'text_button':
        return _buildTextButton(props);
      case 'sizedbox':
      case 'sized_box':
        return _buildSizedBox(props);
      case 'padding':
        return _buildPadding(props, children);
      case 'listview':
      case 'list_view':
        return _buildListView(props, children);
      case 'image':
        return _buildImage(props);
      case 'icon':
        return _buildIcon(props);
      case 'card':
        return _buildCard(props, children);
      case 'expanded':
        return _buildExpanded(props, children);
      case 'flexible':
        return _buildFlexible(props, children);
      default:
        if (customParsers?.containsKey(type) == true) {
          return Builder(builder: (context) => customParsers![type]!(context));
        }
        return Text('Unknown widget type: $type');
    }
  }

  Widget _parseStringWidget(String definition) {
    // Simple string parser for Dart-like syntax
    definition = definition.trim();
    
    if (definition.startsWith('Scaffold(')) {
      return _parseScaffoldString(definition);
    } else if (definition.startsWith('Column(')) {
      return _parseColumnString(definition);
    } else if (definition.startsWith('Row(')) {
      return _parseRowString(definition);
    } else if (definition.startsWith('Text(')) {
      return _parseTextString(definition);
    } else if (definition.startsWith('ElevatedButton(')) {
      return _parseElevatedButtonString(definition);
    } else if (definition.startsWith('Center(')) {
      return _parseCenterString(definition);
    } else if (definition.startsWith('Container(')) {
      return _parseContainerString(definition);
    } else if (definition.startsWith('SizedBox(')) {
      return _parseSizedBoxString(definition);
    } else if (definition.startsWith('Padding(')) {
      return _parsePaddingString(definition);
    } else if (definition.startsWith('CircleAvatar(')) {
      return _parseCircleAvatarString(definition);
    } else if (definition.startsWith('Icon(')) {
      return _parseIconString(definition);
    } else if (definition.startsWith('SingleChildScrollView(')) {
      return _parseSingleChildScrollViewString(definition);
    } else if (definition.startsWith('ListView(')) {
      return _parseListViewString(definition);
    } else if (definition.startsWith('GridView.count(')) {
      return _parseGridViewString(definition);
    } else if (definition.startsWith('TextField(')) {
      return _parseTextFieldString(definition);
    } else if (definition.startsWith('Switch(')) {
      return _parseSwitchString(definition);
    } else if (definition.startsWith('Card(')) {
      return _parseCardString(definition);
    } else if (definition.startsWith('ListTile(')) {
      return _parseListTileString(definition);
    } else if (definition.startsWith('Chip(')) {
      return _parseChipString(definition);
    } else if (definition.startsWith('FloatingActionButton(')) {
      return _parseFloatingActionButtonString(definition);
    } else if (definition.startsWith('TextButton(')) {
      return _parseTextButtonString(definition);
    } else if (definition.startsWith('OutlinedButton(')) {
      return _parseOutlinedButtonString(definition);
    } else if (definition.startsWith('IconButton(')) {
      return _parseIconButtonString(definition);
    } else if (definition.startsWith('Expanded(')) {
      return _parseExpandedString(definition);
    } else if (definition.startsWith('Flexible(')) {
      return _parseFlexibleString(definition);
    } else if (definition.startsWith('Stack(')) {
      return _parseStackString(definition);
    } else if (definition.startsWith('Positioned(')) {
      return _parsePositionedString(definition);
    } else if (definition.startsWith('Wrap(')) {
      return _parseWrapString(definition);
    } else if (definition.startsWith('Divider(')) {
      return _parseDividerString(definition);
    } else if (definition.startsWith('Image.network(')) {
      return _parseImageNetworkString(definition);
    } else if (definition.startsWith('Image.asset(')) {
      return _parseImageAssetString(definition);
    }
    
    return Text('Cannot parse: ${definition.substring(0, definition.length > 50 ? 50 : definition.length)}...');
  }

  // JSON Widget Builders
  Widget _buildScaffold(Map<String, dynamic> props, List<dynamic>? children) {
    return Scaffold(
      appBar: props['appBar'] != null ? _parseJsonWidget(props['appBar']) as PreferredSizeWidget : null,
      body: props['body'] != null ? _parseJsonWidget(props['body']) : null,
      backgroundColor: _parseColor(props['backgroundColor']),
      floatingActionButton: props['floatingActionButton'] != null 
        ? _parseJsonWidget(props['floatingActionButton']) : null,
    );
  }

  PreferredSizeWidget _buildAppBar(Map<String, dynamic> props) {
    return AppBar(
      title: props['title'] != null ? _parseJsonWidget(props['title']) : null,
      backgroundColor: _parseColor(props['backgroundColor']),
      elevation: _parseDouble(props['elevation']),
      centerTitle: props['centerTitle'] ?? false,
    );
  }

  Widget _buildColumn(Map<String, dynamic> props, List<dynamic>? children) {
    return Column(
      mainAxisAlignment: _parseMainAxisAlignment(props['mainAxisAlignment']),
      crossAxisAlignment: _parseCrossAxisAlignment(props['crossAxisAlignment']),
      children: children?.map((child) => _parseJsonWidget(child)).toList() ?? [],
    );
  }

  Widget _buildRow(Map<String, dynamic> props, List<dynamic>? children) {
    return Row(
      mainAxisAlignment: _parseMainAxisAlignment(props['mainAxisAlignment']),
      crossAxisAlignment: _parseCrossAxisAlignment(props['crossAxisAlignment']),
      children: children?.map((child) => _parseJsonWidget(child)).toList() ?? [],
    );
  }

  Widget _buildStack(Map<String, dynamic> props, List<dynamic>? children) {
    return Stack(
      alignment: _parseAlignment(props['alignment']) ?? Alignment.topLeft,
      children: children?.map((child) => _parseJsonWidget(child)).toList() ?? [],
    );
  }

  Widget _buildCenter(Map<String, dynamic> props, List<dynamic>? children) {
    final child = children?.isNotEmpty == true ? _parseJsonWidget(children!.first) : null;
    return Center(child: child);
  }

  Widget _buildContainer(Map<String, dynamic> props, List<dynamic>? children) {
    final child = children?.isNotEmpty == true ? _parseJsonWidget(children!.first) : null;
    return Container(
      width: _parseDouble(props['width']),
      height: _parseDouble(props['height']),
      padding: _parseEdgeInsets(props['padding']),
      margin: _parseEdgeInsets(props['margin']),
      decoration: _parseBoxDecoration(props['decoration']),
      child: child,
    );
  }

  Widget _buildText(Map<String, dynamic> props) {
    return Text(
      props['text']?.toString() ?? '',
      style: _parseTextStyle(props['style']),
      textAlign: _parseTextAlign(props['textAlign']),
    );
  }

  Widget _buildElevatedButton(Map<String, dynamic> props) {
    final String? action = props['action'];
    final Map<String, dynamic>? actionParams = props['actionParams'];
    
    return ElevatedButton(
      onPressed: action != null 
        ? () => actionHandler?.call(action, actionParams)
        : null,
      style: _parseButtonStyle(props['style']),
      child: props['child'] != null ? _parseJsonWidget(props['child']) : const Text('Button'),
    );
  }

  Widget _buildTextButton(Map<String, dynamic> props) {
    final String? action = props['action'];
    final Map<String, dynamic>? actionParams = props['actionParams'];
    
    return TextButton(
      onPressed: action != null 
        ? () => actionHandler?.call(action, actionParams)
        : null,
      style: _parseButtonStyle(props['style']),
      child: props['child'] != null ? _parseJsonWidget(props['child']) : const Text('Button'),
    );
  }

  Widget _buildSizedBox(Map<String, dynamic> props) {
    return SizedBox(
      width: _parseDouble(props['width']),
      height: _parseDouble(props['height']),
    );
  }

  Widget _buildPadding(Map<String, dynamic> props, List<dynamic>? children) {
    final child = children?.isNotEmpty == true ? _parseJsonWidget(children!.first) : null;
    return Padding(
      padding: _parseEdgeInsets(props['padding']) ?? EdgeInsets.zero,
      child: child,
    );
  }

  Widget _buildListView(Map<String, dynamic> props, List<dynamic>? children) {
    return ListView(
      scrollDirection: _parseAxis(props['scrollDirection']) ?? Axis.vertical,
      children: children?.map((child) => _parseJsonWidget(child)).toList() ?? [],
    );
  }

  Widget _buildImage(Map<String, dynamic> props) {
    final String? url = props['url'];
    final String? asset = props['asset'];
    
    if (url != null) {
      return Image.network(
        url,
        width: _parseDouble(props['width']),
        height: _parseDouble(props['height']),
        fit: _parseBoxFit(props['fit']),
      );
    } else if (asset != null) {
      return Image.asset(
        asset,
        width: _parseDouble(props['width']),
        height: _parseDouble(props['height']),
        fit: _parseBoxFit(props['fit']),
      );
    }
    
    return const Icon(Icons.image);
  }

  Widget _buildIcon(Map<String, dynamic> props) {
    return Icon(
      _parseIconData(props['icon']),
      size: _parseDouble(props['size']),
      color: _parseColor(props['color']),
    );
  }

  Widget _buildCard(Map<String, dynamic> props, List<dynamic>? children) {
    final child = children?.isNotEmpty == true ? _parseJsonWidget(children!.first) : null;
    return Card(
      elevation: _parseDouble(props['elevation']),
      margin: _parseEdgeInsets(props['margin']),
      child: child,
    );
  }

  Widget _buildExpanded(Map<String, dynamic> props, List<dynamic>? children) {
    final child = children?.isNotEmpty == true ? _parseJsonWidget(children!.first) : null;
    return Expanded(
      flex: props['flex'] ?? 1,
      child: child ?? const SizedBox(),
    );
  }

  Widget _buildFlexible(Map<String, dynamic> props, List<dynamic>? children) {
    final child = children?.isNotEmpty == true ? _parseJsonWidget(children!.first) : null;
    return Flexible(
      flex: props['flex'] ?? 1,
      child: child ?? const SizedBox(),
    );
  }

  // String Widget Parsers (simplified versions)
  Widget _parseScaffoldString(String definition) {
    // Extract appBar and body from string
    final appBarMatch = RegExp(r'appBar:\s*AppBar\([^)]*\)').firstMatch(definition);
    final bodyMatch = RegExp(r'body:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    
    PreferredSizeWidget? appBar;
    Widget? body;
    
    if (appBarMatch != null) {
      appBar = _parseAppBarString(appBarMatch.group(0)!);
    }
    
    if (bodyMatch != null) {
      body = _parseStringWidget(bodyMatch.group(1)!.trim());
    }
    
    return Scaffold(appBar: appBar, body: body);
  }

  PreferredSizeWidget _parseAppBarString(String definition) {
    final titleMatch = RegExp(r'''title:\s*Text\(\s*(["'])(.*?)\1\s*\)''').firstMatch(definition);
    return AppBar(
      title: titleMatch != null ? Text(titleMatch.group(2)!) : null,
    );
  }

  Widget _parseColumnString(String definition) {
    final childrenMatch = RegExp(r'children:\s*\[(.*)\]', dotAll: true).firstMatch(definition);
    List<Widget> children = [];
    
    if (childrenMatch != null) {
      children = _parseChildrenFromString(childrenMatch.group(1)!);
    }
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _parseRowString(String definition) {
    final childrenMatch = RegExp(r'children:\s*\[(.*)\]', dotAll: true).firstMatch(definition);
    List<Widget> children = [];
    
    if (childrenMatch != null) {
      children = _parseChildrenFromString(childrenMatch.group(1)!);
    }
    
    return Row(children: children);
  }

  Widget _parseTextString(String definition) {
    final textMatch = RegExp(r'''Text\((["'])(.*?)\1\)''').firstMatch(definition);
    return Text(textMatch?.group(2) ?? '');
  }


  Widget _parseElevatedButtonString(String definition) {
    final childMatch = RegExp(r'''child:\s*Text\(\s*(["'])(.*?)\1\s*\)''').firstMatch(definition);
    final onPressedMatch = RegExp(r'onPressed:\s*\(\)\s*\{\s*([^}]*)\s*\}').firstMatch(definition);
    
    return ElevatedButton(
      onPressed: onPressedMatch != null 
        ? () {
            final actionCode = onPressedMatch.group(1)?.trim();
            if (actionCode != null) {
              // Extract function name from function call like "increment()" -> "increment"
              final functionMatch = RegExp(r'(\w+)\(\)').firstMatch(actionCode);
              if (functionMatch != null) {
                final actionName = functionMatch.group(1)!;
                actionHandler?.call(actionName, {});
              }
            }
          }
        : null,
      child: Text(childMatch?.group(2) ?? 'Button'),
    );
  }

  Widget _parseContainerString(String definition) {
    final widthMatch = RegExp(r'width:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final heightMatch = RegExp(r'height:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final colorMatch = RegExp(r'color:\s*Colors\.(\w+)').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    
    Widget? child;
    if (childMatch != null) {
      child = _parseStringWidget(childMatch.group(1)!.trim());
    }
    
    return Container(
      width: widthMatch != null ? double.parse(widthMatch.group(1)!) : null,
      height: heightMatch != null ? double.parse(heightMatch.group(1)!) : null,
      color: colorMatch != null ? _getColorFromName(colorMatch.group(1)!) : null,
      child: child,
    );
  }

  Widget _parseSizedBoxString(String definition) {
    final widthMatch = RegExp(r'width:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final heightMatch = RegExp(r'height:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    
    Widget? child;
    if (childMatch != null) {
      child = _parseStringWidget(childMatch.group(1)!.trim());
    }
    
    return SizedBox(
      width: widthMatch != null ? double.parse(widthMatch.group(1)!) : null,
      height: heightMatch != null ? double.parse(heightMatch.group(1)!) : null,
      child: child,
    );
  }

  Widget _parseCenterString(String definition) {
    final childMatch = RegExp(r'child:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    Widget? child;
    
    if (childMatch != null) {
      child = _parseStringWidget(childMatch.group(1)!.trim());
    }
    
    return Center(child: child);
  }

  Widget _parsePaddingString(String definition) {
    final paddingMatch = RegExp(r'padding:\s*EdgeInsets\.all\((\d+(?:\.\d+)?)\)').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    
    Widget? child;
    if (childMatch != null) {
      child = _parseStringWidget(childMatch.group(1)!.trim());
    }
    
    double paddingValue = 8.0; // default
    if (paddingMatch != null) {
      paddingValue = double.parse(paddingMatch.group(1)!);
    }
    
    return Padding(
      padding: EdgeInsets.all(paddingValue),
      child: child,
    );
  }

  Widget _parseCircleAvatarString(String definition) {
    final radiusMatch = RegExp(r'radius:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final backgroundColorMatch = RegExp(r'backgroundColor:\s*Colors\.(\w+)').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    
    Widget? child;
    if (childMatch != null) {
      child = _parseStringWidget(childMatch.group(1)!.trim());
    }
    
    return CircleAvatar(
      radius: radiusMatch != null ? double.parse(radiusMatch.group(1)!) : 20.0,
      backgroundColor: backgroundColorMatch != null ? _getColorFromName(backgroundColorMatch.group(1)!) : Colors.grey,
      child: child,
    );
  }

  Widget _parseIconString(String definition) {
    final iconMatch = RegExp(r'Icon\(Icons\.(\w+)').firstMatch(definition);
    final colorMatch = RegExp(r'color:\s*Colors\.(\w+)').firstMatch(definition);
    final sizeMatch = RegExp(r'size:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    
    IconData iconData = Icons.help; // default
    if (iconMatch != null) {
      iconData = _getIconFromName(iconMatch.group(1)!) ?? Icons.help;
    }
    
    return Icon(
      iconData,
      color: colorMatch != null ? _getColorFromName(colorMatch.group(1)!) : null,
      size: sizeMatch != null ? double.parse(sizeMatch.group(1)!) : null,
    );
  }

  IconData? _getIconFromName(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'people': return Icons.people;
      case 'shopping_cart': return Icons.shopping_cart;
      case 'bar_chart': return Icons.bar_chart;
      case 'settings': return Icons.settings;
      case 'touch_app': return Icons.touch_app;
      case 'home': return Icons.home;
      case 'person': return Icons.person;
      case 'email': return Icons.email;
      case 'phone': return Icons.phone;
      case 'favorite': return Icons.favorite;
      case 'star': return Icons.star;
      case 'add': return Icons.add;
      case 'edit': return Icons.edit;
      case 'delete': return Icons.delete;
      case 'search': return Icons.search;
      case 'menu': return Icons.menu;
      case 'close': return Icons.close;
      case 'check': return Icons.check;
      case 'arrow_back': return Icons.arrow_back;
      case 'arrow_forward': return Icons.arrow_forward;
      case 'dashboard': return Icons.dashboard;
      case 'message': return Icons.message;
      default: return null;
    }
  }

  Widget _parseSingleChildScrollViewString(String definition) {
    final paddingMatch = RegExp(r'padding:\s*EdgeInsets\.all\((\d+(?:\.\d+)?)\)').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    
    Widget? child;
    if (childMatch != null) {
      child = _parseStringWidget(childMatch.group(1)!.trim());
    }
    
    return SingleChildScrollView(
      padding: paddingMatch != null ? EdgeInsets.all(double.parse(paddingMatch.group(1)!)) : null,
      child: child,
    );
  }

  Widget _parseListViewString(String definition) {
    final scrollDirectionMatch = RegExp(r'scrollDirection:\s*Axis\.(\w+)').firstMatch(definition);
    final childrenMatch = RegExp(r'children:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    
    List<Widget> children = [];
    if (childrenMatch != null) {
      // For now, return a simple placeholder since List.generate is complex to parse
      children = [
        Container(
          width: 120,
          height: 100,
          margin: const EdgeInsets.all(8),
          color: Colors.blue,
          child: const Center(child: Text('List Item', style: TextStyle(color: Colors.white))),
        ),
      ];
    }
    
    return ListView(
      scrollDirection: scrollDirectionMatch?.group(1) == 'horizontal' ? Axis.horizontal : Axis.vertical,
      children: children,
    );
  }

  Widget _parseGridViewString(String definition) {
    final crossAxisCountMatch = RegExp(r'crossAxisCount:\s*(\d+)').firstMatch(definition);
    final crossAxisSpacingMatch = RegExp(r'crossAxisSpacing:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final mainAxisSpacingMatch = RegExp(r'mainAxisSpacing:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    
    // For now, return a simple placeholder since List.generate is complex to parse
    List<Widget> children = List.generate(4, (index) => Container(
      padding: const EdgeInsets.all(16),
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.dashboard, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text('Grid $index', style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    ));
    
    return GridView.count(
      crossAxisCount: crossAxisCountMatch != null ? int.parse(crossAxisCountMatch.group(1)!) : 2,
      crossAxisSpacing: crossAxisSpacingMatch != null ? double.parse(crossAxisSpacingMatch.group(1)!) : 0,
      mainAxisSpacing: mainAxisSpacingMatch != null ? double.parse(mainAxisSpacingMatch.group(1)!) : 0,
      children: children,
    );
  }

  Widget _parseTextFieldString(String definition) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter Text',
      ),
    );
  }

  Widget _parseSwitchString(String definition) {
    final valueMatch = RegExp(r'value:\s*(true|false)').firstMatch(definition);
    bool value = valueMatch?.group(1) == 'true';
    
    return Switch(
      value: value,
      onChanged: (val) {},
    );
  }

  // Additional widget parsers for comprehensive support
  Widget _parseCardString(String definition) {
    final childMatch = RegExp(r'child:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    final elevationMatch = RegExp(r'elevation:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final marginMatch = RegExp(r'margin:\s*EdgeInsets\.all\((\d+(?:\.\d+)?)\)').firstMatch(definition);
    
    Widget? child;
    if (childMatch != null) {
      child = _parseStringWidget(childMatch.group(1)!.trim());
    }
    
    return Card(
      elevation: elevationMatch != null ? double.parse(elevationMatch.group(1)!) : 1.0,
      margin: marginMatch != null ? EdgeInsets.all(double.parse(marginMatch.group(1)!)) : const EdgeInsets.all(4.0),
      child: child,
    );
  }

  Widget _parseListTileString(String definition) {
    final titleMatch = RegExp(r'''title:\s*Text\(["'](.*?)["']\)''').firstMatch(definition);
    final subtitleMatch = RegExp(r'''subtitle:\s*Text\(["'](.*?)["']\)''').firstMatch(definition);
    final leadingMatch = RegExp(r'leading:\s*(.+?)(?=,|\))').firstMatch(definition);
    final trailingMatch = RegExp(r'trailing:\s*(.+?)(?=,|\))').firstMatch(definition);

    return ListTile(
      title: titleMatch != null ? Text(titleMatch.group(1)!) : null,
      subtitle: subtitleMatch != null ? Text(subtitleMatch.group(1)!) : null,
      leading: leadingMatch != null ? _parseStringWidget(leadingMatch.group(1)!.trim()) : null,
      trailing: trailingMatch != null ? _parseStringWidget(trailingMatch.group(1)!.trim()) : null,
    );
  }

  Widget _parseChipString(String definition) {
    final labelMatch = RegExp(r'''label:\s*Text\(["'](.*?)["']\)''').firstMatch(definition);
    final avatarMatch = RegExp(r'avatar:\s*(.+?)(?=,|\))').firstMatch(definition);

    return Chip(
      label: Text(labelMatch?.group(1) ?? 'Chip'),
      avatar: avatarMatch != null ? _parseStringWidget(avatarMatch.group(1)!.trim()) : null,
    );
  }

  Widget _parseFloatingActionButtonString(String definition) {
    final onPressedMatch = RegExp(r'onPressed:\s*\(\)\s*\{\s*([^}]*)\s*\}').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+?)(?=,|\))').firstMatch(definition);
    final backgroundColorMatch = RegExp(r'backgroundColor:\s*Colors\.(\w+)').firstMatch(definition);
    
    return FloatingActionButton(
      onPressed: onPressedMatch != null 
        ? () {
            final actionCode = onPressedMatch.group(1)?.trim();
            if (actionCode != null) {
              final functionMatch = RegExp(r'(\w+)\(\)').firstMatch(actionCode);
              if (functionMatch != null) {
                final actionName = functionMatch.group(1)!;
                actionHandler?.call(actionName, {});
              }
            }
          }
        : null,
      backgroundColor: backgroundColorMatch != null ? _getColorFromName(backgroundColorMatch.group(1)!) : null,
      child: childMatch != null ? _parseStringWidget(childMatch.group(1)!.trim()) : const Icon(Icons.add),
    );
  }

  Widget _parseTextButtonString(String definition) {
    final onPressedMatch = RegExp(r'onPressed:\s*\(\)\s*\{\s*([^}]*)\s*\}').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+?)(?=,|\))').firstMatch(definition);
    
    return TextButton(
      onPressed: onPressedMatch != null 
        ? () {
            final actionCode = onPressedMatch.group(1)?.trim();
            if (actionCode != null) {
              final functionMatch = RegExp(r'(\w+)\(\)').firstMatch(actionCode);
              if (functionMatch != null) {
                final actionName = functionMatch.group(1)!;
                actionHandler?.call(actionName, {});
              }
            }
          }
        : null,
      child: childMatch != null ? _parseStringWidget(childMatch.group(1)!.trim()) : const Text('Button'),
    );
  }

  Widget _parseOutlinedButtonString(String definition) {
    final onPressedMatch = RegExp(r'onPressed:\s*\(\)\s*\{\s*([^}]*)\s*\}').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+?)(?=,|\))').firstMatch(definition);
    
    return OutlinedButton(
      onPressed: onPressedMatch != null 
        ? () {
            final actionCode = onPressedMatch.group(1)?.trim();
            if (actionCode != null) {
              final functionMatch = RegExp(r'(\w+)\(\)').firstMatch(actionCode);
              if (functionMatch != null) {
                final actionName = functionMatch.group(1)!;
                actionHandler?.call(actionName, {});
              }
            }
          }
        : null,
      child: childMatch != null ? _parseStringWidget(childMatch.group(1)!.trim()) : const Text('Button'),
    );
  }

  Widget _parseIconButtonString(String definition) {
    final onPressedMatch = RegExp(r'onPressed:\s*\(\)\s*\{\s*([^}]*)\s*\}').firstMatch(definition);
    final iconMatch = RegExp(r'icon:\s*(.+?)(?=,|\))').firstMatch(definition);
    
    return IconButton(
      onPressed: onPressedMatch != null 
        ? () {
            final actionCode = onPressedMatch.group(1)?.trim();
            if (actionCode != null) {
              final functionMatch = RegExp(r'(\w+)\(\)').firstMatch(actionCode);
              if (functionMatch != null) {
                final actionName = functionMatch.group(1)!;
                actionHandler?.call(actionName, {});
              }
            }
          }
        : null,
      icon: iconMatch != null ? _parseStringWidget(iconMatch.group(1)!.trim()) : const Icon(Icons.touch_app),
    );
  }

  Widget _parseExpandedString(String definition) {
    final flexMatch = RegExp(r'flex:\s*(\d+)').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    
    Widget? child;
    if (childMatch != null) {
      child = _parseStringWidget(childMatch.group(1)!.trim());
    }
    
    return Expanded(
      flex: flexMatch != null ? int.parse(flexMatch.group(1)!) : 1,
      child: child ?? Container(),
    );
  }

  Widget _parseFlexibleString(String definition) {
    final flexMatch = RegExp(r'flex:\s*(\d+)').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    
    Widget? child;
    if (childMatch != null) {
      child = _parseStringWidget(childMatch.group(1)!.trim());
    }
    
    return Flexible(
      flex: flexMatch != null ? int.parse(flexMatch.group(1)!) : 1,
      child: child ?? Container(),
    );
  }

  Widget _parseStackString(String definition) {
    final childrenMatch = RegExp(r'children:\s*\[(.*?)\]', dotAll: true).firstMatch(definition);
    List<Widget> children = [];
    
    if (childrenMatch != null) {
      children = _parseChildrenFromString(childrenMatch.group(1)!);
    }
    
    return Stack(children: children);
  }

  Widget _parsePositionedString(String definition) {
    final topMatch = RegExp(r'top:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final leftMatch = RegExp(r'left:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final rightMatch = RegExp(r'right:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final bottomMatch = RegExp(r'bottom:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final childMatch = RegExp(r'child:\s*(.+)(?=,\s*\)|$)', dotAll: true).firstMatch(definition);
    
    Widget? child;
    if (childMatch != null) {
      child = _parseStringWidget(childMatch.group(1)!.trim());
    }
    
    return Positioned(
      top: topMatch != null ? double.parse(topMatch.group(1)!) : null,
      left: leftMatch != null ? double.parse(leftMatch.group(1)!) : null,
      right: rightMatch != null ? double.parse(rightMatch.group(1)!) : null,
      bottom: bottomMatch != null ? double.parse(bottomMatch.group(1)!) : null,
      child: child ?? Container(),
    );
  }

  Widget _parseWrapString(String definition) {
    final childrenMatch = RegExp(r'children:\s*\[(.*?)\]', dotAll: true).firstMatch(definition);
    final spacingMatch = RegExp(r'spacing:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final runSpacingMatch = RegExp(r'runSpacing:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    
    List<Widget> children = [];
    if (childrenMatch != null) {
      children = _parseChildrenFromString(childrenMatch.group(1)!);
    }
    
    return Wrap(
      spacing: spacingMatch != null ? double.parse(spacingMatch.group(1)!) : 0.0,
      runSpacing: runSpacingMatch != null ? double.parse(runSpacingMatch.group(1)!) : 0.0,
      children: children,
    );
  }

  Widget _parseDividerString(String definition) {
    final heightMatch = RegExp(r'height:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final thicknessMatch = RegExp(r'thickness:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final colorMatch = RegExp(r'color:\s*Colors\.(\w+)').firstMatch(definition);
    
    return Divider(
      height: heightMatch != null ? double.parse(heightMatch.group(1)!) : null,
      thickness: thicknessMatch != null ? double.parse(thicknessMatch.group(1)!) : null,
      color: colorMatch != null ? _getColorFromName(colorMatch.group(1)!) : null,
    );
  }

  Widget _parseImageNetworkString(String definition) {
    final urlMatch = RegExp(r'''Image\.network\(["'](.*?)["']\)''').firstMatch(definition);
    final widthMatch = RegExp(r'width:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final heightMatch = RegExp(r'height:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final fitMatch = RegExp(r'fit:\s*BoxFit\.(\w+)').firstMatch(definition);

    return Image.network(
      urlMatch?.group(1) ?? '',
      width: widthMatch != null ? double.parse(widthMatch.group(1)!) : null,
      height: heightMatch != null ? double.parse(heightMatch.group(1)!) : null,
      fit: fitMatch != null ? _getBoxFitFromName(fitMatch.group(1)!) : null,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
    );
  }

  Widget _parseImageAssetString(String definition) {
    final assetMatch = RegExp(r'''Image\.asset\(["'](.*?)["']\)''').firstMatch(definition);
    final widthMatch = RegExp(r'width:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final heightMatch = RegExp(r'height:\s*(\d+(?:\.\d+)?)').firstMatch(definition);
    final fitMatch = RegExp(r'fit:\s*BoxFit\.(\w+)').firstMatch(definition);
    
    return Image.asset(
      assetMatch?.group(1) ?? '',
      width: widthMatch != null ? double.parse(widthMatch.group(1)!) : null,
      height: heightMatch != null ? double.parse(heightMatch.group(1)!) : null,
      fit: fitMatch != null ? _getBoxFitFromName(fitMatch.group(1)!) : null,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
    );
  }

  BoxFit? _getBoxFitFromName(String fitName) {
    switch (fitName.toLowerCase()) {
      case 'fill': return BoxFit.fill;
      case 'contain': return BoxFit.contain;
      case 'cover': return BoxFit.cover;
      case 'fitwidth': return BoxFit.fitWidth;
      case 'fitheight': return BoxFit.fitHeight;
      case 'none': return BoxFit.none;
      case 'scaledown': return BoxFit.scaleDown;
      default: return null;
    }
  }

  Color? _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'yellow': return Colors.yellow;
      case 'orange': return Colors.orange;
      case 'orangeaccent': return Colors.orangeAccent;
      case 'deeporange': return Colors.deepOrange;
      case 'purple': return Colors.purple;
      case 'pink': return Colors.pink;
      case 'teal': return Colors.teal;
      case 'cyan': return Colors.cyan;
      case 'indigo': return Colors.indigo;
      case 'amber': return Colors.amber;
      case 'lime': return Colors.lime;
      case 'brown': return Colors.brown;
      case 'grey': case 'gray': return Colors.grey;
      case 'black': return Colors.black;
      case 'white': return Colors.white;
      case 'transparent': return Colors.transparent;
      default: return null;
    }
  }

  List<Widget> _parseChildrenFromString(String childrenString) {
    List<Widget> children = [];
    
    // Split by commas that are not inside parentheses
    final parts = _splitByCommaOutsideParentheses(childrenString);
    
    for (String part in parts) {
      final trimmed = part.trim();
      if (trimmed.isNotEmpty) {
        children.add(_parseStringWidget(trimmed));
      }
    }
    
    return children;
  }

  List<String> _splitByCommaOutsideParentheses(String input) {
    List<String> parts = [];
    int parenthesesCount = 0;
    int start = 0;
    
    for (int i = 0; i < input.length; i++) {
      if (input[i] == '(') {
        parenthesesCount++;
      } else if (input[i] == ')') {
        parenthesesCount--;
      } else if (input[i] == ',' && parenthesesCount == 0) {
        parts.add(input.substring(start, i));
        start = i + 1;
      }
    }
    
    if (start < input.length) {
      parts.add(input.substring(start));
    }
    
    return parts;
  }

  // Utility parsers for properties
  Color? _parseColor(dynamic colorValue) {
    return ThemeParser.parseColor(colorValue);
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  MainAxisAlignment _parseMainAxisAlignment(dynamic value) {
    if (value == null) return MainAxisAlignment.start;
    
    switch (value.toString().toLowerCase()) {
      case 'center': return MainAxisAlignment.center;
      case 'end': return MainAxisAlignment.end;
      case 'spacebetween': return MainAxisAlignment.spaceBetween;
      case 'spacearound': return MainAxisAlignment.spaceAround;
      case 'spaceevenly': return MainAxisAlignment.spaceEvenly;
      default: return MainAxisAlignment.start;
    }
  }

  CrossAxisAlignment _parseCrossAxisAlignment(dynamic value) {
    if (value == null) return CrossAxisAlignment.center;
    
    switch (value.toString().toLowerCase()) {
      case 'start': return CrossAxisAlignment.start;
      case 'end': return CrossAxisAlignment.end;
      case 'stretch': return CrossAxisAlignment.stretch;
      case 'baseline': return CrossAxisAlignment.baseline;
      default: return CrossAxisAlignment.center;
    }
  }

  Alignment? _parseAlignment(dynamic value) {
    if (value == null) return null;
    
    switch (value.toString().toLowerCase()) {
      case 'center': return Alignment.center;
      case 'topleft': return Alignment.topLeft;
      case 'topright': return Alignment.topRight;
      case 'bottomleft': return Alignment.bottomLeft;
      case 'bottomright': return Alignment.bottomRight;
      default: return null;
    }
  }

  EdgeInsets? _parseEdgeInsets(dynamic value) {
    return ThemeParser.parseEdgeInsets(value);
  }

  BoxDecoration? _parseBoxDecoration(dynamic value) {
    if (value == null || value is! Map) return null;
    
    return BoxDecoration(
      color: _parseColor(value['color']),
      borderRadius: ThemeParser.parseBorderRadius(value['borderRadius']),
      border: _parseBorder(value['border']),
    );
  }

  Border? _parseBorder(dynamic value) {
    if (value == null || value is! Map) return null;
    
    return Border.all(
      color: _parseColor(value['color']) ?? Colors.black,
      width: _parseDouble(value['width']) ?? 1.0,
    );
  }

  TextStyle? _parseTextStyle(dynamic value) {
    return ThemeParser.parseTextStyle(value);
  }


  TextAlign? _parseTextAlign(dynamic value) {
    if (value == null) return null;
    
    switch (value.toString().toLowerCase()) {
      case 'center': return TextAlign.center;
      case 'left': return TextAlign.left;
      case 'right': return TextAlign.right;
      case 'justify': return TextAlign.justify;
      default: return null;
    }
  }

  ButtonStyle? _parseButtonStyle(dynamic value) {
    return ThemeParser.parseButtonStyle(value);
  }

  Axis? _parseAxis(dynamic value) {
    if (value == null) return null;
    
    switch (value.toString().toLowerCase()) {
      case 'horizontal': return Axis.horizontal;
      case 'vertical': return Axis.vertical;
      default: return null;
    }
  }

  BoxFit? _parseBoxFit(dynamic value) {
    if (value == null) return null;
    
    switch (value.toString().toLowerCase()) {
      case 'cover': return BoxFit.cover;
      case 'contain': return BoxFit.contain;
      case 'fill': return BoxFit.fill;
      case 'fitwidth': return BoxFit.fitWidth;
      case 'fitheight': return BoxFit.fitHeight;
      default: return null;
    }
  }

  IconData? _parseIconData(dynamic value) {
    if (value == null) return null;
    
    switch (value.toString().toLowerCase()) {
      case 'home': return Icons.home;
      case 'settings': return Icons.settings;
      case 'person': return Icons.person;
      case 'search': return Icons.search;
      case 'favorite': return Icons.favorite;
      case 'add': return Icons.add;
      case 'delete': return Icons.delete;
      case 'edit': return Icons.edit;
      default: return Icons.help;
    }
  }
}
