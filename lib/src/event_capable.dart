part of domnode;

abstract class EventCapable {
  List<Element> get elements;

  void on(String type, EventListener listener) {
    for (Element element in elements) {
      element.addEventListener(type, listener);
    }
  }

  void off(String type, EventListener listener) {
    for (Element element in elements) {
      element.removeEventListener(type, listener);
    }
  }

  void trigger(Object type) {
    if (!(type is Event) && !(type is String)) {
      throw new ArgumentError('The \'type\' argument must be String or Event');
    }

    Event event = type is Event ? type : new Event(type.toString());
    for (Element element in elements) {
      element.dispatchEvent(event);
    }
  }
}
