# DomNode

A library to easily traverse and manipulate DOM documents. It is inspired on the jQuery philosophy.

## How to install

Add this to your package's pubspec.yaml file:
```text
dependencies:
  domnode: ">=1.0.0 <2.0.0"
```

You can install packages from the command line:
```bash
pub get
```

Now in your Dart code, you can use:
```dart
import 'package:domnode/core.dart';

void main() {
  // your code here
}
```

## Examples

### Getting elements from a document

The main class of this library is the `DomNode` class. `DomNode` extends the `IterableBase` class. That means that you can think of it as either a single object or a list of object. For example, consider the following code:

```dart
// gets a single element
var title = domQuery('h1');

// gests multiple elements
var items = domQuery('p');
items.forEach((item) {
  print(item);
});
```

In both cases, the `domQuery` function returns a `DomNode` object. But in the first case, we are using it to access a single element and in the other case we are accessing multiple elements.

### Attributes

```dart
// gets an attribute
print(domQuery('a[id="anchor1"]').attr('href'));

// sets an attribute
domQuery('a[id="anchor1"]').attr('title', 'New title');

// does the attribute exist?
assert(domQuery('a[id="anchor1"]').hasAttr('id'))
```

### CSS attributes

```dart
// gets a CSS attribute
print(domQuery('h1').css('background-color'));

// sets a CSS attribute
domQuery('h1').css('background-color', 'yellow');
```

### CSS classes

```dart
// adds a class
domQuery('h1').addClass('class1');

// removes a class
domQuery('h1').removeClass('class1');

// does the class exist?
assert(domQuery('h1').hasClass('class1'));
```

### Inner contents

```dart
var body = domQuery('body');

// appends a new element
body.append('<p>New paragraph</p>');

// prepends a new element
body.prepend('<p>New paragraph at the beginning</p>');

// gets the inner text of a single element
print(domQuery('h1').text());

// changes the inner text of a single element
domQuery('h1').text('New title');

// gets the inner html of a single element
print(domQuery('p[id="p1"]').html());

// sets the inner html of a single element
domQuery('p[id="p1"]').html('This is text is <em>italic</em>');

// removes all childnodes of an element
domQuery('div[id="div1"]').clean();
```

### Saving arbitrary data

```dart
// saves arbitrary data in an element
domQuery('h1').data('my-array', [1, 2, 3, 4]);

// retrieves data from an element
print(domQuery('h1').data('my-array'));
```

### Creating instances from a given source
```dart
// creates an instance from a string
var node = new DomNode.fromString('<root><item id="1" /><item id="2" /><item id="3" /></root>');
print(node);

// creates an instance from a document
var node = new DomNode.fromDocument(myDocument);
print(node);

// creates an instance from a DOM element
var node = new DomNode.fromElement(myElement)
```

### Creating documents from scratch
```dart
var node = new DomNode('root', callback: (DomNode target) {
  // apends a new node with childNodes
  target.append(new DomNode('user', callback: (DomNode target) {
    target.append(new DomNode('first-name', text: 'James'));
    target.append(new DomNode('last-name', text: 'Bond'));
    target.append(new DomNode('age', text: 158));
    target.append(new DomNode('bio', html: 'My name is Bond, <em>James Bond</em>'));
  }));

  // appends more items
  target.append(new DomNode('item', attributes: {'id': 101, 'title': 'Item 1'}));
  target.append(new DomNode('item', attributes: {'id': 102, 'title': 'Item 2'}));
  target.append(new DomNode('item', attributes: {'id': 103, 'title': 'Item 3'}));

  // appends raw content
  target.append('<summary>Look at my horse, my horse is amazing</summary>');
});
print(node);
```
