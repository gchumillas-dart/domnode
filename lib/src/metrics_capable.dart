part of domnode;

/**
 * This class allows operating with metrics (width, heigt, etc...).
 */
abstract class MetricsCapable {
  List<Element> get elements;

  num getBorderHeight() =>
      _getSumPropertyValues(['border-top-width', 'border-bottom-width']);
  num getBorderWidth() =>
      _getSumPropertyValues(['border-left-width', 'border-right-width']);

  num getHeight() => _getSumPropertyValues(['height']);
  num getInnerHeight() => getHeight() + getPaddingHeight();

  num getInnerWidth() => getWidth() + getPaddingWidth();
  num getMarginHeight() =>
      _getSumPropertyValues(['margin-top', 'margin-bottom']);

  num getMarginWidth() =>
      _getSumPropertyValues(['margin-left', 'margin-right']);
  num getOuterHeight([bool includeMargin]) =>
      getInnerHeight() +
      getBorderHeight() +
      (includeMargin ? getMarginHeight() : 0);

  num getOuterWidth([bool includeMargin]) =>
      getInnerWidth() +
      getBorderWidth() +
      (includeMargin ? getMarginWidth() : 0);
  num getPaddingHeight() =>
      _getSumPropertyValues(['padding-top', 'padding-bottom']);

  num getPaddingWidth() =>
      _getSumPropertyValues(['padding-left', 'padding-right']);
  num getWidth() => _getSumPropertyValues(['width']);

  void setHeight(num value) {
    for (Element element in elements) {
      element.style.height = '${value}px';
    }
  }

  void setInnerHeight(num value) => setHeight(value - getPaddingHeight());
  void setInnerWidth(num value) => setWidth(value - getPaddingWidth());
  void setOuterHeight(num value, [bool includeMargin]) {
    setHeight(value -
        getPaddingHeight() -
        getBorderHeight() -
        (includeMargin ? getMarginHeight() : 0));
  }

  void setOuterWidth(num value, [bool includeMargin]) {
    setWidth(value -
        getPaddingWidth() -
        getBorderWidth() -
        (includeMargin ? getMarginWidth() : 0));
  }

  void setWidth(num value) {
    for (Element element in elements) {
      element.style.width = '${value}px';
    }
  }

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
