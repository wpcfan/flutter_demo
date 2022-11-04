import 'package:flutter_dotenv/flutter_dotenv.dart';

String get lcAppId => dotenv.env['LC_APP_ID'] ?? '';
String get lcAppKey => dotenv.env['LC_APP_KEY'] ?? '';
String get lcApiBase => 'feeds.twigcodes.com';
// ignore: non_constant_identifier_names
String get PERF_KEY_ROUTE_BEFORE_LOGIN => 'routeBeforeLogin';
bool get restoreLastRouteBeforeLogin => true;
