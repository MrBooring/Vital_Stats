import 'package:get/get.dart';
import 'package:sqllitecrud/logic/bindings/home_binding.dart';
import 'package:sqllitecrud/logic/bindings/homepage_binding.dart';
import 'package:sqllitecrud/logic/bindings/login_binding.dart';
import 'package:sqllitecrud/view/pages/auth/login.dart';
import 'package:sqllitecrud/view/pages/functions/food.dart';
import 'package:sqllitecrud/view/pages/functions/sleep.dart';
import 'package:sqllitecrud/view/pages/functions/traning.dart';
import 'package:sqllitecrud/view/pages/auth/register.dart';
import 'package:sqllitecrud/view/pages/functions/water.dart';
import 'package:sqllitecrud/view/pages/home/homepage.dart';
import 'package:sqllitecrud/view/pages/profile/profile.dart';
import 'package:sqllitecrud/view/splash_screen.dart';

import '../../logic/bindings/register_binding.dart';

var routes = [
  GetPage(
    name: '/',
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: '/home',
    page: () => const Home(),
    binding: HomePageBindings(),
  ),
  GetPage(
    name: '/login',
    page: () => LoginPage(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: "/Traning",
    page: () => Traning(),
  ),
  GetPage(
    name: '/register',
    page: () => RegisterPage(),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: '/waterTracker',
    page: () => WaterTracker(),
  ),
  GetPage(
    name: '/foodTracker',
    page: () => FoodTracker(),
  ),
  GetPage(
    name: '/sleepTracker',
    page: () => SleepTracker(),
  ),
];
