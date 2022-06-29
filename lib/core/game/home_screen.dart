import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../configs/routes.dart';
import '../../data/category_data.dart';
import 'screens/question_form.dart';
import '../../helpers/user_pref.dart';
import '../../configs/constants.dart';
import '../../configs/app_extensions.dart';

///It will be used to show greetings and display some options
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //fetch user data
  Future<int> _loadData(BuildContext context) async {
    await context.read<UserPref>().fetchData();
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _loadData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SafeArea(child: Center(child: CircularProgressIndicator(color: kPrimaryColor)));
            } else if ((snapshot.connectionState == ConnectionState.done) && snapshot.hasData) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //stack
                      SizedBox(
                        height: kScreenHeight(context) * 0.40,
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(kPaddingS),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 21,
                                    backgroundColor: kWhite,
                                    backgroundImage: FileImage(
                                      File(context.read<UserPref>().userData['imagepath']!),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      context.read<UserPref>().userData['username']!.capitalize(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                            fontSize: 16,
                                            color: kWhite,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              height: kScreenHeight(context) * 0.25,
                              decoration: const BoxDecoration(
                                color: kPrimaryTextColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(kSmallRadius),
                                  bottomRight: Radius.circular(kSmallRadius),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: const EdgeInsets.only(left: kPaddingS + 2, right: kPaddingM + 2),
                                height: kScreenHeight(context) * 0.25,
                                decoration: const BoxDecoration(
                                  color: kBlack,
                                  borderRadius: BorderRadius.all(Radius.circular(kSmallRadius)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: kPaddingS),
                                      width: kScreenWidth(context) * 0.35,
                                      child: Align(child: Image.asset(AssetsImages.homeBannerImg)),
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                        width: kScreenWidth(context) * 0.55,
                                        child: Align(
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'Play & Win.\n',
                                                style: TextStyle(
                                                  fontFamily: GoogleFonts.caveatBrush().fontFamily,
                                                  fontSize: 30,
                                                ),
                                                children: const [
                                                  TextSpan(text: ''),
                                                  TextSpan(text: 'Last quiz: 80%'),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //categories
                      Container(
                        margin: const EdgeInsets.only(
                            left: kPaddingS + 2, right: kPaddingM + 2, bottom: kPaddingM),
                        height: kScreenHeight(context) * 0.05,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(kPaddingS),
                              child: Text(
                                'Top Quiz Categories',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 16, color: kBlack, fontWeight: FontWeight.w900),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: kLightPrimaryColor,
                              ),
                              onPressed: () => Navigator.of(context).pushNamed(Routes.categories),
                              child: Padding(
                                padding: const EdgeInsets.all(kPaddingS - 5),
                                child: Text(
                                  'View All',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 12, color: kDarkPrimaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin:
                            const EdgeInsets.only(top: kPaddingM, left: kPaddingS + 2, right: kPaddingM + 2),
                        height: kScreenHeight(context) * 0.5,
                        child: const _GridContainer(),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Visibility(
              child: Text('Something went wrong...'),
            );
          }),
    );
  }
}

class _GridContainer extends StatelessWidget {
  const _GridContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemBuilder: (ctx, index) {
        // ignore: avoid_print
        return InkWell(
            onTap: (() {
              debugPrint('Position $index clicked');
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.0),
                  ),
                ),
                context: context,
                builder: (_) => QuestionForm(
                  name: categories[index].categoryName,
                  imageUrl: categories[index].categoryImgSrc,
                  tag: categories[index].categoryTag,
                ),
              );
            }),
            child: Card(
              elevation: kCardElevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kMediumRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 50, height: 50),
                    child: Image.asset(categories[index].categoryImgSrc),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        categories[index].categoryName.removeColon(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
