# DomNode

A client-side library to manipulate and traverse DOM objects in a easy and intuitive way. This library does not pretend to be a replacement for the DOM library but, in many cases, it can drastically simplify the code.

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

`DomNode` is the main class of this library. It extends the `IterableBase` class, which means that you can think of it as if it were a single element or multiple elements. Use the `query` method to select zero, one or more elements. For example, consider the following code:

```dart
// gets a single node
var node = query('h1');
if (node.length == 0) {
  print('Node not found');
}

// gests multiple nodes
var nodes = query('p');
nodes.forEach((node) {
  print(node);
});
```

### Events

Note that in the following example we are hidding the `query` function from the `dart:html` library to prevent collisions.

```dart
import 'dart:html' hide query;
import 'package:domnode/core.dart';

void main() {
  var listener = (Event e) {
    print('A ${e.type} event has been fired');
  };

  query('#id')
    // attaches an event listener
    ..on('click', listener)
    // fires an event
    ..trigger('click')
    // removes an event listener
    ..off('click', listener);
}
```

### Attributes

```dart
var node = query('#id');

// gets an attribute
print(node.attr['href']);

// sets an attribute
node.attr['title'] = 'New title';

// does the attribute exist?
assert(node.attr['id'] == null);

// removes an attribute
node.attr.remove('id');
```

### CSS attributes

```dart
var node = query('#id');

// gets a CSS attribute
print(query('h1').css['background-color']);

// sets a CSS attribute
node.css['background-color'] = 'yellow';

// does a CSS attribute exist?
assert(node.css['background-color'] != null);

// removes a CSS attribute
node.css.remove('background-color');
```

### CSS classes

```dart
var node = query('#id');

// adds a class
node.addClass('class1');

// removes a class
node.removeClass('class1');

// does the class exist?
assert(node.hasClass('class1'));

// adds or removes a class
node.toggleClass('class1');
```

### Inner contents

```dart
var body = query('body');
var node = query('#id');

// appends a new element
body.append('<p>New paragraph</p>');

// prepends a new element
body.prepend('<p>New paragraph at the beginning</p>');

// gets the inner text of a single element
print(node.text);

// changes the inner text of a single element
node.text = 'New title';

// gets the inner html of a single element
print(node.html);

// sets the inner html of a single element
node.html = 'This is text is <em>italic</em>';

// removes all childnodes of an element
node.empty();
```

### Metrics
```dart
DomNode node = query('.myDiv');

// sets node size
node
  ..width = 640
  ..height = 480;
print('width: ${node.width}, height: ${node.height}');

// border size
print('border width ${node.borderWidth}, ' +
    'border height: ${node.borderHeight}');

// padding size
print('padding width ${node.paddingWidth}, ' +
    'padding height: ${node.paddingHeight}');

// margin size
print('margin width ${node.marginWidth}, ' +
    'margin height: ${node.marginHeight}');
```

### Saving arbitrary data

```dart
var node = query('#id');

// sets arbitrary data to an element
node.data['test'] = {'one': 1, 'two': 2, 'three': 3};

// gets data from an element
print(node.data['test']);
```

### Creating instances from a given source

You can use the `$` function to create instances from different sources.

```dart
// creates an instance from a string
var node1 =
    $('<root><item id="1" /><item id="2" /><item id="3" /></root>');
print(node1);

// creates an instance from a document
var node2 = $(document);
print(node2);

// creates an instance from a DOM element
var element = document.querySelector('h1');
DomNode node3 = $(element);
print(node3);
```

### Creating nodes from scratch

Note the intensive use of the `$` function.

```dart
// creates a span and appends it to the body
query('body').append($('<span />')
  ..attr['id'] = 'span_id'
  ..attr['title'] = 'Span title'
  ..text = 'Some text here');

// creates a complex node
var node = $('<root />', (target) {
  // apends a new node with childNodes
  target.append($('<user />', (DomNode target) {
    target.append($('<first-name />')..text = 'James');
    target.append($('<last-name />')..text = 'Bond');
    target.append($('<age />')..text = 158);
    target
        .append($('<bio />')..html = 'My name is Bond, <em>James Bond</em>');
  }));

  // appends three subitems
  for (var i = 0; i < 3; i++) {
    target.append($('<item />')
      ..attr['id'] = 'item_${i}'
      ..attr['title'] = 'Item ${i}');
  }

  // prepends raw content
  target.prepend('<summary>Look at my horse, my horse is amazing</summary>');
});
print(node);
```
