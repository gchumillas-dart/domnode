part of domnode;

/**
 * This class allows operating with inner contents.
 */
abstract class ContentCapable {
  List<Element> get elements;

  /**
   * Gets inner html.
   */
  String get html {
    StringBuffer ret = new StringBuffer();

    if (elements.length > 0) {
      List<Node> nodes = elements[0].childNodes;

      nodes.forEach((Node node) {
        ret.write(node2str(node));
      });
    }

    return ret.toString();
  }

  /**
   * Sets inner html.
   */
  void set html(Object value) {
    empty();
    elements.forEach((Element element) {
      element.appendHtml(value.toString(),
          treeSanitizer: new NullTreeSanitizer());
    });
  }

  /**
   * Gets inner text.
   */
  String get text {
    HtmlUnescape decoder = new HtmlUnescape();
    return elements.length > 0 ? decoder.convert(elements[0].text) : '';
  }

  /**
   * Sets inner text.
   */
  void set text(Object value) {
    HtmlEscape encoder = new HtmlEscape();
    empty();
    elements.forEach((Element element) {
      element.text = encoder.convert(value.toString());
    });
  }

  /**
   * Appends content.
   */
  // TODO: obj can be either string|Element or DomNode object
  void append(Object /* DomNode|Object */ obj) {
    if (obj is DomNode) {
      elements.forEach((Element element) {
        obj.elements.forEach((Element node) {
          element.append(node);
        });
      });
    } else {
      elements.forEach((Element element) {
        element.insertAdjacentHtml('beforeend', obj.toString(),
            treeSanitizer: new NullTreeSanitizer());
      });
    }
  }

  /**
   * Removes all child nodes.
   */
  void empty() {
    elements.forEach((Element element) {
      while (element.hasChildNodes()) {
        element.firstChild.remove();
      }
    });
  }

  /**
   * Prepends content.
   */
  // TODO: obj can be a document or element
  // TODO: throw an ArgumentError when invalid obj
  void prepend(Object /* String|DomNode */ obj) {
    if (obj is DomNode) {
      elements.forEach((Element element) {
        obj.elements.forEach((Element node) {
          if (element.childNodes.length > 0) {
            Element firstChild = element.childNodes[0];
            element.insertBefore(node, firstChild);
          } else {
            element.append(node);
          }
        });
      });
    } else {
      elements.forEach((Element element) {
        element.insertAdjacentHtml('afterbegin', obj.toString(),
            treeSanitizer: new NullTreeSanitizer());
      });
    }
  }
}
