import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/generated/assets.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/footer_widget.dart';

import '../../constants/string_res.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, dynamic>> faqData = [
    {
      'category': 'General Questions',
      'questions': [
        {
          'question': 'What is the Online Attendance System?',
          'answer':
              'It is a digital platform to record and manage attendance for higher education students and staff.',
        },
        {
          'question': 'Why is online attendance required?',
          'answer':
              'To ensure transparency and efficiency in attendance management.',
        },
      ],
    },
    {
      'category': 'Account Access',
      'questions': [
        {
          'question': 'How do I register for the system?',
          'answer':
              'You can register using your institutional email on the registration page.',
        },
        {
          'question': 'What should I do if I forget my password?',
          'answer': 'Click on "Forgot Password" and follow the instructions.',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Strings.faq,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        50),
                  ),
                  color: const Color(0xff5699c9),
                  elevation: 6,
                  child: const Image(
                    image: AssetImage(Assets.imagesCglogo),
                    height: 66,
                    width: 66,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            10.height,
            const Text("Higher Education Department's",
                style: kText10BlueBlackColorStyle),
            16.height,
            Expanded(
              child: ListView.builder(
                itemCount: faqData.length,
                itemBuilder: (context, index) {
                  final category = faqData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ExpansionTile(
                      leading: const Icon(Icons.category,
                          color: Colors.blue), // Add leading icon
                      title: Text(
                        category['category'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      backgroundColor:
                          Colors.grey[200],
                      collapsedBackgroundColor:
                          Colors.white,
                      collapsedIconColor:
                          Colors.blue,
                      iconColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        // Add border to the tile
                        side: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      children: category['questions'].map<Widget>((q) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: Shape.submitContainerRed(context),
                          child: ListTile(
                            title: Text(
                              q['question'],
                                style: k13BoldBlackColorStyle
                            ),
                            subtitle: Text(
                              q['answer'],
                                style: k13NormalGreyColorStyle
                            ),
                            leading: const Icon(Icons.help_outline,
                                color: Colors.blue),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            16.height,
          ],
        ),
      ),
      bottomSheet: FooterWidget(),
    );
  }
}
