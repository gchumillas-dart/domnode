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

/// This function has several uses:
///
/// * Searches for elements:
/// DomNode node = $('css selectors')
///
/// * Creates a node from a valid XML document
/// DomNode node = $('<span title="My SPAN">Some text...</span>');
///
/// * Creates a node from an element:
/// Element elem = document.querySelector('p');
/// DomNode node = $(elem);
///
/// * Creates a node from a document:
/// DomNode node = $(document);
///
/// * Redundant but programmatically useful:
/// DomNode target = new DomNode('span');
/// node = $(target);
/// assert(node == target);
DomNode $(dynamic /*css selectors | (Element | Document | DomNode) */ target,
    [dynamic /* Element | Document | DomNode */ context]) {
  DomNode ret;

  if (context == null) {
    context = document;
  }
  if (context != null &&
      !(context is Element || context is Document || context is DomNode)) {
    throw new ArgumentError('Invalid context');
  }

  if (target is String) {
    Parser parser = new xml.XmlParserDefinition().build();
    Result result = parser.parse(target);
    if (result.isSuccess) {
      // xml document
      ret = new DomNode.fromString(target);
    } else {
      // css selectors
      ret = $(context).query(target);
    }
  } else if (target is Element) {
    ret = new DomNode.fromElement(target);
  } else if (target is Document) {
    ret = new DomNode.fromDocument(target);
  } else if (target is DomNode) {
    ret = target;
  } else {
    throw new ArgumentError('Invalid target');
  }

  return ret;
}
