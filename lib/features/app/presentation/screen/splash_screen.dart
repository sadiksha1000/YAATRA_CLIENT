import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaatra_client/features/authentication/presentation/screens/login_screen.dart';

import '../../../../core/config/size.dart';
import '../../../authentication/presentation/blocs/cubit/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: SplashScreen());

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   "assets/images/illustrations/googleicon.png",
              //   width: size(context).width * 0.25,
              //   filterQuality: FilterQuality.high,
              // ),

              SizedBox(height: size(context).height * 0.02),
              const Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: size(context).height * 0.02),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: const Text("Go back to Login page"))
            ],
          ),
        ),
      ),
    );
  }

  /// fetch all data from repositoreis
  getData() async {
    var _authBloc = BlocProvider.of<AuthCubit>(context);
    // _authBloc.fetchData();

    // var authProvider = Provider.of<AuthProvider>(context, listen: false);
    // await authProvider.getSharedPreferences();
    // if (authProvider.token.length == 0) {
    //   Get.offAll(() => Login());
    // } else {
    //   await Provider.of<CartProvider>(context, listen: false).pullCartItems();
    //   await Provider.of<UserProfileProvider>(context, listen: false)
    //       .getProfile();
    //   await Provider.of<UserProfileProvider>(context, listen: false).getStats();
    //   await Provider.of<DataProvider>(context, listen: false).fetchNotices();
    //   Get.offAll(() => Home());
    // }
  }
}
