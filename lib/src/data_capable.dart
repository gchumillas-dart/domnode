part of domnode;

/**
 * This class allows operating with arbitrary data.
 */
abstract class DataCapable extends AttributeCapable {
  String getData(String name) {
    return JSON.decode(getAttr(['data', name].join('-')));
  }

  void setData(String name, Object value) {
    setAttr(['data', name].join('-'), JSON.encode(value));
  }
}
