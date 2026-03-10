import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/branded_button.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/premium_background.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _animationController;

  bool _isLoading = false;
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animationController.forward();

    _emailController.addListener(_validateFormDynamically);
    _passwordController.addListener(_validateFormDynamically);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateFormDynamically() {
    final emailValid = _validateEmail(_emailController.text) == null;
    final passwordValid = _validatePassword(_passwordController.text) == null;
    
    setState(() {
      _isButtonDisabled = !(emailValid && passwordValid);
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        
        debugPrint('Login successful for ${_emailController.text}!');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            duration: Duration(seconds: 1),
            backgroundColor: primaryGreen,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PremiumBackground(),
          SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 414),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 24.0),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: darkGreen.withOpacity(0.1),
                        blurRadius: 32,
                        offset: const Offset(0, 16),
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.6),
                        blurRadius: 0,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    Hero(
                      tag: 'app_logo',
                      child: Image.asset(
                        'assets/images/logo.jpeg',
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    AnimatedEntrance(
                      animationController: _animationController,
                      delay: 0.1,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                        child: Text(
                          'Healthetic Lifestyle',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: darkGreen,
                          ),
                        ),
                      ),
                    ),
                    AnimatedEntrance(
                      animationController: _animationController,
                      delay: 0.2,
                      child: const Text(
                        'Welcome back!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: neutralGrey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    AnimatedEntrance(
                      animationController: _animationController,
                      delay: 0.3,
                      child: Form(
                        key: _formKey,
                        onChanged: () {
                          // The UI updates dynamically via TextEditingController listeners.
                        },
                        child: Column(
                          children: [
                            CustomTextField(
                              label: 'Email',
                              placeholder: 'Enter your email',
                              controller: _emailController,
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              label: 'Password',
                              placeholder: 'Enter your password',
                              controller: _passwordController,
                              isPassword: true,
                              validator: _validatePassword,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    AnimatedEntrance(
                      animationController: _animationController,
                      delay: 0.4,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: neutralGrey,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    AnimatedEntrance(
                      animationController: _animationController,
                      delay: 0.5,
                      child: BrandedButton(
                        label: 'Login',
                        onPressed: _handleLogin,
                        isLoading: _isLoading,
                        isDisabled: _isButtonDisabled,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    AnimatedEntrance(
                      animationController: _animationController,
                      delay: 0.6,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: neutralGrey, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                    color: primaryGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                ),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
