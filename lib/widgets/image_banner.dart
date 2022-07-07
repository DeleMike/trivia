import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../configs/constants.dart';

///[ImageBanner] - displays app logo
class ImageBanner extends StatelessWidget {
  const ImageBanner({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      width: kScreenWidth(context),
      height: kScreenHeight(context) * 0.25,
      child: SvgPicture.asset(
        AssetsImages.authBannerImg,
        semanticsLabel: 'Trivia Banner',
        
      ),
    );
  }
}
