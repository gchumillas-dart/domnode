import 'package:domnode/core.dart';

void main() {
  // accessing a single element
  query('h1')
    ..attr['title'] = 'This is my title'
    ..css['border'] = '1px solid black'
    ..text = 'Changing title';

  // accessing multiple elements
  Iterable<DomNode> paragraphs = query('p');
  paragraphs.forEach((DomNode item) {
    item.html = '<strong>Paragraph</strong>';
  });

  // appends content
  query('p:last-child')
      .append('<br><em>content added to the last paragraph.</em>');
}
