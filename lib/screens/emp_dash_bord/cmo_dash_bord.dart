import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/generated/assets.dart';
import 'package:online/screens/emp_dash_bord/widgets/card_dash_bord.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';

class UserDashBord extends StatefulWidget {
  const UserDashBord({super.key});

  @override
  State<UserDashBord> createState() => _UserDashBordState();
}

class _UserDashBordState extends State<UserDashBord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF5ECF4F5),
      appBar: const CustomAppBar(
        title: 'Master Dashboard',
        showDrawer: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Shape.getStyledCard(
                        context,
                        [
                          Row(
                            children: [
                              Expanded(
                                child: DashBordCard(
                                  image: Assets.assetsFaceId,
                                  title: Strings.login,
                                  numberTwo: '180',
                                  onPressed: () {
                                    // Get.to(() => const TotalUlb());
                                  },
                                  // gradientColors: [],
                                ),
                              ),
                              Expanded(
                                child: DashBordCard(
                                  image: Assets.assetsFaceId,
                                  title: Strings.login,
                                  numberTwo: '180',
                                  onPressed: () {
                                    // Get.to(() => const TotalUlb());
                                  },
                                  // gradientColors: [],
                                ),
                              ),
                            ],
                          ),
                          10.height,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
