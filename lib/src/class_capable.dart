part of domnode;

/**
 * This class allows operating with CSS classes.
 */
abstract class ClassCapable {
  List<Element> get elements;

  void addClass(String className) {
    elements.forEach((Element element) {
      List<String> classes = _getClassMap(element);

      if (!classes.contains(className)) {
        classes.add(className);
        _setClassMap(element, classes);
      }
    });
  }

  void toggleClass(String className) {
    hasClass(className) ? removeClass(className) : addClass(className);
  }

  void removeClass(String className) {
    elements.forEach((Element element) {
      List<String> classes = _getClassMap(element);

      classes.remove(className);
      _setClassMap(element, classes);
    });
  }

  bool hasClass(String className) {
    return elements.any((Element element) {
      List<String> classes = _getClassMap(element);

      return classes.contains(className);
    });
  }

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

  void _setClassMap(Element element, List<String> classes) {
    element.setAttribute('class', classes.join(' '));
  }
}
