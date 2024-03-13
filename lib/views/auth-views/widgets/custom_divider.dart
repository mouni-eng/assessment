import 'package:flutter/material.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_text.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.8,
              color: color.primaryColorDark.withOpacity(0.5),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(12),
            ),
            child: CustomText(
              fontSize: width(15),
              text: "Or Continue with",
              color: color.primaryColorDark.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.8,
              color: color.primaryColorDark.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
