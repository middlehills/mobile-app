import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mid_hill_cash_flow/core/widgets/error_dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/records/data/transaction_model.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_provider.dart';
import 'package:mid_hill_cash_flow/features/records/presentation/filter_records_row.dart';
import 'package:mid_hill_cash_flow/features/records/presentation/income_card.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:provider/provider.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final focusNode = FocusNode();
  final controller = TextEditingController();
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
                heightSpacing(10),
                const IncomeCard(),

                heightSpacing(15),

                const FilterRecordsRow(),

                heightSpacing(10),

                MidhillTextField(
                  label: "",
                  isObscure: false,
                  hintText: "Enter item name...",
                  focusNode: focusNode,
                  controller: controller,
                  suffixAsset: MidhillAssets.customIcon(
                    iconName: value.searchFilter.isEmpty ? 'search' : 'close',
                  ),
                  onTapSuffixIcon: () {
                    if (value.searchFilter.isNotEmpty) {
                      value.searchItem('');
                      focusNode.unfocus();
                    }
                  },
                  onchanged: (p0) {
                    value.searchItem(p0);
                  },
                ),
                heightSpacing(10),

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
                                    : SingleChildScrollView(
                                        child: Column(
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
                                              width: mediaQueryWidth(context) *
                                                  0.61,
                                              child: MidhillTexts.text600(
                                                context,
                                                text: value.transactions.isEmpty
                                                    ? "You have no records yet. Upload your first record to get started!"
                                                    : "There is no transaction that matches this filter",
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                                fontSize: 18,
                                              ),
                                            )
                                          ],
                                        ),
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
