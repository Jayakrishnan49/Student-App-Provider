import 'package:flutter/material.dart';
import 'package:student_app_provider/utilities/customcolor.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final String text;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? textColor;
  final Icon? icon;
  final Color? borderColor;

  const CustomButton({
    super.key,
    this.onTap,
    this.color,
    required this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.textColor,
    this.icon,
    this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 60,
        width: width ?? 200,
        decoration: BoxDecoration(
          color: color ?? AppColor.primary,
          borderRadius: BorderRadius.circular(borderRadius ?? 50),
          border: Border.all(color:borderColor?? AppColor.primary),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) const SizedBox(width: 10),
              Text(text,
                  style: TextStyle(
                    color: textColor ?? AppColor.secondary,
                    fontSize: 18,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
