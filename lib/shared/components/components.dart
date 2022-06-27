import 'package:shop_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';

Widget whiteTextForm({
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

void snkBar({
  required BuildContext context,
  required String title,
  Color? snackColor,
  Color? titleColor,
  int seconds = 3,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      title,
      style: TextStyle(
        color: titleColor,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: snackColor,
    duration: Duration(seconds: seconds),
  ));
}
