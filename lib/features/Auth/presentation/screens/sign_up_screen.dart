import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/utils/app_utils.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/core/widgets/custom_textfield.dart';
import 'package:atef_physics/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:atef_physics/features/home/home_screen.dart';
import 'package:atef_physics/features/Auth/presentation/screens/login_screen.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:atef_physics/core/utils/validator_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const String id = "/SginUpScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // backgroundColor: AppColors.background,
      body: SafeArea(
          child: SizedBox(
        width: AppScreenUtils.w,
        height: AppScreenUtils.h,
        child: const SignUpBody(),
      )),
    );
  }
}

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  late AuthCubit authCubit = AuthCubit.get(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController namecon;
  late TextEditingController emailcon;
  late TextEditingController phonecon;
  late TextEditingController passcon;
  late TextEditingController passconfirmcon;

  @override
  void initState() {
    super.initState();
    namecon = TextEditingController();
    emailcon = TextEditingController();
    phonecon = TextEditingController();
    passcon = TextEditingController();
    passconfirmcon = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    namecon.dispose();
    emailcon.dispose();
    phonecon.dispose();
    passcon.dispose();
    passconfirmcon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: 50.h),
          const Spacer(),
          // CustomImagePicker(
          //   ontap: (XFile file) {},
          //   boxDecoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50.r),
          //     // color: AppColors.grey.withOpacity(.2),
          //     color: Theme.of(context).secondaryHeaderColor,
          //   ),
          //   addIcon: CircleAvatar(
          //     radius: 16.r,
          //     // backgroundColor: AppColors.whiteBlack,
          //     child: Icon(
          //       Icons.add,
          //       // color: AppColors.blackWhite,
          //       size: 20.sp,
          //     ),
          //   ),
          //   child: Assets.images.profileImagePlaceholder.svg(),
          // ),

          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  textEditingController: namecon,
                  validator: (p0) => Validators.nameValidator(p0),
                  hintText: "User Name",
                  prefixIcon: Assets.images.icons.personIcon
                      .image(color: AppColors.whiteBlack),
                  label: "User Name",
                ),
                SizedBox(height: 12.h),
                CustomTextFormField(
                  textEditingController: emailcon,
                  validator: (p0) => Validators.emailValidator(p0),
                  hintText: "Email",
                  label: "Email",
                  prefixIcon: Assets.images.icons.emailIcon
                      .image(color: AppColors.whiteBlack),
                ),
                SizedBox(height: 12.h),
                CustomTextFormField(
                  textEditingController: phonecon,
                  validator: (p0) => Validators.phoneNumberValidator(p0),
                  keyboardType: const TextInputType.numberWithOptions(),
                  hintText: "Phone Number",
                  prefixIcon: Assets.images.icons.phoneIcon
                      .svg(color: AppColors.whiteBlack),
                  label: "User Name",
                ),
                SizedBox(height: 12.h),
                CustomTextFormField(
                  textEditingController: passcon,
                  validator: (p0) => Validators.passwordValidator(p0),
                  hintText: "Password",
                  obscureText: true,
                  prefixIcon: Assets.images.icons.lockIcon
                      .image(color: AppColors.whiteBlack),
                  suffixIconConstraints:
                      const BoxConstraints(minWidth: 50, minHeight: 50),
                  label: "Password",
                ),
                SizedBox(height: 12.h),
                CustomTextFormField(
                  validator: (p0) =>
                      p0 == passcon.text ? null : "Passwords doesn't match",
                  hintText: "Confirm Password",
                  obscureText: true,
                  prefixIcon: Assets.images.icons.lockIcon
                      .image(color: AppColors.whiteBlack),
                  suffixIconConstraints:
                      const BoxConstraints(minWidth: 50, minHeight: 50),
                  label: "Confirm Password",
                ),
              ],
            ),
          ),
          const Spacer(flex: 1),
          //Login Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.sp),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                state.whenOrNull(
                  error: (error) {
                    error.showError(context);
                  },
                  success: (userModel) {
                    AppSnackBar.showSnackBar(
                        context, "welcome ${userModel.name}");
                    context.pushNamed(HomeScreen.id);
                  },
                );
              },
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
                  onTap: () async => (formKey.currentState?.validate() ?? false)
                      ? await authCubit.register(
                          name: namecon.text.trim(),
                          mail: emailcon.text.trim(),
                          phoneNumber: phonecon.text.trim(),
                          pass: passcon.text.trim())
                      : null,
                  filled: true,
                  boarderRadius: 25.sp,
                  title: 'Create Account',
                );
              },
            ),
          ),

          SizedBox(height: 15.sp),
          GestureDetector(
            onTap: () => context.pushNamed(LoginScreen.id),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Already have an account ?  ",
                  style: AppTextStyles.hevoLight15WhiteBlackW500),
              TextSpan(
                text: "login",
                style: AppTextStyles.hevoLight15WhiteBlackW500.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.whiteBlack,
                ),
              )
            ])),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  void onTap() {
    AppSnackBar.showSnackBar(context, "Created");
    context.pushNamed(HomeScreen.id);
  }
}
