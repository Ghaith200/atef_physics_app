import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class StatusListViewWidget extends StatelessWidget {
  const StatusListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(width: 10.w),
          itemCount: 11,
          itemBuilder: (context, index) => index == 0
              ? CustomButton(
                  onTap: () {},
                  isCircle: true,
                  width: 80.w,
                  // boarderRadius: 40.r,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.3),

                  child: Icon(
                    Icons.add,
                    size: 40.r,
                  ),
                )
              : CustomButton(
                  onTap: () {},
                  isCircle: true,
                  width: 80.w,
                  // boarderRadius: 40.r,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.3),
                  image:
                      Assets.images.pexelsRioKuncoro13738342773977.provider(),
                )),
    );
  }
}
