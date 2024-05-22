import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/onboarding_cubit/onboarding_cubit.dart';
import '../data/repository/onboarding_repository.dart';
import '../views/consructor/views/arrival_screen.dart';
import '../views/consructor/views/transfer_screen.dart';
import '../views/homescreen/views/home_screen.dart';
import '../views/onboarding/view/onboarding_screen.dart';
import '../views/settings/views/settings_screen.dart';

abstract class AppRoutes {
  static const home = 'home';
  static const welcome = 'welcome';
  static const profile = 'profile';
  static const arrival = 'arrival';
  static const transfer = 'transfer';

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    final Widget child;

    OnboardingRepository onboardingRepository = OnboardingRepository();
    OnboardingCubit onboardingCubit = OnboardingCubit(onboardingRepository);

    switch (settings.name) {
      case home:
        child = HomeScreen();
      case profile:
        child = const SettingsScreen();
      // case arrival:
      //   child = ArrivalScreen(
      //     travelModel: null,
      //   );
      case transfer:
        child = TransferScreen();
      default:
        child = BlocProvider(
          create: (context) => onboardingCubit,
          child: const OnboardingScreen(),
        );
    }
    return MaterialPageRoute(builder: (_) => child);
  }
}
