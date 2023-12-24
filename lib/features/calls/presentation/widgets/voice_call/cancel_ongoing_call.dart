import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/calls/cubit/calls_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelOngoingCall extends StatelessWidget {
  const CancelOngoingCall({
    super.key,
    required this.userToken,
  });
  final String userToken;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsCubit, CallsState>(
      builder: (context, state) => FloatingActionButton(
        onPressed: () => state.maybeWhen(
          cancelCallLoading: () => () {},
          orElse: () {
            if (!CallsCubit.get(context).isJoined) {
              Go.back(context: context);
            } else {
              CallsCubit.get(context).cancelCall(userToken: userToken);
            }
            return null;
          },
        ),
        backgroundColor: AppColors.red,
        child: state.maybeWhen(
          cancelCallLoading: () => CustomCircleIndicator(
            color: AppColors.white,
            size: AppSize.s18,
            strokeWidth: 1,
          ),
          orElse: () => const Icon(
            IconBroken.Call,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
