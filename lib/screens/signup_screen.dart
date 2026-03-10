import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/branded_button.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/premium_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
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

    _nameController.addListener(_validateFormDynamically);
    _emailController.addListener(_validateFormDynamically);
    _passwordController.addListener(_validateFormDynamically);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateFormDynamically() {
    final nameValid = _validateName(_nameController.text) == null;
    final emailValid = _validateEmail(_emailController.text) == null;
    final passwordValid = _validatePassword(_passwordController.text) == null;

    setState(() {
      _isButtonDisabled = !(nameValid && emailValid && passwordValid);
    });
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
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

  Future<void> _handleSignup() async {
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

        debugPrint('Sign Up successful for ${_emailController.text}!');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign Up successful!'),
            duration: Duration(seconds: 1),
            backgroundColor: primaryGreen,
          ),
        );
        Navigator.pop(context); // Go back to login
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkGreen),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                          'Create Account',
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
                        'Join Healthetic Lifestyle today!',
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
                        onChanged: () {},
                        child: Column(
                          children: [
                            CustomTextField(
                              label: 'Full Name',
                              placeholder: 'Enter your name',
                              controller: _nameController,
                              validator: _validateName,
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              label: 'Email',
                              placeholder: 'Enter your email',
                              controller: _emailController,
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              label: 'Password',
                              placeholder: 'Create a password',
                              controller: _passwordController,
                              isPassword: true,
                              validator: _validatePassword,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    AnimatedEntrance(
                      animationController: _animationController,
                      delay: 0.4,
                      child: BrandedButton(
                        label: 'Sign Up',
                        onPressed: _handleSignup,
                        isLoading: _isLoading,
                        isDisabled: _isButtonDisabled,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AnimatedEntrance(
                      animationController: _animationController,
                      delay: 0.5,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                  color: neutralGrey, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'Login',
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
