import 'package:flutter_dotenv/flutter_dotenv.dart';

String get lcAppId => dotenv.env['LC_APP_ID'] ?? '';
String get lcAppKey => dotenv.env['LC_APP_KEY'] ?? '';
String get lcApiBase => 'feeds.twigcodes.com';
String get placeholderUri => 'https://via.placeholder.com';
String get perfKeyRouteBeforeLogin => 'routeBeforeLogin';
bool get restoreLastRouteBeforeLogin => true;
const int splashDuration = 5;
