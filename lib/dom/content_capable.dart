part of dom_node;

/**
 * This class allows operating with inner contents.
 */
abstract class DomNodeContentCapable {
  List<Element> get elements;

  /**
   * Gets or sets inner html.
   */
  String html([Object value]) {
    if (value != null) {
      _setInnerHtml(value);
    }

    return _getInnerHtml();
  }

  /**
   * Gets or sets inner text.
   */
  String text([Object value]) {
    if (value != null) {
      _setInnerText(value);
    }

    return _getInnerText();
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
   * Appends content.
   */
  void append(Object obj) {
    elements.forEach((Element element) {
      element.insertAdjacentHtml('beforeend', obj.toString());
    });
  }

  /**
   * Prepends content.
   */
  void prepend(Object obj) {
    elements.forEach((Element element) {
      element.insertAdjacentHtml('afterbegin', obj.toString());
    });
  }

  /**
   * Gets inner html.
   */
  String _getInnerHtml() {
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
  void _setInnerHtml(Object value) {
    clean();
    elements.forEach((Element element) {
      element.appendHtml(value.toString());
    });
  }

  /**
   * Gets inner text.
   */
  String _getInnerText() {
    return elements.length > 0 ? elements[0].text : '';
  }

  /**
   * Sets inner text.
   */
  void _setInnerText(Object value) {
    clean();
    elements.forEach((Element element) {
      element.text = value.toString();
    });
  }
}
