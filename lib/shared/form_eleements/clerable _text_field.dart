import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:flutter/material.dart';

class ClearableTextField extends StatelessWidget {
  final String label;
  final Function onChanged;
  final String inputValue;
  final bool enabled;
  final String error;
  const ClearableTextField(
      {Key key,
      this.onChanged,
      this.label,
      this.inputValue,
      this.enabled,
      this.error})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = inputValue ?? null;
    return InputContainer(
      child: TextField(
        enabled: enabled ?? true,
        controller: _controller,
        decoration: textInputDecoration.copyWith(
          errorText: error ?? null,
          suffixIcon: IconButton(
            onPressed: () => _controller.clear(),
            icon: Icon(Icons.clear),
          ),
          labelText: label ?? Labels.area1,
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
