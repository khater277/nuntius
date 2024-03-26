import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius/features/stories/presentation/widgets/stories/my_story/no_stories_exist.dart';
import 'package:flutter/material.dart';

class AddMyStoryProfileImage extends StatelessWidget {
  final List<StoryModel> stories;

  const AddMyStoryProfileImage({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (previous, current) => current.maybeWhen(
        updateProfileImageLoading: () => true,
        updateProfileImage: () => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        final image = di<UserStorage>().getUser()!.image ?? "";
        if (image == "" && stories.isEmpty) {
          return SizedBox(
              width: AppSize.s40,
              height: AppSize.s40,
              child: Stack(
                children: [
                  Align(
                      alignment: AlignmentDirectional.center,
                      child: Icon(
                        IconBroken.Profile,
                        color: AppColors.blue,
                        size: AppSize.s30,
                      )),
                  // if(stories.isEmpty)
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppHeight.h1, horizontal: AppWidth.w1),
                      child: CircleAvatar(
                        radius: AppSize.s8,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                            radius: AppSize.s6,
                            backgroundColor: AppColors.blue.withOpacity(0.7),
                            child: Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: AppSize.s10,
                            )),
                      ),
                    ),
                  ),
                ],
              ));
        } else {
          return stories.isEmpty
              ? NoStoriesExist(image: image)
              : Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    CircleAvatar(
                      radius: AppSize.s24,
                      backgroundColor: Colors.grey.withOpacity(0.7),
                    ),
                    CircleAvatar(
                      radius: AppSize.s22,
                      backgroundColor: image == ""
                          ? AppColors.lightBlack
                          : AppColors.blue.withOpacity(0.2),
                      backgroundImage: image == ""
                          ? null
                          : CachedNetworkImageProvider(image),
                      child: image != ""
                          ? null
                          : const Icon(
                              IconBroken.Profile,
                              color: AppColors.blue,
                            ),
                    ),
                  ],
                );
        }
      },
    );
  }
}
