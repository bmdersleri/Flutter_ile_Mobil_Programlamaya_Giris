import 'package:flutter/material.dart';

class AutocompleteBasicExample extends StatelessWidget {
  late var search_text;
  late String field_text;
  AutocompleteBasicExample(
      {required this.search_text, required this.field_text});
  static List<String> _kOptions = <String>[
    '1512132',
    '9461338',
    '6554333',
    '7623355',
    '6542654',
    '1235214',
    '3423545',
    '6542654',
    '6241625',
    '6245114',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: field_text),
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return AutocompleteBasicExample._kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        search_text(selection);
      },
    );
  }
}
