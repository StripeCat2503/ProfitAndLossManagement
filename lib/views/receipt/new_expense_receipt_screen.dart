import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pnL/blocs/receipt_create_new_bloc.dart';
import 'package:pnL/helpers/datetime_helper.dart';
import 'package:pnL/helpers/text_helper.dart';
import 'package:pnL/main.dart';
import 'package:pnL/models/receipt_model.dart';
import 'package:pnL/models/receipt_new_model.dart';
import 'package:pnL/models/supplier_model.dart';
import 'package:pnL/models/transaction_category_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/views/components/custom_amount_input.dart';
import 'package:pnL/views/components/payment_method_card.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorScheme;
import 'package:pnL/views/receipt/components/datetime_picker_button.dart';
import 'package:pnL/views/receipt/components/transaction_category_card.dart';

class NewExpenseReceiptScreen extends StatefulWidget {
  @override
  _NewExpenseReceiptScreenState createState() =>
      _NewExpenseReceiptScreenState();
}

class _NewExpenseReceiptScreenState extends State<NewExpenseReceiptScreen> {
  DateTime _issueDate; // ngay xuat hoa don
  DateTime _createdDate; // ngay nhap hoa don vao he thong
  DateTime _expiryDate; // ngay ket thuc (optional)

  List<File> _receiptImages = [];
  final imagePicker = ImagePicker();
  Supplier _supplier;

  double _amountPaid = 0;
  double _balanceDue = 0;
  var bloc = new ReceiptCreateNewBloc();
  var _receipt = new ReceiptNew();
  List<Supplier> lstSupplier = [];

  // fake income category for demo purpose
  List<TransactionCategory> _transactionCategories = [
    TransactionCategory(id: 'sales', name: 'Doanh thu bán hàng', isDebit: true),
    TransactionCategory(
        id: 'services', name: 'Doanh thu cung cấp dịch vụ', isDebit: true),
    TransactionCategory(id: 'liabilities', name: 'Thu nợ', isDebit: true),
    TransactionCategory(id: 'interest', name: 'Tiền lãi suất', isDebit: true),
    TransactionCategory(id: 'other', name: 'Khác', isDebit: true),
  ];
  TransactionCategory _selectedTransactionCategory;

