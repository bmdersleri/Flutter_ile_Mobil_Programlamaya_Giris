import 'package:flutter/material.dart';

class ListField extends StatefulWidget {
  List<String> list;
  var setDropdownValue;
  var getDropdownValue;
  String text;
  ListField({
    required this.list,
    required this.setDropdownValue,
    required this.getDropdownValue,
    required this.text,
  });

  @override
  State<ListField> createState() => _ListFieldState();
}

class _ListFieldState extends State<ListField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 150,
      child: Row(mainAxisAlignment:
               MainAxisAlignment.spaceEvenly,
        children: [
          DropdownButton<String>(
            value: widget.getDropdownValue(),
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: Theme.of(context).textTheme.button,
            underline: Container(
              height: 2,
              color: Theme.of(context).primaryColor,
            ),
            onChanged: (String? newValue) {
              setState(() {
                widget.setDropdownValue(newValue);
              });
            },
            items: widget.list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>( 
                
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Text(widget.text , style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }
}
