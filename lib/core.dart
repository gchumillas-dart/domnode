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

/**
 * Searches nodes by CSS selectors.
 */
DomNode $(String cssSelectors) {
  DomNode node = new DomNode.fromDocument(document);
  return node.query(cssSelectors);
}
