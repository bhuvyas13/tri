import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart'; // Import the home page after successful login

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String welcomeText = "WELCOME!";
  List<String> translations = [
    "WELCOME!", "स्वागत है!", "സ്വാഗതം!", "ಸ್ವಾಗತ", 
    "வரவேற்கிறோம்!", "स्वागत आहे!", "ਸੁਆਗਤ ਹੈ!", "স্বাগতম!"
  ];
  int currentTranslationIndex = 0;
  bool showErrorMessages = false;
  bool isLogin = true; // Flag to toggle between login and signup
  bool keepMeLoggedIn = false; // State for "Keep Me Logged In" checkbox

  @override
  void initState() {
    super.initState();
    startWelcomeTextTransition();
  }

  void startWelcomeTextTransition() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        currentTranslationIndex = (currentTranslationIndex + 1) % translations.length;
        welcomeText = translations[currentTranslationIndex];
      });
      startWelcomeTextTransition();
    });
  }

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() {
        showErrorMessages = true;
      });
      return;
    }

    if (password.isEmpty || password.length < 6) {
      setState(() {
        showErrorMessages = true;
      });
      return;
    }

    try {
      // Set persistence based on the "Keep Me Logged In" checkbox
      if (keepMeLoggedIn) {
        await FirebaseAuth.instance.setPersistence(Persistence.LOCAL); // Session persists across browser restarts
      } else {
        await FirebaseAuth.instance.setPersistence(Persistence.SESSION); // Session ends when browser closes
      }

      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        showErrorDialog("Please verify your email.");
      } else {
        // Redirect to home page and clear navigation stack to prevent going back to login page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
      }
    } catch (e) {
      showErrorDialog(e.toString());
    }
  }

  Future<void> signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || password != confirmPassword) {
      setState(() {
        showErrorMessages = true;
      });
      return;
    }

    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      // Redirect to home page and clear navigation stack to prevent going back to login page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      showErrorDialog(e.toString());
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Image and welcome text
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    Image.asset('assets/triangle_image.png', height: 150),
                    Text(welcomeText, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Full Name (Visible only in Signup mode)
              if (!isLogin)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Full Name *'),
                    TextField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your full name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              // Phone (Visible only in Signup mode)
              if (!isLogin)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Phone Number *'),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              // Email Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email *'),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'for example: ab@xyz.christuniversity.in',
                      border: const OutlineInputBorder(),
                      errorText: showErrorMessages && emailController.text.isEmpty
                          ? 'Enter a valid email'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Password *'),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'must contain at least 6 characters',
                      border: const OutlineInputBorder(),
                      errorText: showErrorMessages && passwordController.text.length < 6
                          ? 'Password too short'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Confirm Password (Visible only in Signup mode)
              if (!isLogin)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Confirm Password *'),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        errorText: showErrorMessages &&
                                confirmPasswordController.text != passwordController.text
                            ? 'Passwords do not match'
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              // "Keep Me Logged In" Checkbox
              CheckboxListTile(
                title: const Text("Keep Me Logged In"),
                value: keepMeLoggedIn,
                onChanged: (bool? value) {
                  setState(() {
                    keepMeLoggedIn = value ?? false;
                  });
                },
              ),
              
              // Log In or Sign Up Button
              ElevatedButton(
                onPressed: isLogin ? login : signUp,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(isLogin ? 'Log In' : 'Sign Up'),
              ),
              const SizedBox(height: 16),

              // Toggle between Log In and Sign Up
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin; // Toggle login and signup
                  });
                },
                child: Text(isLogin ? 'Don\'t have an account? Sign Up' : 'Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
