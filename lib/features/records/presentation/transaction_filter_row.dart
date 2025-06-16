import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_provider.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:provider/provider.dart';

class TransactionFilterRow extends StatelessWidget {
  const TransactionFilterRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27,
      child: Consumer<RecordsProvider>(
        builder: (BuildContext context, RecordsProvider value, Widget? child) =>
            ListView.separated(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            FilterRange thisFilterRange = FilterRange.values[index];

            String filterRangeString = thisFilterRange.toReadableString();

            return InkWell(
              onTap: () {
                // value.setFilterRange(thisFilterRange);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  // color: value.filterRange == thisFilterRange
                  //     ? const Color.fromRGBO(18, 18, 18, 0.04)
                  //     : null,
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: MidhillTexts.text600(
                  context,
                  text: filterRangeString,
                  // color: value.filterRange == thisFilterRange
                  //     ? MidhillColors.primaryColor
                  //     : const Color(0xff667185),
                  fontSize: 13,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => widthSpacing(10),
        ),
      ),
    );
  }
}

enum FilterRange { all, today, thisWeek, thisMonth }

extension FilterRangeExtension on FilterRange {
  String toReadableString() {
    switch (this) {
      case FilterRange.all:
        return "All";
      case FilterRange.today:
        return "Today";
      case FilterRange.thisWeek:
        return "This Week";
      case FilterRange.thisMonth:
        return "This Month";
    }
  }
}
