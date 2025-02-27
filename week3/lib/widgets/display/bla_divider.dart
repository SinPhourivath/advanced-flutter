import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class BlaDivider extends StatelessWidget {
  const BlaDivider({super.key, this.horizontalPadding});

  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0.0),
      child: Divider(
        height: 1,
        thickness: 1,
        color: BlaColors.greyLight,
      ),
    );
  }
}
