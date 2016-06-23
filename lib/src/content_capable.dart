part of domnode;

/**
 * This class allows operating with inner contents.
 */
abstract class ContentCapable {
  NodeValidator get validator;
  NodeTreeSanitizer get sanitizer;
  List<Element> get elements;

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
   * Appends content.
   */
  void append(Object obj) {
    elements.forEach((Element element) {
      element.insertAdjacentHtml('beforeend', obj.toString(),
          validator: validator, treeSanitizer: sanitizer);
    });
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
    clean();
    elements.forEach((Element element) {
      element.appendHtml(value.toString(),
          validator: validator, treeSanitizer: sanitizer);
    });
  }

  /**
   * Gets inner text.
   */
  String getText() {
    return elements.length > 0 ? elements[0].text : '';
  }

  /**
   * Sets inner text.
   */
  void setText(Object value) {
    clean();
    elements.forEach((Element element) {
      element.text = value.toString();
    });
  }
}
