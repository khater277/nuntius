import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/back_button.dart';
import 'package:nuntius/core/shared_widgets/no_items_founded.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/search/cubit/search_cubit.dart';
import 'package:nuntius/features/search/presentation/widgets/search_result.dart';
import 'package:nuntius/features/search/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    di<SearchCubit>().initSearch();
    super.initState();
  }

  @override
  void dispose() {
    di<SearchCubit>().disposeSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: AppHeight.h8,
            right: AppWidth.w10,
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  CustomBackButton(),
                  SearchTextField(),
                ],
              ),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return Expanded(
                    child: di<SearchCubit>().searchController!.text.isEmpty
                        ? const NoItemsFounded(
                            icon: IconBroken.Search,
                            text: 'search now for your friends.',
                          )
                        : di<SearchCubit>().searchResult.isEmpty
                            ? const NoItemsFounded(
                                icon: IconBroken.User1,
                                text: 'there is no matching results.',
                              )
                            : SearchResult(
                                searchResult: di<SearchCubit>().searchResult),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
