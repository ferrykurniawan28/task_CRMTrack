import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/ui/pages/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _codeController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.57,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 85),
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/CRMTrack.png'),
                  spacerHeight(38),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: TextStyle(
                            color: secondPrimaryColor,
                            fontSize: 24,
                            fontWeight: medium,
                          ),
                        ),
                        Text(
                          'Again!',
                          style: TextStyle(
                            color: const Color(0xFF141619),
                            fontSize: 24,
                            fontWeight: medium,
                          ),
                        ),
                        const Text(
                          'Sign in to access your account',
                          style: TextStyle(
                            color: Color(0xFF4D5154),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  spacerHeight(38),
                  Column(
                    children: [
                      customTextForm(
                        title: 'Code',
                        required: true,
                        controller: _codeController,
                      ),
                      spacerHeight(20),
                      customTextForm(
                        title: 'Username',
                        required: true,
                        controller: _usernameController,
                      ),
                      spacerHeight(20),
                      customTextForm(
                        title: 'Password',
                        required: true,
                        controller: _passwordController,
                        isPassword: true,
                        isObscure: _isObscure,
                        onToggleObscure: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xFFD4292C),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Modular.to.navigate('/home'),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xFFD4292C)),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          minimumSize: WidgetStateProperty.all(
                            const Size(double.infinity, 56),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget customTextForm({
  required String title,
  required bool required,
  required TextEditingController controller,
  bool isPassword = false,
  bool isObscure = false,
  VoidCallback? onToggleObscure,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF141619),
            ),
          ),
          spacerHeight(4),
          required
              ? const Text(
                  '*',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFDC3545),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      spacerHeight(4),
      TextFormField(
        controller: controller,
        obscureText: isPassword ? isObscure : false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          hintText: 'Enter $title',
          hintStyle: const TextStyle(
            color: Color(0xFF899197),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Color(0xFFE6E6E6),
            ),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: onToggleObscure, // Use the passed function
                )
              : null,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $title';
          }
          return null;
        },
      ),
    ],
  );
}
