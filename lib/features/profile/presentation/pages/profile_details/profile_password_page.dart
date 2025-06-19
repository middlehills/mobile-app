import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/error_dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_provider.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:provider/provider.dart';

class ProfilePasswordPage extends StatefulWidget {
  const ProfilePasswordPage({super.key});

  @override
  State<ProfilePasswordPage> createState() => _ProfilePasswordPageState();
}

class _ProfilePasswordPageState extends State<ProfilePasswordPage> {
  final pageViewController = PageController();

  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, ((index) => TextEditingController()));
    focusNodes = List.generate(4, ((index) => FocusNode()));
  }

  @override
  Widget build(BuildContext context) {
    return midhillAnnotatedRegion(
      barColor: MidhillColors.primaryColor,
      child: Consumer2<ProfileProvider, ApiUrlProvider>(
        builder: (BuildContext context, ProfileProvider value,
                ApiUrlProvider value3, Widget? child) =>
            Scaffold(
          appBar: midhillAppBar(context),
          backgroundColor: MidhillColors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpacing(10),
                  mBackButton(context),
                  heightSpacing(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MidhillTexts.text700(
                        context,
                        text: "Enter",
                        fontSize: 20,
                      ),
                      heightSpacing(8),
                      MidhillTexts.text400(
                        context,
                        text: "Please enter your PIN to continue",
                        fontSize: 14,
                        color: const Color(0xff6C7A93),
                      ),
                      heightSpacing(24),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      7,
                      (index) => index % 2 == 0
                          ? buildOtpField(
                              context,
                              index: index == 0 ? 0 : index ~/ 2,
                              controllers: controllers,
                              focusNodes: focusNodes,
                            )
                          : widthSpacing(10),
                    ),
                  ),
                  heightSpacing(40),
                  InkWell(
                    child: SizedBox(
                      height: 50,
                      child: midhillButton(
                        context,
                        onPressed: () async {
                          String pin = controllers.map((e) => e.text).join();
                          bool result = await value.updateProfileDetails(
                            baseUrl: value3.apiUrl!,
                            pin: pin,
                          );
                          if (context.mounted) {
                            if (result) {
                              context.goNamed(
                                MidhillRoutesList.profileDetailsOtpPage,
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: ErrorDialogContent(
                                      errorHeader: "Update Details error",
                                      errror: value.updateProfileApiResponse
                                              ?.message ??
                                          "An error ocurred",
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        },
                        text: "Update User",
                        isLoading: value.isProfileUpdating,
                        isEnabled: controllers.every(
                            (controller) => controller.value.text.isNotEmpty),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
