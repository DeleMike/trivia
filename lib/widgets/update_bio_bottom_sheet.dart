import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../core/auth/controllers/auth_controller.dart';

import '../configs/constants.dart';

class UpdateBioBottomSheet extends StatelessWidget {
  const UpdateBioBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kScreenWidth(context),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(kPaddingS),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(55),
                ),
                child: CircleAvatar(
                    radius: 55,
                    backgroundColor: kTransparent,
                    child: Visibility(
                      visible: !context.watch<AuthController>().hasPickedImageSuccessfully,
                      child: TextButton.icon(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        icon: const Icon(Icons.image),
                        label: Text(
                          'change image',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kPrimaryColor),
                        ),
                        onPressed: () => context.read<AuthController>().pickProfileUpdateImage(),
                      ),
                    ),
                    backgroundImage: context.watch<AuthController>().updateProfilePickedImgFile != null
                        ? FileImage(context.watch<AuthController>().updateProfilePickedImgFile!)
                        : null),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      context.read<AuthController>().updateProfileUsername = value;
                    },
                    keyboardType: TextInputType.name,
                    autocorrect: true,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: kBlack,
                        fontFamily: GoogleFonts.caveatBrush().fontFamily,
                      ),
                      labelText: 'Enter your geek name',
                      border: const UnderlineInputBorder(),
                      fillColor: kCanvasColor,
                      filled: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(kPaddingS),
            child: ElevatedButton.icon(
              onPressed: () async {
                await context.read<AuthController>().updateUserProfile(context);
                context.read<AuthController>().clearStates();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.upgrade),
              label: Padding(
                padding: const EdgeInsets.all(kPaddingS + 5),
                child: Text(
                  'Update changed data',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kWhite),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
