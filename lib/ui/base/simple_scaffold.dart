import 'package:flutter/material.dart';
import 'package:medplus/res/palette.dart';

class SimpleScaffold extends StatelessWidget {
  const SimpleScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: buildBody,
    );
  }

  Widget get buildBody => Container();
}
