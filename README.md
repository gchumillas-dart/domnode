# DomNode

A client-side library to manipulate and traverse DOM objects in a easy and
intuitive way.

## How to install

Edit your pubspec.yaml file and add the `domnode` package:
```yaml
dependencies:
  domnode: any
```

Install dependencies:
```bash
> pub get
```

Import the library:
```dart
import 'package:domnode/core.dart';

void main() {
  // your code here
}
```

## Examples

### Getting elements from a document

`DomNode` is the main class of this library. It extends the `IterableBase`
class, which means that you can think of it as a single node or multiple nodes.
Use the `$` method to find elements. For example, consider the following code:

```dart
// gets a single node
DomNode node = $('h1');
if (node.length == 0) {
  print('Node not found');
}

// gests multiple nodes
Iterable<DomNode> nodes = $('p');
nodes.forEach((DomNode node) {
  print(node);
});
```

In both cases `$()` returns a `DomNode` object. But in the first case we
access a single node and in the second case we traverse multiple nodes.

### Events

```dart
EventListener listener = (Event e) {
  print('A ${e.type} event has been fired');
};

$('#id')
  // attaches an event listener
  ..on('click', listener)
  // fires an event
  ..trigger('click')
  // removes an event listener
  ..off('click', listener);
```

### Attributes

```dart
// gets an attribute
print($('a[id="anchor1"]').getAttr('href'));

// sets an attribute
$('a[id="anchor1"]').setAttr('title', 'New title');

// does the attribute exist?
assert($('a[id="anchor1"]').hasAttr('id'));
```

### CSS attributes

```dart
// gets a CSS attribute
print($('h1').getCssAttr('background-color'));

// sets a CSS attribute
$('h1').setCssAttr('background-color', 'yellow');
```

### CSS classes

```dart
// adds a class
$('h1').addClass('class1');

// removes a class
$('h1').removeClass('class1');

// adds or removes a class
$('h1').toggleClass('class1');

// does the class exist?
assert($('h1').hasClass('class1'));
```

### Inner contents

```dart
DomNode body = $('body');

// appends a new element
body.append('<p>New paragraph</p>');

// prepends a new element
body.prepend('<p>New paragraph at the beginning</p>');

// gets the inner text of a single element
print($('h1').getText());

// changes the inner text of a single element
$('h1').setText('New title');

// gets the inner html of a single element
print($('p[id="p1"]').getHtml());

// sets the inner html of a single element
$('p[id="p1"]').setHtml('This is text is <em>italic</em>');

// removes all childnodes of an element
$('div[id="div1"]').empty();
```

### Metrics
```dart
DomNode node = $('.myDiv');

// sets node size
node
  ..setWidth(640)
  ..setHeight(480);
print('width: ' + node.getWidth() + ', height: ' + node.getHeight());

// sets 'inner' size (includes padding size)
node
  ..setInnerWidth(640)
  ..setInnerHeight(480);

// sets 'outer' size (includes padding and border sizes)
node
  ..setOuterWidth(640)
  ..setOuterHeight(480);

// sets 'outer' size (includes padding, border and margin sizes)
node
  ..setOuterWidth(640, includeMargin: true)
  ..setOuterHeight(480, includMargin: true);
```

### Saving arbitrary data

```dart
// sets arbitrary data to an element
$('h1').setData('test', {'one': 1, 'two': 2, 'three': 3});

// gets data from an element
print($('h1').getData('test'));
```

### Creating instances from a given source
```dart
// creates an instance from a string
DomNode node = new DomNode.fromString(
    '<root><item id="1" /><item id="2" /><item id="3" /></root>');
print(node);

// creates an instance from a document
DomNode node = new DomNode.fromDocument(myDocument);
print(node);

// creates an instance from a DOM element
DomNode node = new DomNode.fromElement(myElement);
```

### Creating nodes from scratch

```dart
// creates a span and appends it to the body
DomNode node = new DomNode('span',
    attrs: {'id': 'span_id', 'title': 'Span Title'}, text: 'Some text here');
$('body').append(node);

// creates a complex node
DomNode node = new DomNode('root', callback: (DomNode target) {
  // apends a new node with childNodes
  target.append(new DomNode('user', callback: (DomNode target) {
    target.append(new DomNode('first-name', text: 'James'));
    target.append(new DomNode('last-name', text: 'Bond'));
    target.append(new DomNode('age', text: 158));
    target.append(
      new DomNode('bio', html: 'My name is Bond, <em>James Bond</em>'));
  }));

  // appends more items
  target.append(new DomNode('item', attrs: {'id': '101', 'title': 'Item 1'}));
  target.append(new DomNode('item', attrs: {'id': '102', 'title': 'Item 2'}));
  target.append(new DomNode('item', attrs: {'id': '103', 'title': 'Item 3'}));

  // prepends raw content
  target.prepend('<summary>Look at my horse, my horse is amazing</summary>');
});
print(node);
```
