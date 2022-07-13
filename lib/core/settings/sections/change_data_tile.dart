import 'package:flutter/material.dart';

import '../../../widgets/update_bio_bottom_sheet.dart';
import '../../../configs/constants.dart';

class ChangeDataTile extends StatelessWidget {
  const ChangeDataTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kPaddingM + 2, bottom: kPaddingS),
      child: InkWell(
        onTap: () {
          debugPrint('Open \'change bio\' page');
          // show bottomsheet
          showBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
            ),

            context: context,
            builder: (ctx) => const UpdateBioBottomSheet(),
          );
        },
        child: ListTile(
          title: Text('Biodata', style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16)),
          subtitle: const Text('change your name or profile picture'),
        ),
      ),
    );
  }
}
