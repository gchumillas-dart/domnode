part of domnode;

/**
 * This class allows operating with CSS attributes.
 */
abstract class CssCapable {
  Map<String, Object> get css => new _CssAttrManager(this);

  List<Element> get elements;
}

class _CssAttrManager extends MapBase<String, Object> {
  final DomNode _target;

  _CssAttrManager(this._target);

  Iterable<String> get keys {
    Iterable<String> ret;
    for (Element element in _target.elements) {
      Map<String, String> attrs = _getCssAttrMap(element);
      ret = attrs.keys;
      break;
    }
    return ret;
  }

  String operator [](Object key) {
    String ret;
    for (Element element in _target.elements) {
      Map<String, String> attrs = _getCssAttrMap(element);
      ret = attrs[key.toString()];
      break;
    }
    return ret;
  }

  void operator []=(String key, Object value) {
    for (Element element in _target.elements) {
      Map<String, String> attrs = _getCssAttrMap(element);
      attrs[key] = value.toString();
      _setCssAttrMap(element, attrs);
    }
  }

  void clear() {
    for (Element element in _target.elements) {
      _setCssAttrMap(element, {});
    }
  }

  String remove(Object key) {
    String ret = null;
    for (Element element in _target.elements) {
      Map<String, String> attrs = _getCssAttrMap(element);
      ret = attrs.remove(key.toString());
      _setCssAttrMap(element, attrs);
    }
    return ret;
  }

  // TODO: si el atributo no existe, debería devolver null
  Map<String, String> _getCssAttrMap(Element element) {
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

  void _setCssAttrMap(Element element, Map<String, String> attrs) {
    List<String> arr = [];

    attrs.keys.forEach((String key) {
      if (key != null && key.length > 0) {
        arr.add(key.toLowerCase() + ': ' + attrs[key]);
      }
    });

    element.setAttribute('style', arr.join('; '));
  }
}
