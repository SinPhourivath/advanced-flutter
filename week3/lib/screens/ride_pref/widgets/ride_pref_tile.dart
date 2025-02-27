import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

// This tile is used to display the ride preferences
class RidePrefTile extends StatelessWidget {
  const RidePrefTile(
      {super.key,
      required this.text,
      required this.leadingIcon,
      required this.onPressed,
      this.trailingIconButton});

  final String text;
  final IconData leadingIcon;
  final VoidCallback onPressed;

  // Make optionally For the fist tile that have switch location action
  final IconButton? trailingIconButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
      child: ListTile(
          onTap: onPressed,
          title: Text(text,
              style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)),
          leading: Icon(leadingIcon),
          trailing: trailingIconButton),
    );
  }
}
