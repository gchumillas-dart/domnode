part of domnode;

/**
 * This class allows operating with metrics (width, heigt, etc...).
 */
abstract class MetricsCapable {
  List<Element> get elements;

  num getWidth() => _getSumPropertyValues(['width']);
  void setWidth(num value) {
    for (Element element in elements) {
      element.style.width = '${value}px';
    }
  }

  num getHeight() => _getSumPropertyValues(['height']);
  void setHeight(num value) {
    for (Element element in elements) {
      element.style.height = '${value}px';
    }
  }

  num getInnerWidth() => getWidth() + getPaddingWidth();
  void setInnerWidth(num value) => setWidth(value - getPaddingWidth());

  num getInnerHeight() => getHeight() + getPaddingHeight();
  void setInnerHeight(num value) => setHeight(value - getPaddingHeight());

  num getOuterWidth([bool includeMargin]) =>
      getInnerWidth() +
      getBorderWidth() +
      (includeMargin ? getMarginWidth() : 0);
  void setOuterWidth(num value, [bool includeMargin]) {
    setWidth(value -
        getPaddingWidth() -
        getBorderWidth() -
        (includeMargin ? getMarginWidth() : 0));
  }

  num getOuterHeight([bool includeMargin]) =>
      getInnerHeight() +
      getBorderHeight() +
      (includeMargin ? getMarginHeight() : 0);
  void setOuterHeight(num value, [bool includeMargin]) {
    setHeight(value -
        getPaddingHeight() -
        getBorderHeight() -
        (includeMargin ? getMarginHeight() : 0));
  }

  num getPaddingWidth() =>
      _getSumPropertyValues(['padding-left', 'padding-right']);
  num getPaddingHeight() =>
      _getSumPropertyValues(['padding-top', 'padding-bottom']);
  num getBorderWidth() =>
      _getSumPropertyValues(['border-left-width', 'border-right-width']);
  num getBorderHeight() =>
      _getSumPropertyValues(['border-top-width', 'border-bottom-width']);
  num getMarginWidth() =>
      _getSumPropertyValues(['margin-left', 'margin-right']);
  num getMarginHeight() =>
      _getSumPropertyValues(['margin-top', 'margin-bottom']);

  num _getSumPropertyValues(List<String> propertyNames) {
    num ret = 0;

    for (Element element in elements) {
      CssStyleDeclaration style = element.getComputedStyle();
      for (String propertyName in propertyNames) {
        ret += _pixelToNum(style.getPropertyValue(propertyName));
      }
      break;
    }

    return ret;
  }

  num _pixelToNum(String pixels) {
    return pixels.length > 0
        ? num.parse(pixels.replaceAll(new RegExp(r'px$'), ''))
        : 0;
  }
}
