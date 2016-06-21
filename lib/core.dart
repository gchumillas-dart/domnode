import 'dart:html';
import 'node.dart';
export 'node.dart' show DomNode;

/**
 * Searches nodes by CSS selectors.
 */
DomNode $(String cssSelectors, [Document doc]) {
  if (doc == null) {
    doc = document;
  }

  DomNode node = new DomNode.fromDocument(doc);
  return node.query(cssSelectors);
}
