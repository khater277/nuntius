import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:flutter/material.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  // @override
  // void initState() {
  //   CallsCubit.get(context).getCalls();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: LargeHeadText(text: "CALLS SCREEN")),
    );
    // return BlocBuilder<CallsCubit, CallsState>(
    //   builder: (context, state) {
    //     final cubit = CallsCubit.get(context);
    //     return state.maybeWhen(
    //       initCalls: () => const Center(child: CustomCircleIndicator()),
    //       getCallsLoading: () => const Center(child: CustomCircleIndicator()),
    //       getCallsError: (errorMsg) =>
    //           errorSnackBar(context: context, errorMsg: errorMsg),
    //       orElse: () => SliverScrollableView(
    //         isScrollable: cubit.calls!.isNotEmpty,
    //         child: cubit.calls!.isEmpty
    //             ? const NoItemsFounded(
    //                 text:
    //                     'there is no calls yet, keep in touch with your friends and call them now.',
    //                 icon: IconBroken.Call,
    //               )
    //             : CallsItems(calls: cubit.calls!),
    //       ),
    //     );
    //   },
    // );
  }
}
