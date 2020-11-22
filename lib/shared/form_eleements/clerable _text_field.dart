import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:flutter/material.dart';

class ClearableTextField extends StatelessWidget {
  final String label;
  final Function onChanged;
  final Function editComplete;
  final String inputValue;
  final bool enabled;
  final String error;
  const ClearableTextField(
      {Key key,
      this.onChanged,
      this.label,
      this.inputValue,
      this.enabled,
      this.error,
      this.editComplete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = inputValue ?? null;
    return InputContainer(
      child: TextField(
        onEditingComplete: editComplete == null
            ? null
            : () {
                editComplete();
              },
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

class EHSTextField extends StatelessWidget {
  final String label;
  final Function onChanged;
  final String inputValue;
  final TextInputType keyboardType;
  final bool enabled;
  final String error;
  final bool obscureText;

  const EHSTextField(
      {Key key,
      this.label,
      this.onChanged,
      this.inputValue,
      this.enabled,
      this.error,
      this.keyboardType,
      this.obscureText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = inputValue ?? null;
    return InputContainer(
      child: TextField(
        obscureText: obscureText ?? false,
        keyboardType: keyboardType ?? null,
        enabled: enabled ?? true,
        controller: _controller,
        decoration: textInputDecoration.copyWith(
          errorText: error ?? null,
          labelText: label ?? Labels.area1,
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
