import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/generated/assets.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';

class FaqScreen extends StatelessWidget {
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
        {
          'question': 'Is the system secure?',
          'answer': 'Yes, the system uses secure protocols to protect user data.',
        },
      ],
    },
    {
      'category': 'Face Registration & Verification',
      'questions': [
        {
          'question': 'How to register your face for the first time?',
          'answer': 'Enter your Employee Code and capture your face during the first-time registration, then follow the on-screen instructions.',
        },
        {
          'question': 'What if my location is not verified?',
          'answer':
          'Ensure that you are within the permitted location area and try again.',
        },
        {
          'question':
          'What happens if both location and face verification are successful?',
          'answer':
          'The system will record your attendance once both verifications are complete.',
        },
        {
          'question': 'Can I register multiple faces for one employee code?',
          'answer':
          'No, only one face can be registered per employee code for security reasons.',
        },
      ],
    },
    {
      'category': 'Troubleshooting',
      'questions': [
        {
          'question': 'What if I forget my Employee Code?',
          'answer': 'Contact your HR or system administrator to retrieve it.',
        },
        {
          'question': 'Why is the face recognition not working?',
          'answer':
          'Ensure good lighting and position your face properly in front of the camera.',
        },
        {
          'question': 'What should I do if the system shows location mismatch?',
          'answer':
          'Check if your GPS is enabled and ensure you are within the authorized location.',
        },
      ],
    },
  ];

  FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "FAQ",
        showBackButton: true, // Back button for easy navigation
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Logo at the top
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
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
            Text(
              "Higher Education Department's",
              style: kText10BlueBlackColorStyle,
            ),
            16.height,
            // FAQ List
            Expanded(
              child: ListView.builder(
                itemCount: faqData.length,
                itemBuilder: (context, index) {
                  final category = faqData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.category,
                        color: Colors.blue,
                      ),
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
                      backgroundColor: Colors.grey[200],
                      collapsedBackgroundColor: Colors.white,
                      collapsedIconColor: Colors.blue,
                      iconColor: Colors.green,
                      shape: RoundedRectangleBorder(
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
                              style: k13BoldBlackColorStyle,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                q['answer'],
                                style: k13NormalGreyColorStyle,
                              ),
                            ),
                            leading: const Icon(
                              Icons.help_outline,
                              color: Colors.blue,
                            ),
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
    );
  }
}
