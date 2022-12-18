import 'package:flutter/material.dart';
import 'package:{{{app_name.snakeCase()}}}/app/global_widgets/text_widget.dart';
import 'package:{{{app_name.snakeCase()}}}/app/res/colors/colors.dart';
import 'package:{{{app_name.snakeCase()}}}/app/res/fonts/font_family.dart';
import 'package:{{{app_name.snakeCase()}}}/app/res/size_values/size_config.dart';
import 'package:{{{app_name.snakeCase()}}}/app/utils/mixin/common_layout_mixin.dart';

class TextFieldDropDown<E> extends StatelessWidget with CommonLayoutMixin {
  final Function(E)? onChange;
  final VoidCallback? onRestartTap;
  final VoidCallback? onTap;
  final bool stretchToWidth;
  final bool isLoading;
  final bool shouldShowReload;
  final bool hasError;
  final double? borderCorners;
  final double? horizontalPadding;
  final double? verticalPadding;
  final String? suffixIconPath;
  final BoxFit? suffixFit;
  final double? suffixSize;
  final List<E> items;
  final String? lable;
  final String? hint;
  final String Function(E)? dropdownValueBuilder;
  final E? value;

  TextFieldDropDown({
    required this.items,
    super.key,
    this.onChange,
    this.onTap,
    this.lable,
    this.horizontalPadding,
    this.verticalPadding,
    this.stretchToWidth = false,
    this.shouldShowReload = true,
    this.borderCorners,
    this.suffixIconPath,
    this.suffixFit,
    this.suffixSize,
    this.hint,
    this.isLoading = false,
    // this.valueId,
    this.dropdownValueBuilder,
    this.value,
    this.hasError = false,
    this.onRestartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lable != null)
          Column(
            children: [
              getVerticalSpace(verticalPadding ?? 4.h),
              TextWidget(
                textSize: 14.sp,
                fontWeight: FontWeight.bold,
                padding: EdgeInsets.only(left: horizontalPadding ?? 16.w),
                text: lable ?? '',
              ),
            ],
          ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(
              left: horizontalPadding ?? 16.w,
              right: horizontalPadding ?? 16.w,
              bottom: 8.h,
              top: 4.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(borderCorners ?? 16.r),
              ),
              border: Border.all(color: AppColors.colorDarkGrey),
            ),
            height: 48.h,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<E>(
                icon: isLoading
                    ? Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: SizedBox(
                          height: 14.h,
                          width: 14.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.green,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                          right: !hasError ? 16.w : 0,
                        ),
                        child: !shouldShowReload
                            ? Container()
                            : hasError
                                ? IconButton(
                                    icon: const Icon(Icons.restart_alt),
                                    onPressed: onRestartTap,
                                  )
                                : Row(
                                    children: [
                                      getHorizontalSpace(40.w),
                                      Image.asset(
                                        suffixIconPath!,
                                        width: suffixSize ?? 14.w,
                                        height: suffixSize ?? 14.h,
                                        fit: suffixFit ?? BoxFit.fitHeight,
                                      ),
                                    ],
                                  ),
                      ),
                value: value,
                isExpanded: stretchToWidth,
                isDense: stretchToWidth,
                selectedItemBuilder: (context) {
                  return items.map((item) {
                    return Container(
                      margin: EdgeInsets.only(left: 16.w),
                      child: TextWidget(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: dropdownValueBuilder != null
                            ? dropdownValueBuilder!(item).toString()
                            : item.toString(),
                        textSize: 14.sp,
                        fontWeight: FontStyles.regular,
                      ),
                    );
                  }).toList();
                },
                hint: Container(
                  margin: EdgeInsets.only(left: 16.w),
                  child: TextWidget(
                    text: hint ?? '',
                    color: AppColors.colorLightGrey,
                    textSize: 14.sp,
                    fontWeight: FontStyles.regular,
                  ),
                ),
                items: items.map((item) {
                  return DropdownMenuItem<E>(
                    value: /*valueId!=null
                        ? valueId.toString()
                        : */
                        item,
                    child: TextWidget(
                      text: dropdownValueBuilder != null
                          ? dropdownValueBuilder!(item)
                          : item.toString(),
                      textSize: 14.sp,
                      fontWeight: FontStyles.regular,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (onChange != null) {
                    onChange?.call(value!);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
