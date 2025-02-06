import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_architecture/provider/auth_provider.dart';
import 'package:future_architecture/ui/screens/product_screen.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDefaultCredentialsDialog();
    });
  }

  void showDefaultCredentialsDialog() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: 'Use These Credentials',
      text: '👨‍🎓 Username: eve.holt@reqres.in\n 🔑 Password: cityslicka',
      confirmBtnText: 'Copy',
      onConfirmBtnTap: () {
        Clipboard.setData(
                ClipboardData(text: 'eve.holt@reqres.in  \n  cityslicka'))
            .then((_) {
          Navigator.pop(context);

          // Show a success alert after copying
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Copied!',
            text: 'Username & Password copied to clipboard!',
            autoCloseDuration: Duration(seconds: 2),
            showConfirmBtn: false,
          );
        });
      },
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB), // Light background color
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 60.h),
                        Center(
                          child: Image.asset(
                            "assets/icons/logo.png",
                            height: 120.h,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          "Infinity Tech Solutions Ltd.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00778F),
                              ),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00778F),
                              ),
                        ),
                        SizedBox(height: 20.h),
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  hintText: 'User Name',
                                  hintStyle: TextStyle(fontSize: 16.sp),
                                  filled: true,
                                  fillColor: const Color(0xFFE3F5EC),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                    vertical: 14.h,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.r),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: TextFormField(
                                  obscureText: !_passwordVisible,
                                  style: TextStyle(fontSize: 16.sp),
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(fontSize: 16.sp),
                                    filled: true,
                                    fillColor: const Color(0xFFE3F5EC),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 24.w,
                                      vertical: 14.h,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: 12.w),
                                      child: IconButton(
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 24.sp,
                                          color: Color(0xFF00778F),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: authProvider.isLoading
                                    ? null
                                    : () async {
                                        if (authProvider.isLoading) return;

                                        String username =
                                            usernameController.text.trim();
                                        String password =
                                            passwordController.text.trim();

                                        // Check if username or password is empty
                                        if (username.isEmpty ||
                                            password.isEmpty) {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Error!',
                                            text:
                                                'User Name and Password are required.',
                                            showConfirmBtn: false,
                                            barrierDismissible: true,
                                            autoCloseDuration:
                                                Duration(seconds: 1),
                                          );
                                          return;
                                        }

                                        try {
                                          await authProvider.login(
                                              username, password);

                                          if (authProvider.token != null) {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.success,
                                              title: 'Success!',
                                              text: 'Login Successfully!',
                                              showConfirmBtn: false,
                                              barrierDismissible: true,
                                              autoCloseDuration:
                                                  Duration(seconds: 1),
                                            );

                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductScreen()),
                                                (route) => false,
                                              );
                                            });

                                            usernameController.clear();
                                            passwordController.clear();
                                          }
                                        } catch (e) {
                                          print('Login error: $e');
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor: Color(0xFF00778F),
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(double.infinity, 48),
                                  shape: const StadiumBorder(),
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: authProvider.isLoading
                                    ? SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.0,
                                        ),
                                      )
                                    : Text(
                                        "Sign In",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ),
                              SizedBox(height: 16.h),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(0.64),
                                      ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.indigo.shade600,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xFF00778F),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
