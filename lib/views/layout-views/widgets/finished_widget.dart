import 'package:flutter/material.dart';
import 'package:mohamed_mounir_assesment/constants.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_text.dart';

class NoMoreWidget extends StatelessWidget {
  const NoMoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Center(
      child: Container(
        margin: padding,
        padding: padding / 2,
        decoration: BoxDecoration(
          color: color.primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: CustomText(
          fontSize: width(16),
          text: "No More Data To Load",
        ),
      ),
    );
  }
}
