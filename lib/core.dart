import 'dart:html';

import 'node.dart';

export 'node.dart' show DomNode;

/**
 * Searches nodes by CSS selectors.
 */
DomNode $(String cssSelectors) {
  DomNode node = new DomNode.fromDocument(document);
  return node.query(cssSelectors);
}
