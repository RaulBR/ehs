import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/fields/search_picker/bloc/search_picker_bloc.dart';
import 'package:ehsfocus/shared/loading.dart';

class ListDiablog extends StatelessWidget {
  final Function selected;
  final String label;
  final Function searchFor;
  const ListDiablog({
    Key key,
    this.label,
    this.searchFor,
    this.selected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<GenericListObject> dropDownList = [];
    return AlertDialog(
      title: TextField(
        onChanged: (value) {
          searchFor(value);
        },
        decoration: textInputDecoration.copyWith(
            labelText: label, suffixIcon: Icon(Icons.search)),
      ),
      content: Container(
        height: 250.0,
        width: double.maxFinite,
        child: BlocBuilder<SearchPickerBloc, SearchPickerState>(
            builder: (context, state) {
          if (state is ListLoadoing) {
            return Loading();
          }
          if (state is ElementListItems) {
            dropDownList = state.values;
          }
          return dropDownList.length != 0
              ? ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: dropDownList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(dropDownList[index].title ?? ''),
                      subtitle: dropDownList[index].subtitle != null
                          ? Text(dropDownList[index].subtitle)
                          : null,
                      onTap: () {
                        selected(dropDownList[index]);
                        Navigator.of(context).pop();
                      },
                    );
                    // );
                  },
                )
              : Text(Labels.noData);
        }),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text(Labels.clear),
          onPressed: () {
            selected(null);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: new Text(Labels.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
