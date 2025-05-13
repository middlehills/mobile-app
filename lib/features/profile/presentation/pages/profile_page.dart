import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/profile/presentation/components/delete_account_dialog.dart';
import 'package:mid_hill_cash_flow/features/profile/presentation/components/logout_dialog.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: midhillAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: mediaQueryHeight(context) * 0.06,
                child: MidhillTexts.text600(
                  context,
                  text: "Profile",
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: mediaQueryHeight(context) * 0.05,
                child: MidhillTexts.text400(
                  context,
                  text: "My account",
                  color: const Color(0xff777777),
                  fontSize: 18,
                ),
              ),
              ...List.generate(
                5,
                (index) {
                  List<String> titles = [
                    'Profile Details',
                    'Security',
                    'Bank Account Details',
                    'Logout',
                    'Delete Account',
                  ];
                  List<String> icons = [
                    'profile-details',
                    'security',
                    'bank-account',
                    'logout',
                    'delete',
                  ];
                  return InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          context.goNamed(MidhillRoutesList.profileDetailsPage);
                        case 1:
                          context.goNamed(MidhillRoutesList.securityPage);
                        case 2:
                          context.goNamed(MidhillRoutesList.accountPage);
                        case 3:
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: MidhillColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                content: const LogoutDialog(),
                              );
                            },
                          );
                        case 4:
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: MidhillColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                content: const DeleteAccountDialog(),
                              );
                            },
                          );
                          break;

                        default:
                          null;
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0x82777777),
                          ),
                        ),
                      ),
                      height: mediaQueryHeight(context) * 0.08,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            MidhillAssets.customIcon(
                              iconName: icons[index],
                            ),
                            colorFilter: index == icons.length - 1
                                ? null
                                : const ColorFilter.mode(
                                    Color.fromRGBO(18, 18, 18, 0.8),
                                    BlendMode.srcIn,
                                  ),
                          ),
                          widthSpacing(8),
                          MidhillTexts.text400(
                            context,
                            text: titles[index],
                            fontSize: 20,
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            MidhillAssets.customIcon(
                              iconName: 'arrow-right',
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
