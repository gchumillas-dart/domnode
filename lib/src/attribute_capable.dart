part of domnode;

/**
 * This class allows operating with attributes.
 */
abstract class AttributeCapable {
  /**
   * Gets the internal elements.
   */
  List<Element> get elements;

  /**
   * Does the attribute exist?
   */
  bool hasAttribute(String name) {
    return elements.length > 0 ? elements[0].getAttribute(name) != null : false;
  }

  /**
   * Gets an attribute.
   */
  String getAttribute(String name) {
    String ret = '';

    if (elements.length > 0) {
      String attr = elements[0].getAttribute(name);

      if (attr != null) {
        ret = attr;
      }
    }

    return ret;
  }

  /**
   * Sets an attribute.
   */
  void setAttribute(String name, Object value) {
    elements.forEach((Element element) {
      element.setAttribute(name, value.toString());
    });
  }
}
