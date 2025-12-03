// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../features/auth/controller/auth_cubit.dart' as _i383;
import '../../../features/auth/data/auth_repo/auth_repo.dart' as _i621;
import '../../../features/home_screen/controller/home_screen_cubit.dart'
    as _i1066;
import '../../../features/home_screen/data/home_repo/home_repo.dart' as _i16;
import '../../../features/home_screen/tabs/profile_tab/controller/profile_cubit.dart'
    as _i702;
import '../../../features/home_screen/tabs/profile_tab/data/repo/profile_repo.dart'
    as _i491;
import '../../../features/notification/controller/notification_cubit.dart'
    as _i656;
import '../../../features/notification/data/notification_repo/notification_repo.dart'
    as _i525;
import '../../../features/orders/controller/orders_cubit.dart' as _i272;
import '../../../features/orders/data/repo/orders_repo.dart' as _i337;
import '../../../features/service_screen/controller/service_cubit.dart' as _i97;
import '../../../features/service_screen/data/repo/service_repo.dart' as _i140;
import '../../../features/statics/controller/statics_cubit.dart' as _i679;
import '../../../features/statics/data/repo/statics_repo.dart' as _i661;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i621.AuthRepo>(() => _i621.AuthRepo());
    gh.factory<_i16.HomeRepo>(() => _i16.HomeRepo());
    gh.factory<_i491.ProfileRepo>(() => _i491.ProfileRepo());
    gh.factory<_i525.NotificationRepo>(() => _i525.NotificationRepo());
    gh.factory<_i337.OrdersRepo>(() => _i337.OrdersRepo());
    gh.factory<_i140.ServiceRepo>(() => _i140.ServiceRepo());
    gh.factory<_i661.StaticsRepo>(() => _i661.StaticsRepo());
    gh.factory<_i702.ProfileCubit>(
      () => _i702.ProfileCubit(gh<_i491.ProfileRepo>()),
    );
    gh.factory<_i1066.HomeScreenCubit>(
      () => _i1066.HomeScreenCubit(gh<_i16.HomeRepo>()),
    );
    gh.factory<_i97.ServiceCubit>(
      () => _i97.ServiceCubit(gh<_i140.ServiceRepo>()),
    );
    gh.factory<_i272.OrdersCubit>(
      () => _i272.OrdersCubit(gh<_i337.OrdersRepo>()),
    );
    gh.factory<_i383.AuthCubit>(() => _i383.AuthCubit(gh<_i621.AuthRepo>()));
    gh.factory<_i656.NotificationCubit>(
      () => _i656.NotificationCubit(gh<_i525.NotificationRepo>()),
    );
    gh.factory<_i679.StaticsCubit>(
      () => _i679.StaticsCubit(gh<_i661.StaticsRepo>()),
    );
    return this;
  }
}
