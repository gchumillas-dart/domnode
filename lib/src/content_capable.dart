part of domnode;

/**
 * This class allows operating with inner contents.
 */
abstract class ContentCapable {
  List<Element> get elements;

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
  // TODO: replace 'clean' by 'empty'
  void clean() {
    elements.forEach((Element element) {
      while (element.hasChildNodes()) {
        element.firstChild.remove();
      }
    });
  }

  /**
   * Gets inner html.
   */
  String getHtml() {
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
   * Gets inner text.
   */
  String getText() {
    HtmlUnescape decoder = new HtmlUnescape();
    return elements.length > 0 ? decoder.convert(elements[0].text) : '';
  }

  /**
   * Prepends content.
   */
  void prepend(Object obj) {
    elements.forEach((Element element) {
      element.insertAdjacentHtml('afterbegin', obj.toString(),
          treeSanitizer: new NullTreeSanitizer());
    });
  }

  /**
   * Sets inner html.
   */
  void setHtml(Object value) {
    clean();
    elements.forEach((Element element) {
      element.appendHtml(value.toString(),
          treeSanitizer: new NullTreeSanitizer());
    });
  }

  /**
   * Sets inner text.
   */
  void setText(Object value) {
    HtmlEscape encoder = new HtmlEscape();
    clean();
    elements.forEach((Element element) {
      element.text = encoder.convert(value.toString());
    });
  }
}
