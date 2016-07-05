import 'package:domnode/core.dart';

void main() {
  // accessing a single element
  q('h1')
    ..setAttr('title', 'This is my title')
    ..text = 'Changing title'
    ..setCssAttr('border', '1px solid black');
  q('h1').text = 'title';

  // accessing multiple elements
  Iterable<DomNode> paragraphs = q('p');
  paragraphs.forEach((DomNode item) {
    item.html = '<strong>Paragraph</strong>';
  });

  // appends content
  q('p:last-child').append('<br><em>content added to the last paragraph.</em>');
}
