
import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({
    Key? key,
    required this.items,
    this.onSelected,
  }) : super(key: key);

  final List<PopupMenuEntry> items;
  final void Function(dynamic)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_horiz,
        color: Colors.grey[600],
        size: 19,
      ),
      itemBuilder: (context) => items,
      onSelected: onSelected,
    );
  }
}
