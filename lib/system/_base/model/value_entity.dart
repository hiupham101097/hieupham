import 'package:equatable/equatable.dart';

// ignore: camel_case_types, must_be_immutable
class valueEntity extends Equatable {
  String? value1;
  String? value2;
  String? value3;
  String? value4;
  String? value5;
  String? value6;
  String? value7;
  String? value8;
  String? value9;
  String? value10;
  double? number1;
  double? number2;
  double? number3;
  double? number4;
  double? number5;
  double? number6;
  double? number7;
  double? number8;
  double? number9;
  double? number10;
  bool? bool1;
  bool? bool2;
  bool? bool3;
  bool? bool4;
  bool? bool5;

  valueEntity({
    this.value1,
    this.value2,
    this.value3,
    this.value4,
    this.value5,
    this.value6,
    this.value7,
    this.value8,
    this.value9,
    this.value10,
    this.number1,
    this.number2,
    this.number3,
    this.number4,
    this.number5,
    this.number6,
    this.number7,
    this.number8,
    this.number9,
    this.number10,
    this.bool1,
    this.bool2,
    this.bool3,
    this.bool4,
    this.bool5,
  });

  @override
  List<Object?> get props => [
        value1,
        value2,
        value3,
        value4,
        value5,
        value6,
        value7,
        value8,
        value9,
        value10,
        number1,
        number2,
        number3,
        number4,
        number5,
        number6,
        number7,
        number8,
        number9,
        number10,
        bool1,
        bool2,
        bool3,
        bool4,
        bool5
      ];
}
