import 'package:flutter/material.dart';
import 'package:waterreminder/resources/app_symbols.dart';

class WaterInput {
  final int milliliters;
  final IconData icon;
  final Color backgroundColor;

  WaterInput({
    required this.milliliters,
    required this.icon,
    required this.backgroundColor,
  });

  factory WaterInput.small() = _Small;
  factory WaterInput.regular() = _Regular;
  factory WaterInput.medium() = _Medium;
  factory WaterInput.large() = _Large;
}

class _Small extends WaterInput {
  _Small()
      : super(
          milliliters: 180,
          icon: AppSymbols.coffee_cup,
          backgroundColor: Color(0xFFCAACE9),
        );
}

class _Regular extends WaterInput {
  _Regular()
      : super(
          milliliters: 250,
          icon: AppSymbols.water_glass,
          backgroundColor: Color.fromARGB(255, 193, 151, 235),
        );
}

class _Medium extends WaterInput {
  _Medium()
      : super(
          milliliters: 500,
          icon: AppSymbols.water,
          backgroundColor: Color.fromARGB(255, 184, 135, 233),
        );
}

class _Large extends WaterInput {
  _Large()
      : super(
          milliliters: 750,
          icon: AppSymbols.jug,
          backgroundColor: Color.fromARGB(255, 178, 119, 236),
        );
}
