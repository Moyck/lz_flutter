# LZ Flutter Framework



[TOC]


自用FLutter MVP框架


#### 网络

网络层依赖 [Retrofit](https://pub.dev/packages/retrofit) 和 [Dio](https://pub.dev/packages/dio) 

##### 基本配置

```dart
 Config.getInstance()
      .netWorkConfig 																			//网络配置
      .setApiDomain(apiDomain) 												 		//Api Domain
      .setConnectionTimeout(15 * 1000)  									//设置超时时间
      .setProxy(proxy)																		//设置代理
      .addNetWorkInterceptor([														//添加网络拦截器
    getIt<HttpRequestSignatureInterceptor>()
  ]).setRepository([SecurityRetrofit(Api.getClient())]);  //添加repository
```

##### 网络拦截

```dart
//拦截器需要继承NetWorkInterceptor类
class HttpRequestSignatureInterceptor extends NetWorkInterceptor{ 

  SecurityApplication _securityApplication;

  HttpRequestSignatureInterceptor(this._securityApplication);

  
 //网络请求前的拦截，一般用于添加请求头，如签名token
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    options.headers['X-OPENINVITE-SIGNATURE'] = '';
    options.headers['X-OPENINVITE-TIMESTAMP'] = '';
    options.headers['X-OPENINVITE-NONCE'] = '';
    options.headers['X-OPENINVITE-DEVICE-ID'] = '';
  }

  //当接口返回401 / 403 时会触发，用于刷新Token
  @override
  Future onTokenError() async => _securityApplication.refreshToken();

   //当接口返回码大于400触发，可用于统一处理请求错误
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
  
}
```

##### Repository

```dart
part 'security_retrofit.g.dart';

//Repository 依赖Retrofit 具体使用请参考Retrofit的接口文档
@RestApi()
abstract class SecurityRetrofit{

  //Retrofit 依赖 Dio 所以每个Repository都需要传入 Api.getClient()
  factory SecurityRetrofit(Dio dio, {String baseUrl}) = _SecurityRetrofit;

  //只需要LoginResponse 有实现 toJson fromJson 就支持自动序列化
  @POST('login')
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);
  
  @GET('bind_google_account')
  Future<void> bindGoogleAccount(@Query() String uid);

  @POST('google_sign_in')
  Future<LoginResponse> googleSignIn(@Field() String uid);

}
```

##### 发起请求

```dart
//SecurityRetrofit 需要在 Config.getInstance().netWorkConfig.setRepository 里传入 	
    
Api.getService<SecurityRetrofit>().login(loginData.toLoginRequest());
```



#### 依赖注入

依赖注入依赖 [get_it](https://pub.dev/packages/get_it) 和 [injectable](https://pub.dev/packages/injectable) 

##### 初始化

```dart
//在app入口文件 （main_common.dart）添加初始化代码
final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', 
  preferRelativeImports: true, 
  asExtension: false, 
)

void configureDependencies() => $initGetIt(getIt);

Future<void> mainCommon(String apiServerUrl, {bool debug = false}) async {
  await init();
  runApp(MyApp());
}

Future<void> init() async {
  configureDependencies();  //初始化IOC
```

##### 依赖注入

```dart
//需要依赖注入的类加上 @injectable即可
@injectable
class SecurityApplication {
  
  //被注入的类也需要加上 @injectable注解
  SecurityRepository _securityRepository;
  
  SecurityApplication(this._securityRepository);
```

##### 单例

```dart
//当你依赖注入的类需要是单例时添加@singleton注解
@singleton
@injectable
class SecurityApplication {

```

##### 动态获取IOC的类

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	//无法使用依赖注入的类（比如动态创建的widget）也能拿到IOC管理的类而无需关心SecurityApplication的依赖关系
    SecurityApplication securityApplication = getIt<SecurityApplication>();
    return Container();
  }
}
```

##### 通过IOC跳转页面并传参

```dart
class MyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      Container(child: InkWell(onTap: () {
        //这里跳转页面通过getIt拿到LoginPage的实例而不用关心LoginPage的依赖关系
          routeTo(MaterialPageRoute(builder: (ct) => getIt<LoginPage>()));
        //getIt还可以传参,填入param1，用于页面之间跳转传参
          routeTo(MaterialPageRoute(builder: (ct) => getIt<LoginPage>(param1: User())));
      },
       child: const Text('跳转页面')));
} 
  
 
@injectable
class LoginPage extends StatefulWidget {

  final LoginPresenter _presenter;
  User _user;

 	//如果getIt param1为空_user就会为空
  //如果getIt param1有值，会自动赋值到_user，不需要通过 ModalRoute.of(context).settings.arguments 传参
  const LoginPage(this._presenter,{this._user});

  @override
  _LoginPageState createState() => _LoginPageState();
}

```



#### MVP

框架推荐的MVP实现

##### BaseState

```dart
//定义了一些常用的方法
abstract class View {

  //presenter可以通过getContext拿到Page的context
  BuildContext getContext();

  //通过SnackBar弹出提示信息
  void showMsgBySnackBar(String msg,{bool needLocal = false });

