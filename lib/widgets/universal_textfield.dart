import 'package:fire_base_example/utils/extensions/extensions.dart';
import 'package:fire_base_example/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors/colors.dart';
import '../utils/styles/styles.dart';

class UniversalTextFormField extends StatelessWidget {
  const UniversalTextFormField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.onSubmit,
    this.keyboardType,
    this.prefix,
    required this.controller,
    required this.errorText,
    required this.type,
    required this.regExp,
    this.labelText,
    required this.isVisible,
    this.suffix,
  }) : super(key: key);

  final String hintText;
  final TextInputType? keyboardType;
  final Function(String value) onChanged;
  final Function(String v) onSubmit;
  final SvgPicture? prefix;
  final SvgPicture? suffix;
  final TextEditingController controller;
  final String errorText;
  final TextInputType type;
  final RegExp regExp;
  final String? labelText;
  final  bool? isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
           height: 60,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow:[
                BoxShadow(color: Colors.grey, blurRadius: 3.0, spreadRadius: 0.4,offset: Offset(0, 3), )
              ]
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              onChanged: onChanged,
              validator: (String? value) {
                if (value == null ||
                    value.isEmpty ||
                    !regExp.hasMatch(value) ||
                    value.length < 3) {
                  return errorText;
                } else {
                  return null;
                }
              },
              obscureText: isVisible!,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                fillColor: AppColors.white,
                filled: true,
                hintText: hintText,
                suffix: suffix,
                prefixIcon: prefix,
                prefixIconConstraints: BoxConstraints(minWidth: 60.w),
                helperStyle: AppTextStyle.rubikMedium.copyWith(
                  color: AppColors.c_2A3256,
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                errorStyle: TextStyle(color: Colors.red),
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                // Adding shadow to the bottom
                suffixIcon: Visibility(
                  visible: isVisible!,
                  child:IconButton(
                    onPressed: (){

                    },icon: SvgPicture.asset(AppImages.eye),
                  )
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
