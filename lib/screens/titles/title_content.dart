import 'dart:async';

import 'package:bookyourdriveing/models/home_mode.dart';
import 'package:bookyourdriveing/screens/titles/title_element.dart';


import 'package:flutter/material.dart';

class TitleContent extends StatefulWidget {
  @override
  _TitleContentState createState() => _TitleContentState();
}

class _TitleContentState extends State<TitleContent> {
 StreamSubscription subscription;
  final List<HomeElement> pageItems = [
    HomeElement(title: 'title', subtitle: 'secondery name', icon: 'home'),
    HomeElement(title: 'title', subtitle: 'secondery name', icon: 'home'),
    HomeElement(title: 'title', subtitle: 'secondery name', icon: 'home'),
    HomeElement(title: 'title', subtitle: 'secondery name', icon: 'home'),
    HomeElement(title: 'title', subtitle: 'secondery name', icon: 'home'),
    HomeElement(title: 'title', subtitle: 'secondery name', icon: 'home'),
    HomeElement(title: 'title', subtitle: 'secondery name', icon: 'home'),
    HomeElement(title: 'title', subtitle: 'secondery name', icon: 'home')
  ];

  @override
  Widget build(BuildContext context) {
    bool condition(int x) {
      return x < 12;
    }

    data() {
      Duration interval = Duration(seconds: 1);
      Stream<int> stream = Stream<int>.periodic(interval, (int value) => (value + 1) * 2);
      stream = stream.takeWhile(condition);
      stream = stream.take(5);
      // List<int> data = await stream.toList();
      subscription = stream.listen((x) {
        print(x);
      });

    }

    return ListView.builder(
        itemCount: pageItems.length,
        itemBuilder: (context, index) {
          return TitleMenuElement(homeElement: pageItems[index], data: data);
        });
  }
    void dispose() {
    if(subscription != null ) {
        subscription.cancel();
    }
    
    print('dispose titles');
    super.dispose();
  }

}
