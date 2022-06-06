import 'package:deneme_flutter/resources/auth_method.dart';
import 'package:deneme_flutter/responsive/responsive_layout.dart';
import 'package:deneme_flutter/screens/homeowner_screen.dart';
import 'package:deneme_flutter/screens/homeuser_screen.dart';
import 'package:deneme_flutter/screens/login_screen.dart';
import 'package:deneme_flutter/utils/colors.dart';
import 'package:deneme_flutter/utils/utils.dart';
import 'package:deneme_flutter/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _phonenumberController = TextEditingController();
final TextEditingController _usernameController = TextEditingController();
bool _isLoading = false;

class _SignupScreenState extends State<SignupScreen> {
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _phonenumberController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      phonenumber: _phonenumberController.text,
    );

    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                const ResponsiveLayout(mobileScreenLayout: HomeUser())),
      );
    } else {
      showSnackBar(context, res);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            child: Container(),
            flex: 1,
          ),
          // svg img
          if (!isKeyboard)
            SvgPicture.asset(
              'assets/brotherscarservice.svg',
              color: primaryColor,
              height: 64,
            ),
          const SizedBox(
            height: 64,
          ),

          // text field input for name and surname
          TextFieldInput(
            hintText: '  Enter your name and surname',
            textInputType: TextInputType.text,
            textEditingController: _usernameController,
          ),
          const SizedBox(
            height: 24,
          ),
          // text field input for e mail
          TextFieldInput(
            hintText: '  Enter your email',
            textInputType: TextInputType.emailAddress,
            textEditingController: _emailController,
          ),
          const SizedBox(
            height: 24,
          ),
          // text field input for password
          TextFieldInput(
            hintText: '  Enter your password',
            textInputType: TextInputType.text,
            textEditingController: _passwordController,
            isPass: true,
          ),
          const SizedBox(
            height: 24,
          ),
          //text field input for phone number
          TextFieldInput(
            hintText: '  Enter your phone number',
            textInputType: TextInputType.text,
            textEditingController: _phonenumberController,
          ),
          const SizedBox(
            height: 24,
          ),
          // login button
          InkWell(
            onTap: signUpUser,
            child: Container(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : const Text('Sign Up'),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: blueColor),
            ),
          ),
          Flexible(
            child: Container(),
            flex: 3, //3
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text("Do you have an account?"),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
              ),
              GestureDetector(
                onTap: navigateToLogin,
                child: Container(
                  child: Text(
                    "  Login.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
        ]),
      )),
    );
  }
}
