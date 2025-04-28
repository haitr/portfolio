import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

const kSmallBreakPoint = 'SMALL';
const kLargeBreakPoint = 'LARGE';

const packageCardHeight = 150.0;

bool shouldRenderSmallLayout(BuildContext context) =>
    ResponsiveBreakpoints.of(context).breakpoint.name == kSmallBreakPoint;
