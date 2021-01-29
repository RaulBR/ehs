import 'package:ehsfocus/models/area/area_model.dart';
import 'package:ehsfocus/screens/category/category_service.dart';
import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:ehsfocus/services/popup_service/generic_message_popup.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_page_wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepForm extends StatelessWidget {
  final String area;
  final CategorySertvice _categorySertvice = CategorySertvice();

  StepForm({Key key, this.area}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Area _area = Area();
    TextEditingController txt;

    return BlocBuilder<AreaBloc, AreaState>(builder: (context, state) {
      // return widget here based on BlocA's state
      BlocProvider.of<AreaBloc>(context).getStepes(area);
      return PageWrapper(
        // title: Labels.area2,
        appBarr: AppBar(title: Text(Labels.area2)),
        add: () {
          _categorySertvice.openCategoryModal(context,
              add: (data) => BlocProvider.of<AreaBloc>(context).addStep(data),
              title: Labels.area2);
        },
        footerActions: [Labels.back],
        footerAction: (data) {
          if (data == Labels.back) {
            Navigator.pop(context);
          }
        },
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            InputContainer(
              child: TextField(
                controller: txt,
                decoration: textInputDecoration.copyWith(
                    labelText: Labels.area2, suffixIcon: Icon(Icons.search)),
                onChanged: null,
              ),
            ),
            SizedBox(height: 20),
            BlocBuilder<AreaBloc, AreaState>(
                buildWhen: (previous, current) => current is StepListState,
                builder: (context, state) {
                  List<dynamic> stepts = [];
                  if (state is StepListState) {
                    stepts = state.stepList;
                  }
                  return Flexible(
                    child: ListView.builder(
                      itemCount: stepts.length,
                      itemBuilder: (context, index) {
                        return GennericListElement(
                          subtitle: area,
                          title: stepts[index].step,
                          deleted: () async {
                            if (await EhsGennericPopup().showPupup(
                              context,
                              what: _area.steps[index].step,
                              title: Labels.area2,
                            )) {
                              BlocProvider.of<AreaBloc>(context)
                                  .deleteStep(_area.steps[index]);
                              print('data');
                            }
                          },
                          isSelected: () {
                            _categorySertvice.openCategoryModal(context,
                                add: (data) =>
                                    BlocProvider.of<AreaBloc>(context)
                                        .addStep(data),
                                title: Labels.area2);
                          },
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      );
    });
  }
}
