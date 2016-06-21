import 'package:domnode/core.dart';

void main() {
  DomNode span = $('span', text: 'This is a text')
    ..setAttribute('ups', 'lol')
    ..html('<custom-component></custom-component>')
    ..append('<lalala></lalala>')
    ..prepend('<ups>jejeje</ups>');
  print(span);
  /*
  Iterable<DomNode> node = $('root', callback: (DomNode target) {
    // apends a new node with childNodes
    target.append($('user', callback: (DomNode target) {
      target.append($('first-name', text: 'James'));
      target.append($('last-name', text: 'Bond'));
      target.append($('age', text: 158));
      target.append($('bio', html: 'My name is Bond, <em>James Bond</em>'));
    }));

    // appends more items
    target.append($('item', attributes: {'id': 101, 'title': 'Item 1'}));
    target.append($('item', attributes: {'id': 102, 'title': 'Item 2'}));
    target.append($('item', attributes: {'id': 103, 'title': 'Item 3'}));

    // appends raw content
    target.append('<summary>Look at my horse, my horse is amazing</summary>');
  });
  print(node);*/
  /*
  // accessing a single element
  domQuery('h1')
    ..text('Changing title')
    ..css('border', '1px solid black');

  // accessing multiple elements
  DomNode paragraphs = domQuery('p');
  paragraphs.forEach((DomNode item) {
    item.html('<strong>Paragraph</strong>');
  });

  // appends content
  domQuery('p:last-child')
      .append('<span>content added to the last paragraph.</span>');*/
}
