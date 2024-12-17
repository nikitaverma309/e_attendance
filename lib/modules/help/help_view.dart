import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class HintView extends StatelessWidget {
  final List<Map<String, String>> faqList = [
    {
      'question': 'How to login?',
      'answer': 'Click on the login button and enter your credentials.',
    },
    {
      'question': 'How to reset my password?',
      'answer': 'Click on forgot password and follow the instructions.',
    },
    {
      'question': 'Help & Support',
      'answer': 'Click here to view the Help and Support PDF.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView.builder(
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(faqList[index]['question']!),
            children: [
              ListTile(
                title: Text(faqList[index]['answer']!),
                onTap: () {
                  if (faqList[index]['question'] == 'Help & Support') {
                    // Open URL with PDF
                    _openPDF('https://finance.cg.gov.in/budget_doc/2023-2024/Budget-Speech/Budget-Speech.pdf');
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // Function to open the URL
  Future<void> _openPDF(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not open the URL';
    }
  }
}

