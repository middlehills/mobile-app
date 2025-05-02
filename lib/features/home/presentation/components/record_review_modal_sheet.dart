import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class RecordReviewModalSheet extends StatelessWidget {
  const RecordReviewModalSheet({
    super.key,
  });

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
      child: Column(
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
              MidhillTexts.text600(text: "Items"),
              widthSpacing(4),
              CircleAvatar(
                radius: 12,
                backgroundColor: MidhillColors.primaryColor,
                child: Center(
                  child: MidhillTexts.text600(
                    text: "2",
                    fontSize: 12,
                    color: MidhillColors.white,
                  ),
                ),
              ),
              const Spacer(),
              Container(
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
                      text: "Add Record",
                      fontSize: 14,
                    ),
                  ],
                ),
              )
            ],
          ),
          heightSpacing(15),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                              text: "Plantain",
                              color: const Color(0xCC101928),
                              fontSize: 14,
                            ),
                            heightSpacing(10),
                            MidhillTexts.text400(
                              text: "Quantity: 5",
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
                                text: "N 3500",
                                color: MidhillColors.black,
                                fontSize: 18,
                              ),
                              widthSpacing(15),
                              IconButton(
                                onPressed: () {},
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
              itemCount: 6,
            ),
          )
        ],
      ),
    );
  }
}
