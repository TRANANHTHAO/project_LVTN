import 'package:appcoffeeshop/ui/auth/switch_admin_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/http_exception.dart';
import '../shared/dialog_utils.dart';

import 'auth_manager.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  bool isEnableModeAdmin = false;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await context.read<AuthManager>().login(
              _authData['email']!,
              _authData['password']!,
              isEnableModeAdmin,
            );

        String url = "http://127.0.0.1:3306/qlcoffee/customers";
        // var response =
      } else {
        // Sign user up
        await context.read<AuthManager>().signup(
            _authData['email']!, _authData['password']!, isEnableModeAdmin);
      }
    } catch (error) {
      showErrorDialog(
        context,
        (error is HttpException) ? error.toString() : 'Xác Thực Thất Bại!',
      );
    }

    _isSubmitting.value = false;
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 15.0,
      color: const Color.fromARGB(255, 84, 75, 66).withOpacity(0.5),
      child: Container(
        // height: _authMode == AuthMode.signup ? 420 : 340,
        // constraints:
        //     BoxConstraints(minHeight: _authMode == AuthMode.signup ? 420 : 340),
        width: deviceSize.width * 0.85,
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildEmailField(),
                const SizedBox(
                  height: 20,
                ),
                _buildPasswordField(),
                if (_authMode == AuthMode.signup) _buildPasswordConfirmField(),
                const SizedBox(
                  height: 30,
                ),
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: SwitchAdminMode(
                //     onChanged: (bool value) {
                //       isEnableModeAdmin = value;
                //     },
                //   ),
                // ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isSubmitting,
                  builder: (context, isSubmitting, child) {
                    if (isSubmitting) {
                      return const CircularProgressIndicator();
                    }
                    return _buildSubmitButton();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildAuthModeSwitchButton(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthModeSwitchButton() {
    return TextButton(
      onPressed: _switchAuthMode,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 12.0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: const Color.fromARGB(255, 0, 15, 27),
        textStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Text(
        '${_authMode == AuthMode.login ? 'ĐĂNG KÝ' : 'ĐĂNG NHẬP'} TÀI KHOẢN',
        style: const TextStyle(
          color: Color.fromARGB(255, 246, 139, 82),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 86, 156),
        padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 12.0),
        textStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 12, 21),
        ),
      ),
      child: Text(
        _authMode == AuthMode.login ? 'ĐĂNG NHẬP' : 'ĐĂNG KÝ',
      ),
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      cursorColor: const Color.fromARGB(255, 240, 241, 241),
      enabled: _authMode == AuthMode.signup,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.password,
          color: Colors.deepOrangeAccent,
        ),
        labelText: 'Xác nhận mật khẩu',
        labelStyle: TextStyle(
          color: Colors.deepOrangeAccent,
        ),
      ),
      obscureText: true,
      validator: _authMode == AuthMode.signup
          ? (value) {
              if (value != _passwordController.text) {
                return 'Xác nhận mật khẩu không chính xác!';
              }
              return null;
            }
          : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      cursorColor: const Color.fromARGB(255, 240, 241, 241),
      decoration: const InputDecoration(
        labelText: 'Mật Khẩu',
        labelStyle: TextStyle(
          color: Colors.deepOrangeAccent,
        ),
        icon: Icon(
          Icons.key,
          color: Colors.deepOrangeAccent,
        ),
      ),
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length < 5) {
          return 'Mật khẩu không hợp lệ !';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      cursorColor: const Color.fromARGB(255, 240, 241, 241),
      decoration: const InputDecoration(
        labelText: 'E-Mail',
        labelStyle: TextStyle(
          color: Colors.deepOrangeAccent,
        ),
        icon: Icon(
          Icons.email,
          color: Colors.deepOrangeAccent,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Email không hợp lệ!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
    );
  }
}
