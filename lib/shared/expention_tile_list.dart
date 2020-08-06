import 'package:ehsfocus/models/area_modal.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/category/category_type_list.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:flutter/material.dart';

class ExpandableListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function selected;
  final Function add;
  final List<GenericListObject> listElements;

  ExpandableListTile(
      {this.title, this.subtitle, this.selected, this.listElements, this.add});

  @override
  Widget build(BuildContext context) {
    double getheight() {
      if (listElements == null || listElements.length == 0) {
        return 0;
      }
      double size = listElements.length.toDouble();
      return size > 3 ? 250 : size * 100;
    }

    return InputContainer(
      child: ExpansionTile(
        tilePadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        title: InputContainer(child: Text(title, style: normallabelFomat)),
        children: [
          Container(
            height: getheight(),
            child: EhsGenericList(
              listElements: listElements,
              selected: (element) {},
              deleted: (element) {},
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FlatButton.icon(
              onPressed: () => add(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              icon: Icon(Icons.add),
              label: Text(Labels.add),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableRoleTile extends StatelessWidget {
  final List<AreaRole> roles;
  final Function selected;
  final Function add;

  const ExpandableRoleTile({Key key, this.roles, this.selected, this.add})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpandableListTile(
      title: 'Alege Responsabil',
      add: () {
        add();
      },
      selected: (e) {
        selected();
      },
      listElements: roles
          .map((e) => GenericListObject(
              id: e.id,
              title: '${e.responsable.firstName} ${e.responsable.lastName}',
              subtitle: e.role))
          .toList(),
    );
  }
}
