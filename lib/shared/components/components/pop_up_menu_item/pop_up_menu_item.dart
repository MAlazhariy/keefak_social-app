import 'package:flutter/material.dart';

PopupMenuEntry customPopupMenuItem({
  required IconData icon,
  required String title,
  void Function()? onTap,
  dynamic value,
}){
  return PopupMenuItem(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.grey[600],
          size: 16,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    ),
    onTap: onTap,
    value: value?? title,
  );
}