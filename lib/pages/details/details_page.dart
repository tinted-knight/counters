import 'package:flutter/material.dart';

import 'details_content.dart';

class DetailsPage extends StatelessWidget {
  static const route = "/details";

  @override
  Widget build(BuildContext context) {
    final counter = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: DetailsOf(counter),
    );
  }
}
