import 'dart:html';
import 'dom/node.dart';
export 'dom/node.dart' show DomNode;

/**
 * Searches nodes by CSS selectors.
 */
DomNode domQuery(String cssSelectors, [Document doc]) {
  if (doc == null) {
    doc = document;
  }

  DomNode node = new DomNode.fromDocument(doc);
  return node.query(cssSelectors);
}
