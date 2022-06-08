import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trivia/core/auth/controllers/auth_controller.dart';

import '../../../helpers/dark_theme_provider.dart';
import '../../../widgets/image_banner.dart';
import '../../../widgets/text_banner.dart';
import '../../../configs/constants.dart';

import 'auth_form.dart';

///AuthScreen used to display [AuthForm] widget.
class AuthScreen extends StatelessWidget {
  /// AuthScreen used to display [AuthForm] widget.
  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DarkThemeProvider>(
        builder: (_, theme, __) => SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: kScreenWidth(context),
              height: kScreenHeight(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ImageBanner(),
                  const TextBanner(),
                  AuthForm(),
                  Container(
                    width: kScreenWidth(context),
                    padding: const EdgeInsets.all(kPaddingS),
                    margin: const EdgeInsets.all(kPaddingS),
                    child: ElevatedButton(
                        onPressed: () => context.read<AuthController>().trySubmit(context),
                        child: Padding(
                          padding: const EdgeInsets.all(kPaddingS),
                          child: Text(
                            'Let\'s go!!',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: GoogleFonts.caveatBrush().fontFamily,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
