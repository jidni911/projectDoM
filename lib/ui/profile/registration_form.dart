import 'package:flutter/material.dart';
import 'package:project_dom/dto/signup_dto.dart';
// import 'package:project_dom/models/users.dart';
import 'package:project_dom/service/auth_service.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    super.key,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();

  static bool isEmailValid(String input) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(input);
  }
}

class _RegistrationFormState extends State<RegistrationForm> {
  var echoWord = 'please wait...';
  var isUserNameUnique = false;
  var isUserEmailUnique = false;
  var userInfo = UserSignupDto("", "", "", "", "");

  final authService = AuthService();
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    authService.echo("Server is running").then((value) => setState(() {
          echoWord = value;
        }));
    emailController.addListener(() {
      if (RegistrationForm.isEmailValid(emailController.text)) {
        authService
            .isEmailUnique(emailController.text)
            .then((value) => setState(() {
                  isUserEmailUnique = value;
                  userInfo.email = emailController.text;
                }));
      } else {
        setState(() {
          isUserEmailUnique = false;
          userInfo.email = emailController.text;
        });
      }
    });
    usernameController.addListener(() {
      if (usernameController.text.length > 4) {
        authService
            .isUsernameUnique(usernameController.text)
            .then((value) => setState(() {
                  isUserNameUnique = value;
                  userInfo.username = usernameController.text;
                }));
      } else {
        setState(() {
          isUserNameUnique = false;
          userInfo.username = usernameController.text;
        });
      }
    });
    fullNameController.addListener(() {
      setState(() {
        userInfo.fullName = fullNameController.text;
      });
    });
    passwordController.addListener(() {
      setState(() {
        userInfo.password = passwordController.text;
      });
    });
    confirmPasswordController.addListener(() {
      setState(() {
        userInfo.retypePassword = confirmPasswordController.text;
      });
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    authService.signup(userInfo).then((value) => setState(() {
          echoWord = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.app_registration, size: 50, color: colorScheme.primary),
            Text('Registration Form'),
            Text(echoWord),
            SizedBox(height: 20),
            FullNameWidget(
              controller: fullNameController,
            ),
            EmailWidget(
              emailController: emailController,
              isUserEmailUnique: isUserEmailUnique,
            ),
            UserNameWidget(
              usernameController: usernameController,
              isUsernameUnique: isUserNameUnique,
            ),
            PasswordWidget(
              passwordController: passwordController,
            ),
            ConfirmPasswordWidget(
              password: passwordController.text,
              confirmPasswordController: confirmPasswordController,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      userInfo = UserSignupDto("", "", "", "", "");
                      isUserNameUnique = false;
                      isUserEmailUnique = false;

                      fullNameController.text = "";
                      emailController.text = "";
                      usernameController.text = "";
                      passwordController.text = "";
                      confirmPasswordController.text = "";
                    });
                  },
                  child: Text('Reset'),
                ),
                ElevatedButton(onPressed: _submitForm, child: Text('Register')),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // userInfo = UserSignupDto(
                      //   "demoUser",
                      //   "12345678",
                      //   "demo@mail.com",
                      //   "Demo User",
                      //   "12345678",
                      // );
                      userInfo.fullName = "Demo User";
                      userInfo.username = "demoUser";
                      userInfo.email = "demo@mail.com";
                      userInfo.password = "12345678";
                      userInfo.retypePassword = "12345678";

                      fullNameController.text = "Demo User";
                      emailController.text = "demo@mail.com";
                      usernameController.text = "demoUser";
                      passwordController.text = "12345678";
                      confirmPasswordController.text = "12345678";

                      // isUserNameUnique = false;
                      // isUserEmailUnique = false;
                    });
                  },
                  child: Text('Demo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FullNameWidget extends StatelessWidget {
  FullNameWidget({required this.controller, super.key});

  // final Function(String) onNameChange;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    String fullName = controller.text;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.person),
        title: TextField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
          controller: controller,
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                fullName.length > 5
                    ? 'Full Name is valid'
                    : 'Full Name is not valid',
                style: TextStyle(
                  color: fullName.length > 5 ? Colors.green : Colors.red,
                ),
              ),
            ),
            PopupMenuItem(
              child: Text(
                'Full Name should be at least 6 characters',
                style: TextStyle(
                  color: fullName.length > 5 ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
          icon: Icon(
            fullName.length > 5 ? Icons.check : Icons.error,
            color: fullName.length > 5 ? Colors.green : Colors.red,
            size: 30,
          ),
          offset: Offset(0, 50),
          elevation: 2,
          tooltip: fullName.length < 6
              ? 'Full Name should be at least 6 characters'
              : 'good',
        ),
      ),
    );
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    required this.emailController,
    required this.isUserEmailUnique,
    super.key,
  });
  final TextEditingController emailController;
  final bool isUserEmailUnique;

  @override
  Widget build(BuildContext context) {
    String email = emailController.text;
    var isEmailValid = RegistrationForm.isEmailValid(email);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.email),
        title: TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          controller: emailController,
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                isEmailValid ? 'Email is valid' : 'Email is not valid',
                style: TextStyle(
                  color: isEmailValid ? Colors.green : Colors.red,
                ),
              ),
            ),
            PopupMenuItem(
              child: Text(
                isUserEmailUnique ? 'Email is unique' : 'Email is not unique',
                style: TextStyle(
                  color: isEmailValid ? Colors.green : Colors.red,
                ),
              ),
            ),
            PopupMenuItem(
              child: Text(
                'Email should be valid and unique',
                style: TextStyle(
                  color: isEmailValid ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
          icon: Icon(
            isEmailValid && isUserEmailUnique ? Icons.check : Icons.error,
            color:
                isEmailValid && isUserEmailUnique ? Colors.green : Colors.red,
            size: 30,
          ),
          offset: Offset(0, 50),
          elevation: 2,
          tooltip: !isEmailValid && !isUserEmailUnique
              ? 'Email should be valid and unique'
              : 'good',
        ),
      ),
    );
  }
}

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    required this.isUsernameUnique,
    required this.usernameController,
    super.key,
  });
  final bool isUsernameUnique;
  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    String username = usernameController.text;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.face),
        title: TextField(
          decoration: InputDecoration(
            labelText: 'username',
            border: OutlineInputBorder(),
          ),
          controller: usernameController,
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                username.length > 4
                    ? 'Username is valid'
                    : 'Username is not valid',
                style: TextStyle(
                  color: username.length > 4 ? Colors.green : Colors.red,
                ),
              ),
            ),
            PopupMenuItem(
              child: Text(
                isUsernameUnique
                    ? 'Username is unique'
                    : 'Username is not unique',
                style: TextStyle(
                  color: isUsernameUnique ? Colors.green : Colors.red,
                ),
              ),
            ),
            PopupMenuItem(
              child: Text(
                'Username should be at least 5 characters and unique',
                style: TextStyle(
                  color: username.length > 4 && isUsernameUnique
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ],
          icon: Icon(
            username.length > 4 && isUsernameUnique ? Icons.check : Icons.error,
            color: username.length > 4 && isUsernameUnique
                ? Colors.green
                : Colors.red,
            size: 30,
          ),
          offset: Offset(0, 50),
          elevation: 2,
          tooltip: username.length < 5 && !isUsernameUnique
              ? 'Username should be at least 5 characters'
              : 'good',
        ),
      ),
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    required this.passwordController,
    super.key,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    String password = passwordController.text;
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
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                password.length > 7
                    ? 'Password is valid'
                    : 'Password is not valid',
                style: TextStyle(
                  color: password.length > 7 ? Colors.green : Colors.red,
                ),
              ),
            ),
            PopupMenuItem(
              child: Text(
                'Password should be at least 8 characters',
                style: TextStyle(
                  color: password.length > 7 ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
          icon: Icon(
            password.length > 7 ? Icons.check : Icons.error,
            color: password.length > 7 ? Colors.green : Colors.red,
            size: 30,
          ),
          offset: Offset(0, 50),
          elevation: 2,
          tooltip: password.length < 8
              ? 'Password should be at least 6 characters'
              : 'good',
        ),
      ),
    );
  }
}

class ConfirmPasswordWidget extends StatelessWidget {
  const ConfirmPasswordWidget({
    required this.password,
    required this.confirmPasswordController,
    super.key,
  });

  final String password;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    String confirmPassword = confirmPasswordController.text;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.lock),
        title: TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'retype password',
            border: OutlineInputBorder(),
          ),
          controller: confirmPasswordController,
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                password == confirmPassword
                    ? 'Confirm Password is valid'
                    : 'Confirm Password is not valid',
                style: TextStyle(
                  color:
                      password == confirmPassword ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
          icon: Icon(
            password == confirmPassword ? Icons.check : Icons.error,
            color: password == confirmPassword ? Colors.green : Colors.red,
            size: 30,
          ),
          offset: Offset(0, 50),
          elevation: 2,
          tooltip:
              password != confirmPassword ? 'Passwords should match' : 'good',
        ),
      ),
    );
  }
}

// User infos: name, email, password, confirm password, phone, address, role,
// image, date of birth, gender,

//Student infos: class, roll, section, registration number,

//Teacher infos: subject, experience, qualification, designation
