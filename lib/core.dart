library domnode;

import 'dart:collection';
import 'dart:convert';
import 'dart:html';

import 'package:html_unescape/html_unescape.dart';
import 'package:petitparser/petitparser.dart';
import 'package:xml/xml.dart' as xml;

import 'src/utils.dart';

part 'dom_node.dart';
part 'src/attribute_capable.dart';
part 'src/class_capable.dart';
part 'src/content_capable.dart';
part 'src/css_capable.dart';
part 'src/event_capable.dart';
part 'src/metrics_capable.dart';
part 'src/null_tree_sanitizer.dart';

/// Creates a DomNode from a given [source] and, eventually, calls
/// the [callback] function.
DomNode $(Object source, [Callback callback]) {
  DomNode node;

  // creates a node from a given source
  if (source is String) {
    node = new DomNode.fromString(source);
  } else if (source is Element) {
    node = new DomNode.fromElement(source);
  } else if (source is Document) {
    node = new DomNode.fromDocument(source);
  } else if (source is DomNode) {
    node = source;
  } else {
    throw new ArgumentError(
        'Invalid argument: String|Element|Document|DomNode');
  }

  if (callback != null) {
    Function.apply(callback, [node]);
  }

  return node;
}

/// Searches the [cssSelectors] nodes from a [context].
DomNode query(String cssSelectors, [DomNode context]) {
  if (context == null) {
    context = new DomNode.fromDocument(document);
  }
  return context.query(cssSelectors);
}
