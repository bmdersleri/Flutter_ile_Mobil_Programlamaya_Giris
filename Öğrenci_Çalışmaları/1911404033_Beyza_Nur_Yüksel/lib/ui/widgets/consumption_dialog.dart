import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterreminder/bloc/water_bloc.dart';
import 'package:waterreminder/ui/widgets/primary_button.dart';
import 'package:waterreminder/ui/widgets/secondary_button.dart';

class ConsumptionDialog extends StatefulWidget {
  @override
  _ConsumptionDialogState createState() => _ConsumptionDialogState();
}

class _ConsumptionDialogState extends State<ConsumptionDialog> {
  final _form = GlobalKey<FormState>();
  String? _text;

  String? _validateText(String? value) {
    if (value == null) {
      return "2000 ml minimum";
    }

    final number = int.tryParse(value);
    if (number != null && number >= 2000) {
      return null;
    }

    return "2000 ml minimum";
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<WaterBloc>();
    return AlertDialog(
      title: Text(
        "Günlük tüketim",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Günlük su tüketimi hedefinizi mililitre olarak değiştirin.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            TextFormField(
              maxLength: 4,
              initialValue: bloc.state.recommendedMilliliters.toString(),
              keyboardType: TextInputType.number,
              onSaved: (value) => _text = value,
              validator: _validateText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: "2000 ml",
                counterText: "",
              ),
            ),
            SizedBox(height: 24),
            PrimaryButton(
              onPressed: () {
                if (_form.currentState?.validate() ?? false) {
                  _form.currentState?.save();
                  FocusScope.of(context).unfocus();
                  context.read<WaterBloc>().setRecommendedMilliliters(
                        int.parse(_text!),
                      );
                  Navigator.of(context).pop();
                }
              },
              title: "Onayla",
            ),
            SizedBox(height: 10),
            SecondaryButton(
              onPressed: () => Navigator.of(context).pop(),
              title: "İptal et",
            ),
          ],
        ),
      ),
    );
  }
}
