import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/text_form_field.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) => Expanded(
        child: CustomTextField(
          hintText: 'search now..',
          controller: di<SearchCubit>().searchController!,
          inputType: TextInputType.text,
          prefixIcon: IconBroken.Search,
          suffixIcon: di<SearchCubit>().searchController!.text.isNotEmpty
              ? GestureDetector(
                  onTap: () => di<SearchCubit>().clearSearchTextField(),
                  child: Icon(
                    Icons.close,
                    size: AppSize.s18,
                    color: AppColors.red,
                  ),
                )
              : null,
          onChange: (value) =>
              di<SearchCubit>().onChangeSearchTextField(value: value),
        ),
      ),
    );
  }
}
