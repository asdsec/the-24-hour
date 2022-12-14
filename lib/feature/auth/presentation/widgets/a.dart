import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:the_24_hour/feature/auth/presentation/cubit/login_state.dart';
import 'package:the_24_hour/injection.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

class ATest extends StatelessWidget {
  const ATest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AT')),
      body: BlocProvider<LoginCubit>(
        create: (_) => sl.get<LoginCubit>(),
        child: Column(
          children: [
            const Text('TA'),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return state.status == LoginStatus.loading ? const Text('L') : const Text('UL');
              },
            ),
            Text(LocaleKeys.appName.tr()),
          ],
        ),
      ),
    );
  }
}
