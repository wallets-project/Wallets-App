
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/transfer/ui/widgets/transfer_section_card.dart';

class NoteSectionCard extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const NoteSectionCard({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TransferSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('common.note_optional'.tr(), style: TextStyles.black16Medium),
          SizedBox(height: 8.h),
          TextField(
            controller: controller,
            onChanged: onChanged,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'transfer.add_note'.tr(),
              hintStyle: TextStyles.gray14,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            ),
            style: TextStyles.black16Bold,
          ),
        ],
      ),
    );
  }
}
