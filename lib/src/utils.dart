import 'dart:convert';
import 'dart:html';

/**
 * Gets a string representation of [node].
 */
String node2str(Node node) {
  StringBuffer str = new StringBuffer();

  if (node is Text) {
    str.write(node.text);
  } else if (node is Comment) {
    str.write('<!--${node.text}-->');
  } else if (node is Element) {
    HtmlEscape escape = const HtmlEscape(HtmlEscapeMode.ATTRIBUTE);
    String tagName = node.nodeName.toLowerCase();

    str.write('<$tagName');

    node.attributes.forEach((String attrName, String value) {
      str.write(' $attrName="${escape.convert(value)}"');
    });

    if (node.childNodes.length > 0) {
      str.write('>');

      node.childNodes.forEach((Node item) {
        str.write(node2str(item));
      });

      str.write('</$tagName>');
    } else {
      str.write(' />');
    }
  }

  return str.toString();
}