  TextEditingController _categoryTextController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categoryTextController.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc.initReceipt(false);
    _categoryTextController = TextEditingController(text: '');
  }

  // picking an image from gallery of device
  Future _getImageFromGallery() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    print('image picked from gallery');

    setState(() {
      if (pickedFile != null) {
        _receiptImages.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

// picking an image from camera of device
  Future _getImageFromCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    print('image picked from camera');
    setState(() {
      if (pickedFile != null) {
        _receiptImages.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  addNewExpense() {
    _receipt.category = _selectedTransactionCategory.code;
    _receipt.openDate = _issueDate;
    _receipt.closeDate = _expiryDate;
    bloc.createExpenseTransaction(_supplier, _receipt, _receiptImages);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: bloc.result,
        builder: (context, snapshot) {
          if (snapshot.data == 'success') {
            Fluttertoast.showToast(
                msg: "Added new transaction",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            Navigator.pop(context);
          } else {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // customer input
                    buildCustomerInput(),
                    // input name of receipt
                    buldReceiptNameInput(),

                    // Terms
                    buildTermSection(),

                    // input amount of money
                    buildAmountTotalInput(),

                    // choose transaction category
                    buildChooseTransactionCategory(context),

                    // Receipt
                    buildAttachmentSection(context),

                    // Note messages
                    buildMessageSection(),

                    // payment method section
                    buildPaymentMethodSection(size),

                    // confirm button to post receipt
                    buildConfirmButton(),
                  ],
                ),
              ),
            );
          }
        });
  }

  Container buildConfirmButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 55,
      child: RaisedButton(
        color: ColorScheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: () {
          addNewExpense();
        },
        child: Text(
          'Save'.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  StreamBuilder buildChooseTransactionCategory(BuildContext context) {
    return StreamBuilder(
        stream: bloc.listTransationCates,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TransactionCategory> listTransactionCate = snapshot.data;
            if (listTransactionCate == null)
              listTransactionCate = new List<TransactionCategory>();
            return InkWell(
              onTap: () {
                // modal bottom to show all common transation category
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        padding: EdgeInsets.all(10),
                        children:
                            List.generate(listTransactionCate.length, (index) {
                          var category = listTransactionCate[index];
                          return TransactionCategoryCard(
                            transactionCategory: category,
                            onSelected: () {
                              var selectedCategory =
                                  listTransactionCate.firstWhere(
                                (element) => element.id == category.id,
                                orElse: () => null,
                              );

                              // if category is 'other' then show dialog to enter new category
                              if (selectedCategory.id == 'other') {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Category'),
                                      content: TextField(
                                        controller: _categoryTextController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter category name...',
                                        ),
                                      ),
                                      actions: [
                                        FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              _selectedTransactionCategory =
                                                  TransactionCategory(
                                                      name:
                                                          _categoryTextController
                                                              .text);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text('OK'),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: Text('CANCEL'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                setState(() {
                                  _selectedTransactionCategory =
                                      selectedCategory;
                                  Navigator.pop(context);
                                });
                              }
                            },
                          );
                        }),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.category,
                      color: ColorScheme.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(_selectedTransactionCategory == null
                        ? 'Choose category'
                        : _selectedTransactionCategory.name),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right,
                        color: ColorScheme.primaryColor),
                  ],
                ),
              ),
            );
          }
          return InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [],
              ),
            ),
          );
        });
  }

  Container buildAmountTotalInput() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.euro),
              SizedBox(
                width: 5,
              ),
              Text(
                'Amount',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: 'Amount...',
                suffix: Text(
                  'VND',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            onChanged: (value) =>
                {_receipt.totalBalance = double.tryParse(value)},
          ),
        ],
      ),
    );
  }

  Container buldReceiptNameInput() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.dashboard),
              SizedBox(
                width: 5,
              ),
              Text(
                'Receipt\'s Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Name of receipt...',
            ),
            onChanged: (value) => {_receipt.name = value},
          ),
        ],
      ),
    );
  }

  Widget buildMessageSection() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.sms),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Note',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Note Message',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorScheme.primaryLightColor))),
                  onChanged: (text) {
                    _receipt.noteMessage = text;
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildAttachmentSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.attachment),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Attachments',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              // button to add image of receipt
              IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    color: ColorScheme.primaryLightColor,
                  ),
                  onPressed: () {
                    // show bottom sheet with 2 options: Photo Library and Camera
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext bc) {
                          return SafeArea(
                            child: Container(
                              child: new Wrap(
                                children: <Widget>[
                                  new ListTile(
                                      leading: new Icon(Icons.photo_library),
                                      title: new Text('Gallery'),
                                      onTap: () {
                                        _getImageFromGallery();
                                        Navigator.of(context).pop();
                                      }),
                                  new ListTile(
                                    leading: new Icon(Icons.photo_camera),
                                    title: new Text('Camera'),
                                    onTap: () {
                                      _getImageFromCamera();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ],
          ),
          // uploading images of receipt
          _receiptImages.length <= 0
              ? buildEmptyReceiptImage()
              : Container(
                  margin: EdgeInsets.only(top: 10.0),
                  // grid view to display all picked images
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    shrinkWrap: true,
                    children: _receiptImages.map((image) {
                      return Container(
                        padding: EdgeInsets.all(5.0),
                        child: Image.file(image),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(5.0)),
                      );
                    }).toList(),
                  ),
                )
        ],
      ),
    );
  }

  Widget buildEmptyReceiptImage() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 80.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: ColorScheme.primaryColor.withOpacity(0.3))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'there\'s no attachment'.toUpperCase(),
              style: TextStyle(color: Colors.grey[400]),
            ),
            SizedBox(
              height: 5.0,
            ),
            Icon(
              Icons.add_a_photo,
              color: Colors.grey[400],
            )
          ],
        ),
      ),
    );
  }

  Widget buildTermSection() {
    return Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.description),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Terms',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                // term date picker
                DatePickerButton(
                  selectedDate: _issueDate,
                  hintText: 'Issue Date',
                  onPickedDate: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(Duration(days: 365 * 10)),
                      lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                    ).then((value) {
                      setState(() {
                        _issueDate = value;
                      });
                    });
                  },
                ),
                Spacer(),
                DatePickerButton(
                  selectedDate: _expiryDate,
                  hintText: 'Expiry Date',
                  onPickedDate: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(Duration(days: 365 * 10)),
                      lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                    ).then((value) {
                      setState(() {
                        _expiryDate = value;
                      });
                    });
                  },
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)));
  }

  Widget buildPaymentMethodSection(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.payment),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              // button to add new payment method
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorScheme.primaryLightColor,
                  ),
                  child: Center(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          // Cash payment method
          PaymentMethodCard(
            paymentMethodText: 'Cash',
            isCashPaymentMethod: true,
            onChanged: (value) {},
            onDeleted: () {},
          ),
        ],
      ),
    );
  }

  Widget buildCustomerInput() {
    return StreamBuilder(
        stream: bloc.lstSupplier,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Supplier> listSupplier = snapshot.data;
            return Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new InputDecorator(
                            decoration: InputDecoration(
                              filled: false,
                              hintText: 'Income collected from...',
                              prefixIcon: Icon(
                                Icons.group,
                                color: ColorScheme.primaryColor,
                              ),
                              // labelText: 'Income collected from',
                              // errorText: '_errorText',
                            ),
                            isEmpty: _supplier == null,
                            child: new DropdownButton<Supplier>(
                              value: _supplier,
                              isDense: true,
                              icon: Icon(
                                Icons.add,
                                color: ColorScheme.primaryColor,
                              ),
                              onChanged: (Supplier newValue) {
                                setState(() {
                                  _supplier = newValue;
                                });
                              },
                              items: listSupplier.map((Supplier value) {
                                return DropdownMenuItem<Supplier>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      hintText: 'Income collected from...',
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      prefixIcon: Icon(
                        Icons.group,
                        color: ColorScheme.primaryColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorScheme.primaryColor))),
                )),
              ],
            ),
          );
        });
  }
}
