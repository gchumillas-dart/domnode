library domnode;

import 'dart:collection';
import 'dart:convert';
import 'dart:html';
import 'src/utils.dart';
part 'src/attribute_capable.dart';
part 'src/class_capable.dart';
part 'src/content_capable.dart';
part 'src/css_capable.dart';
part 'src/metrics_capable.dart';
part 'src/null_tree_sanitizer.dart';

/**
 * This class represents one or more DOM elements.
 */
class DomNode extends IterableBase<DomNode>
    with
        AttributeCapable,
        CssCapable,
        ClassCapable,
        ContentCapable,
        MetricsCapable {
  List<Element> _elements = [];
  NodeValidator _validator;
  NodeTreeSanitizer _sanitizer;
  List<Element> get elements => this._elements;
  NodeValidator get validator => _validator;
  NodeTreeSanitizer get sanitizer => _sanitizer;

  DomNode(String nodeName,
      {Map<String, Object> attrs,
      Object text,
      Object html,
      void callback(DomNode target),
      NodeValidator validator,
      NodeTreeSanitizer sanitizer}) {
    if (validator == null && sanitizer == null) {
      sanitizer = new NullTreeSanitizer();
    }

    _validator = validator;
    _sanitizer = sanitizer;

    Element elem = document.createElement(nodeName);
    _elements.add(elem);

    if (attrs != null) {
      attrs.forEach((String name, Object value) {
        setAttr(name, value);
      });
    }

    if (text != null) {
      this.setText(text);
    }

    if (html != null) {
      this.html = html;
    }

    if (callback != null) {
      Function.apply(callback, [this]);
    }
  }

  DomNode.fromString(String str, [String contentType = 'text/xml']) {
    DomParser parser = new DomParser();
    Document doc = parser.parseFromString(str, contentType);

    _elements = [doc.documentElement];
  }

  DomNode.fromDocument(Document doc) {
    _elements = [doc.documentElement];
  }

  DomNode.fromElement(Element element) {
    _elements = [element];
  }

  DomNode.fromList(List<Element> elements) {
    _elements = elements;
  }

  Iterator<DomNode> get iterator {
    List<DomNode> ret = new List<DomNode>();
    int len = _elements.length;

    for (int i = 0; i < len; i++) {
      ret.add(new DomNode.fromElement(_elements[i]));
    }

    return ret.iterator;
  }

  /**
   * Searches elements by CSS selectors.
   */
  DomNode query(String selectors) {
    List<Element> elements = new List<Element>();

    _elements.forEach((Element element) {
      ElementList<Element> items = element.querySelectorAll(selectors);

      items.forEach((Element item) {
        if (!elements.contains(item)) {
          elements.add(item);
        }
      });
    });

    return new DomNode.fromList(elements);
  }

  /**
   * Gets the node name.
   */
  String getName() {
    return _elements.length > 0 ? _elements[0].nodeName : '';
  }

  DomNode getParent() {
    return _elements.length > 0
        ? new DomNode.fromElement(_elements[0].parent)
        : null;
  }

  String getData(String name) {
    return JSON.decode(getAttr(['data', name].join('-')));
  }

  void setData(String name, Object value) {
    setAttr(['data', name].join('-'), JSON.encode(value));
  }

  void remove() {
    while (_elements.length > 0) {
      Element element = _elements.removeLast();

      element.remove();
    }
  }

  String toString() {
    StringBuffer str = new StringBuffer();

    _elements.forEach((Element element) {
      str.write(node2str(element));
    });

    return str.toString();
  }
}
