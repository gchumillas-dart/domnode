part of domnode;

/**
 * This class allows operating with attributes.
 */
abstract class AttributeCapable {
  List<Element> get elements;

  String getAttr(String name) {
    return elements.length > 0 ? elements[0].getAttribute(name) : '';
  }

  bool hasAttr(String name) {
    return elements.length > 0 ? elements[0].getAttribute(name) != null : false;
  }

  void removeAttr(String name) {
    elements.forEach((Element element) {
      element.attributes.remove(name);
    });
  }

  void setAttr(String name, Object value) {
    elements.forEach((Element element) {
      element.setAttribute(name, value.toString());
    });
  }
}
