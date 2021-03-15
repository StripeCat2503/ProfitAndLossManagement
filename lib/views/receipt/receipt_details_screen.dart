import 'package:flutter/material.dart';
import 'package:pnL/blocs/receipt_detail_bloc.dart';
import 'package:pnL/helpers/datetime_helper.dart';
import 'package:pnL/helpers/route_helper.dart';
import 'package:pnL/helpers/text_helper.dart';
import 'package:pnL/models/member.dart';
import 'package:pnL/models/receipt_new_model.dart';
import 'package:pnL/models/store_model.dart';
import 'package:pnL/models/supplier_model.dart';
import 'package:pnL/models/transaction_category_model.dart';
import 'package:pnL/models/receipt_detail_new_model.dart';
import 'package:pnL/models/transaction_model.dart';
import 'package:pnL/themes/color_scheme.dart' as ColorScheme;
import 'package:pnL/views/photo_viewer/photo_view_screen.dart';
import 'package:pnL/views/receipt/components/transaction_detail_card.dart';

class ReceiptDetailsScreen extends StatefulWidget {
  String receiptId;
  ReceiptDetailsScreen({Key key, this.receiptId}) : super(key: key);
  @override
  _ReceiptDetailsScreenState createState() => _ReceiptDetailsScreenState();
}

class _ReceiptDetailsScreenState extends State<ReceiptDetailsScreen> {
  TextEditingController _txtSearchController;
  // TransactionRepository _transactionRepository;
  ReceiptDetailBloc bloc = ReceiptDetailBloc();

  // Fake data for demo purpose
  ReceiptNew receipt = ReceiptNew(
      code: 'Rì síp',
      name: 'Tiền nhập hàng',
      member: Member(firstName: 'Huấn Rose'),
      closeDate: DateTime(2020, 11, 10),
      createdDate: DateTime(2020, 11, 9),
      listImage: [
        'https://firebasestorage.googleapis.com/v0/b/swdk13.appspot.com/o/Evidence%2F12065746_1758190651075094_3360078855248465130_n.jpg?alt=media&token=9285d179-e284-48a8-a874-b2c47859081c&fbclid=IwAR3THEBWeMNcebRg94Ih5QT9PMBoODVjyS9IG7B7gujMMxMMENOLYaausOg',
        'https://firebasestorage.googleapis.com/v0/b/swdk13.appspot.com/o/Evidence%2F12065746_1758190651075094_3360078855248465130_n.jpg?alt=media&token=9285d179-e284-48a8-a874-b2c47859081c&fbclid=IwAR3THEBWeMNcebRg94Ih5QT9PMBoODVjyS9IG7B7gujMMxMMENOLYaausOg',
      ],
      id: 'rs-12312313',
      openDate: DateTime(2020, 11, 8),
      status: 1,
      store: Store(
        id: 'st-177897',
        code: 'st-pet',
        name: 'Cửa hàng thú cưng - petWorld',
      ),
      totalBalance: 3478000,
      supplier: Supplier(
        name: 'Công ty cổ phần gia súc Meo Meo',
        address: 'TPHCM',
        email: 'pet@gmail.com',
        id: 'sp-meow',
        phone: 0123456789,
      ),
      noteMessage: 'Thức ăn cho thú cưng, số lượng (x 150)');

  List<Transaction> transactionDetails = [
    Transaction(
      description: 'Thức ăn cho chó',
      balance: 1500000,
      transactionCategory: TransactionCategory(isDebit: false),
    ),
    Transaction(
      description: 'Thức ăn cho mèo',
      balance: 1200000,
      transactionCategory: TransactionCategory(isDebit: false),
    ),
    Transaction(
      description: 'Nhà mini cho thú cưng',
      balance: 1000000,
      transactionCategory: TransactionCategory(isDebit: false),
    ),
  ];

  @override
  void initState() {
    super.initState();
    bloc.initReceipt(widget.receiptId);
  }

  Widget _buildTotalBalanceSection(double balance) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Text(
            'Total',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Spacer(),
          Text(
            TextHelper.numberWithCommasAndCurrency(balance, 'đ '),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      margin: EdgeInsets.only(top: 5.0),
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
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          // list of payment methods
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              children: [
                Text('Master card'),
                Spacer(),
                Icon(
                  Icons.payment,
                  color: ColorScheme.primaryColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTransactionDetailsSection(List<Transaction> transactionDetails) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(Icons.receipt),
            SizedBox(
              width: 5,
            ),
            Text(
              'Transactions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      transactionDetails.length > 0
          ? Column(
              children: List.generate(transactionDetails.length, (index) {
              var details = transactionDetails[index];
              return TransactionDetailCard(
                transactionDetail: details,
              );
            }))
          : Center(
              child: Text('There\'s no details'),
            ),
    ]);
  }

  Widget _buildAttachmentSection(List<String> imageList) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Icon(Icons.receipt_long),
              SizedBox(
                width: 5,
              ),
              Text(
                'Receipts Attachments',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        // receipt images here!
        Container(
          padding: EdgeInsets.all(10.0),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: List.generate(imageList.length, (index) {
              return GestureDetector(
                onTap: () {
                  // view image in full screen
                  RouteHelper.route(
                      context,
                      PhotoViewScreen(
                        imageUrl: imageList[index],
                      ));
                },
                child: Image.network(imageList[index]),
              );
            }),
          ),
        ),
      ],
    ));
  }

  Widget _buildNoteMessageSection(String msg) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Row(
              children: [Text(msg)],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScheme.primaryColor,
        title: Text("receipt details".toUpperCase()),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: StreamBuilder(
            stream: bloc.receipt,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ReceiptNew receiptNew = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // receipt header
                      buildReceiptHeader(receiptNew),

                      // member who created receipt
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.group, color: ColorScheme.primaryColor),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Created By'),
                            Spacer(),
                            Text(
                              receiptNew.member.firstName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      _paymentMethodSection(),
                      // list of transaction details
                      Container(
                          child: _buildTransactionDetailsSection(
                              receiptNew.lstTransactionDetail)),
                      SizedBox(height: 10),
                      _buildTotalBalanceSection(receiptNew.totalBalance),
                      SizedBox(height: 10),
                      _buildAttachmentSection(receiptNew.listImage),
                      _buildNoteMessageSection(receiptNew.noteMessage)
                    ],
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              );
            }),
      ),
    );
  }

  Column buildReceiptHeader(ReceiptNew receiptNew) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // name of receipt
              Text(
                receiptNew.name.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // issue date
            Text(
              'Issue at ' +
                  DatetimeHelper.toDayMonthYearFormatString(
                      receiptNew.openDate),
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),

        // expiry date and created date
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // expiry date
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 14,
                        color: ColorScheme.primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Expiry date',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Text(
                    DatetimeHelper.toDayMonthYearFormatString(
                        receiptNew.closeDate),
                  ),
                ],
              ),

              // created date
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 14,
                        color: ColorScheme.primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Created date',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Text(DatetimeHelper.toDayMonthYearFormatString(
                      receiptNew.createdDate)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // store and supplier
        Row(
          children: [
            Icon(
              Icons.store,
              color: ColorScheme.primaryColor,
            ),
            Text(
              'Store',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Spacer(),
            Text(receiptNew.store?.name ?? '')
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.group,
              color: ColorScheme.primaryColor,
            ),
            Text(
              'Supplier',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Spacer(),
            Text(receiptNew.supplier?.name ?? '')
          ],
        ),
      ],
    );
  }
}
