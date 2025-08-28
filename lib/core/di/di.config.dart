// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:rakaan/core/api/api_consumer.dart' as _i337;
import 'package:rakaan/core/api/dio_consumer.dart' as _i3;
import 'package:rakaan/core/api/dio_log_interceptor.dart' as _i1050;
import 'package:rakaan/core/api/network_info.dart' as _i435;
import 'package:rakaan/core/di/di_module.dart' as _i308;
import 'package:rakaan/core/framework/app_firebase.dart' as _i810;
import 'package:rakaan/core/framework/device_info.dart' as _i833;
import 'package:rakaan/core/helpers/image_helper.dart' as _i1063;
import 'package:rakaan/core/local/shared_preferences/shared_pref_services.dart'
    as _i336;
import 'package:rakaan/features/auth/data/data_source/local/auth_local_data_source.dart'
    as _i758;
import 'package:rakaan/features/auth/data/data_source/local/auth_local_data_source_impl.dart'
    as _i864;
import 'package:rakaan/features/auth/data/data_source/remote/auth_remote_data_source.dart'
    as _i620;
import 'package:rakaan/features/auth/data/data_source/remote/auth_remote_data_source_impl.dart'
    as _i568;
import 'package:rakaan/features/auth/data/repository/auth_repository.dart'
    as _i957;
import 'package:rakaan/features/auth/data/repository/auth_repository_impl.dart'
    as _i816;
import 'package:rakaan/features/auth/presentation/cubits/login_cubit/login_cubit.dart'
    as _i223;
import 'package:rakaan/features/auth/presentation/cubits/pin_code_cubit/pin_code_cubit.dart'
    as _i1011;
import 'package:rakaan/features/auth/presentation/cubits/register_cubit/register_cubit.dart'
    as _i207;
import 'package:rakaan/features/chat/data/data_source/chat_data_source.dart'
    as _i761;
import 'package:rakaan/features/chat/data/data_source/chat_data_source_impl.dart'
    as _i200;
import 'package:rakaan/features/chat/data/repository/chat_repository.dart'
    as _i737;
import 'package:rakaan/features/chat/data/repository/chat_repository_impl.dart'
    as _i208;
import 'package:rakaan/features/chat/presentation/cubit/chat_cubit.dart'
    as _i453;
import 'package:rakaan/features/contact_and_report/data/data_source/contact_and_report_data_source.dart'
    as _i955;
import 'package:rakaan/features/contact_and_report/data/data_source/contact_and_report_data_source_impl.dart'
    as _i829;
import 'package:rakaan/features/contact_and_report/data/repository/contact_and_report_repository.dart'
    as _i791;
import 'package:rakaan/features/contact_and_report/data/repository/contact_and_report_repository_impl.dart'
    as _i221;
import 'package:rakaan/features/contact_and_report/presentation/cubit/contact_and_report_cubit.dart'
    as _i554;
import 'package:rakaan/features/edit_profile/presentation/cubit/edit_profile_cubit.dart'
    as _i69;
import 'package:rakaan/features/faq/data/data_source/faq_data_source.dart'
    as _i377;
import 'package:rakaan/features/faq/data/data_source/faq_data_source_impl.dart'
    as _i1056;
import 'package:rakaan/features/faq/data/repository/faq_repository.dart'
    as _i504;
import 'package:rakaan/features/faq/data/repository/faq_repository_impl.dart'
    as _i436;
import 'package:rakaan/features/faq/presentation/cubit/faq_cubit.dart' as _i788;
import 'package:rakaan/features/home/data/data_source/home_data_source.dart'
    as _i152;
import 'package:rakaan/features/home/data/data_source/home_data_source_impl.dart'
    as _i882;
import 'package:rakaan/features/home/data/repository/home_repository.dart'
    as _i444;
import 'package:rakaan/features/home/data/repository/home_repository_impl.dart'
    as _i850;
import 'package:rakaan/features/home/presentation/cubit/home_cubit.dart'
    as _i650;
import 'package:rakaan/features/intro/onboarding/data/data_source/onBoarding_data_source.dart'
    as _i656;
import 'package:rakaan/features/intro/onboarding/data/data_source/onBoarding_data_source_impl.dart'
    as _i391;
import 'package:rakaan/features/intro/onboarding/data/repository/onBoarding_repository.dart'
    as _i347;
import 'package:rakaan/features/intro/onboarding/data/repository/onBoarding_repository_impl.dart'
    as _i785;
import 'package:rakaan/features/intro/onboarding/presentation/cubit/on_boarding_cubit.dart'
    as _i288;
import 'package:rakaan/features/intro/select_language/presentation/cubit/select_language_cubit.dart'
    as _i260;
