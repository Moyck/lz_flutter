// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'config/database/app_database.dart' as _i7;
import 'config/http_request_auto_retry_interceptor.dart' as _i9;
import 'config/http_request_signature_interceptor.dart' as _i11;
import 'network/application/http_request_auto_retry_app.dart' as _i8;
import 'network/repositories/simple_http_request_repository.dart' as _i6;
import 'notification/application/notification_application.dart' as _i12;
import 'security/application/secutity_application.dart' as _i10;
import 'security/page/login_page.dart' as _i3;
import 'security/page/login_presenter.dart' as _i4;
import 'security/repositories/security_repository.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.LoginPage>(() => _i3.LoginPage());
  gh.factory<_i4.LoginPresenter>(() => _i4.LoginPresenter());
  gh.factory<_i5.SecurityRepository>(() => _i5.SecurityRepository());
  gh.factory<_i6.SimpleHttpRequestRepository>(
      () => _i6.SimpleHttpRequestRepository(get<_i7.AppDataBase>()));
  gh.factory<_i8.HttpRequestAutoRetryApplication>(() =>
      _i8.HttpRequestAutoRetryApplication(
          get<_i6.SimpleHttpRequestRepository>()));
  gh.factory<_i9.HttpRequestAutoRetryInterceptor>(() =>
      _i9.HttpRequestAutoRetryInterceptor(
          get<_i8.HttpRequestAutoRetryApplication>()));
  gh.factory<_i10.SecurityApplication>(
      () => _i10.SecurityApplication(get<_i5.SecurityRepository>()));
  gh.factory<_i11.HttpRequestSignatureInterceptor>(() =>
      _i11.HttpRequestSignatureInterceptor(get<_i10.SecurityApplication>()));
  gh.singleton<_i7.AppDataBase>(_i7.AppDataBase());
  gh.singleton<_i12.NotificationApplication>(_i12.NotificationApplication());
  return get;
}
