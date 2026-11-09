import 'package:flutter/material.dart';

void main() {
  runApp(const LoginRegisterApp());
}

class LoginRegisterApp extends StatelessWidget {
  const LoginRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Activity 3',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.teal,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
          prefixIconColor: Colors.teal,
        ),
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLogin = true;
  bool _hidePassword = true;
  bool _isLoggedIn = false;
  String? _registeredName;
  String? _registeredEmail;
  String? _registeredPassword;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.teal.shade800,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  void _switchForm() {
    _formKey.currentState?.reset();
    _clearFields();
    setState(() {
      _isLogin = !_isLogin;
      _hidePassword = true;
    });
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text;
    if (_isLogin) {
      if (_registeredEmail == null) {
        _showMessage('Please register an account first.');
        return;
      }
      if (email != _registeredEmail || password != _registeredPassword) {
        _showMessage('Incorrect email or password.');
        return;
      }
      _clearFields();
      setState(() {
        _isLoggedIn = true;
      });
    } else {
      if (_registeredEmail != null) {
        _showMessage(
          'An account already exists. Please log in.',
        );
        return;
      }
      _registeredName = _nameController.text.trim();
      _registeredEmail = email;
      _registeredPassword = password;
      _formKey.currentState!.reset();
      _clearFields();
      setState(() {
        _isLogin = true;
        _hidePassword = true;
      });
      _showMessage('Registration successful! Please log in.');
    }
  }

  void _logout() {
    _clearFields();
    setState(() {
      _isLoggedIn = false;
      _isLogin = true;
      _hidePassword = true;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.teal,
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome, $_registeredName!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _registeredEmail ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _logout,
                  child: const Text('Logout'),
                ),
                const SizedBox(height: 32),
                Card(
                  elevation: 0,
                  color: Colors.teal.withValues(alpha: 0.08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.teal.withValues(alpha: 0.3)),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    child: Column(
                      children: [
                        Text(
                          'Student: Lourde Vincent Pablo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Section: BSIT 3-A',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLogin ? 'Login' : 'Register',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Requirement: Add an application name above the form
              const Text(
                'AuthPortal App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 16),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 80,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _isLogin ? 'Welcome Back!' : 'Create an Account',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Display the name field during registration
                    if (!_isLogin) ...[
                      TextFormField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your full name.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (email.isEmpty) {
                          return 'Please enter your email.';
                        }
                        final emailPattern =
                            RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                        if (!emailPattern.hasMatch(email)) {
                          return 'Please enter a valid email.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Requirement: Minimum password length of 8 characters
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _hidePassword,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          tooltip:
                              _hidePassword ? 'Show password' : 'Hide password',
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        if (value.length < 8) {
                          return 'Use at least 8 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Display confirmation during registration
                    if (!_isLogin) ...[
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _hidePassword,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password.';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        _isLogin ? 'Login' : 'Register',
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextButton(
                      onPressed: _switchForm,
                      child: Text(
                        _isLogin
                            ? 'No account yet? Register'
                            : 'Already have an account? Login',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Requirement: Add your name and section below the form
              Card(
                elevation: 0,
                color: Colors.teal.withValues(alpha: 0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.teal.withValues(alpha: 0.3)),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        'Student: Lourde Vincent Pablo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Section: BSIT 3-A',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
