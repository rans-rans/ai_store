import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart' show smallSpacing;

extension Spaced on Row {
  Row withSpacing({
    Axis axis = Axis.vertical,
  }) {
    final result = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length) {
        result.add(
          SizedBox(
            width: axis == Axis.horizontal ? smallSpacing : null,
            height: axis == Axis.vertical ? smallSpacing : null,
          ),
        );
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: result,
    );
  }
}
