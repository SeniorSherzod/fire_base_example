import 'package:fire_base_example/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../utils/colors/colors.dart';
import '../../utils/connstants/app_const.dart';
import '../../utils/images/images.dart';
import '../../utils/styles/styles.dart';
import '../../view_models/login_view_models.dart';
import '../../widgets/global_button.dart';
import '../../widgets/universal_textfield.dart';
import '../sign_up_screen/sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();


  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = false;
  bool _switchValue=false;
  bool isLoading=false;
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.transparent
      ),
      child:Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding:const EdgeInsets.only(top: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: SizedBox(
                    width: 225.w,
                      child: Image.asset(AppImages.img))),
              SizedBox(height: 50),
              Text(
                "Log in",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: AppTextStyle.rubikBold.copyWith(
                  fontSize: 24,
                  color: AppColors.black,
                ),
              ),

              SizedBox(height: 20),
              UniversalTextFormField(
                prefix:SvgPicture.asset(AppImages.emails),
                hintText: "Email",
                onChanged: context.read<LoginViewModel>().updateEmail,
                onSubmit: (v){},
                controller:emailController ,
                errorText: 'Emailda xato bor',
                type: TextInputType.emailAddress,
                regExp: AppConstants.emailRegExp,
                isVisible: false,),
              SizedBox(height: 15),
              UniversalTextFormField(
                prefix:SvgPicture.asset(AppImages.password),
                hintText: "Password",
                onChanged:context.read<LoginViewModel>().updatePassword,
                onSubmit: (v){},
                controller: passwordController,
                errorText: 'passworda xatolik bor',
                type: TextInputType.text,
                regExp: AppConstants.passwordRegExp, isVisible: true,),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CupertinoSwitch(
                    // trackColor: AppColors.c_1A72DD,
                    activeColor: AppColors.c_1A72DD,
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                  Text(
                    "Remember me",
                    style: AppTextStyle.rubikRegular.copyWith(
                        fontSize: 14, color: AppColors.black),
                  ),
                  SizedBox(width: 10.w),
                  TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      "Forgot Password?",
                      style: AppTextStyle.rubikRegular.copyWith(
                          fontSize: 14, color: AppColors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              GlobalButton(onTap: (){
                isLoading=true;
                context.read<LoginViewModel>().login(context);
                bool validated = formKey.currentState!.validate();
                if (validated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("SUCCESS!")));
                }
              },
                pixels: 53,
                colors: AppColors.c_1A72DD,
                title: "Log in",
                horizontalPadding: 22.w),
              SizedBox(height: 16.h),
              Text(
                "OR",
                style: AppTextStyle.rubikRegular.copyWith(
                    fontSize: 20.w, color: AppColors.black),
              ),
              SizedBox(height: 16.h),
              Text(
                "Log in with",
                style: AppTextStyle.rubikRegular.copyWith(
                    fontSize: 20.w, color: AppColors.black),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (){}, icon: SvgPicture.asset
                    (AppImages.google)),
                  IconButton(
                      onPressed: (){}, icon: SvgPicture.asset
                    (AppImages.instagram)),
                  IconButton(
                      onPressed: (){}, icon: SvgPicture.asset
                    (AppImages.facebook)),
                ],
              ),
              SizedBox(height: 46.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: Row(
                  children: [
                    Text(
                      "Don't have account?",
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.rubikRegular.copyWith(
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignUpScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Register Now",
                        style: AppTextStyle.rubikRegular.copyWith(
                            fontSize: 14, color: AppColors.c_1A72DD),
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}