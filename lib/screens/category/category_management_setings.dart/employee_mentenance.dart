import 'package:ehsfocus/models/category/category_type_responsible.dart';
import 'package:ehsfocus/screens/category/category_management_setings.dart/bloc/category_management_bloc.dart';
import 'package:ehsfocus/screens/category/category_service.dart';
import 'package:ehsfocus/screens/forms/area/role_dialog.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_list_page_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagersMentenanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        CategoryManagementBloc categoryManagementBloc =
            CategoryManagementBloc();

        return categoryManagementBloc;
      },
      child: BlocBuilder<CategoryManagementBloc, CategoryManagementState>(
        buildWhen: (previous, current) =>
            current is CategoryManagementListState,
        builder: (context, state) {
          return SearchPageWrapper(
            title: Labels.managerMantanence,
            listObjects:
                CategorySertvice().handleCategorysStateChange(context, state),
            selected: (data) {
              print(data);
              // _showDialog(context, data, (data) {
              //   BlocProvider.of<CategoryManagementBloc>(context)
              //       .add(SetCategoryManagementEvent(data));
              //   print(data);
              // });
            },
            add: () {
              print('here');
              // add popup
              // BlocProvider.of<CategoryBloc>(context).selectedType(null);
              _showDialog(context, null, (data) {
                BlocProvider.of<CategoryManagementBloc>(context)
                    .add(SetCategoryManagementEvent(data));
                print(data);
              });
            },
            deleted: (data) async {
              // if (await EhsGennericPopup()
              //     .showPupup(context, what: data.title)) {
              //   BlocProvider.of<CategoryBloc>(context)
              //       .deleteCategoryType(data.id);
              // }
            },
            searchLabel: 'Cauta',
            search: (data) {},
          );
        },
      ),
    );
  }

  void _showDialog(context, CategoryTypeResponsible input, Function add) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return RoleDialog2(
          customLabes: [Labels.aspectType, Labels.manager],
          customTitle: Labels.manager,
          areaRole: input,
          add: (areaRole) {
            add(areaRole);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
