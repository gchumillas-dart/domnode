part of domnode;

/**
 * This class allows operating with attributes.
 */
abstract class AttributeCapable {
  List<Element> get elements;

  bool hasAttr(String name) {
    return elements.length > 0 ? elements[0].getAttribute(name) != null : false;
  }

  String getAttr(String name) {
    return elements.length > 0 ? elements[0].getAttribute(name) : null;
  }

  void setAttr(String name, Object value) {
    elements.forEach((Element element) {
      element.setAttribute(name, value.toString());
    });
  }
}
