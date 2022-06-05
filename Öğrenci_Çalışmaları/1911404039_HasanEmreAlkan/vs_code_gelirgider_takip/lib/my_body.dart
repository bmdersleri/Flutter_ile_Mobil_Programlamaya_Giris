import 'package:flutter/cupertino.dart';
import 'expenses_incomes.dart';

class MyBody extends StatelessWidget {
  const MyBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ExpensesIncomes(
              islemAdi: '', para: '', gelirVeyaGider: '');
        });
  }
}