import 'package:rakaan/features/intro/splash/presentation/cubit/splash_cubit.dart'
    as _i961;
import 'package:rakaan/features/learn/data/data_source/learn_data_source.dart'
    as _i894;
import 'package:rakaan/features/learn/data/data_source/learn_data_source_impl.dart'
    as _i232;
import 'package:rakaan/features/learn/data/repository/learn_repository.dart'
    as _i24;
import 'package:rakaan/features/learn/data/repository/learn_repository_impl.dart'
    as _i984;
import 'package:rakaan/features/learn/presentation/cubit/learn_cubit.dart'
    as _i171;
import 'package:rakaan/features/notifications/data/data_source/remote/notifications_remote_data_source.dart'
    as _i205;
import 'package:rakaan/features/notifications/data/data_source/remote/notifications_remote_data_source_impl.dart'
    as _i658;
import 'package:rakaan/features/notifications/data/repository/notifications_repository.dart'
    as _i896;
import 'package:rakaan/features/notifications/data/repository/notifications_repository_impl.dart'
    as _i909;
import 'package:rakaan/features/notifications/presentation/cubit/notifications_cubit.dart'
    as _i857;
import 'package:rakaan/features/order_status/data/data_source/order_status_data_source.dart'
    as _i74;
import 'package:rakaan/features/order_status/data/data_source/order_status_data_source_impl.dart'
    as _i125;
import 'package:rakaan/features/order_status/data/repository/order_status_repository.dart'
    as _i663;
import 'package:rakaan/features/order_status/data/repository/order_status_repository_impl.dart'
    as _i14;
import 'package:rakaan/features/order_status/presentation/cubit/order_status_cubit.dart'
    as _i33;
import 'package:rakaan/features/orders/data/data_source/orders_data_source.dart'
    as _i789;
import 'package:rakaan/features/orders/data/data_source/orders_data_source_impl.dart'
    as _i508;
import 'package:rakaan/features/orders/data/repository/orders_repository.dart'
    as _i730;
import 'package:rakaan/features/orders/data/repository/orders_repository_impl.dart'
    as _i112;
import 'package:rakaan/features/orders/presentation/cubit/orders_cubit.dart'
    as _i501;
import 'package:rakaan/features/side_menu/data/data_source/settings_remote_data_source.dart'
    as _i357;
import 'package:rakaan/features/side_menu/data/data_source/settings_remote_data_source_impl.dart'
    as _i897;
import 'package:rakaan/features/side_menu/data/repository/settings_repository.dart'
    as _i110;
import 'package:rakaan/features/side_menu/data/repository/settings_repository_impl.dart'
    as _i299;
import 'package:rakaan/features/side_menu/presentation/cubit/side_menu_cubit.dart'
    as _i288;
import 'package:rakaan/features/static_page/data/data_source/static_page_data_source.dart'
    as _i312;
import 'package:rakaan/features/static_page/data/data_source/static_page_data_source_impl.dart'
    as _i1048;
import 'package:rakaan/features/static_page/data/repository/static_page_repository.dart'
    as _i664;
import 'package:rakaan/features/static_page/data/repository/static_page_repository_impl.dart'
    as _i762;
import 'package:rakaan/features/static_page/presentation/cubit/static_page_cubit.dart'
    as _i856;
import 'package:rakaan/features/statics/data/data_source/statics_data_source.dart'
    as _i343;
import 'package:rakaan/features/statics/data/data_source/statics_data_source_impl.dart'
    as _i1039;
import 'package:rakaan/features/statics/data/repository/statics_repository.dart'
    as _i993;
import 'package:rakaan/features/statics/data/repository/statics_repository_impl.dart'
    as _i247;
import 'package:rakaan/features/statics/presentation/cubit/statics_cubit.dart'
    as _i132;
import 'package:rakaan/features/trip_details/data/data_source/trip_details_data_source.dart'
    as _i306;
import 'package:rakaan/features/trip_details/data/data_source/trip_details_data_source_impl.dart'
    as _i179;
import 'package:rakaan/features/trip_details/data/repository/trip_details_repository.dart'
    as _i128;
import 'package:rakaan/features/trip_details/data/repository/trip_details_repository_impl.dart'
    as _i305;
import 'package:rakaan/features/trip_details/presentation/cubit/trip_details_cubit.dart'
    as _i66;
import 'package:rakaan/features/wallet/data/data_source/wallet_data_source.dart'
    as _i1033;
import 'package:rakaan/features/wallet/data/data_source/wallet_data_source_impl.dart'
    as _i78;
import 'package:rakaan/features/wallet/data/repository/wallet_repository.dart'
    as _i933;
