import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_provider.dart';
import 'package:mid_hill_cash_flow/features/records/presentation/transaction_filter_row.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';
import 'package:provider/provider.dart';

class FilterRecordsRow extends StatelessWidget {
  const FilterRecordsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordsProvider>(
      builder: (BuildContext context, RecordsProvider value, Widget? child) =>
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      value.selectDate(null);
                      value.setFilterRange(null);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      constraints: BoxConstraints(
                        minWidth: mediaQuery(context).width * 0.2,
                      ),
                      decoration: BoxDecoration(
                        color: value.filterRange == null
                            ? MidhillColors.dartkGradientColor
                            : null,
                        borderRadius: BorderRadius.circular(12),
                        border: value.filterRange != null
                            ? Border.all(
                                color: MidhillColors.dartkGradientColor,
                              )
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MidhillTexts.text400(
                            context,
                            text: value.selectedDate == null
                                ? "All"
                                : DateFormat('dd MMMM yyyy')
                                    .format(value.selectedDate!),
                            fontSize: 18,
                            color: value.filterRange == null
                                ? MidhillColors.white
                                : MidhillColors.dartkGradientColor,
                          ),
                          if (value.selectedDate != null) widthSpacing(5),
                          if (value.selectedDate != null)
                            const Icon(
                              Icons.close,
                              color: MidhillColors.white,
                              size: 18,
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (value.selectedDate == null) widthSpacing(10),
                  if (value.selectedDate == null)
                    InkWell(
                      onTap: () {
                        value.setFilterRange(FilterRange.thisWeek);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        constraints: BoxConstraints(
                          minWidth: mediaQuery(context).width * 0.2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: value.filterRange != FilterRange.thisWeek
                              ? null
                              : MidhillColors.dartkGradientColor,
                          border: value.filterRange != FilterRange.thisWeek
                              ? Border.all(
                                  color: MidhillColors.dartkGradientColor,
                                )
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: MidhillTexts.text400(
                          context,
                          text: "This Week",
                          color: value.filterRange != FilterRange.thisWeek
                              ? MidhillColors.dartkGradientColor
                              : MidhillColors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  if (value.selectedDate == null) widthSpacing(10),
                  if (value.selectedDate == null)
                    InkWell(
                      onTap: () {
                        value.setFilterRange(FilterRange.thisMonth);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        constraints: BoxConstraints(
                          minWidth: mediaQuery(context).width * 0.2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: value.filterRange != FilterRange.thisMonth
                              ? null
                              : MidhillColors.dartkGradientColor,
                          border: value.filterRange != FilterRange.thisMonth
                              ? Border.all(
                                  color: MidhillColors.dartkGradientColor,
                                )
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: MidhillTexts.text400(
                          context,
                          text: "This Month",
                          color: value.filterRange != FilterRange.thisMonth
                              ? MidhillColors.dartkGradientColor
                              : MidhillColors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // calendar icon
          InkWell(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 216,
                    padding: const EdgeInsets.only(top: 6.0),
                    color:
                        CupertinoColors.systemBackground.resolveFrom(context),
                    child: SafeArea(
                      top: false,
                      child: CupertinoDatePicker(
                        initialDateTime: value.selectedDate ?? DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime newDate) {
                          // if (newDate.isBefore(
                          //   DateTime.now().subtract(
                          //     const Duration(hours: 23, minutes: 59, seconds: 59),
                          //   ),
                          // )) {
                          //   // Do not set date if before today
                          //   return;
                          // }
                          value.selectDate(newDate);
                        },
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                MidhillAssets.customIcon(
                  iconName: 'calendar',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
