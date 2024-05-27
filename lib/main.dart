import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buddyget/core/constants/app/app_constants.dart';
import 'package:buddyget/core/theme/app_theme/app_theme.dart';
import 'package:buddyget/feature/add_transaction/cubit/transaction_cubit.dart';
import 'package:buddyget/product/init/localization/localizaton_manager.dart';
import 'package:buddyget/product/init/product_init.dart';
import 'package:buddyget/widgets/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'feature/tab_controller/viewmodel/tab_controller_viewmodel.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProductInit.getInstance.initProduct();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      path: AppConstants.getInstance.localizationPath,
      supportedLocales: LocalizationManager.getInstance.supportedLocales,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionCubit(),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.getInstance.appTitle,
        key: UniqueKey(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.getInstance.appTheme,
        home: const AuthGate(),
      ),
    );
  }
}
