import 'package:auto_route/auto_route.dart';
import 'package:demo/bloc/all.dart';
import 'package:demo/config.dart';
import 'package:demo/interceptors/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/router/guards/all.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'observers/all.dart';

part 'app_widget.dart';

void main() async {
  Bloc.observer = AppBlocObserver();

  /// 确保在初始化之前调用
  WidgetsFlutterBinding.ensureInitialized();

  /// 加载环境变量
  await dotenv.load(fileName: ".env");

  /// 加载本地存储
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // 如果没有购物车 id，就生成一个
  if (prefs.getString('cartId') == null) {
    if (prefs.getString('sessionToken') != null) {
      await prefs.setString('cartId', prefs.getString('sessionToken')!);
    } else {
      await prefs.setString('cartId', const Uuid().v4());
    }
  }

  /// 注意：不要把路由初始化放到 `builder` 函数中
  /// 否则你会在热重载后看到空白屏
  final AppRouter appRouter = AppRouter(AuthGuard(prefs));
  runApp(App(
    sharedPreferences: prefs,
    appRouter: appRouter,
  ));
}
