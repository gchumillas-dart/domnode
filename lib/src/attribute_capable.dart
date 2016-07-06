part of domnode;

/**
 * This class allows operating with attributes.
 */
abstract class AttributeCapable {
  Map<String, Object> get attr => new _AttrManager(this);

  set attr(Map<String, Object> value) {
    attr.clear();
    value.forEach((String key, Object value) {
      attr[key] = value;
    });
  }

  Map<String, Object> get data => new _DataManager(this);

  set data(Map<String, Object> value) {
    data.clear();
    value.forEach((String key, Object value) {
      data[key] = value;
    });
  }

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

class _DataManager extends _AttrManager {
  _DataManager(DomNode target) : super(target);

  Iterable<String> get keys {
    return super
        .keys
        .where((String key) => key.startsWith('data-'))
        .map((String key) => key.replaceFirst('data-', ''));
  }

  String operator [](Object key) {
    String value = super[['data', key].join('-')];
    return value != null ? JSON.decode(value) : null;
  }

  void operator []=(String key, Object value) {
    super[['data', key].join('-')] = JSON.encode(value);
  }

  void clear() {
    for (Element element in _target.elements) {
      element.attributes.keys
          .where((String key) => key.startsWith('data-'))
          .forEach((String key) => element.attributes.remove(key));
    }
  }

  String remove(Object key) {
    return super.remove(['data', key].join('-'));
  }
}
