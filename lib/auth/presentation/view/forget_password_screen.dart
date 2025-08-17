import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';

import '../../../constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _resetPassword() async {
    final code = _codeController.text.trim();
    final pass = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (code.isEmpty || pass.isEmpty || confirm.isEmpty) {
      _showSnackBar('Please fill all fields');
      return;
    }

    if (pass != confirm) {
      _showSnackBar('Passwords do not match');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await Dio().post(
        '${kBaseUrl}auth/reset-password/$code',
        data: {"password": pass, "passwordConfirm": pass},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnackBar('Password reset successfully');
        context.go('/');
      } else {
        _showSnackBar('Failed to reset password');
      }
    } on DioException catch (e) {
      String msg = 'Something went wrong';
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        msg = data['message'].toString();
      } else if (data is String) {
        msg = data;
      }
      _showSnackBar(msg);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: 'Verification Code'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _resetPassword,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }
}
