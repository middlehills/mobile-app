import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
// import 'package:mid_hill_cash_flow/features/authentication/domain/auth_provider.dart';
import 'package:mid_hill_cash_flow/features/home/presentation/pages/upload_page.dart';
import 'package:mid_hill_cash_flow/features/nav_bar/nav_bar_provider.dart';
import 'package:mid_hill_cash_flow/features/profile/presentation/pages/profile_page.dart';
import 'package:mid_hill_cash_flow/features/records/presentation/records_page.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:provider/provider.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  List<Widget> screens = const [
    UploadPage(),
    RecordsPage(),
    ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();
    // final navBarProvider = Provider.of<NavBarProvider>(context);
    // final authProvider = Provider.of<AuthProvider>(context);

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) async {
    //     navBarProvider.setUserId(
    //       authProvider.midhillUser?.id ?? "",
    //       authProvider.midhillUser?.firstName ?? "",
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarProvider>(
      builder: (BuildContext context, value, Widget? child) => PopScope(
        canPop: value.selectedIndex == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (value.selectedIndex != 0) {
            value.updateIndex(0);
          }
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: screens[value.selectedIndex],
                    ),

                    // custom bottom nav bar
                    Container(
                      height: 80,
                      width: mediaQueryWidth(context),
                      decoration: const BoxDecoration(
                        color: Color(0xffF7F7F7),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: List.generate(
                          3,
                          (index) {
                            return Expanded(
                              child: InkWell(
                                onTap: () {
                                  value.updateIndex(index);
                                },
                                child: Container(
                                  height: 48,
                                  decoration: value.selectedIndex == index
                                      ? BoxDecoration(
                                          color: const Color(0xffE7EDF6),
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        )
                                      : null,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        MidhillAssets.customIcon(
                                          iconName: index == 0
                                              ? "home"
                                              : index == 1
                                                  ? "record"
                                                  : "profile",
                                        ),
                                        colorFilter: ColorFilter.mode(
                                          value.selectedIndex == index
                                              ? MidhillColors.primaryColor
                                              : const Color(0xff6C7A93),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      if (value.selectedIndex == index)
                                        widthSpacing(5),
                                      if (value.selectedIndex == index)
                                        MidhillTexts.text600(
                                          context,
                                          text: index == 0
                                              ? "Upload"
                                              : index == 1
                                                  ? "Records"
                                                  : "Profile",
                                          color: MidhillColors.primaryColor,
                                          fontSize: 14,
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
