import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/styles.dart';

Future<T?> showSelectionBottomSheet<T>({
  required BuildContext context,
  required String title,
  required List<T> items,
  required bool Function(T item) isSelected,
  required Widget Function(T item) leadingBuilder,
  required String Function(T item) titleBuilder,
  String Function(T item)? subtitleBuilder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99.r),
                  color: Colors.grey.shade300,
                ),
              ),
              SizedBox(height: 12.h),
              Text(title, style: TextStyles.black16Bold),
              SizedBox(height: 12.h),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final selected = isSelected(item);
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: leadingBuilder(item),
                      title: Text(
                        titleBuilder(item),
                        style: TextStyles.black14Medium,
                      ),
                      subtitle: subtitleBuilder == null
                          ? null
                          : Text(
                              subtitleBuilder(item),
                              style: TextStyles.gray12Medium,
                            ),
                      trailing: selected
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const Icon(Icons.radio_button_off),
                      onTap: () {
                        Navigator.of(sheetContext).pop(item);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
