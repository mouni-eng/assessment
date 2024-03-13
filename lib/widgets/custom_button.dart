import 'package:flutter/material.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final double? btnWidth, btnHeight, radius, fontSize;
  final bool? isUpperCase, showLoader, enabled;
  final String? text;
  final Color? background, textColor;
  final Function()? function;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    this.btnWidth = double.infinity,
    this.background,
    this.radius = 8.0,
    required this.fontSize,
    this.isUpperCase = false,
    required this.function,
    required this.text,
    this.showLoader = false,
    this.btnHeight = 60,
    this.enabled = true,
    this.fontWeight,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    var bg = background ?? Theme.of(context).primaryColor;
    return Container(
      width: btnWidth,
      height: height(btnHeight!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius!,
        ),
        color: showLoader! || !enabled! ? bg.withOpacity(0.3) : bg,
      ),
      child: MaterialButton(
          onPressed: showLoader! || !enabled! ? null : function,
          child: _rowWidget(context)),
    );
  }

  Widget _rowWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLoader!)
          SizedBox(
              width: height(btnHeight! * 0.7),
              height: height(btnHeight! * 0.7),
              child: const CircularProgressIndicator.adaptive()),
        if (showLoader!)
          SizedBox(
            width: width(14),
          ),
        _textWidget(context),
      ],
    );
  }

  Widget _textWidget(context) {
    var color = Theme.of(context);
    return Expanded(
        child: Center(
      child: CustomText(
        text: isUpperCase! ? text!.toUpperCase() : text!,
        color: textColor ?? color.primaryColorLight,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize!,
      ),
    ));
  }
}
