import 'package:flutter/material.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorScheme;
import 'package:pnL/views/components/go_back_button.dart';
import 'package:pnL/views/store_filter/store_card.dart';

class StoreFilter extends StatefulWidget {
  @override
  _StoreFilterState createState() => _StoreFilterState();
}

class _StoreFilterState extends State<StoreFilter> {
  bool _isSearchBarShown = false;
  FocusNode _searchFocusNode;

// Fake data of store
  List<Store> _storeList = [
    Store(code: 'ST711', id: '1', name: '711'),
    Store(code: 'STPassio', id: '2', name: 'Passio Coffee'),
    Store(code: 'STRelax', id: '3', name: 'Relax Coffee'),
    Store(code: 'STFMart', id: '4', name: 'Family Mart'),
    Store(code: 'STVMart', id: '5', name: 'Mart'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GoBackButton(
          color: ColorScheme.primaryColor,
          size: 35.0,
        ),
        backgroundColor: Colors.white,
        title: _isSearchBarShown // search bar
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5.0)),
                child: TextField(
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Search store'),
                ),
              )
            : Text(
                'store'.toUpperCase(),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
        centerTitle: true,
        actions: [
          // search button to toggle search bar
          IconButton(
              icon: Icon(
                _isSearchBarShown ? Icons.clear : Icons.search,
                color: ColorScheme.primaryColor,
              ),
              onPressed: () {
                setState(() {
                  _isSearchBarShown = !_isSearchBarShown;
                  _searchFocusNode.requestFocus();
                });
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            // choose all stores checkbox
            CheckboxListTile(
              value: false,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: ColorScheme.primaryLightColor,
              onChanged: (value) {
                // check all store event handling here!
              },
              title: Text(
                'All stores',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            // The list of stores
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var store = _storeList[index];
                return StoreCard(
                  store: store,
                  onSelected: (value) {
                    // selecting a store event handling here!
                  },
                );
              },
              itemCount: _storeList.length,
            ),
            Spacer(),
            Container(
              width: double.infinity,
              height: 50.0,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  'Apply',
                  style: TextStyle(color: Colors.white),
                ),
                color: ColorScheme.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
