import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakaan/core/util/routing/routes.dart';
import 'package:rakaan/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:rakaan/features/chat/presentation/view/chat_view.dart';
import 'package:rakaan/features/contact_and_report/presentation/cubit/contact_and_report_cubit.dart';
import 'package:rakaan/features/contact_and_report/presentation/view/contact_and_report_view.dart';
import 'package:rakaan/features/faq/presentation/cubit/faq_cubit.dart';
import 'package:rakaan/features/home/presentation/cubit/home_cubit.dart';
import 'package:rakaan/features/home/presentation/view/home_view.dart';
import 'package:rakaan/features/learn/presentation/cubit/learn_cubit.dart';
import 'package:rakaan/features/learn/presentation/view/learn_view.dart';
import 'package:rakaan/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:rakaan/features/notifications/presentation/view/notifications_view.dart';
import 'package:rakaan/features/order_status/data/arguments/order_status_arguments.dart';
import 'package:rakaan/features/order_status/presentation/cubit/order_status_cubit.dart';
import 'package:rakaan/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:rakaan/features/orders/presentation/view/orders_view.dart';
import 'package:rakaan/features/static_page/presentation/cubit/static_page_cubit.dart';
import 'package:rakaan/features/statics/presentation/cubit/statics_cubit.dart';
import 'package:rakaan/features/trip_details/data/arguments/trip_details_arguments.dart';
import 'package:rakaan/features/trip_details/presentation/cubit/trip_details_cubit.dart';
import 'package:rakaan/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:rakaan/features/wallet/presentation/view/wallet_view.dart';

import '../../../features/auth/data/arguments/pin_code_argument.dart';
import '../../../features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import '../../../features/auth/presentation/cubits/pin_code_cubit/pin_code_cubit.dart';
import '../../../features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import '../../../features/auth/presentation/views/login_view.dart';
import '../../../features/auth/presentation/views/pin_code_view.dart';
import '../../../features/auth/presentation/views/register_view.dart';
import '../../../features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import '../../../features/edit_profile/presentation/view/edit_profile_view.dart';
import '../../../features/faq/presentation/view/faq_view.dart';
import '../../../features/intro/onboarding/presentation/cubit/on_boarding_cubit.dart';
import '../../../features/intro/onboarding/presentation/view/onboarding_view.dart';
import '../../../features/intro/select_language/presentation/cubit/select_language_cubit.dart';
import '../../../features/intro/select_language/presentation/views/select_language_view.dart';
import '../../../features/intro/splash/presentation/cubit/splash_cubit.dart';
import '../../../features/intro/splash/presentation/views/splash_view.dart';
import '../../../features/order_status/presentation/view/order_status_view.dart';
import '../../../features/side_menu/data/arguments/edit_profile_argument.dart';
import '../../../features/static_page/data/arguments/static_page_arguments.dart';
import '../../../features/static_page/presentation/view/static_page_view.dart';
import '../../../features/statics/presentation/view/statics_view.dart';
import '../../../features/trip_details/presentation/view/trip_details_view.dart';
import '../../di/di.dart';
import '../../framework/navigation_animation.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SplashCubit>(),
            child: const SplashView(),
          ),
        );

      case Routes.onBoardingView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<OnBoardingCubit>()..getData()..updateForLogin(),
            child: const OnBoardingView(),
          ),
        );
      case Routes.selectLanguageView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SelectLanguageCubit>(),
            child: const SelectLanguageView(),
          ),
        );
      case Routes.loginView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginView(),
          ),
        );
      case Routes.registerView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<RegisterCubit>()..getCars(),
            child: RegisterView(),
          ),
        );
      case Routes.pinCodeView:
        final argument = arguments as PinCodeArgument;
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<PinCodeCubit>(),
            child: PinCodeView(
              argument: argument,
            ),
          ),
        );
      case Routes.homeView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: HomeView(),
          ),
        );
      case Routes.notificationsView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<NotificationsCubit>()..getData(),
            child: NotificationsView(),
          ),
        );
      case Routes.walletView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<WalletCubit>()..getData(),
            child: WalletView(),
          ),
        );
      case Routes.faqView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<FaqCubit>()..getData(),
            child: FaqView(),
          ),
        );
      case Routes.contactUsView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ContactAndReportCubit>(),
            child: ContactAndReportView(),
          ),
        );
      case Routes.staticsView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<StaticsCubit>()..getData(),
            child: StaticsView(),
          ),
        );
      case Routes.learnView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LearnCubit>()..getData(),
            child: LearnView(),
          ),
        );
        case Routes.orderView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<OrdersCubit>()..getData(),
            child: OrdersView(),
          ),
        );
        case Routes.chatView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ChatCubit>()..getData(),
            child: ChatView(),
          ),
        );
      case Routes.tripDetailsView:
        final argument = arguments as TripDetailsArguments;
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<TripDetailsCubit>(),
            child: TripDetailsView(arguments: argument),
          ),
        );
        case Routes.orderStatusView:
        final argument = arguments as OrderStatusArguments;
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<OrderStatusCubit>(),
            child: OrderStatusView(arguments: argument),
          ),
        );
      case Routes.editProfileView:
        final argument = arguments as EditProfileArgument;
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<EditProfileCubit>()
              ..getCars()
              ..getSavedData(),
            child: EditProfileView(argument: argument),
          ),
        );
      case Routes.staticPageView:
        final argument = arguments as StaticPageArguments;
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<StaticPageCubit>(),
            child: StaticPageView(argument: argument),
          ),
        );

      default:
        return _buildRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  PageRoute _buildRoute({required WidgetBuilder builder}) {
    return Platform.isAndroid ? FadePageRoute(builder: builder) : MaterialPageRoute(builder: builder);
  }
}
