import 'package:flutter_dotenv/flutter_dotenv.dart';

String get lcAppId => dotenv.env['LC_APP_ID'] ?? '';
String get lcAppKey => dotenv.env['LC_APP_KEY'] ?? '';
String get lcApiBase => 'feeds.twigcodes.com';
String get cartQlApiBase => 'https://api.cartql.com';
String get placeholderUri => 'https://via.placeholder.com';
String get perfKeyRouteBeforeLogin => 'routeBeforeLogin';
bool get restoreLastRouteBeforeLogin => true;
const int splashDuration = 5;
const bool hasSplash = false;
const int pageSize = 20;
const int maxHistoryLength = 20;
// 距离屏幕边缘的水平距离
const double screenHorizontalPadding = 12;
// 距离列表边缘的水平距离
const double listHorizontalPadding = 12;
// 距离列表边缘的垂直距离
const double listVerticalPadding = 12;
// 相邻列表条目之间的垂直距离
const double spaceBetweenListItems = 12;
// 默认最大购买数量
const int maxOrderQuantity = 999;
// 默认最小购买数量
const int minOrderQuantity = 1;
// 默认购买数量步长，即每次增加或减少的数量
const int orderQuantityStep = 1;
