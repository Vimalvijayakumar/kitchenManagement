import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_manager/data/repositories/firebase_repository.dart';
import 'package:kitchen_manager/ui/common_widgets/app_loader.dart';
import 'package:kitchen_manager/ui/screens/dashboard/admin_dashboard.dart';
import 'package:kitchen_manager/ui/screens/login/login_cubit.dart';
import 'package:kitchen_manager/ui/screens/orders/orders_cubit.dart';
import 'package:kitchen_manager/ui/screens/orders/schef_screen.dart';
import 'package:kitchen_manager/utils/colors.dart';
import 'package:kitchen_manager/utils/styles.dart';
import 'package:kitchen_manager/utils/validaions.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = true;
  @override
  void initState() {
    // TODO: implement initState
    if (Repository().authInstance.currentUser != null) {
      chkAdmin();
    } else {
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (_) => BlocProvider(
      //               create: (context) => LoginCubit(Repository()),
      //               child: Login(),
      //             )));
    }
    super.initState();
  }

  void chkAdmin() async {
    bool isAdmin = await Repository()
        .chkAdmin(Repository().authInstance.currentUser!.email.toString());
    if (isAdmin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => AdminDashboard()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => OrdersCubit(Repository()),
                    child: SchefOrderScreen(),
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      body: SingleChildScrollView(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              AppValidations.showToast(state.error);
            }
            if (state is AdminLoginSucess) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => AdminDashboard()));
            }
            if (state is ChefLoginSucess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider(
                            create: (context) => OrdersCubit(Repository()),
                            child: SchefOrderScreen(),
                          )));
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return AppLoader();
            }
            return Container(
              height: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: SafeArea(
                child: Form(
                    key: _loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 25.w,
                          color: Appcolors.accentColor,
                        ),
                        Text(
                          "Have a good day",
                          style: TextStyle(
                              color: Appcolors.accentColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        TextFormField(
                          controller: _emailController,
                          style: TextStyle(
                              fontSize: 16.sp, color: Appcolors.textColor),
                          validator: AppValidations.validateEmailInput,
                          decoration: AppStyles.getInputDecorationStyle(
                            hint: "Enter your email id",
                            icon: Icons.email_outlined,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFormField(
                            controller: _passwordController,
                            obscureText: _passwordVisible,
                            validator: AppValidations.validatePassword,
                            style: TextStyle(
                                fontSize: 16.sp, color: Appcolors.textColor),
                            decoration: InputDecoration(
                                hintText: "Enter password",
                                prefixIcon: Icon(Icons.lock_outline,
                                    size: 30, color: Appcolors.accentColor),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Appcolors.accentColor),
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        color: Appcolors.accentColor,
                                        width: 1)),
                                hintStyle: TextStyle(
                                    color: Appcolors.hintColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    textBaseline: TextBaseline.alphabetic,
                                    fontStyle: FontStyle.normal),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        color: Appcolors.accentColor,
                                        width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        color: Appcolors.accentColor,
                                        width: 1)))),
                        SizedBox(
                          height: 6.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Appcolors.accentColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Appcolors.accentColor)))),
                              onPressed: () {
                                if (_loginFormKey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context).Login(
                                      _emailController.text,
                                      _passwordController.text);
                                }
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Appcolors.backgroundColor,
                                    fontSize: 14.sp),
                              )),
                        )
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
