// 홈에서는 navigatorKey 가 준비가 안되어 null 이다. 그래서 홈에서 특별히 이 homeContext 를 사용한다.
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

BuildContext get _context => AppService.instance.context;
TextStyle get bodySmall => Theme.of(_context).textTheme.bodySmall!;
TextStyle get bodyMedium => Theme.of(_context).textTheme.bodyMedium!;
TextStyle get bodyLarge => Theme.of(_context).textTheme.bodyLarge!;
TextStyle get titleSmall => Theme.of(_context).textTheme.titleSmall!;
TextStyle get titleMedium => Theme.of(_context).textTheme.titleMedium!;
TextStyle get titleLarge => Theme.of(_context).textTheme.titleLarge!;

TextStyle get headlineSmall => Theme.of(_context).textTheme.headlineSmall!;
TextStyle get headlineMedium => Theme.of(_context).textTheme.headlineMedium!;
TextStyle get headlineLarge => Theme.of(_context).textTheme.headlineLarge!;

TextStyle get labelSmall => Theme.of(_context).textTheme.labelSmall!;
TextStyle get labelMedium => Theme.of(_context).textTheme.labelMedium!;
TextStyle get labelLarge => Theme.of(_context).textTheme.labelLarge!;

Color get primaryColor => Theme.of(_context).primaryColor;

Color get outline => Theme.of(_context).colorScheme.outline;
