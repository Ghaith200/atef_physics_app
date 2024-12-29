import 'package:flutter/material.dart';
import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    this.title,
    this.color = AppColors.blue,
    this.width,
    this.height,
    this.image,
    this.filled = true,
    this.isCircle = false,
    this.boarderRadius,
    this.child,
    this.radius,
    this.titleTextStyle,
    this.boxShadow,
  });

  final void Function()? onTap;
  final String? title;
  final Color color;
  final ImageProvider<Object>? image;
  final double? width;
  final double? height;
  final double? radius;
  final double? boarderRadius;
  final bool filled;
  final bool isCircle;
  final Widget? child;
  final TextStyle? titleTextStyle;
  final List<BoxShadow>? boxShadow;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          color: filled ? color : AppColors.blue,
          borderRadius:
              isCircle ? null : BorderRadius.circular(boarderRadius ?? 0),
          border: filled ? null : Border.all(color: AppColors.blue),
          image: image == null
              ? null
              : DecorationImage(
                  image: image!,
                  fit: BoxFit.cover,
                ),
        ),
        height: radius ?? height,
        width: radius ?? width,
        child: child ??
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title ?? "",
                style: titleTextStyle ??
                    (filled
                        ? AppTextStyles.hevoLight25WhitekW900
                        : AppTextStyles.hevoLight25BlackWhiteW900),
              ),
            ),
      ),
    );
  }
}
