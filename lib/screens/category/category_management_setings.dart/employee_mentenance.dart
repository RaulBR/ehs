import 'package:ehsfocus/models/category/category_type_responsible.dart';
import 'package:ehsfocus/bloc/category/category_mentenance/category_management_bloc.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/category/category_service.dart';
import 'package:ehsfocus/screens/forms/area/area_service.dart';
import 'package:ehsfocus/screens/forms/area/role_dialog.dart';
import 'package:ehsfocus/services/popup_service/generic_message_popup.dart';

import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/bloc/ehs_generic_list_bloc.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_list_page_search.dart';
import 'package:ehsfocus/shared/form_eleements/lists/ehs_generic_animated_lsit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagersMentenanceScreen extends StatelessWidget {
  final _areaService = AreaService();
  final _mylistKey = GlobalKey<AnimatedListState>();
  final _categorySerice = CategorySertvice();
  final List<GenericListObject> list = [];
  @override
  Widget build(BuildContext context) {
    BuildContext _context;
    return BlocDependencys(
      child: SearchPageWrapper(
        title: Labels.managerMantanence,
        customListWidget:
            BlocListener<CategoryManagementBloc, CategoryManagementState>(
          listener: (context, state) {
            if (state is AddedCategoryManagemt) {
              CategoryTypeResponsible categoryResp =
                  state.categoryTypeResponsible;
              list.add(
                  _categorySerice.convertToGenericListObkect(categoryResp));
              _mylistKey.currentState.insertItem(list.length);
              BlocProvider.of<CategoryManagementBloc>(context)
                  .add(UpdateListEvent());
            }
          },
          child: BlocBuilder<CategoryManagementBloc, CategoryManagementState>(
              buildWhen: (previous, current) =>
                  current is CategoryManagementListState,
              builder: (context, state) {
                List<GenericListObject> list = CategorySertvice()
                    .handleCategorysStateChange(context, state);
                _context = context;

                return EhsGenericAnimatedList(
                  listKey: _mylistKey,
                  listElements: list,
                  selected: (data) {
                    CategoryTypeResponsible cattegoryManagment =
                        BlocProvider.of<CategoryManagementBloc>(context)
                            .setCategoryByid(data.id);
                    _showDialog(context, cattegoryManagment, (data) {
                      BlocProvider.of<CategoryManagementBloc>(context)
                          .add(SetCategoryManagementEvent(data));
                    });
                  },
                  deleted: (GenericListObject data, index) async {
                    if (await EhsGennericPopup().showPupup(context,
                        messageTitle: data.title,
                        subtitle:
                            'Nu va mai fi manager pe: ${data.subtitle}')) {
                      CategoryTypeResponsible cat =
                          CategoryTypeResponsible(id: data.id);
                      BlocProvider.of<CategoryManagementBloc>(context)
                          .add(DeleteCategoryManagementEvent(cat));
                      _areaService.deletteElemet(_mylistKey, index, data, list);
                    }

                    // BlocProvider.of<AreaBloc>(context).deleteArea(data.id);
                  },
                );
              }),
        ),
        searchLabel: Labels.search,
        add: () {
          _showDialog(context, null, (data) {
            BlocProvider.of<CategoryManagementBloc>(_context)
                .add(SetCategoryManagementEvent(data));
          });
        },
        search: (data) {},
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

class BlocDependencys extends StatelessWidget {
  final Widget child;

  const BlocDependencys({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryManagementBloc>(
          create: (_) => CategoryManagementBloc(),
        ),
        BlocProvider<EhsGenericListBloc>(
          create: (_) => EhsGenericListBloc(),
        ),
      ],
      child: child,
      // ),
    );
  }
}
