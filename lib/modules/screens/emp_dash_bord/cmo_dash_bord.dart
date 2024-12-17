import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/modules/auth/SharedPref.dart';
import 'package:online/modules/auth/views/view_drawer.dart';
import 'package:online/modules/help/help_view.dart';
import 'package:online/modules/screens/emp_dash_bord/widgets/card_dash_bord.dart';
import 'package:online/modules/screens/leave_screen.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/generated/assets.dart';
import 'package:online/utils/shap/shape_design.dart';

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
      appBar: AppBar(
        title: const Text('Master Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context), // Close dialog
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          SharedPref.logoutUser(); // Call logout function
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
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
                                  numberTwo: 'Leave',
                                  onPressed: () {
                                    Get.to(() => LeaveListScreen());
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
                                    Get.to(() => HintView());
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
