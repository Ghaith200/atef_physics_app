import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class CustomChatWidget extends StatelessWidget {
  const CustomChatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          foregroundImage:
              Assets.images.pexelsRioKuncoro13738342773977.provider(),
          radius: 30.r,
        ),
        SizedBox(width: 15.w),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Martin Randolph",
              style: AppTextStyles.alexandria20WhiteBlackW700,
            ),
            Text(
              "You: What’s man! · 9:40 AM",
              style: AppTextStyles.alexandria14greykW500,
            ),
          ],
        )),
        SizedBox(width: 15.w),
        CustomButton(
            onTap: () {},
            color: Colors.transparent,
            child: const Icon(Icons.circle_outlined))
      ],
    );
  }
}
