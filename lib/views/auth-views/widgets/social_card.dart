import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    super.key,
    required this.onTap,
    required this.logo,
  });

  final Function() onTap;
  final String logo;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width(13),
          vertical: height(13),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: color.colorScheme.secondaryContainer,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(
          logo,
          width: width(25),
          height: height(25),
        ),
      ),
    );
  }
}
