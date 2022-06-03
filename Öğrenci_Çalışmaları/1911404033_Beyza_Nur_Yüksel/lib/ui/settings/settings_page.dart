import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:waterreminder/bloc/water_bloc.dart';
import 'package:waterreminder/ui/settings/rolling_switch_button.dart';
import 'package:waterreminder/util/dialog.dart';
import 'package:waterreminder/util/num_extension.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<WaterBloc>();
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: 32 + 64 + 40, top: 32.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(width: double.infinity),
              Text(
                "Ayarlar",
                style: theme.textTheme.headline4,
              ),
              SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.only(left: 6, right: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("Hatırlatıcılar"),
                    ),
                    RollingSwitchButton(
                      value: bloc.state.alarmEnabled,
                      colorOff: theme.errorColor,
                      onChange: (value) => bloc.changeAlarmEnabled(value),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              TextButton(
                onPressed: () => showConsumptionDialog(context),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      theme.primaryColor.withOpacity(0.06)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Günlük tüketim",
                          style: theme.textTheme.bodyText2,
                        ),
                      ),
                      Text(
                        bloc.state.recommendedMilliliters.asMilliliters(),
                        style: theme.textTheme.bodyText2
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => clearDataStore(context),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        theme.errorColor.withOpacity(0.06)),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Verileri Sıfırla",
                        style: theme.textTheme.bodyText2?.copyWith(
                          color: theme.errorColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  "Hakkımda",
                  style: theme.textTheme.headline4,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Yazılımcı:",
                    style: TextStyle(color: Color(0xFF5B1C85)),
                  ),
                  Text(" Beyza Nur Yüksel")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "E-posta:",
                    style: TextStyle(color: Color(0xFF5B1C85)),
                  ),
                  Text(" beyzayuksel0111@gmail.com")
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> clearDataStore(BuildContext context) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: "Verileri Sıfırla",
      content:
          "Tüm uygulama verilerini sıfırlamak üzeresiniz. Bu işlem geri alınamaz.",
    );
    if (confirmed) {
      context.read<WaterBloc>().clearDataStore();
    }
  }
}
