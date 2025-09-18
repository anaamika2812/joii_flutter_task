import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController(text: 'test@joiicare.com');
  final _passwordController = TextEditingController(text: 'Test@123');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              prefixIcon: const Icon(Icons.email_outlined),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your email' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              prefixIcon: const Icon(Icons.lock_outline),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your password' : null,
          ),
          const SizedBox(height: 24),
           Expanded(
              child: ElevatedButton(
                onPressed: _login,
                child: const Text('Sign In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),

        ],
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginEvent(email: _emailController.text, password: _passwordController.text),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}