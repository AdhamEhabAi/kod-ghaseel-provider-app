import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../generated/l10n.dart';
import '../../controller/profile_cubit.dart';

class ChooseImageSourceSheet extends StatelessWidget {
  const ChooseImageSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading:  Icon(Icons.camera_alt_outlined),
            title:  Text(S.of(context).camera,style: AppTextStyle.blackW500Size20,),
            onTap: () async {
              Navigator.pop(context);
              await context.read<ProfileCubit>().pickAndSet(fromCamera: true);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(S.of(context).gallery,style: AppTextStyle.blackW500Size20,),
            onTap: () async {
              Navigator.pop(context);
              await context.read<ProfileCubit>().pickAndSet(fromCamera: false);
            },
          ),
        ],
      ),
    );
  }
}
