import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/contacts/presentation/widgets/contacts/contact_view.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final List<UserData> searchResult;
  const SearchResult({super.key, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: searchResult.length,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: AppHeight.h5),
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(left: AppWidth.w10),
        child: ContactView(user: searchResult[index]),
      ),
    );
  }
}
