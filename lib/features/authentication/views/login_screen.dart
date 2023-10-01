import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:show_flutter/constants/gaps.dart';
import 'package:show_flutter/constants/sizes.dart';
import 'package:show_flutter/features/authentication/view_models/login_view_model.dart';
import 'package:show_flutter/features/authentication/views/widgets/form_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void onSignUpTap(BuildContext context) {
    context.go("/home");
  }

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(loginProvider.notifier).login(
              formData["email"]!,
              formData["password"]!,
              context,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v80,
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: Sizes.size36,
                  ),
                ),
                Gaps.v40,
                TextFormField(
                  obscureText: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your email";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['email'] = newValue;
                    }
                  },
                ),
                Gaps.v16,
                TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your password";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['password'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(
                      disabled: false, //ref.watch(loginProvider).isLoading,
                      text: "Enter"),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.size32,
          bottom: Sizes.size64,
          left: Sizes.size40,
          right: Sizes.size40,
        ),
        child: GestureDetector(
          onTap: () => onSignUpTap(context),
          child: const FormButton(
            disabled: false,
            text: "Create an account",
          ),
        ),
      ),
    );
  }
}
