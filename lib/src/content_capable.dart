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
  void append(Object /* Element|DomNode|String */ obj) {
    if (obj is! Element && obj is! DomNode && obj is! String) {
      throw new ArgumentError(
          'Allowed values for \'obj\' are: Element|DomNode|String');
    }

    DomNode node = $(obj);
    elements.forEach((Element element) {
      element.insertAdjacentHtml('beforeend', node.toString(),
          treeSanitizer: new NullTreeSanitizer());
    });
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
  void prepend(Object /* Element|DomNode|Object */ obj) {
    if (obj is! Element && obj is! DomNode && obj is! String) {
      throw new ArgumentError(
          'Allowed values for \'obj\' are: Element|DomNode|String');
    }

    DomNode node = $(obj);
    elements.forEach((Element element) {
      element.insertAdjacentHtml('afterbegin', node.toString(),
          treeSanitizer: new NullTreeSanitizer());
    });
  }
}
