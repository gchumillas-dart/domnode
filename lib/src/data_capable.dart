part of domnode;

/**
 * This class allows operating with arbitrary data.
 */
abstract class DataCapable {
  /**
   * Data namespace.
   */
  static const String _NAMESPACE = '__dartQuery__';

  /**
   * Gets the internal elements.
   */
  List<Element> get elements;

  /**
   * Gets or sets data.
   */
  Object data(String name, [Object value]) {
    if (value != null) {
      _setData(name, value);
    }

    return _getData(name);
  }

  /**
   * Gets arbitrary data from an element.
   */
  Map<String, dynamic> _getDataObject(Element element) {
    String attr = element.getAttribute(_NAMESPACE);
    dynamic data = attr != null ? JSON.decode(attr) : {};

    return data as Map<String, dynamic>;
  }

  /**
   * Sets arbitrary data into an element.
   */
  void _setDataObject(Element element, Map<String, dynamic> data) {
    element.setAttribute(_NAMESPACE, JSON.encode(data));
  }

  /**
   * Gets arbitrary data.
   */
  Object _getData(String name) {
    String str = null;

    if (elements.length > 0) {
      Map<String, dynamic> data = _getDataObject(elements[0]);

      if (data.containsKey(name)) {
        str = data[name];
      }
    }

    return str;
  }

  /**
   * Sets arbitrary data.
   */
  void _setData(String name, Object value) {
    elements.forEach((Element element) {
      Map<String, dynamic> data = _getDataObject(element);

      data[name] = value;
      _setDataObject(element, data);
    });
  }
}
