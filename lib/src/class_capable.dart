part of dom_node;

/**
 * This class allows operating with CSS classes.
 */
abstract class ClassCapable {
  /**
   * Gets the internal elements.
   */
  List<Element> get elements;

  /**
   * Adds a class.
   */
  void addClass(String className) {
    elements.forEach((Element element) {
      List<String> classes = _getClassMap(element);

      if (!classes.contains(className)) {
        classes.add(className);
        _setClassMap(element, classes);
      }
    });
  }

  /**
   * Removes a class.
   */
  void removeClass(String className) {
    elements.forEach((Element element) {
      List<String> classes = _getClassMap(element);

      classes.remove(className);
      _setClassMap(element, classes);
    });
  }

  /**
   * Does the class exist?
   */
  bool hasClass(String className) {
    return elements.any((Element element) {
      List<String> classes = _getClassMap(element);

      return classes.contains(className);
    });
  }

  /**
   * Gets the list of classes.
   */
  List<String> _getClassMap(Element element) {
    List<String> ret = new List<String>();
    String classAttr = element.getAttribute('class');

    if (classAttr != null) {
      List<String> classes = classAttr.trim().split(new RegExp(r'\s+'));

      classes.forEach((String className) {
        if (className.length > 0 && !ret.contains(className)) {
          ret.add(className);
        }
      });
    }

    return ret;
  }

  /**
   * Sets a list of classes.
   */
  void _setClassMap(Element element, List<String> classes) {
    element.setAttribute('class', classes.join(' '));
  }
}
