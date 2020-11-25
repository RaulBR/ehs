import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/forms/aspects/bloc/aspect_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/photoComponents/placeholder_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_card.dart';

// TODO BIG MAKE DINAMIC
class ActionDistributionCard extends StatelessWidget {
  final Function isSelected;
  final Aspect aspect;

  const ActionDistributionCard({
    Key key,
    this.isSelected,
    this.aspect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AspectBloc>(context).getAspectsPhotos(aspect);
    // TODO move to service
    String getResponsable() {
      if (aspect != null && aspect.action != null) {
        return aspect.action.responsable != null
            ? '${aspect.action.responsable.firstName ?? null} ${aspect.action.responsable.lastName ?? null}'
            : 'Nu sa setat';
      }
      return 'Nu sa setat';
    }

    String getCreatedBy() {
      if (aspect != null &&
          aspect.audit != null &&
          aspect.audit.employee != null &&
          aspect.audit.employee.firstName != null) {
        return '${aspect.audit.employee.firstName ?? null} ${aspect.audit.employee.lastName ?? null}';
      }
      return 'Nu sa setat';
    }

    String getDate() {
      if (aspect != null && aspect.action != null) {
        return aspect.action.limitDate != null
            ? aspect.action.limitDate
            : 'fara data';
      }
    }

    return Padding(
      padding: EdgeInsets.all(3),
      child: Card(
        borderOnForeground: true,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          // height: 280,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ListTile(
                    onTap: () async {
                      isSelected();
                    },
                    title: Text(
                        aspect.audit == null ? 'no data' : aspect.audit.area),
                    subtitle: Container(
                      child: Text(
                        '${aspect.categoryType} -> ${aspect.category}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),

                  PhotoWithPlaceholder(
                    aspectIn: aspect,
                    isEditable: false,
                    addPicture: null,
                    deletePicture: null,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  // Text(Labels.comment),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: Text(
                      '${aspect.comment}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EmployeeCard(
                      action: Labels.doneBy,
                      name: getCreatedBy(),
                      date: aspect.createdDate,
                    ),
                    EmployeeCard(
                      action: Labels.responsable,
                      name: getResponsable(),
                      date: getDate(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
