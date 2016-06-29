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

  void trigger(String type) {
    for (Element element in elements) {
      element.dispatchEvent(new Event(type));
    }
  }
}
