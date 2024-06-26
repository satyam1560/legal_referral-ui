import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_referral_ui/src/core/common_widgets/widgets.dart';
import 'package:legal_referral_ui/src/core/constants/icon_string_constants.dart';

class DocumentPost extends StatelessWidget {
  const DocumentPost({
    required this.fileName,
    required this.fileSize,
    super.key,
  });

  final String fileName;
  final String fileSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        horizontalTitleGap: 10,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 4,
        minLeadingWidth: 10,
        visualDensity: VisualDensity.standard,
        title: Text(
          fileName,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          fileSize,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
        leading: SvgPicture.asset(
          IconStringConstants.pdfIcon,
        ),
        trailing: SvgButton(
          width: 20,
          height: 20,
          imagePath: IconStringConstants.cross2,
          onPressed: () {},
        ),
      ),
    );
  }
}
