part of domnode;

/**
 * This class allows operating with CSS attributes.
 */
abstract class CssCapable {
  List<Element> get elements;

  void setCssAttr(String name, String value) {
    elements.forEach((Element element) {
      Map<String, String> attrs = getCssAttributeMap(element);

      attrs[name] = value;
      setCssAttributeMap(element, attrs);
    });
  }

  String getCssAttr(String name) {
    String ret = '';

    if (elements.length > 0) {
      Map<String, String> attrs = getCssAttributeMap(elements[0]);

      name = name.toLowerCase();
      if (attrs.containsKey(name)) {
        ret = attrs[name];
      }
    }

    return ret;
  }

  // TODO: rename method
  Map<String, String> getCssAttributeMap(Element element) {
    Map<String, String> ret = new Map<String, String>();
    String css = element.getAttribute('style');

    if (css != null) {
      css.split(';').forEach((String cssAttr) {
        List<String> item = cssAttr.split(':');
        String key = item.length > 0 ? item[0].trim().toLowerCase() : '';
        String value = item.length > 1 ? item[1].trim() : '';

        if (key.length > 0 && value.length > 0) {
          ret[key] = value;
        }
      });
    }

    return ret;
  }

  void setCssAttributeMap(Element element, Map<String, String> attrs) {
    List<String> arr = new List<String>();

    attrs.keys.forEach((String key) {
      if (key != null && key.length > 0) {
        arr.add(key.toLowerCase() + ': ' + attrs[key]);
      }
    });

    element.setAttribute('style', arr.join('; '));
  }
}
