part of domnode;

/**
 * This class allows operating with attributes.
 */
abstract class AttributeCapable {
  Map<String, Object> get attr => new _AttrManager(this);

  List<Element> get elements;
}

class _AttrManager extends MapBase<String, Object> {
  final DomNode _target;

  _AttrManager(this._target);

  Iterable<String> get keys {
    Iterable<String> ret = null;
    for (Element element in _target.elements) {
      ret = element.attributes.keys;
      break;
    }
    return ret;
  }

  String operator [](Object key) {
    String ret = null;
    for (Element element in _target.elements) {
      ret = element.getAttribute(key.toString());
      break;
    }
    return ret;
  }

  void operator []=(String key, Object value) {
    for (Element element in _target.elements) {
      element.setAttribute(key, value.toString());
    }
  }

  void clear() {
    for (Element element in _target.elements) {
      element.attributes.clear();
    }
  }

  String remove(Object key) {
    String ret = null;
    for (Element element in _target.elements) {
      ret = element.attributes.remove(key.toString());
    }
    return ret;
  }
}
