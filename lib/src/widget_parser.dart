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
        ? () => actionHandler?.call('custom', {'code': onPressedMatch.group(1)})
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

  Color? _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'yellow': return Colors.yellow;
      case 'orange': return Colors.orange;
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
