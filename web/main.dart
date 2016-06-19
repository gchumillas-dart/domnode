import 'package:domnode/core.dart';

void main() {
  DomNode h1 = domQuery('h1');

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
      .append('<span>content added to the last paragraph.</span>');
}
