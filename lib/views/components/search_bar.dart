import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  FocusNode focusNode;
  String hint;
  Function(String searchData) onSearchDataChange;

  SearchBar({this.focusNode, this.hint, this.onSearchDataChange});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0), color: Colors.white),
      child: TextField(
        focusNode: widget.focusNode,
        onChanged: widget.onSearchDataChange,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 14.0),
            contentPadding: EdgeInsets.only(left: 10.0)),
      ),
    );
  }
}
