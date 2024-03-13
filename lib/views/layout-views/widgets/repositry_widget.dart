import 'package:flutter/material.dart';
import 'package:mohamed_mounir_assesment/constants.dart';
import 'package:mohamed_mounir_assesment/models/repositry_model.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_text.dart';

class RepositryWidget extends StatelessWidget {
  const RepositryWidget({super.key, required this.repository});

  final GithubRepository repository;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: color.colorScheme.secondaryContainer),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            fontSize: width(20),
            text: repository.name,
            color: color.primaryColor,
          ),
          SizedBox(
            height: height(5),
          ),
          if (repository.description != null)
            CustomText(
              fontSize: width(16),
              text: repository.description!,
              color: color.colorScheme.secondaryContainer,
              maxlines: 3,
            ),
          SizedBox(
            height: height(10),
          ),
          CustomText(
            fontSize: width(14),
            text: "Posted by ${repository.owner.login}",
            color: color.primaryColor,
          ),
        ],
      ),
    );
  }
}
