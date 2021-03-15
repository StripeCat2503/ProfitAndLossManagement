import 'package:flutter/material.dart';
import 'package:pnL/views/choose_accounting_period/choose_accounting_period_for_investor.dart';
import 'package:pnL/views/home/bottom_sheet_item.dart';

class MenuBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          BottomSheetItem(
            icon: Icons.pending_actions,
            title: 'Choose Accounting Period',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChooseAccountingPeriodForInvestorScreen(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
