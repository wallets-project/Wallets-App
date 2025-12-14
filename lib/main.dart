import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/di/service_locator.dart';
import 'package:wallets/core/routing/app_router.dart';
import 'package:wallets/wallets_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await setupServiceLocator();
  runApp(WalletsApp(appRouter: AppRouter()));
}
