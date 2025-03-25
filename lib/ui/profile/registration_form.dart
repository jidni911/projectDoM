import 'package:flutter/material.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 50, color: colorScheme.primary),
          Text('Registration Form'),
          // ElevatedButton.icon(
          //   icon: Icon(Icons.login, color: colorScheme.primary),
          //   label: Text('Log in', style: TextStyle(color: colorScheme.primary)),
          //   onPressed: () {},
          //   style: ButtonStyle(
          //     backgroundColor:
          //         WidgetStateProperty.all(colorScheme.primaryContainer),
          //   ),
          // ),
          // ElevatedButton.icon(
          //   icon: Icon(Icons.person, color: colorScheme.primary),
          //   label: Text('Registration',
          //       style: TextStyle(color: colorScheme.primary)),
          //   onPressed: () {},
          //   style: ButtonStyle(
          //     backgroundColor:
          //         WidgetStateProperty.all(colorScheme.primaryContainer),
          //   ),
          // ),
        ],
      ),
    );
  }
}



// User infos: name, email, password, confirm password, phone, address, role,
// image, date of birth, gender,

//Student infos: class, roll, section, registration number,

//Teacher infos: subject, experience, qualification, designation

