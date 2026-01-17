import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wallets/core/di/service_locator.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/features/auth/logic/login/cubit/login_cubit.dart';
import 'package:wallets/features/auth/logic/logout/cubit/logout_cubit.dart';
import 'package:wallets/features/auth/logic/otp/cubit/otp_cubit.dart';
import 'package:wallets/features/auth/logic/register/cubit/register_cubit.dart';
import 'package:wallets/features/auth/ui/login/login_screen.dart';
import 'package:wallets/features/bill_payments/ui/bill_payment_details_screen.dart';
import 'package:wallets/features/bill_payments/ui/bill_payments_screen.dart';
import 'package:wallets/features/bill_payments/ui/select_provider_screen.dart';
import 'package:wallets/features/currency_exchange/ui/currency_exchange_screen.dart';
import 'package:wallets/features/get_start/ui/get_start_screen.dart';
import 'package:wallets/features/home/logic/cubit/home_cubit.dart';
import 'package:wallets/features/home/ui/home_screen.dart';
import 'package:wallets/features/profile/logic/cubit/profile_cubit.dart';
import 'package:wallets/features/profile/ui/edit_profile_screen.dart';
import 'package:wallets/features/profile/ui/profile_screen.dart';
import 'package:wallets/features/top_up/ui/top_up_screen.dart';
import 'package:wallets/features/transaction_history/ui/transaction_history_screen.dart';
import 'package:wallets/features/onboarding/ui/onboarding_screen.dart';
import 'package:wallets/features/auth/ui/otp/otp_screen.dart';
import 'package:wallets/features/auth/ui/register/register_screen.dart';
import 'package:wallets/features/transfer/logic/cubit/transfer_cubit.dart';
import 'package:wallets/features/transfer/ui/teansfer_screen.dart';
import 'package:wallets/features/wallets/models/wallet_item.dart';
import 'package:wallets/features/wallets/ui/wallets_screen.dart';
import 'package:wallets/features/withdraw_funds/withdraw_funds_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onbordingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.getStartScreen:
        return MaterialPageRoute(builder: (context) => const GetStartScreen());
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<HomeCubit>()
                  ..getWallets()
                  ..getAllTransactions(),
              ),
              BlocProvider(create: (_) => getIt<LogoutCubit>()),
              BlocProvider(
                create: (_) => getIt<ProfileCubit>()..fetchProfile(),
              ),
            ],
            child: const HomeScreen(),
          ),
        );
      case Routes.otpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<OtpCubit>(),
            child: const OtpScreen(),
          ),
          settings: settings,
        );
      case Routes.walletsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>()..getWallets(),
            child: const WalletsSCreen(),
          ),
        );
      case Routes.transactionHistoryScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>()
              ..getWallets()
              ..getAllTransactions(),
            child: const TransactionHistoryScreen(),
          ),
        );
      case Routes.transferScreen:
        final walletItems =
            (settings.arguments as List<WalletItem>?) ?? const [];
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<TransferCubit>(),
            child: TransferScreen(wallets: walletItems),
          ),
        );
      case Routes.topupScreen:
        return MaterialPageRoute(builder: (context) => const TopUp());
      case Routes.currencyexchangescreen:
        return MaterialPageRoute(
          builder: (context) => const CurrencyExchangeScreen(),
        );

      case Routes.withdrawfundsscreen:
        return MaterialPageRoute(
          builder: (context) => const WithdrawFundsScreen(),
        );

      case Routes.billpaymentsscreen:
        return MaterialPageRoute(
          builder: (context) => const BillPaymentsScreen(),
        );

      case Routes.selectproviderscreen:
        return MaterialPageRoute(
          builder: (context) => const SelectProviderScreen(),
        );

      case Routes.billpaymentdetailsscreen:
        return MaterialPageRoute(
          builder: (context) => const BillPaymentDetailsScreen(),
        );

      case Routes.profilescreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<ProfileCubit>()..fetchProfile(),
            child: const ProfileScreen(),
          ),
        );

      case Routes.editprofilescreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ProfileCubit>(
            create: (context) => getIt<ProfileCubit>()..fetchProfile(),
            child: EditProfileScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Center(child: Text('common.not_found'.tr())),
        );
    }
  }
}
