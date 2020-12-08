import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/aspect_distribution/bold_elemen_text.dart';
import 'package:ehsfocus/shared/check_box.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/photoComponents/placeholder_photo.dart';
import 'package:flutter/material.dart';
import 'employee_card.dart';

class ActionDistributionCard extends StatelessWidget {
  final Function isSelected;
  final Function hasDublicate;
  final Aspect aspect;

  const ActionDistributionCard({
    Key key,
    this.isSelected,
    this.aspect,
    this.hasDublicate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO move to service
    bool _hasDublicate = hasDublicate == null ? false : true;
    String getResponsable() {
      if (aspect != null && aspect.action != null) {
        return aspect.action.responsable != null
            ? '${aspect.action.responsable.firstName ?? null} ${aspect.action.responsable.lastName ?? null}'
            : Labels.notSet;
      }
      return Labels.notSet;
    }

    String getCreatedBy() {
      if (aspect != null &&
          aspect.audit != null &&
          aspect.audit.employee != null &&
          aspect.audit.employee.firstName != null) {
        return '${aspect.audit.employee.firstName ?? null} ${aspect.audit.employee.lastName ?? null}';
      }
      return Labels.notSet;
    }

    String getDate() {
      if (aspect != null && aspect.action != null) {
        return aspect.action.limitDate != null
            ? aspect.action.limitDate
            : Labels.notSet;
      }
    }

    var duplicat;
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${aspect.categoryType} -> ${aspect.category}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
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
                    child: BoldElementText(
                      boldText: Labels.observation,
                      text: aspect.comment == null ? '' : '${aspect.comment}',
                    ),
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: BoldElementText(
                      boldText: Labels.acction,
                      text: aspect.action.comment == null
                          ? ''
                          : '${aspect.action.comment}',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              !_hasDublicate
                  ? Text('')
                  : EhsCheckBox(
                      spred: false,
                      isEditable: true,
                      value: false,
                      label: Labels.duplicat,
                      setValue: (value) {
                        hasDublicate(value);
                      },
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
