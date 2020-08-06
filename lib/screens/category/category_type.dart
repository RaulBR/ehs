import 'package:ehsfocus/models/category_model.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';

import 'package:flutter/material.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list_page_search.dart';

class CategoryTypeMentenanceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> category = [
      Category(category: 'Lemne'),
      Category(category: 'banane'),
      Category(category: 'Lemne'),
      Category(category: 'Lemne'),
      Category(category: 'Lemne'),
      Category(category: 'Lemne'),
      Category(category: 'Lemne'),
      Category(category: 'banane')
    ];
    return PageWrapper(
      title: Labels.aspectType,
      add: () {},
      child: Column(
        children: <Widget>[
          ClearableTextField(
            label: Labels.aspectType,
            inputValue: null,
            onChanged: (value) {},
            error: null,
          ),
          SizedBox(height: 20),
          InputContainer(
            child: TextField(
              decoration: textInputDecoration.copyWith(
                  labelText: Labels.category, suffixIcon: Icon(Icons.search)),
              onChanged: (data) {
                ///widget.search(data);
              },
            ),
          ),
          SizedBox(height: 20),
          Flexible(
            child: ListView.builder(
              itemCount: category.length,
              itemBuilder: (context, index) {
                return GennericListElement(
                  title: category[index].category,
                  // file: aspects[index].photo,
                  isSelected: () {
                    //  selected(categoryTypes[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      footerAction: (data) {
        print(data);
      },
    );
  }
}
