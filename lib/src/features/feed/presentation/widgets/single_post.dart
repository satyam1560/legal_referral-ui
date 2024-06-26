import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:legal_referral_ui/src/core/common_widgets/widgets.dart';

class SinglePost extends StatelessWidget {
  const SinglePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        ExpandableText(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          text: '',
        ),
        const SizedBox(height: 10),
        Container(
          height: 375,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
