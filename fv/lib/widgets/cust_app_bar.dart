import 'package:flutter/material.dart';
import 'package:infv1/utils/universal_variables.dart';


class CustAppBar extends StatelessWidget implements PreferredSizeWidget{

  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;

  const CustAppBar({
    Key key,
    @required this.title,
    @required this.actions,
    @required this.leading, 
    @required this.centerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: UniversalVariables.backgroundGrey,
        // border: Border(
        //   bottom: BorderSide(
        //     color: UniversalVariables.separatorColor,
        //     width: 1.9,
        //     style: BorderStyle.solid,
        //   ),
        // ),
      ),
      child: AppBar(
        backgroundColor: UniversalVariables.backgroundGrey,
        elevation: 0,
        leading: leading,
        actions: actions,
        centerTitle: centerTitle,
        title: title,
      ),
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight+10);
}