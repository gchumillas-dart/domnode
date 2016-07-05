import 'package:domnode/core.dart';

void main() {
  DomNode root = a('<a href="#">Some text...</a>');
  /*
  // accessing a single element
  $('h1')
    ..setAttr('title', 'This is my title')
    ..setText('Changing title')
    ..setCssAttr('border', '1px solid black');
  $('h1').setText('title');

  // accessing multiple elements
  Iterable<DomNode> paragraphs = $('p');
  paragraphs.forEach((DomNode item) {
    item.setHtml('<strong>Paragraph</strong>');
  });

  // appends content
  $('p:last-child').append('<br><em>content added to the last paragraph.</em>');*/
}
