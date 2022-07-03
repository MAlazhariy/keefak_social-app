
import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget customWhiteTextForm({
  TextInputAction inputAction = TextInputAction.none,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.emailAddress,
  String hintText = '',
  String? labelText,
  Icon? prefixIcon,
  String helper = '',
  void Function(String)? onChanged,
  required String? Function(String?)? validator,
  bool obscureText = false,
  void Function(String)? onFieldSubmitted,
  Widget? suffix,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      boxShadow: const [
        BoxShadow(
          color: Color(0x3B8B8B8B),
          blurRadius: 15,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: TextFormField(
      textInputAction: inputAction,
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: 19.5,
        fontWeight: FontWeight.w600,
        color: kMainColor,
      ),
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 18,
        ),
        filled: true,
        fillColor: Colors.white,
        suffix: suffix,
        suffixStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: kRedColor,
        ),
        labelText: labelText,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: kRedColor,
            width: 2.2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: kRedColor,
            width: 2.2,
          ),
        ),
        errorStyle: const TextStyle(
          color: kRedColor,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 19.5,
          fontWeight: FontWeight.w600,
          color: Color(0x7C323F48),
        ),
        prefixIcon: prefixIcon != null
            ? Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: prefixIcon,
        )
            : null,
        helperText: helper,
        helperStyle: const TextStyle(
          color: kRedColor,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          gapPadding: 10,
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    ),
  );
}

class CustomWhiteTextForm extends StatelessWidget {
  const CustomWhiteTextForm({
    Key? key,
    this.inputAction = TextInputAction.none,
    required this.controller,
    this.keyboardType = TextInputType.emailAddress,
    this.hintText = '',
    this.labelText,
    this.prefixIcon,
    this.helper = '',
    this.onChanged,
    required this.validator,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.suffix,
  }) : super(key: key);

  final TextInputAction inputAction;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final String? labelText;
  final Icon? prefixIcon;
  final String helper;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function(String)? onFieldSubmitted;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3B8B8B8B),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        textInputAction: inputAction,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 19.5,
          fontWeight: FontWeight.w600,
          color: kMainColor,
        ),
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 18,
          ),
          filled: true,
          fillColor: Colors.white,
          suffix: suffix,
          suffixStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: kRedColor,
          ),
          labelText: labelText,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: kRedColor,
              width: 2.2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: kRedColor,
              width: 2.2,
            ),
          ),
          errorStyle: const TextStyle(
            color: kRedColor,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 19.5,
            fontWeight: FontWeight.w600,
            color: Color(0x7C323F48),
          ),
          prefixIcon: prefixIcon != null
              ? Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: prefixIcon,
          )
              : null,
          helperText: helper,
          helperStyle: const TextStyle(
            color: kRedColor,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            gapPadding: 10,
          ),
        ),
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
