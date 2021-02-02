import 'package:ehsfocus/models/area/area_model.dart';
import 'package:ehsfocus/models/area/area_role_model.dart';
import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/screens/forms/area/role_dialog.dart';
import 'package:ehsfocus/screens/forms/area/step_form.dart';
import 'package:ehsfocus/services/popup_service/generic_message_popup.dart';
import 'package:ehsfocus/shared/GoToButton.dart';
import 'package:ehsfocus/shared/animations/slide_right_router.dart';
import 'package:ehsfocus/shared/comment.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/expention_tile_list.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_page_wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AreaMentenanceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Area _area = Area();

    return PageWrapper(
      child: SingleChildScrollView(
        child: BlocListener<AreaBloc, AreaState>(
          listener: (context, state) {
            if (state is Success) {
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<AreaBloc, AreaState>(
            buildWhen: (previous, current) => current is AreaFormState,
            builder: (context, state) {
              if (state is AreaFormState) {
                _area = state.area;
              }
              return Column(
                children: <Widget>[
                  ClearableTextField(
                    inputValue: _area.area,
                    onChanged: (value) {
                      _area.area = value;
                    },
                    error: null,
                  ),
                  ExpandableRoleTile(
                    roles: _area.roles ?? [],
                    delete: (data) async {
                      if (await EhsGennericPopup().showPupup(context,
                          messageTitle: data.title, subtitle: data.subtitle)) {
                        BlocProvider.of<AreaBloc>(context).deleteRole(data.id);
                      }
                    },
                    add: () async {
                      _showDialog(context, null, (data) {
                        _area.roles = _area.roles ?? [];
                        _area.roles.add(data);
                        BlocProvider.of<AreaBloc>(context).setAreaForm(_area);
                      });
                    },
                  ),
                  InputContainer(
                    child: GoToButton(
                      icon: Icon(Icons.arrow_right_sharp),
                      label: Labels.area2,
                      onPressed: () {
                        Provider.of<AreaBloc>(context, listen: false);
                        // showModalBottomSheet(
                        //   context: context,
                        //   builder: (context) => BlocProvider.value(
                        //       value: myModel, child: StepForm()),
                        // );
                        Navigator.push(
                            context,
                            SlideRightRoute(
                                page: BlocProvider.value(
                                    value: BlocProvider.of<AreaBloc>(context),
                                    child: StepForm(area: _area.area))));
                      },
                    ),
                  ),
                  OpenTextAreaWidget(
                    icon: Icon(Icons.info_outline),
                    label: 'Informatii ${Labels.area1}',
                    text: _area.areaInfo ?? null,
                    onEdit: (text) {
                      _area.areaInfo = text;
                      BlocProvider.of<AreaBloc>(context).setAreaForm(_area);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      footerActions: [Labels.delete, Labels.save],
      footerAction: (data) {
        if (data == Labels.save) {
          BlocProvider.of<AreaBloc>(context).setAreaForm(_area);
          BlocProvider.of<AreaBloc>(context).add(SetAreaEvent());
        }
      },
    );
  }

  void _showDialog(context, AreaRole input, Function add) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return RoleDialog(
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
