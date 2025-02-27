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
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isPrimary ? BlaColors.primary : BlaColors.white,
          foregroundColor: isPrimary ? BlaColors.white : BlaColors.primary,
          side: isPrimary ? null : BorderSide(color: BlaColors.greyLight),
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
            if (iconData != null) ...[
              Icon(iconData,
                  // Using height make the icon size more on par with the text
                  // Alternative fontSize is too small
                  size: BlaTextStyles.button.height,
                  color: isPrimary ? BlaColors.white : BlaColors.primary),
              SizedBox(width: BlaSpacings.s),
            ],
            Text(text, style: BlaTextStyles.button),
          ],
        ),
      ),
    );
  }
}
