import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/no_items_founded.dart';
import 'package:nuntius/core/shared_widgets/sliver_scrollable_view.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/presentation/widgets/calls/calls_items.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsCubit, CallsState>(
      buildWhen: (previous, current) => current.maybeWhen(
        getCallsLoading: () => true,
        getCalls: (calls) => true,
        getCallsError: (errorMsg) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return state.maybeWhen(
          getCallsLoading: () => const Center(child: CustomCircleIndicator()),
          orElse: () => SliverScrollableView(
            isScrollable: di<CallsCubit>().calls.isNotEmpty,
            child: di<CallsCubit>().calls.isEmpty
                ? const NoItemsFounded(
                    text:
                        'there is no calls yet, keep in touch with your friends and call them now.',
                    icon: IconBroken.Call,
                  )
                : CallsItems(calls: di<CallsCubit>().calls),
          ),
        );
      },
    );
  }
}
