import 'package:flutter/material.dart';
import 'package:pnL/helpers/datetime_helper.dart';
import 'package:pnL/models/accounting_period_model.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/themes/color_scheme.dart';
import 'package:pnL/views/components/go_back_button.dart';
import 'package:pnL/views/components/rounded_button.dart';
import 'package:pnL/views/components/search_bar.dart';

class ChooseStoreScreen extends StatefulWidget {
  ChooseStoreScreen();

  @override
  _ChooseStoreScreenState createState() => _ChooseStoreScreenState();
}

class _ChooseStoreScreenState extends State<ChooseStoreScreen> {
  bool _isSearchBarShown = false;
  FocusNode _focusNode = FocusNode();

  // Fake store data for demo purpose
  List<Store> _stores = [
    Store(code: 'ST711', id: '1', name: '711'),
    Store(code: 'STPassio', id: '2', name: 'Passio Coffee'),
    Store(code: 'STRelax', id: '3', name: 'Relax Coffee'),
    Store(code: 'STFMart', id: '4', name: 'Family Mart'),
    Store(code: 'STVMart', id: '5', name: 'Mart'),
  ];

// map to store the checking state for each checkbox
  Map<String, bool> _storeCheckboxs = {'allStore': true};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stores.forEach((s) {
      _storeCheckboxs[s.code] = true;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  Widget _buildStoreCard(Store store) {
    return Container(
        margin: EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: CheckboxListTile(
          onChanged: (value) {
            setState(() {
              _storeCheckboxs[store.code] = value;
              if (_storeCheckboxs[store.code] == false &&
                  _storeCheckboxs['allStore'] == true) {
                _storeCheckboxs['allStore'] = false;
              }
            });
          },
          value: _storeCheckboxs[store.code],
          controlAffinity: ListTileControlAffinity.trailing,
          activeColor: primaryColor,
          secondary: Icon(
            Icons.store,
            color: primaryColor,
          ),
          title: Text(
            store.name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: _storeCheckboxs[store.code] == true
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
          subtitle: Text(
            'Code: ${store.code}',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: !_isSearchBarShown
            ? Text(('chọn cửa hàng'.toUpperCase()))
            : SearchBar(
                focusNode: _focusNode,
                hint: 'Tìm cửa hàng...',
                onSearchDataChange: (searchData) {
                  // handle search action here!
                },
              ),
        actions: [
          IconButton(
              icon: Icon(
                _isSearchBarShown ? Icons.clear : Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isSearchBarShown = !_isSearchBarShown;
                });
              })
        ],
        leading: GoBackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // list of stores
            Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                margin: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: CheckboxListTile(
                    onChanged: (value) {
                      setState(() {
                        _storeCheckboxs['allStore'] = value;
                        if (_storeCheckboxs['allStore'] == true) {
                          _storeCheckboxs.forEach((key, value) {
                            _storeCheckboxs[key] = true;
                          });
                        } else {
                          _storeCheckboxs.forEach((key, value) {
                            _storeCheckboxs[key] = false;
                          });
                        }
                      });
                    },
                    value: _storeCheckboxs['allStore'],
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: primaryColor,
                    title: Text(
                      'tất cả cửa hàng'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: _storeCheckboxs['allStore'] == true
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ))),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var store = _stores[index];
                  return _buildStoreCard(store);
                },
                itemCount: _stores.length,
              ),
            ),
            RoundedButton(
              text: 'Áp dụng',
              textColor: Colors.white,
              bgColor: primaryColor,
              onPress: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
