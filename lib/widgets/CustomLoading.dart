import 'package:flutter/material.dart';
import 'Loading.dart';

class ShowLoading {
  BuildContext context;

  ShowLoading(this.context);

  showLoading() {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Loading();
      },
    );
  }
}
