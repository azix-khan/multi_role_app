import 'package:flutter/material.dart';
import 'package:multi_role_base_app/home_screen.dart';
import 'package:multi_role_base_app/student_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  String dropdownValue = 'Admin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Age',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,

              ),
              child: DropdownButton<String>(
                // Step 3.
                value: dropdownValue,
                // Step 4.
                items: <String>['Admin', 'Teacher', 'Student']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString('email', emailController.text.toString());
                sp.setString('age', ageController.text.toString());

                //admin, student, teacher
                sp.setString('userType', dropdownValue);
                sp.setBool('IsLogin', true);

                if (sp.getString('userType') == dropdownValue) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const StudentScreen()));
                } else if (sp.getString('userType') == dropdownValue) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const StudentScreen()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()));
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.green,
                child: const Center(
                  child: Text('Sign up'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
