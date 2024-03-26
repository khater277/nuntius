import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/no_items_founded.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';

class ContactsStoriesEmptyView extends StatelessWidget {
  const ContactsStoriesEmptyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NoItemsFounded(
              text: "There is no stories to show yet.",
              icon: IconBroken.Camera,
            ),
            BlocBuilder<StoriesCubit, StoriesState>(
              buildWhen: (previous, current) => current.maybeWhen(
                showRefreshButton: () => true,
                orElse: () => false,
              ),
              builder: (context, state) {
                if (di<StoriesCubit>().refreshButton) {
                  return IconButton(
                      onPressed: () => di<StoriesCubit>()
                          .getContactsCurrentStories(loading: true),
                      icon: Icon(
                        Icons.refresh,
                        color: AppColors.blue,
                        size: AppSize.s25,
                      ));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
