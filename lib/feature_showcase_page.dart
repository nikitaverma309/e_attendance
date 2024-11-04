
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/modules/home/home.dart';
import 'constants/string_res.dart';

class FeatureShowCasePage extends StatefulWidget {
  const FeatureShowCasePage({super.key});

  @override
  State<FeatureShowCasePage> createState() => _FeatureShowCasePageState();
}

class _FeatureShowCasePageState extends State<FeatureShowCasePage> {
  final PageController pageController = PageController();
  int currentPage = 0;
  List<FeatureShowCaseModel> featureList = [
    FeatureShowCaseModel(
        subtitle: Strings.introOneTitle,
        title: Strings.introOneT,
        imgPath: "assets/intro/documentFace.jpg"),
    FeatureShowCaseModel(
        subtitle: Strings.introTwoSub,
        title: Strings.introTwoTi,
        imgPath: "assets/intro/faceCamera.png"),
    FeatureShowCaseModel(
        subtitle: Strings.introThreeSub,
        title: Strings.introThreeT,
        imgPath: "assets/intro/faceIntro.png"),
  ];

  onNext() {
    setState(() {
      pageController.nextPage(
          duration: const Duration(microseconds: 9000), curve: Curves.easeIn);
    });
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    bool isDark =
        Theme.of(context).textTheme.labelMedium!.color == Colors.white;

    buildFeatureDetail({required int index}) {
      var feature = featureList[index];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            // const Spacer(
            //   flex: 1,
            // ),
            Center(
              child: Image.asset(feature.imgPath,
                  height: height * .35, width: width * .99),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .05),
              child: Text(
                feature.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              width: width * .85,
              child: Text(
                feature.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(.7)
                        : Colors.black.withOpacity(.7),
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
            const Spacer(),
          ],
        ),
      );
    }

    buildBottomController() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(featureList.length, (id) {
                    if (id == currentPage) {
                      return Container(
                        width: 28,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.circle,
                          size: 12,
                          color: Colors.blue.withOpacity(.2),
                        ),
                      );
                    }
                  }).toList()),
              SizedBox(
                height: height * .03,
              ),
              currentPage == 2
                  ? SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: () {
                            Get.to(() =>  MyHomePage());
                          },
                          child: const Text(
                            'Get Started',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                    )
                  : Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.to(() =>  MyHomePage());
                            },
                            child: Text(
                              "Skip",
                              style: TextStyle(color: Colors.blue.shade800),
                            )),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            onNext();
                          },
                          child: SizedBox(
                            //   color: Colors.black,
                            width: 100,
                            height: 50,
                            child: Stack(
                              children: [
                                ...List.generate(
                                    3,
                                    (index) => Positioned(
                                        right: index * 10,
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue.shade700
                                                .withOpacity(.15 + index * .13),
                                          ),
                                        ))).toList(),
                                Positioned(
                                    right: 3 * 10,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primary,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: height * .05,
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    onPageChanged: (int pageId) {
                      setState(() {
                        currentPage = pageId;
                      });
                    },
                    itemCount: featureList.length,
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return buildFeatureDetail(index: index);
                    }),
              ),
              buildBottomController()
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureShowCaseModel {
  final String imgPath;
  final String title;
  final String subtitle;

  FeatureShowCaseModel(
      {required this.subtitle, required this.title, required this.imgPath});
}
