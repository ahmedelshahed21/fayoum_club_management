import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fayoum_club_management/core/utils/app_colors.dart';
import 'package:fayoum_club_management/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String> onChanged;
  final String hintText;
  final String? Function(String?)? validator;

  const DropdownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      value: value,
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.expand_more_outlined,
          size: 28,
          color: AppColors.lightGreyColor,
        ),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        hintText: hintText,
        hintStyle: AppStyles.styleMedium16(context)
            .copyWith(color: AppColors.greyColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.lightGreyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.lightGreyColor),
        ),
      ),
      buttonStyleData: ButtonStyleData(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        height: 56,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.pureWhiteColor,
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(

        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 36,
      ),
      items: items,
      onChanged: (newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
      // validator: validator ??
      //         (val) {
      //       if (val == null || val.isEmpty) {
      //         return "هذا الحقل مطلوب";
      //       }
      //       return null;
      //     },
    );
  }
}

