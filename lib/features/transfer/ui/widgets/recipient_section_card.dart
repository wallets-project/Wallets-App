import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/transfer/data/models/recipient_model.dart';
import 'package:wallets/features/transfer/ui/widgets/recipient_tile.dart';
import 'package:wallets/features/transfer/ui/widgets/transfer_section_card.dart';

class RecipientSectionCard extends StatelessWidget {
  final TextEditingController controller;
  final List<Recipient> recipients;
  final ValueChanged<String> onChanged;
  final void Function(String name, String id) onRecipientTap;
  final bool isLoading;
  final String? error;

  const RecipientSectionCard({
    super.key,
    required this.controller,
    required this.recipients,
    required this.onChanged,
    required this.onRecipientTap,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return TransferSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recipient', style: TextStyles.black16Medium),
          SizedBox(height: 8.h),
          TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Search by phone or wallet ID',
              hintStyle: TextStyles.gray14,
              prefixIcon: const Icon(Icons.search),
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
          Text('Recipients', style: TextStyles.gray12Medium),
          SizedBox(height: 12.h),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (error != null)
            Center(child: Text(error!, style: TextStyles.gray12Medium))
          else if (recipients.isEmpty)
            Center(
              child: Text(
                'No recipients found',
                style: TextStyles.gray12Medium,
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recipients.length,
              itemBuilder: (context, index) {
                final recipient = recipients[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: RecipientTile(
                    name: recipient.name,
                    id: recipient.displayId,
                    onTap: () =>
                        onRecipientTap(recipient.name, recipient.displayId),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
