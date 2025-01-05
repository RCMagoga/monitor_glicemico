import 'package:flutter/material.dart';

class SnackbarCustom {
  static void showCustomSnackbar(BuildContext context, String msg, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: cor,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        showCloseIcon: true,
      ),
    );
    ;
  }
}
