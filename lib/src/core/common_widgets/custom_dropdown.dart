import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:legal_referral_ui/src/core/constants/colors.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    required this.items,
    required this.onChange,
    required this.hintText,
    required this.labelText,
    this.selectedValue,
    this.selectedValueNotifier,
    this.showSelectedValue = true,
    this.validator,
    super.key,
  });

  final List<String> items;
  final ValueChanged<String?> onChange;

  final String hintText;
  final String labelText;

  /// Optional normal selected value.
  ///
  /// Existing usages don't need to provide this.
  final String? selectedValue;

  /// Existing notifier-based implementation.
  ///
  /// Kept so existing usages are not affected.
  final ValueNotifier<String?>? selectedValueNotifier;

  final bool showSelectedValue;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.bodyLarge,
        ),

        SizedBox(height: 8.h),

        _buildDropdown(context),
      ],
    );
  }

  Widget _buildDropdown(BuildContext context) {
    // Existing notifier has priority.
    if (selectedValueNotifier != null) {
      return DropdownButtonFormField2<String>(
        isExpanded: true,

        valueListenable: showSelectedValue
            ? selectedValueNotifier
            : ValueNotifier<String?>(null),

        hint: _hint(context),

        decoration: _decoration(),

        items: _items(context),

        validator: validator,

        onChanged: onChange,

        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
        ),

        dropdownStyleData: DropdownStyleData(
          maxHeight: 250.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
        ),
      );
    }

    // New selectedValue support.
    return DropdownButtonFormField2<String>(
      isExpanded: true,

      valueListenable: ValueNotifier<String?>(
        showSelectedValue ? selectedValue : null,
      ),

      hint: _hint(context),

      decoration: _decoration(),

      items: _items(context),

      validator: validator,

      onChanged: onChange,

      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
        ),
      ),

      dropdownStyleData: DropdownStyleData(
        maxHeight: 250.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),

      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
        ),
      ),
    );
  }

  Text _hint(BuildContext context) {
    return Text(
      hintText,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: LegalReferralColors.textgrey300,
      ),
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
      filled: true,
      fillColor: LegalReferralColors.containerWhite500,

      errorStyle: const TextStyle(
        color: LegalReferralColors.error,
      ),

      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: LegalReferralColors.borderBlue300,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: LegalReferralColors.borderBlue300,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: LegalReferralColors.error,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: LegalReferralColors.error,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  List<DropdownItem<String>> _items(BuildContext context) {
    return items
        .map(
          (item) => DropdownItem<String>(
            value: item,
            child: Text(
              item,
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList();
  }
}