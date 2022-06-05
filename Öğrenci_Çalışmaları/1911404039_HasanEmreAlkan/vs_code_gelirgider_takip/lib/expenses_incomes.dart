import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpensesIncomes extends StatelessWidget {
  final String islemAdi;
  final String para;
  final String gelirVeyaGider;
  ExpensesIncomes(
      {required this.islemAdi,
      required this.para,
      required this.gelirVeyaGider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.grey.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepOrangeAccent.shade100,
                    ),
                    child: const Text(
                      '₺',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    islemAdi,
                    style: GoogleFonts.roboto(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                (gelirVeyaGider == 'gider' ? '-' : '+') + '\₺' + para,
                style: GoogleFonts.roboto(
                  color:
                      (gelirVeyaGider == 'gider' ? Colors.red : Colors.green),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
