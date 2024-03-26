import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';

class BookingPopupMenu extends StatelessWidget {
  final List<PopUpInfo> popUpInfoList;
  const BookingPopupMenu({super.key, required this.popUpInfoList});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.more_horiz_outlined, color: AppColors.white),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s15),
            borderSide: BorderSide(
              color: Theme.of(context).hintColor,
            )),
        color: Theme.of(context).hintColor,
        elevation: 2,
        enabled: true,
        onSelected: (PopUpInfo value) {
          // cubit.updateMyBooking(
          //     params: UpdateMyBookingParams(
          //   bookingId: bookingId,
          //   bookingType: value.text!,
          // ));
          // debugPrint(value.text!.toLowerCase());
        },
        itemBuilder: (context) {
          return popUpInfoList.map((PopUpInfo choice) {
            return PopupMenuItem(
              value: choice,
              child: Row(
                children: [
                  Expanded(child: SmallHeadText(text: choice.text)),
                  Icon(
                    choice.icon,
                    color: AppColors.red,
                  )
                ],
              ),
            );
          }).toList();
        });
  }
}

class PopUpInfo {
  final String text;
  final IconData icon;

  PopUpInfo({required this.text, required this.icon});
}
