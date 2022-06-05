import 'package:flutter/material.dart';
import 'package:turkish/turkish.dart';

class SearchSelectPage extends StatefulWidget {
  final String hinttext;
  final List<String> items;
  final String selectedItem;
  final void Function(String) onSelection;
  final TextInputType inputType;
  final TextEditingController controller;

  const SearchSelectPage({
    Key? key,
    required this.hinttext,
    required this.items,
    required this.selectedItem,
    required this.onSelection,
    required this.inputType,
    required this.controller,
  }) : super(key: key);

  @override
  _SearchSelectPageState createState() => _SearchSelectPageState();
}

class _SearchSelectPageState extends State<SearchSelectPage> {
   late TextInputType _inputType;
   late TextEditingController _controller;
  String _filterWord = "";
  String _hinttext = "";
  late String _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    _hinttext = widget.hinttext;
    if (_selectedItem.isNotEmpty) {
      widget.items.sort((a, b) => _selectedItem == a ? -1 : a.compareTo(b));
    } else {
      widget.items.sort(
        (a, b) => a.compareTo(b),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF375BA3),
        title: TextField(
          controller: widget.controller,
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            hintText: _hinttext,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          onChanged: (v) => setState(() => _filterWord = v),
        ),
      ),
      body: ListView(
        children: [
          for (final item in widget.items.where((element) =>
              element.toLowerCaseTr().contains(_filterWord.toLowerCaseTr())))
            Card(
              child: ListTile(
                onTap: () {
                  widget.onSelection(item);
                  _selectedItem = item;
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                title: Builder(
                  builder: (context) {
                    final items =
                        item.toLowerCaseTr().split(_filterWord.toLowerCaseTr());

                    return Text.rich(
                      TextSpan(
                        children: [
                          for (final itemPart in items)
                            TextSpan(
                              children: [
                                TextSpan(text: itemPart),
                                if (itemPart != items.last)
                                  TextSpan(
                                    text: _filterWord,
                                  ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
                trailing: Icon(
                  Icons.check,
                  color: _selectedItem == item
                      ? Colors.green
                      : Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
