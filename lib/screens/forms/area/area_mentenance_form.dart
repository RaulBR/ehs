import 'package:ehsfocus/models/area_modal.dart';
import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';
import 'package:ehsfocus/screens/forms/area/bloc/area_bloc.dart';
import 'package:ehsfocus/screens/forms/area/role_dialog.dart';
import 'package:ehsfocus/shared/GoToButton.dart';
import 'package:ehsfocus/shared/comment.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/expention_tile_list.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:flutter/material.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list_page_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'area_providers.dart';

class AreaMentenanceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: Labels.audits,
      child: SingleChildScrollView(
        child: AreaDependencies(
          child: Column(
            children: <Widget>[
              ClearableTextField(
                inputValue: null,
                onChanged: (value) {},
                error: null,
              ),
              BlocBuilder<AreaBloc, AreaState>(
                builder: (context, state) => ExpandableRoleTile(
                    roles: state is AreaFormState ? state.area.roles : [],
                    add: () async {
                      _showDialog(context, null, (data) {
                        print(data);
                        BlocProvider.of<AreaBloc>(context)
                            .add(SetRoleEvent(data));
                      });
                    }),
              ),
              InputContainer(
                child: GoToButton(
                  icon: Icon(Icons.arrow_right_sharp),
                  label: 'Pasi',
                  onPressed: () => {},
                ),
              ),
              OpenTextAreaWidget(
                icon: Icon(Icons.info_outline),
                label: 'Inflarmatii ${Labels.area1}',
                text: null,
                onEdit: (text) {},
              ),
            ],
          ),
        ),
      ),
      footerAction: (data) {
        print(data);
      },
    );
  }

  void _showDialog(context2, AreaRole input, Function add) async {
    await showDialog(
      context: context2,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<CategoryBloc>(context2),
          child: RoleDialog(
            areaRole: input,
            add: (areaRole) {
              add(areaRole);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
