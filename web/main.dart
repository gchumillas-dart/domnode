import 'package:domnode/core.dart';

void main() {
  // accessing a single element
  $('h1')
    ..setText('Changing title')
    ..setCssAttr('border', '1px solid black');

  // accessing multiple elements
  Iterable<DomNode> paragraphs = $('p');
  paragraphs.forEach((DomNode item) {
    item.setHtml('<strong>Paragraph</strong>');
  });

  // appends content
  $('p:last-child').append('<span>content added to the last paragraph.</span>');
}
