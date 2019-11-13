import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NumberTrivia extends Equatable{
  final String txt; 
  final int num;

  NumberTrivia({
    @required this.txt,@required this.num,
  }): super ([txt, num]);
}