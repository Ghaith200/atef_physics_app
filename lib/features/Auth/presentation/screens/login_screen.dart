import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/utils/validator_utils.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/core/widgets/custom_textfield.dart';
import 'package:atef_physics/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:atef_physics/features/home/presentation/home_screen.dart';
import 'package:atef_physics/features/Auth/presentation/screens/sign_up_screen.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late AuthCubit authCubit = AuthCubit.get(context);
  late TextEditingController emailcon;
  late TextEditingController passcon;

  @override
  void initState() {
    super.initState();
    emailcon = TextEditingController();
    passcon = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailcon.dispose();
    passcon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 50.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Assets.images.logoPng.image(
              //   width: 200.sp,
              //   height: 200.sp,
              //   // fit: BoxFit.contain,
              // ),
              const SizedBox(height: 20),
              Text(
                'Welcome Back',
                style: AppTextStyles.hevoLight25WhiteBlackW900,
              ),
              SizedBox(height: 50.sp),

              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                          textEditingController: emailcon,
                          validator: (p0) => Validators.emailValidator(p0!),
                          keyboardType: TextInputType.emailAddress,
                          inputTextStyle:
                              TextStyle(fontSize: 10.sp, color: Colors.white),
                          hintText: 'Enter your email',
                          prefixIcon: Assets.images.icons.emailIcon
                              .image(color: AppColors.whiteBlack),
                          label: 'Email'),

                      SizedBox(height: 10.sp),

                      // Password Text Form Field
                      CustomTextFormField(
                          validator: (p0) => Validators.passwordValidator(p0),
                          textEditingController: passcon,
                          suffixIconConstraints:
                              const BoxConstraints(minWidth: 50, minHeight: 50),
                          hintText: 'Enter your password',
                          obscureText: true,
                          prefixIcon: Assets.images.icons.lockIcon
                              .image(color: AppColors.whiteBlack),
                          label: 'Password'),
                      SizedBox(height: 20.sp),
                    ],
                  )),
              // Email Text Form Field

              //Login Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) => state.whenOrNull(
                    error: (error) => error.showError(context),
                    success: (userModel) {
                      AppSnackBar.showSnackBar(
                          context, "welcome ${userModel.name}");
                      context.pushNamed(HomeScreen.id);
                      return null;
                    },
                  ),
                  builder: (context, state) {
                    state.whenOrNull(
                      loading: () => CustomButton(
                        onTap: () async {},
                        filled: true,
                        boarderRadius: 25.sp,
                        // title: 'Login',
                        child: const CircularProgressIndicator(),
                      ),
                    );
                    return CustomButton(
                      onTap: () async =>
                          (formKey.currentState?.validate() ?? false)
                              ? await authCubit.login(
                                  email: emailcon.text.trim(),
                                  pass: passcon.text.trim())
                              : null,
                      filled: true,
                      boarderRadius: 25.sp,
                      title: 'Login',
                    );
                  },
                ),
              ),
              const Spacer(),
              SizedBox(height: 20.sp),
              GestureDetector(
                onTap: () {
                  context.push(SignUpScreen.id);
                },
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Don't have an account ?  ",
                      style: AppTextStyles.hevoLight15WhiteBlackW500),
                  TextSpan(
                    text: "Sign Up",
                    style: AppTextStyles.hevoLight15WhiteBlackW500.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.whiteBlack,
                    ),
                  )
                ])),
              ),
            ],
          ),
        ));
  }
}
