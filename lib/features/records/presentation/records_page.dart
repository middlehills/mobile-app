import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/records/data/records_model.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_provider.dart';
import 'package:mid_hill_cash_flow/features/records/presentation/blurred_text.dart';
import 'package:mid_hill_cash_flow/features/records/presentation/transaction_filter_row.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';
import 'package:provider/provider.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return midhillAnnotatedRegion(
      barColor: MidhillColors.primaryColor,
      child: Scaffold(
        appBar: midhillAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<RecordsProvider>(
            builder:
                (BuildContext context, RecordsProvider value, Widget? child) =>
                    Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpacing(15),
                MidhillTexts.text600(
                  context,
                  text: "Records",
                  fontSize: 20,
                ),
                heightSpacing(15),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xffEDF4FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
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
                              value.showIncome
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 16,
                            ),
                          )
                        ],
                      ),

                      heightSpacing(10),

                      // amount
                      BlurredText(
                        'N 40, 391.00',
                        blurRadius: value.showIncome ? 0 : 5,
                        style: MidhillStyles.textStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: MidhillColors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                heightSpacing(20),

                // transaction rows
                const TransactionFilterRow(),

                heightSpacing(15),

                // transaction List
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final thisRecord = dummyRecords[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: MidhillColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color: const Color(0x09121212),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MidhillTexts.text400(
                                    context,
                                    text: thisRecord.itemName,
                                    color: const Color(0xff101928),
                                    fontSize: 14,
                                  ),
                                  heightSpacing(10),
                                  MidhillTexts.text400(
                                    context,
                                    text:
                                        "${thisRecord.quantity} unit(s) | ${DateFormat("hh:mm a").format(thisRecord.updatedAt)}",
                                    color: const Color(0xCC101928),
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    MidhillTexts.text600(
                                      context,
                                      text: "N ${thisRecord.amount}",
                                      color: const Color(0xB1121212),
                                      fontSize: 18,
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.more_vert_rounded),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return heightSpacing(10);
                    },
                    itemCount: dummyRecords.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
