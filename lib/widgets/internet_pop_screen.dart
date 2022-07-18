import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';

import '../configs/constants.dart';

/// Pops up when there is no internet connection in the app.
class InternetPopScreen extends StatelessWidget {
  /// Pops up when there is no internet connection in the app.
  const InternetPopScreen({Key? key}) : super(key: key);

  /// check if connected to the internet
  void _checkOnlineStatus(BuildContext context) async {
    bool isOnline = false;
    isOnline = await InternetConnectionChecker().hasConnection;
    String text = isOnline ? 'Connected to the interent' : 'No internet connection';
    Color color = isOnline ? kGreen : kRed;

    showSimpleNotification(
      Text(
        text,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              color: kWhite,
              fontSize: 20,
            ),
      ),
      background: color,
      trailing: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: kWhite),
        ),
        onPressed: () {},
        child: Text(
          isOnline ? 'Let\'s Go ' : 'Okay',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: kWhite,
                fontSize: 20,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(kPaddingS),
                child: Text(
                  'Connect to the Internet'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                ),
              ),
              SizedBox(
                height: kScreenHeight(context) * 0.40,
                child: Lottie.asset(AssetsAnimations.noInternet),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kPaddingM + 2, right: kPaddingM + 2, bottom: kPaddingM),
                child: Text(
                  'Please connect to the internet to enjoy a smooth experience...',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3.0,
                      ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: kPaddingM + 2, right: kPaddingM + 2, top: kPaddingM),
                child: ElevatedButton(
                  child: Text(
                    'Check Internet connection',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(kScreenWidth(context), kScreenHeight(context) * 0.05),
                    padding: const EdgeInsets.all(kPaddingM - 5),
                  ),
                  onPressed: () {
                    _checkOnlineStatus(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
