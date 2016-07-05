part of domnode;
// TODO: simplify the '$' function
// TODO: add a 'query' function
// TODO: setters and getters

typedef void Callback(DomNode target);

/**
 * This class represents one or more DOM elements.
 */
class DomNode extends IterableBase<DomNode>
    with
        AttributeCapable,
        CssCapable,
        ClassCapable,
        ContentCapable,
        EventCapable,
        MetricsCapable {
  List<Element> _elements = [];
  DomNode(String nodeName,
      {Map<String, Object> attrs,
      Object text,
      Object html,
      Callback callback}) {
    Element elem = document.createElement(nodeName);
    _elements.add(elem);

    if (attrs != null) {
      attrs.forEach((String name, Object value) {
        this.attr[name] = value;
      });
    }

    if (text != null) {
      this.text = text;
    }

    if (html != null) {
      this.html = html;
    }

    if (callback != null) {
      Function.apply(callback, [this]);
    }
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

  // TODO: we do not need 'type' (or replace it by isXml)
  DomNode.fromString(String str, {String type: 'text/xml'}) {
    // verifies that the XML document is well formed
    Parser parser = new xml.XmlParserDefinition().build();
    Result result = parser.parse(str);
    if (result.isFailure) {
      throw new ArgumentError(new ParserError(result).toString());
    }

    DocumentFragment fragment = document.createDocumentFragment();
    fragment.appendHtml(str, treeSanitizer: new NullTreeSanitizer());
    _elements = new List<Element>.from(fragment.children);
  }

  List<Element> get elements => this._elements;

  Iterator<DomNode> get iterator {
    List<DomNode> ret = new List<DomNode>();
    int len = _elements.length;

    for (int i = 0; i < len; i++) {
      ret.add(new DomNode.fromElement(_elements[i]));
    }

    return ret.iterator;
  }

  String get name {
    return _elements.length > 0 ? _elements[0].nodeName : '';
  }

  DomNode get parent {
    return _elements.length > 0
        ? new DomNode.fromElement(_elements[0].parent)
        : null;
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
