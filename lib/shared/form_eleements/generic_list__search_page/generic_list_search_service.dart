import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/bloc/ehs_generic_list_bloc.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_list_page_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndependenSearchPageWrapper extends StatelessWidget {
  final String title;
  final String searchLabel;
  final List<GenericListObject> listObjects;
  final Widget customListWidget;
  final Widget addForm;
  final Function search;
  final Function deleted;
  final Function selected;
  final Function add;

  const IndependenSearchPageWrapper(
      {Key key,
      this.title,
      this.searchLabel,
      this.listObjects,
      this.customListWidget,
      this.addForm,
      this.search,
      this.deleted,
      this.selected,
      this.add})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EhsGenericListBloc>(
          create: (_) => EhsGenericListBloc(),
        ),
      ],
      child: SearchPageWrapper(
          title: title,
          searchLabel: searchLabel,
          listObjects: listObjects,
          customListWidget: customListWidget,
          addForm: addForm,
          selected: selected,
          deleted: deleted,
          search: search,
          add: add),
      // ),
    );
  }
}