import 'package:rakaan/features/wallet/data/repository/wallet_repository_impl.dart'
    as _i227;
import 'package:rakaan/features/wallet/presentation/cubit/wallet_cubit.dart'
    as _i417;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.factory<_i161.InternetConnection>(
        () => injectionModule.internetConnection);
    gh.factory<_i361.Dio>(() => injectionModule.dioClient);
    gh.factory<_i183.ImagePicker>(() => injectionModule.imagePicker);
    gh.factory<_i810.AppFirebase>(() => _i810.AppFirebase());
    gh.factory<_i833.DeviceInfo>(() => _i833.DeviceInfo());
    gh.lazySingleton<_i1050.DioLogInterceptor>(
        () => _i1050.DioLogInterceptor());
    gh.factory<_i1063.DocumentHelper>(
        () => _i1063.DocumentHelper(imagePicker: gh<_i183.ImagePicker>()));
    gh.lazySingleton<_i336.SharedPrefServices>(() => _i336.SharedPrefServices(
        sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.factory<_i758.AuthLocalDataSource>(() =>
        _i864.AuthLocalDataSourceImpl(appPref: gh<_i336.SharedPrefServices>()));
    gh.factory<_i435.NetworkInfo>(() => _i435.NetworkInfoImpl(
        internetConnection: gh<_i161.InternetConnection>()));
    gh.factory<_i260.SelectLanguageCubit>(
        () => _i260.SelectLanguageCubit(gh<_i336.SharedPrefServices>()));
    gh.factory<_i961.SplashCubit>(
        () => _i961.SplashCubit(gh<_i336.SharedPrefServices>()));
    gh.lazySingleton<_i337.ApiConsumer>(() => _i3.DioApiConsumer(
          networkInfo: gh<_i435.NetworkInfo>(),
          dioClient: gh<_i361.Dio>(),
          appPref: gh<_i336.SharedPrefServices>(),
        ));
    gh.factory<_i620.AuthRemoteDataSource>(() =>
        _i568.AuthRemoteDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i152.HomeDataSource>(
        () => _i882.HomeDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i1033.WalletDataSource>(
        () => _i78.WalletDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i656.OnBoardingDataSource>(() =>
        _i391.OnBoardingDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i444.HomeRepository>(() =>
        _i850.HomeRepositoryImpl(homeDataSource: gh<_i152.HomeDataSource>()));
    gh.factory<_i74.OrderStatusDataSource>(() =>
        _i125.OrderStatusDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i205.NotificationsRemoteDataSource>(() =>
        _i658.NotificationsRemoteDataSourceImpl(
            apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i894.LearnDataSource>(
        () => _i232.LearnDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i789.OrdersDataSource>(
        () => _i508.OrdersDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i663.OrderStatusRepository>(() =>
        _i14.OrderStatusRepositoryImpl(
            orderStatusDataSource: gh<_i74.OrderStatusDataSource>()));
    gh.factory<_i312.StaticPageDataSource>(() =>
        _i1048.StaticPageDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i896.NotificationsRepository>(() =>
        _i909.NotificationsRepositoryImpl(
            notificationsRemoteDataSource:
                gh<_i205.NotificationsRemoteDataSource>()));
    gh.factory<_i761.ChatDataSource>(
        () => _i200.ChatDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i377.FaqDataSource>(
        () => _i1056.FaqDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i343.StaticsDataSource>(() =>
        _i1039.StaticsDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i306.TripDetailsDataSource>(() =>
        _i179.TripDetailsDataSourceImpl(apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i24.LearnRepository>(() => _i984.LearnRepositoryImpl(
        learnDataSource: gh<_i894.LearnDataSource>()));
    gh.factory<_i357.SettingsRemoteDataSource>(() =>
        _i897.SettingsRemoteDataSourceImpl(
            apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i955.ContactAndReportDataSource>(() =>
        _i829.ContactAndReportDataSourceImpl(
            apiConsumer: gh<_i337.ApiConsumer>()));
    gh.factory<_i957.AuthRepository>(() => _i816.AuthRepositoryImpl(
          authRemoteDataSource: gh<_i620.AuthRemoteDataSource>(),
          authLocalDataSource: gh<_i758.AuthLocalDataSource>(),
        ));
    gh.factory<_i933.WalletRepository>(() => _i227.WalletRepositoryImpl(
        walletDataSource: gh<_i1033.WalletDataSource>()));
    gh.factory<_i33.OrderStatusCubit>(() => _i33.OrderStatusCubit(
          gh<_i663.OrderStatusRepository>(),
          gh<_i1063.DocumentHelper>(),
        ));
    gh.factory<_i1011.PinCodeCubit>(
        () => _i1011.PinCodeCubit(authRepository: gh<_i957.AuthRepository>()));
    gh.factory<_i737.ChatRepository>(() =>
        _i208.ChatRepositoryImpl(chatDataSource: gh<_i761.ChatDataSource>()));
    gh.factory<_i664.StaticPageRepository>(() => _i762.StaticPageRepositoryImpl(
        staticPageDataSource: gh<_i312.StaticPageDataSource>()));
    gh.factory<_i207.RegisterCubit>(() => _i207.RegisterCubit(
          repository: gh<_i957.AuthRepository>(),
          documentHelper: gh<_i1063.DocumentHelper>(),
        ));
    gh.factory<_i347.OnBoardingRepository>(() => _i785.OnBoardingRepositoryImpl(
        onBoardingDataSource: gh<_i656.OnBoardingDataSource>()));
    gh.factory<_i993.StaticsRepository>(() => _i247.StaticsRepositoryImpl(
        staticsDataSource: gh<_i343.StaticsDataSource>()));
    gh.factory<_i857.NotificationsCubit>(
        () => _i857.NotificationsCubit(gh<_i896.NotificationsRepository>()));
    gh.factory<_i650.HomeCubit>(() => _i650.HomeCubit(
          gh<_i444.HomeRepository>(),
          gh<_i336.SharedPrefServices>(),
        ));
    gh.factory<_i128.TripDetailsRepository>(() =>
        _i305.TripDetailsRepositoryImpl(
            tripDetailsDataSource: gh<_i306.TripDetailsDataSource>()));
    gh.factory<_i504.FaqRepository>(() =>
        _i436.FaqRepositoryImpl(faqDataSource: gh<_i377.FaqDataSource>()));
    gh.factory<_i171.LearnCubit>(
        () => _i171.LearnCubit(gh<_i24.LearnRepository>()));
    gh.factory<_i453.ChatCubit>(() => _i453.ChatCubit(
          gh<_i737.ChatRepository>(),
          gh<_i336.SharedPrefServices>(),
        ));
    gh.factory<_i791.ContactAndReportRepository>(() =>
        _i221.ContactAndReportRepositoryImpl(
            remoteDataSource: gh<_i955.ContactAndReportDataSource>()));
    gh.factory<_i788.FaqCubit>(() => _i788.FaqCubit(gh<_i504.FaqRepository>()));
    gh.factory<_i417.WalletCubit>(() => _i417.WalletCubit(
          gh<_i933.WalletRepository>(),
          gh<_i336.SharedPrefServices>(),
        ));
    gh.factory<_i223.LoginCubit>(() => _i223.LoginCubit(
          repository: gh<_i957.AuthRepository>(),
          sharedPrefServices: gh<_i336.SharedPrefServices>(),
        ));
    gh.factory<_i110.SettingsRepository>(() => _i299.SettingsRepositoryImpl(
        remoteDataSource: gh<_i357.SettingsRemoteDataSource>()));
    gh.factory<_i730.OrdersRepository>(() => _i112.OrdersRepositoryImpl(
        ordersDataSource: gh<_i789.OrdersDataSource>()));
    gh.factory<_i288.SideMenuCubit>(() => _i288.SideMenuCubit(
          gh<_i110.SettingsRepository>(),
          gh<_i336.SharedPrefServices>(),
        ));
    gh.factory<_i69.EditProfileCubit>(() => _i69.EditProfileCubit(
          gh<_i110.SettingsRepository>(),
          gh<_i336.SharedPrefServices>(),
          gh<_i1063.DocumentHelper>(),
          gh<_i957.AuthRepository>(),
        ));
    gh.factory<_i288.OnBoardingCubit>(() => _i288.OnBoardingCubit(
          gh<_i347.OnBoardingRepository>(),
          gh<_i336.SharedPrefServices>(),
        ));
    gh.factory<_i856.StaticPageCubit>(() => _i856.StaticPageCubit(
          gh<_i664.StaticPageRepository>(),
          gh<_i336.SharedPrefServices>(),
        ));
    gh.factory<_i132.StaticsCubit>(
        () => _i132.StaticsCubit(gh<_i993.StaticsRepository>()));
    gh.factory<_i501.OrdersCubit>(() => _i501.OrdersCubit(
          gh<_i730.OrdersRepository>(),
          gh<_i336.SharedPrefServices>(),
        ));
    gh.factory<_i554.ContactAndReportCubit>(() =>
        _i554.ContactAndReportCubit(gh<_i791.ContactAndReportRepository>()));
    gh.factory<_i66.TripDetailsCubit>(
        () => _i66.TripDetailsCubit(gh<_i128.TripDetailsRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i308.InjectionModule {}
