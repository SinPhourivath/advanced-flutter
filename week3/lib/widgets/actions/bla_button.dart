import 'package:flutter/material.dart';

import '../../theme/theme.dart';

// This button can be used for primary and secondary actions
class BlaButton extends StatelessWidget {
  const BlaButton(
      {super.key,
      required this.isPrimary,
      this.iconData,
      required this.text,
      required this.onPressed});

  final bool isPrimary;
  final IconData? iconData; // Icon on the left of the text is optional
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Compute the button style
    Color backgroundColor = isPrimary ? BlaColors.primary : BlaColors.white;
    Color foregroundColor = isPrimary ? BlaColors.white : BlaColors.primary;
    BorderSide? boarder =
        isPrimary ? null : BorderSide(color: BlaColors.greyLight);

    // Create icon​ inside button if it is provided
    final List<Widget> buttonChildren = [];

    if (iconData != null) {
      buttonChildren.add(
        Icon(iconData,
            // Using height make the icon size more on par with the text
            // Alternative fontSize is too small
            size: BlaTextStyles.button.height,
            color: foregroundColor),
      );
      buttonChildren.add(SizedBox(width: BlaSpacings.s));
    }

    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: boarder,
          padding: EdgeInsets.symmetric(
            vertical: BlaSpacings.m,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...buttonChildren,
            Text(text, style: BlaTextStyles.button),
          ],
        ),
      ),
    );
  }
}
