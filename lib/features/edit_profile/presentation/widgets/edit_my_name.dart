import 'package:flutter/material.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/edit_profile/presentation/widgets/edit_name_text_field.dart';
import 'package:nuntius/features/edit_profile/presentation/widgets/save_and_cancel_buttons.dart';

class EditMyName extends StatefulWidget {
  const EditMyName({super.key});

  @override
  State<EditMyName> createState() => _EditMyNameState();
}

class _EditMyNameState extends State<EditMyName> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightBlack,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s10),
                        topRight: Radius.circular(AppSize.s10),
                      )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppHeight.h4, horizontal: AppWidth.w8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppHeight.h4),
                        LargeHeadText(
                          text: "Enter your name",
                          size: FontSize.s13,
                        ),
                        SizedBox(height: AppHeight.h4),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            children: [
                              const EditNameTextField(),
                              SizedBox(height: AppHeight.h4),
                              const SaveAndCancelButtons(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        icon: Icon(
          IconBroken.Edit,
          size: AppSize.s16,
          color: AppColors.grey,
        ));
  }
}
