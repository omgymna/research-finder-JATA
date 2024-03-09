import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<FormState> _teacherFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _studentFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildTextInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    required String? Function(String?) validator,
    bool isObscure = false,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          prefixIcon: Icon(icon),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildForm(GlobalKey<FormState> formKey, Function() onSubmit) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _buildTextInputField(
              controller: _usernameController,
              icon: Icons.person,
              hintText: 'Enter your Username',
              validator: (value) => value!.isEmpty ? 'Username is required' : null,
            ),
            _buildTextInputField(
              controller: _emailController,
              icon: Icons.email,
              hintText: 'Enter your Email',
              validator: (value) => value!.isEmpty ? 'Email is required' : null,
            ),
            _buildTextInputField(
              controller: _passwordController,
              icon: Icons.lock,
              hintText: 'Enter your Password',
              isObscure: true,
              validator: (value) => value!.length < 8 ? 'Password must be at least 8 characters' : null,
            ),
            _buildTextInputField(
              controller: _confirmPasswordController,
              icon: Icons.lock_outline,
              hintText: 'Confirm your Password',
              isObscure: true,
              validator: (value) => value != _passwordController.text ? 'Passwords do not match' : null,
            ),
            ElevatedButton(
              onPressed: onSubmit,
              child: Text('SIGN UP'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Teacher'),
            Tab(text: 'Student'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildForm(_teacherFormKey, () {
            if (_teacherFormKey.currentState!.validate()) {
              // Perform teacher sign up
              print('Teacher form is valid');
            }
          }),
          _buildForm(_studentFormKey, () {
            if (_studentFormKey.currentState!.validate()) {
              // Perform student sign up
              print('Student form is valid');
            }
          }),
        ],
      ),
    );
  }
}
