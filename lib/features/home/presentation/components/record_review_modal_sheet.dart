import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/error_dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/home/domain/upload_provider.dart';
import 'package:mid_hill_cash_flow/features/nav_bar/nav_bar_provider.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:provider/provider.dart';

class RecordReviewModalSheet extends StatefulWidget {
  const RecordReviewModalSheet({
    super.key,
  });

  @override
  State<RecordReviewModalSheet> createState() => _RecordReviewModalSheetState();
}

class _RecordReviewModalSheetState extends State<RecordReviewModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQueryWidth(context),
      decoration: const BoxDecoration(
        color: MidhillColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Consumer2<UploadProvider, ApiUrlProvider>(
        builder: (BuildContext context, UploadProvider value,
                ApiUrlProvider apiUrlProvider, Widget? child) =>
            Stack(
          children: [
            Column(
              children: [
                heightSpacing(5),
                Row(
                  children: [
                    const Expanded(flex: 4, child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xffD9D9D9),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 4,
                      child: SizedBox(),
                    ),
                  ],
                ),
                heightSpacing(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      MidhillAssets.customIcon(
                        iconName: "cart",
                      ),
                      height: 24,
                      fit: BoxFit.fitHeight,
                    ),
                    widthSpacing(4),
                    MidhillTexts.text600(context, text: "Items"),
                    widthSpacing(4),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: MidhillColors.primaryColor,
                      child: Center(
                        child: MidhillTexts.text600(
                          context,
                          text: value.uploads.length.toString(),
                          fontSize: 12,
                          color: MidhillColors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        // value.setAddingNewRecordState(true);
                        context.pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0x18121212),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              color: MidhillColors.black,
                              size: 24,
                            ),
                            MidhillTexts.text600(
                              context,
                              text: "Add Record",
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                heightSpacing(15),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
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
                                    text: value.uploads[index].itemName,
                                    color: const Color(0xCC101928),
                                    fontSize: 14,
                                  ),
                                  heightSpacing(10),
                                  MidhillTexts.text400(
                                    context,
                                    text: value.uploads[index].quantity,
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
                                    MidhillTexts.text400(
                                      context,
                                      text: value.uploads[index].amount
                                          .toString(),
                                      color: MidhillColors.black,
                                      fontSize: 18,
                                    ),
                                    widthSpacing(15),
                                    IconButton(
                                      onPressed: () {
                                        value.deleteRecord(
                                          createdAt:
                                              value.uploads[index].createdAt,
                                        );
                                        if (value.uploads.isEmpty) {
                                          context.pop();
                                        }
                                      },
                                      icon: SvgPicture.asset(
                                        MidhillAssets.customIcon(
                                          iconName: "delete",
                                        ),
                                        height: 18,
                                        fit: BoxFit.fitHeight,
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
                    separatorBuilder: (context, index) => heightSpacing(10),
                    itemCount: value.uploads.length,
                  ),
                )
              ],
            ),

            // upload button
            Positioned(
              bottom: 4,
              child: SizedBox(
                width: mediaQueryWidth(context) - 32,
                child: midhillButton(
                  context,
                  isLoading: value.isSavingRecordsToServer,
                  isEnabled: !value.isSavingRecordsToServer,
                  onPressed: () async {
                    bool result = await value.saveRecordsToServer(
                      baseUrl: apiUrlProvider.apiUrl!,
                    );

                    if (result) {
                      if (context.mounted) {
                        value.clearRecords();
                        context.pop();
                        Provider.of<NavBarProvider>(context, listen: false)
                            .updateIndex(1);
                      }
                    } else if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: ErrorDialogContent(
                              errorHeader:
                                  value.recordsToServerApiResponse!.message!,
                              errror: value
                                  .recordsToServerApiResponse!.data!["error"],
                            ),
                          );
                        },
                      );
                    }
                  },
                  text: "Done",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
