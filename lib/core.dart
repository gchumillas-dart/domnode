import 'dart:html';
import 'node.dart';
export 'node.dart' show DomNode;

/**
 * Sugar syntax.
 *
 * Instead of creating a DomNode instance directly, you can use the
 * 'sugar syntax'. For example, the following lines are equivalent:
 *
 * var node = new DomNode('span', attributes: {'id': 'span_id'});
 * var node = $('span', attributes: {'id': 'span_id'});
 */
DomNode $(String nodeName,
        {Document context,
        Map<String, Object> attributes,
        Object text,
        Object html,
        void callback(DomNode target),
        NodeValidator validator,
        NodeTreeSanitizer sanitizer}) =>
    new DomNode(nodeName,
        context: context,
        attributes: attributes,
        text: text,
        html: html,
        callback: callback,
        validator: validator,
        sanitizer: sanitizer);

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
