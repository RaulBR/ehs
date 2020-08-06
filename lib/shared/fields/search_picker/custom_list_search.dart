import 'package:ehsfocus/models/drop_down_model.dart';
import 'package:ehsfocus/shared/fields/search_picker/bloc/search_picker_bloc.dart';
import 'package:ehsfocus/shared/fields/search_picker/list_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';

class EhsSearchListPicker2 extends StatelessWidget {
  final List<DropDown> list;
  final String label;
  final Function selected;
  final Function tapped;
  final Function searchFor;
  final String preselected;
  final String error;
  const EhsSearchListPicker2({
    Key key,
    this.label,
    this.selected,
    this.tapped,
    this.preselected,
    this.searchFor,
    this.error,
    this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchPickerBloc>(
      create: (context) => SearchPickerBloc(),
      child: TexEditingHost(
          label: label,
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
  final List<DropDown> list;
  final String label;
  final Function selected;
  final Function tapped;
  final Function searchFor;
  final String preselected;
  final String error;

  const TexEditingHost(
      {Key key,
      this.tapped,
      this.list,
      this.label,
      this.selected,
      this.searchFor,
      this.preselected,
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
        readOnly: true,
        onTap: () {
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
