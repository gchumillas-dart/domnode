import 'dart:html';

import 'dom_node.dart';

export 'dom_node.dart' show DomNode;

/**
 * Searches nodes by CSS selectors.
 */
DomNode $(String cssSelectors) {
  DomNode node = new DomNode.fromDocument(document);
  return node.query(cssSelectors);
}
