import 'package:flutter/material.dart';
import 'package:project_dom/service/auth_service.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({required this.refreshUser, super.key});
  final Function refreshUser;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool? usernameValid;
  bool? passwordValid;
  var authService = AuthService();
  var echoWord = 'please wait...';
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  void _submitForm() {
    if (usernameController.text.length > 4 &&
        passwordController.text.length > 7) {
      authService
          .login(usernameController.text, passwordController.text)
          .then((value) => setState(() {
                if (value == null) {
                  widget.refreshUser();
                  context
                      .findAncestorWidgetOfExactType<TabBarView>()!
                      .controller!
                      .index = 2;
                  return;
                }
                echoWord = value;
                if (value.isEmpty) {
                  usernameValid = false;
                  passwordValid = false;
                } else {
                  usernameValid = true;
                  passwordValid = true;
                }
              }));
    } else {
      setState(() {
        usernameValid = null;
        passwordValid = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    authService.echo("Server is running").then((value) => setState(() {
          echoWord = value;
        }));
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login, size: 50, color: Colors.green),
            SizedBox(height: 20),
            Text('Login Form', style: TextStyle(fontSize: 20)),
            Text(echoWord),
            SizedBox(height: 20),
            UserNameWidget(
              usernameController: usernameController,
              usernameValid: usernameValid,
            ),
            PasswordWidget(
              passwordController: passwordController,
              passwordValid: passwordValid,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      usernameController.text = "";
                      passwordController.text = "";
                    });
                  },
                  child: Text('Reset'),
                ),
                ElevatedButton(onPressed: _submitForm, child: Text('Log in')),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      usernameController.text = "demoUser";
                      passwordController.text = "12345678";
                    });
                  },
                  child: Text('Demo'),
                ),
              ],
            ),
            Text("new here ?"),
            ElevatedButton.icon(
              onPressed: () {
                context
                    .findAncestorWidgetOfExactType<TabBarView>()!
                    .controller!
                    .index = 0;
              },
              label: Text("Sign up"),
              icon: Icon(Icons.app_registration),
            )
          ],
        ),
      ),
    );
  }
}

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    required this.usernameController,
    this.usernameValid,
    super.key,
  });

  final TextEditingController usernameController;
  final bool? usernameValid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.person),
        title: TextField(
          decoration: InputDecoration(
            labelText: 'username',
            border: OutlineInputBorder(),
          ),
          controller: usernameController,
        ),
        trailing: usernameValid != null
            ? Icon(usernameValid! ? Icons.check : Icons.error,
                color: usernameValid! ? Colors.green : Colors.red)
            : null,
      ),
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    required this.passwordController,
    this.passwordValid,
    super.key,
  });

  final TextEditingController passwordController;
  final bool? passwordValid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.lock),
        title: TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            border: OutlineInputBorder(),
          ),
          controller: passwordController,
        ),
        trailing: passwordValid != null
            ? Icon(passwordValid! ? Icons.check : Icons.error,
                color: passwordValid! ? Colors.green : Colors.red)
            : null,
      ),
    );
  }
}
