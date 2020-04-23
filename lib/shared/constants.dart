import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: AppColors.field,
  filled: true,
  enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: AppColors.field, width: 2)),
  focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accent, width: 2)),
);