  //通过Toast弹出提示信息
  void showMsgByToast(String msg,{bool needLocal = false });

  //显示Loding提示框 （barrierDismissible：是否可以点击空白处隐藏dialog）
  void showLoadingDialog({String msg,bool needLocal = false,bool barrierDismissible = false});

  //隐藏Loding提示框  实际等于 pop()
  void hideLoadingDialog();

  //返回上一个页面 可传参
  void pop({result});

  //返回指定页面
  void popTo(String routePath);

  //刷新页面 等于 setState()
  void refresh();

  //跳转页面 （replace：是否替换当前页面，clearStack是否清除堆栈，predicate：clearStack不为空时，自行处理路由堆栈,默认清除所有）
  Future<T?> routeTo<T extends Object?>(Route<T> newRoute,{bool replace = false,bool clearStack = false,RoutePredicate? predicate});

}

//BaseState就是实现了View方法的State<T>
abstract class BaseState<T extends StatefulWidget>  extends State<T> implements View{

  @override
  void showMsgBySnackBar(String msg) {
    Scaffold.of(getContext()).showSnackBar(SnackBar(content: new Text(msg)));
  }
```



##### Page

```dart
//View的抽象类，需要实现View接口
abstract class HomeView implements View{

  //传值可以通过set方法
  set user(User value);
  
  //定义presenter需要调用的方法
  void toLoginPage();

}

@injectable  //依赖注入
class HomePage extends StatefulWidget {
  
  HomePresenter _presenter;
  User? _user;
  
  //注入Presenter或可选参数
  const HomePage(this._presenter,{this._user});

  @override
  _HomePageState createState() => _HomePageState();
}

//继承BaseState 实现HomeView定义的方法
class _HomePageState extends BaseState<HomePage> implements HomeView{
  
  @override
  void initState() {
    super.initState();
    widget.presenter.bind(this); //将view与presenter绑定
  }
  

```



##### Presenter

```dart
@injectable 
class HomePresenter{

  HomeView _view;
  SecurityApplication _securityApplication;
  
  //注入所需的依赖
  HomePresenter(this._securityApplication);
  
  //绑定View
  void bind(HomeView view){
    _view = view;
  }
  
  void next(){
    //Presenter调用view定义的方法
    _view.toLoginPage();
  }

}

```



#### 数据库

数据库依赖 [floor](https://pub.flutter-io.cn/packages/floor)

##### 初始化

```dart
//version 是数据库版本，entities是需要创建的表
@Database(version: 1, entities: [SimpleHttpRequest])
abstract class MyFloorDatabase extends FloorDatabase {
  //local repository都需要在这里配置
  SimpleHttpRequestDao get simpleHttpRequestDao;
}
```

```dart
//在main_common进行初始化 
getIt<AppDataBase>().init();
```

##### Repository

```dart
//具体用法请参考floor的官方文档
@dao
abstract class SimpleHttpRequestDao{

  //查询
  @floor.Query('SELECT * FROM SimpleHttpRequest')
  Future<List<SimpleHttpRequest>> findAllSimpleHttpRequest();

  //插入
  @insert
  Future<void> insertSimpleHttpRequest(SimpleHttpRequest request);

  //更新
  @update
  Future<int> updateSimpleHttpRequests(List<SimpleHttpRequest> request);

  //删除
  @delete
  Future<int> deleteSimpleHttpRequests(List<SimpleHttpRequest> request);

}
```

##### Dao使用

```dart
@injectable
class SimpleHttpRequestRepository{

  AppDataBase _appDataBase;
	//依赖注入AppDataBase
  SimpleHttpRequestRepository(this._appDataBase);

  //使用对应的dao 
  Future<List<SimpleHttpRequest>> getAllRequest() async => _appDataBase.db.simpleHttpRequestDao.findAllSimpleHttpRequest();

}
```



#### 国际化/资源配置

##### 初始化

```dart
 Config.getInstance().resourceConfig //资源配置
      .setLocalRes({'zh': zh, 'en': en}) //传入 国际化文件
  		.setCurrentLanguageCode('zh')			 //设置APP语言，即使系统语言改变也只显示设置的语言
      .setDefaultLanguageCode('zh')			 //国际化文件没有当前系统语言时显示该语言，国际化文件有当前系统语言时显示系统语言
   		.setDesignSize(360, 640)；					//屏幕自适应设计稿大小
```

##### 国际化

```dart
//在国际化文件中输入需要国际化的内容
const zh = {
  "app_name": "测试demo",
  "user_info": ["姓名", "ID", "头像"]
};

//通过String的拓展方法拿到国际化后的内容
Text("app_name".resLocal(context));
//通过String的拓展方法拿到国际化后的内容（List<String>）
List<String> list = "user_info".resStringList(context);
```

##### 屏幕适配

```dart
//通过int double的拓展方法拿到屏幕适配后算出的值
//请谨慎使用，绝大多数情况都不需要使用屏幕适配，使用屏幕适配会让字体/高度随着屏幕大小按比例缩放，但是参考微信 QQ 无论你使用手机还是平板，他们的字体大小，头像大小，标题栏工具栏大小都是不会随着屏幕大小变化的
Container(width: 10.toAdapterSize());
```



#### 调试工具

框架自带调试工具可以查看网络请求或APP未捕获的异常

##### 全局异常捕获

```dart
// 开启全局异常捕获 
Config.getInstance().debuggerConfig.startCatchAllException(); 
```

##### 显示调试工具浮动按钮

```dart
//1.添加navigatorKey在最外层MaterialApp
MaterialApp(
   navigatorKey: Config.getInstance().debuggerConfig.navigatorKey,
);

//2.在第一个显示的页面里显示浮动按钮
class _HomePageState extends BaseState<HomePage> {
  
