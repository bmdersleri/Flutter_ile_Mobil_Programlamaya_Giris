import 'dart:convert';

import 'package:delta_markdown/delta_markdown.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:markdown/markdown.dart';

class QuillHelper {
  static String deltaToHtml(Delta delta) {
    final convertedValue = jsonEncode(delta.toJson());
    final markdown = deltaToMarkdown(convertedValue);
    final html = markdownToHtml(markdown);

    return html;
  }

  static Delta htmlToDelta(String html) {
    final markdown = html2md.convert(html);
    final String convertedValue = markdownToDelta(markdown);
    final Delta delta = Delta.fromJson(jsonDecode(convertedValue));
    return delta;
  }
}
