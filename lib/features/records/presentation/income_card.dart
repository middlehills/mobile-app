import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_functions.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_provider.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:provider/provider.dart';

class IncomeCard extends StatelessWidget {
  const IncomeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffEDF4FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Consumer<RecordsProvider>(
        builder: (BuildContext context, RecordsProvider value, Widget? child) =>
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MidhillTexts.text400(
                  context,
                  text: "Total Income",
                  color: const Color(0xff6C7A93),
                ),
                widthSpacing(10),
                InkWell(
                  onTap: () {
                    value.setShowIncomeState(!value.showIncome);
                  },
                  child: Icon(
                    value.showIncome && value.transactions.isNotEmpty
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 16,
                  ),
                )
              ],
            ),
            heightSpacing(10),
            value.showIncome
                ? MidhillTexts.text700(
                    context,
                    text:
                        'N ${RecordsFunctions.formatMoney(value.totalIncome)}',
                    fontSize: 28,
                    color: MidhillColors.black,
                  )
                : SizedBox(
                    height: 20,
                    child: Image.asset(
                      MidhillAssets.customImage(
                        iconName: 'hidden-code',
                      ),
                    ),
                  ),
            if (!value.showIncome) heightSpacing(8),
          ],
        ),
      ),
    );
  }
}
