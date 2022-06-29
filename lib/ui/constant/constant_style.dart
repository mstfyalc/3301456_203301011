
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant_color.dart';

class ConstantStyle {
  // Variables
  static const String _termsImagePath = 'assets/images/terms-image.jpeg';
  static const String _googleLogoPath = 'assets/images/google-logo.png';
  static const String _appleLogoPath = 'assets/images/apple-logo.png';
  static const String _microsoftLogoPath = 'assets/images/microsoft-logo.png';

  static TextStyle termsAppNameStyle = GoogleFonts.lato(
      color: ConstantColor.appTermsNameColor,
      fontSize: 40,
      fontWeight: FontWeight.w600);

  static TextStyle appNames = GoogleFonts.lato(
      color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600);

  static TextStyle newMessageStyle = GoogleFonts.lato(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500,letterSpacing: 0.3);

  static TextStyle termsDescriptionStyle = GoogleFonts.lato(
      color: ConstantColor.appTermsDescriptionColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      wordSpacing: 1.5);

  static Decoration termsImageBoxDecorationStyle = BoxDecoration(
      image: const DecorationImage(
          image: AssetImage(_termsImagePath), fit: BoxFit.cover),
      border:
          Border.all(width: 0.5, color: ConstantColor.appTermsImageBorderColor),
      borderRadius: const BorderRadius.all(Radius.circular(12)));

  static Decoration sigInProviderButtonsBoxDecorationStyle = BoxDecoration(
      border: Border.all(
          width: 0.5, color: ConstantColor.signInProviderButtonBorderColor),
      borderRadius: const BorderRadius.all(Radius.circular(3)));

  static Decoration googleButtonsBoxDecorationStyle = const BoxDecoration(
      image: DecorationImage(
          image: AssetImage(_googleLogoPath), fit: BoxFit.cover));

  static Decoration appleButtonsBoxDecorationStyle = const BoxDecoration(
      image: DecorationImage(
          image: AssetImage(_appleLogoPath), fit: BoxFit.cover));

  static Decoration appBarActionBoxDecoration = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(35)),
    color: Colors.grey
  );

  static Decoration microsoftButtonsBoxDecorationStyle = const BoxDecoration(
      image: DecorationImage(
          image: AssetImage(_microsoftLogoPath), fit: BoxFit.cover));

  static TextStyle termsTextStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w400,
    color: ConstantColor.termsTextColor,
    fontSize: 14,
  );

  static TextStyle signTextStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 13,
  );

  static TextStyle orTextStyle = GoogleFonts.lato(
      fontSize: 13, fontWeight: FontWeight.w700, color: ConstantColor.appColor);

  static TextStyle termsLinkStyle = GoogleFonts.lato(
    fontWeight: FontWeight.bold,
    color: ConstantColor.termsTextColor,
    fontSize: 14,
  );

  static ButtonStyle acceptTermsButtonStyle = ElevatedButton.styleFrom(
    onPrimary: const Color(0xff6247aa),
    primary: const Color(0xfff8f7ff),
    minimumSize: const Size(88, 40),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  static ButtonStyle signInButtonStyle = ElevatedButton.styleFrom(
    onPrimary: const Color(0xfff8f7ff),
    primary: const Color(0xff6247aa),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
    ),
  );

  static TextStyle signInTextStyle = GoogleFonts.lato(
      color: ConstantColor.signInTextColor,
      fontSize: 32,
      fontWeight: FontWeight.w600);

  InputDecoration signInEmailFieldDecoration(String? errorText) {
    return InputDecoration(
        hintText: 'Enter email',
        errorText: errorText,
        filled: true,
        fillColor: ConstantColor.signInTextFieldFillColor,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColor.appColor)),
        enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
                width: .2, color: ConstantColor.signInTextFieldBorderColor)));
  }

  InputDecoration signInPasswordFieldDecoration(String? errorText) {
    return InputDecoration(
        hintText: 'Enter password',
        errorText: errorText,
        filled: true,
        fillColor: ConstantColor.signInTextFieldFillColor,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColor.appColor)),
        enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
                width: .2, color: ConstantColor.signInTextFieldBorderColor)));
  }
}
