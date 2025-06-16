import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mid_hill_cash_flow/core/widgets/error_dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/records/data/transaction_model.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_provider.dart';
import 'package:mid_hill_cash_flow/features/records/presentation/income_card.dart';
import 'package:mid_hill_cash_flow/features/records/presentation/transaction_filter_row.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:provider/provider.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  void initState() {
    super.initState();
    final recordsProvider =
        Provider.of<RecordsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        bool result = await recordsProvider.fetchRecordsFromServer(
          baseUrl: Provider.of<ApiUrlProvider>(context, listen: false).apiUrl!,
        );
        if (!result && mounted) {
          if (recordsProvider.recordsApiResponse?.message !=
              "No transactions found") {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: ErrorDialogContent(
                    errorHeader: "Records Fetching Error",
                    errror: recordsProvider.recordsApiResponse!.message ??
                        "An error occured",
                  ),
                );
              },
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return midhillAnnotatedRegion(
      barColor: MidhillColors.primaryColor,
      child: Scaffold(
        appBar: midhillAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer2<RecordsProvider, ApiUrlProvider>(
            builder: (BuildContext context, RecordsProvider value,
                    apiUrlProvider, Widget? child) =>
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
                const IncomeCard(),

                heightSpacing(28),

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
                                          color:
                                              MidhillColors.dartkGradientColor,
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
                                    if (value.selectedDate != null)
                                      widthSpacing(5),
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
                                    color: value.filterRange !=
                                            FilterRange.thisWeek
                                        ? null
                                        : MidhillColors.dartkGradientColor,
                                    border: value.filterRange !=
                                            FilterRange.thisWeek
                                        ? Border.all(
                                            color: MidhillColors
                                                .dartkGradientColor,
                                          )
                                        : null,
                                  ),
                                  alignment: Alignment.center,
                                  child: MidhillTexts.text400(
                                    context,
                                    text: "This Week",
                                    color: value.filterRange !=
                                            FilterRange.thisWeek
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
                                    color: value.filterRange !=
                                            FilterRange.thisMonth
                                        ? null
                                        : MidhillColors.dartkGradientColor,
                                    border: value.filterRange !=
                                            FilterRange.thisMonth
                                        ? Border.all(
                                            color: MidhillColors
                                                .dartkGradientColor,
                                          )
                                        : null,
                                  ),
                                  alignment: Alignment.center,
                                  child: MidhillTexts.text400(
                                    context,
                                    text: "This Month",
                                    color: value.filterRange !=
                                            FilterRange.thisMonth
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
                              color: CupertinoColors.systemBackground
                                  .resolveFrom(context),
                              child: SafeArea(
                                top: false,
                                child: CupertinoDatePicker(
                                  initialDateTime:
                                      value.selectedDate ?? DateTime.now(),
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

                heightSpacing(15),

                // transaction List
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          await value.fetchRecordsFromServer(
                            baseUrl: apiUrlProvider.apiUrl!,
                          );
                        },
                        child: value.filteredTransactions.isEmpty
                            ? SizedBox(
                                width: mediaQueryWidth(context),
                                child: value.isRecordFetching
                                    ? null
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            MidhillAssets.customIcon(
                                              iconName: 'transaction',
                                            ),
                                          ),
                                          heightSpacing(18),
                                          SizedBox(
                                            width:
                                                mediaQueryWidth(context) * 0.61,
                                            child: MidhillTexts.text600(
                                              context,
                                              text:
                                                  "You have no records yet. Upload your first record to get started!",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.clip,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  final Transaction thisRecord =
                                      value.filteredTransactions[index];
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                    "${thisRecord.quantity} unit(s) | ${DateFormat("hh:mm a").format(thisRecord.updatedAt)} • ${DateFormat("d MMMM").format(thisRecord.updatedAt)} ",
                                                color: const Color(0xCC101928),
                                                fontSize: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                MidhillTexts.text600(
                                                  context,
                                                  text:
                                                      "N ${thisRecord.amount}",
                                                  color:
                                                      const Color(0xB1121212),
                                                  fontSize: 18,
                                                ),
                                                PopupMenuButton(
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      value: 'delete',
                                                      child:
                                                          MidhillTexts.text700(
                                                        context,
                                                        text: "Delete",
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                  onSelected: (_) async {
                                                    if (!value
                                                        .isDeletingRecord) {
                                                      bool result = await value
                                                          .deleteRecord(
                                                        baseUrl: apiUrlProvider
                                                            .apiUrl!,
                                                        transaction: thisRecord,
                                                        index: index,
                                                      );
                                                      if (!result &&
                                                          context.mounted) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              content:
                                                                  ErrorDialogContent(
                                                                errorHeader:
                                                                    "Delete record error",
                                                                errror: value
                                                                        .deleteRecordFromServerApiResponse!
                                                                        .message ??
                                                                    "An error ocurred",
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5,
                                                    ),
                                                    child: const Icon(
                                                      Icons.more_vert_rounded,
                                                    ),
                                                  ),
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
                                itemCount: value.filteredTransactions.length,
                              ),
                      ),

                      // progress
                      if (value.isRecordFetching || value.isDeletingRecord)
                        const CircularProgressIndicator(),
                    ],
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
