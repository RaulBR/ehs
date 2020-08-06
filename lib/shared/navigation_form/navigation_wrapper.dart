import 'package:ehsfocus/shared/navigation_form/bloc/navigation_bloc.dart';
import 'package:ehsfocus/shared/navigation_form/navigation_bottom_buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EhsNavigatorWidget extends StatelessWidget {
  final List<Widget> displayWidgets;
  final int pageStart;
  final Function action;
  const EhsNavigatorWidget(
      {Key key, this.displayWidgets, this.pageStart, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int page = pageStart;
    PageController _controller;
    _controller = PageController(
      initialPage: pageStart,
    );

    return BlocProvider<NavigationBloc>(
      create: (_) => NavigationBloc(displayWidgets.length),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (BuildContext context, NavigationState state) {
          if (state is NavigateState) {
            page = state.toPage;
            _controller.animateToPage(state.toPage,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          }
          if (state is SubmitState) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) => Scaffold(
              resizeToAvoidBottomPadding: false,
              body: PageView(
                dragStartBehavior: DragStartBehavior.start,
                controller: _controller,
                pageSnapping: true,
                children: displayWidgets,
              ),
              bottomNavigationBar: BottomGroupButtons(
                isBackHiden: page == 0,
                navigate: (value) {
                  action(_controller.page.toInt());
                  BlocProvider.of<NavigationBloc>(context)
                      .navigate(value, _controller.page.toInt());
                },
                submit: () {
                  Navigator.pop(context);
                },
              )),
        ),
      ),
    );
  }
}
