import 'package:flutter/material.dart';

import '../../core/color.dart';

class TextFormFieldUtl extends StatelessWidget {

  TextFormFieldUtl({
      required this.controller,
      required this.formKey,
      required this.onTapOutside,
      required this.title,
      required this.prefixIcon,
      required this.message,
      required this.onTap,
      this.readonly=false,
      required this.onEditingComplete,
      });

  final TextEditingController controller;
  final GlobalKey<FormState>  formKey;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool readonly ;
  final String title;
  final Widget prefixIcon;
  final String message;
  final void Function()? onTap;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
          onTapOutside: onTapOutside,
          maxLines: 1,
          controller: controller,
          keyboardType: TextInputType.text,
          readOnly: readonly,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: title,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.c1,
            ),
            prefixIcon: prefixIcon,
            enabled: true,
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return message;
            }
            return null;
          },
          onTap: onTap,
          onEditingComplete:onEditingComplete ,
      ),
    );
  }
}
