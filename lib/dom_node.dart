part of domnode;

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
  NodeValidator _validator;
  NodeTreeSanitizer _sanitizer;
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
      this.setHtml(html);
    }

    if (callback != null) {
      Function.apply(callback, [this]);
    }
  }

  DomNode.fromDocument(Document doc,
      {NodeValidator validator, NodeTreeSanitizer sanitizer}) {
    if (validator == null && sanitizer == null) {
      sanitizer = new NullTreeSanitizer();
    }
    _validator = validator;
    _sanitizer = sanitizer;
    _elements = [doc.documentElement];
  }

  DomNode.fromElement(Element element,
      {NodeValidator validator, NodeTreeSanitizer sanitizer}) {
    if (validator == null && sanitizer == null) {
      sanitizer = new NullTreeSanitizer();
    }
    _validator = validator;
    _sanitizer = sanitizer;
    _elements = [element];
  }

  DomNode.fromList(List<Element> elements,
      {NodeValidator validator, NodeTreeSanitizer sanitizer}) {
    if (validator == null && sanitizer == null) {
      sanitizer = new NullTreeSanitizer();
    }
    _validator = validator;
    _sanitizer = sanitizer;
    _elements = elements;
  }

  DomNode.fromString(String str,
      {String type: 'text/xml',
      NodeValidator validator,
      NodeTreeSanitizer sanitizer}) {
    if (validator == null && sanitizer == null) {
      sanitizer = new NullTreeSanitizer();
    }
    _validator = validator;
    _sanitizer = sanitizer;

    // verifies that the XML document is well formed
    Parser parser = new xml.XmlParserDefinition().build();
    Result result = parser.parse(str);
    if (result.isFailure) {
      throw new ArgumentError(new ParserError(result).toString());
    }

    DomParser domParser = new DomParser();
    Document doc = domParser.parseFromString(str, type);
    _elements = [doc.documentElement];
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

  NodeTreeSanitizer get sanitizer => _sanitizer;

  NodeValidator get validator => _validator;

  String getData(String name) {
    return JSON.decode(getAttr(['data', name].join('-')));
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

  void setData(String name, Object value) {
    setAttr(['data', name].join('-'), JSON.encode(value));
  }

  String toString() {
    StringBuffer str = new StringBuffer();

    _elements.forEach((Element element) {
      str.write(node2str(element));
    });

    return str.toString();
  }
}
