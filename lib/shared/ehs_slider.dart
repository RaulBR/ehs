import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class EhsSlider extends StatelessWidget {
  final String title;
  final int step;
  final Function getValue;
  final List<String> inputList;
  EhsSlider({this.step, this.getValue, this.inputList, this.title});
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: Column(
        children: [
          SizedBox(height: 10),
          Slider(
            value: (step).toDouble(),
            activeColor: AppColors.tfPiker[step],
            inactiveColor: AppColors.tfPiker[step],
            min: 0,
            max: (inputList.length - 1).toDouble(),
            label: inputList[step],
            divisions: inputList.length,
            onChanged: (value) {
              getValue(value.round());
            },
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(inputList[0], style: labelFomat),
                  Text(inputList[inputList.length - 1], style: labelFomat)
                ]),
          ),
        ],
      ),
    );
  }
}