  //防止热更新后context销毁 因此需要用GlobalKey
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (_scaffoldKey.currentContext != null) {
      Config.getInstance().debuggerConfig.showDebuggerFloatingButton(
          _scaffoldKey.currentContext!); //显示调试工具浮动按钮
    }
    return Scaffold(
        key: _scaffoldKey,
```



#### 工具类

提供一些常用方法

##### SpUtil 

SharedPreferences的封装类用于简单常用数据存取

##### SignatureKey

防重放攻击密钥计算



#### 业务相关

框架实现了一些常用的业务，但需要根据自己项目的实际需求更改

##### 推送

需要先按照[flutter_apns](https://pub.flutter-io.cn/packages/flutter_apns)文档配置iOS/Android 

```dart
@singleton
@injectable
class NotificationApplication {

  //在maim_common 初始化
  Future<void> init() async {
    final connector = createPushConnector();
    connector.configure(
      onLaunch: onPush,
      onResume: onPush,
      onMessage: onPush,
      onBackgroundMessage: onBackgroundMessage
    );

    connector.token.addListener(
            ()  => onTokenRefresh(connector.token.value!));
    connector.requestNotificationPermissions();
  }

  //Token刷新回调
  Future onTokenRefresh(String token) async {
    print(token);
  }

  //消息推送回调
  Future onPush(RemoteMessage message) async {
    print(message);
  }

  //透传消息回调
  Future onBackgroundMessage(RemoteMessage message) async {
    print(message);
  }

}

```

##### 第三方登录

```dart
@injectable
class SocialLoginService {

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email', 'https://www.googleapis.com/auth/contacts.readonly']);

  //Google登录 返回google账号的唯一id
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if(googleUser == null){
      throw SocialLoginException(SocialLoginExceptionCode.loginWithGoogleError,'sign with google wrong');
    }
    return googleUser.id;
  }

  //Apple登录 返回Apple账号的唯一id
  Future<String> signInWithApple() async {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      return credential.userIdentifier!;
  }

}
```

##### 指纹/人脸验证

```dart
// 需要参考 https://pub.dev/packages/local_auth 配置Android iOS

@injectable
class LocalAuthService {
  LocalAuthentication localAuth = LocalAuthentication();

  //指纹/人脸登录，返回值代表是否验证成功, BiometricType:验证类型 localizedReason:验证原因
  Future<bool> loginWithLocalAuth(BiometricType biometricType, String localizedReason) async {
    final List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();
    if (!await localAuth.canCheckBiometrics) {
      throw LocalAuthException(LocalAuthExceptionCode.cantSupportBiometrics, 'the device can not support biometrics');
    }
    if (!availableBiometrics.contains(biometricType)) {
      throw LocalAuthException(LocalAuthExceptionCode.noAvailableBiometrics, 'the biometricType no available');
    }
    return localAuth.authenticate(localizedReason: localizedReason, biometricOnly: true);
  }

}
```

##### 账号密码登录

只实现基本流程，根据自己项目需求更改Domain和相关逻辑

```dart
@injectable
class SecurityApplication {

  //账号密码登录
  Future<void> login(LoginCommand loginCommand) async {
    loginCommand.checkValid();
    final loginResponse = await _securityRepository.login(loginCommand);
    loginResponse.toSession().save();
  }

  //注册
  Future<void> register(RegisterCommand registerCommand) async {
    registerCommand.checkValid();
    final loginResponse = await _securityRepository.register(registerCommand);
    loginResponse.toSession().save();
  }
  
  //Google登录
  Future loginWithGoogle() async {
    final googleId = await _socialLoginService.signInWithGoogle();
    final loginResponse = await _securityRepository.googleSignIn(googleId);
    loginResponse.toSession().save();
  }

  //关联Google
  Future bindGoogleAccount() async {
    final googleId = await _socialLoginService.signInWithGoogle();
    await _securityRepository.bindGoogleAccount(googleId);
  }

  //登出
  Future<void> logout() async {
    await SpUtil.putObject('user','');
  }

  //刷新token
  Future refreshToken() async {
    final Session session = Session.fromJson(SpUtil.getObject('user') as Map<String, dynamic> );
    await _securityRepository.refreshAccessToken(session);
  }

  Session? getSession(){
    if(SpUtil.getObject('user') == null){
      return null;
    }
    final Session session = Session.fromJson(SpUtil.getObject('user') as Map<String, dynamic> );
    return session;
  }
```

