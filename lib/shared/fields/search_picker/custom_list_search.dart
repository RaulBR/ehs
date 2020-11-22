import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/shared/fields/search_picker/bloc/search_picker_bloc.dart';
import 'package:ehsfocus/shared/fields/search_picker/list_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';

class EhsSearchListPicker extends StatelessWidget {
  final List<GenericListObject> list;
  final String label;
  final Function selected;
  final Function tapped;
  final Function searchFor;
  final bool isEditable;
  final String preselected;
  final String error;
  const EhsSearchListPicker({
    Key key,
    this.label,
    this.selected,
    this.tapped,
    this.preselected,
    this.searchFor,
    this.error,
    this.list,
    this.isEditable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchPickerBloc>(
      create: (context) => SearchPickerBloc(),
      child: TexEditingHost(
          label: label,
          isEditable: isEditable == null || isEditable,
          selected: selected,
          tapped: tapped,
          preselected: preselected,
          searchFor: searchFor,
          error: error,
          list: list),
    );
  }
}

class TexEditingHost extends StatelessWidget {
  final List<GenericListObject> list;
  final String label;
  final Function selected;
  final Function tapped;
  final Function searchFor;
  final String preselected;
  final bool isEditable;
  final String error;

  const TexEditingHost(
      {Key key,
      this.tapped,
      this.list,
      this.label,
      this.selected,
      this.searchFor,
      this.preselected,
      this.isEditable,
      this.error})
      : super(key: key);
  void _showDialog(context2) {
    showDialog(
      context: context2,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<SearchPickerBloc>(context2),
          child: ListDiablog(
            searchFor: (data) {
              if (searchFor != null) {
                searchFor(data);
                return;
              }
              BlocProvider.of<SearchPickerBloc>(context2).search(data);
            },
            selected: (data) {
              selected(data);
            },
            label: label,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = preselected ?? null;
    BlocProvider.of<SearchPickerBloc>(context).loadList(list);
    return InputContainer(
      child: TextField(
        autofocus: false,
        enabled: isEditable,
        readOnly: true,
        onTap: () {
          if (!isEditable) return;
          tapped();
          FocusScope.of(context).requestFocus(new FocusNode()); //remove focus
          _showDialog(context);
        },
        controller: _controller,
        decoration: textInputDecoration.copyWith(
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelText: label,
            errorText: error),
      ),
      // ),
    );
  }
}
