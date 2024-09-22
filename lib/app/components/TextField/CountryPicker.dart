import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class Countrypicker extends StatefulWidget {
  const Countrypicker({super.key});

  @override
  State<Countrypicker> createState() => _CountrypickerState();
}

class _CountrypickerState extends State<Countrypicker> {
  String countryLabel = "Choisir un pays";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: PrimaryColor.primary900),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 7),
      child: Align(
        alignment: Alignment.topCenter,
        child: CSCPicker(
          flagState: CountryFlag.ENABLE,
          disabledDropdownDecoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          dropdownDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.transparent,
          ),
          dropdownHeadingStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          showCities: false,
          showStates: false,
          searchBarRadius: 8,
          defaultCountry: CscCountry.Cote_D_Ivoire_Ivory_Coast,
          countryDropdownLabel: countryLabel,
          onCountryChanged: (value) {
            setState(() {
              print(value);
              countryLabel = value;
            });
          },
        ),
      ),
    );
  }
}
