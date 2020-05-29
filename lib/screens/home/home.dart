import 'package:ehsfocus/screens/home/home_menu.dart';
import 'package:ehsfocus/screens/side_menu/side_menu.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(Lables.ehsTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/a.png'),
                    )),
              ),
            ];
          },
          body: HomeMenu()),
    );
  }
}
