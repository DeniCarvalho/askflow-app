// ignore_for_file: non_constant_identifier_names

import 'package:askflow/core/domain/domain.dart';
import 'package:askflow/core/infrastructure/infrastructure.dart';

export 'extensions/extensions.dart';
export 'mixin/mixin.dart';

///
/// Provides a static access to a singleton that implements [Navigation]
///
final Navigation Nav = ModularNavigation.i();

///
/// Provides a static access to a singleton that implements [DependencyManager]
///
final DependencyManager DM = ModularDependencyManager.i();
