import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/transfer/ui/widgets/transfer_section_card.dart';

class AmountSectionCard extends StatelessWidget {
  final TextEditingController controller;
  final String? availableText;
  final ValueChanged<String> onChanged;
  final String? title;

  const AmountSectionCard({
    super.key,
    required this.controller,
    this.availableText,
    required this.onChanged,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TransferSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'common.enter_amount'.tr(),
            style: TextStyles.black16Medium,
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: TextStyles.gray14,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
            ),
            style: TextStyles.black16Bold,
          ),
          SizedBox(height: 8.h),
          if (availableText != null)
            Text(availableText!, style: TextStyles.gray16Medium),
        ],
      ),
    );
  }
}
