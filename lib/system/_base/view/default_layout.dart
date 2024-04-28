import 'package:flutter/material.dart';
import 'package:qlcv/system/_variables/value/app_style.dart';

class DefaultLayout {
  static Widget contentXs(Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: child,
    );
  }

  static Widget contentSm(Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: child,
    );
  }

  static Widget contentMd(Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: child,
    );
  }

  static Widget contentLg(Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 13, right: 13),
      child: child,
    );
  }

  static Widget contentxl(Widget child) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: child,
    );
  }

  static Widget contentXxl(Widget child) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  static Widget buttonDefault(Widget child, Function() childFunction) {
    return TextButton(
        onPressed: childFunction,
        child: Container(
          color: AppStyle.colors[2][4],
          child: Container(
            padding: const EdgeInsets.all(5),
            child: child,
          ),
        ));
  }

  static Widget buttonDelete(Widget child, Function() childFunction) {
    return TextButton(
        onPressed: childFunction,
        child: Container(
          color: AppStyle.colors[2][3],
          child: Container(
            padding: const EdgeInsets.all(5),
            child: child,
          ),
        ));
  }

  static Widget buttonSuccess(Widget child, Function() childFunction) {
    return TextButton(
        onPressed: childFunction,
        child: Container(
          decoration: BoxDecoration(
              color: AppStyle.colors[0][4],
              borderRadius: const BorderRadius.all(Radius.circular(3))),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: child,
          ),
        ));
  }

  static Widget buttonCancel(Widget child, Function() childFunction) {
    return TextButton(
        onPressed: childFunction,
        child: Container(
          decoration: BoxDecoration(
              color: AppStyle.colors[1][6],
              borderRadius: const BorderRadius.all(Radius.circular(3))),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: child,
          ),
        ));
  }
}
