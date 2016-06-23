part of domnode;

/**
 * This class allows operating with attributes.
 */
abstract class AttributeCapable {
  List<Element> get elements;

  bool hasAttr(String name) {
    return elements.length > 0 ? elements[0].getAttribute(name) != null : false;
  }

  // TODO: it should return a null element if the attribute does no exist
  String getAttr(String name) {
    String ret = '';

    if (elements.length > 0) {
      String attr = elements[0].getAttribute(name);

      if (attr != null) {
        ret = attr;
      }
    }

    return ret;
  }

  void setAttr(String name, Object value) {
    elements.forEach((Element element) {
      element.setAttribute(name, value.toString());
    });
  }
}
