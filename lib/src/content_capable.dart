part of domnode;

/**
 * This class allows operating with inner contents.
 */
abstract class ContentCapable {
  List<Element> get elements;
  NodeTreeSanitizer get sanitizer;
  NodeValidator get validator;

  /**
   * Appends content.
   */
  void append(Object obj) {
    elements.forEach((Element element) {
      element.insertAdjacentHtml('beforeend', obj.toString(),
          validator: validator, treeSanitizer: sanitizer);
    });
  }

  /**
   * Removes all child nodes.
   */
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
          validator: validator, treeSanitizer: sanitizer);
    });
  }

  /**
   * Sets inner html.
   */
  void setHtml(Object value) {
    clean();
    elements.forEach((Element element) {
      element.appendHtml(value.toString(),
          validator: validator, treeSanitizer: sanitizer);
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
