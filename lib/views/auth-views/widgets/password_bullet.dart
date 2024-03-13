import 'package:flutter/material.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_text.dart';

class PasswordBulletPoints extends StatelessWidget {
  const PasswordBulletPoints({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Row(
      children: [
        Container(
          width: width(10),
          height: height(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.primaryColorDark.withOpacity(0.25),
          ),
        ),
        SizedBox(
          width: width(10),
        ),
        CustomText(
          fontSize: width(14),
          text: title,
          color: color.primaryColorDark.withOpacity(0.25),
        ),
      ],
    );
  }
}
