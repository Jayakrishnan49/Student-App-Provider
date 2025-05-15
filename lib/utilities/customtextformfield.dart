import 'package:flutter/material.dart';
import 'package:student_app_provider/utilities/customcolor.dart';
// import 'package:project_1_carecloud/utilities/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final double? width;
  final double? height;
  final String? suffixText;
  final IconData? icon;
  final String? hintText;
  final double? borderRadius;
  final String? labelText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String?>? onSaved; 

  const CustomTextFormField(
      {super.key,
      this.controller,
      this.width,
      this.height,
      this.suffixText,
      this.icon,
      this.hintText,
      this.borderRadius,
      this.labelText,
      this.initialValue,
      this.validator,
      this.keyboardType,
      this.autovalidateMode,
      this.onSaved,
      
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 350,
      height: height,
      child: TextFormField(
        
        initialValue: initialValue,
        controller: controller,
        decoration: InputDecoration(
          suffix: suffixText!=null?Text(suffixText!):null,
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: AppColor.subTitle
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
            // borderSide: BorderSide(color: AppColors.subTitle),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
            borderSide: const BorderSide(color: AppColor.subTitle),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
            borderSide: const BorderSide(color: AppColor.primary, width: 2.0),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColor.subTitle),
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(   
            vertical: height ?? 20,
            horizontal: 10,
          ),
        ),
        validator: validator,
        keyboardType: keyboardType,
        autovalidateMode: autovalidateMode,
        onSaved: onSaved,
      ),
    );
  }
}
