// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final idController = TextEditingController();
  final phoneController = TextEditingController();
  String? roleController;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    idController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      controller: nameController,
      autofocus: false,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Full Name',
        // labelText: 'Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        if (value.length < 6) {
          return 'Name must be at least 6 characters';
        }
        return null;
      },
      onSaved: (newValue) => nameController.text = newValue!,
      textInputAction: TextInputAction.next,
    );

    final emailField = TextFormField(
      controller: emailController,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Email',
        // labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onSaved: (newValue) => emailController.text = newValue!,
      textInputAction: TextInputAction.next,
    );
    bool hidePass = true;
    final passwordField = TextFormField(
      controller: passwordController,
      autofocus: false,
      obscureText: hidePass,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        suffixIcon: GestureDetector(
          onTap: (() => setState(() => hidePass = !hidePass)),
          child: const Icon(Icons.remove_red_eye),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Enter password',
        // labelText: 'Password',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password must be at least 6 characters';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      onSaved: (newValue) => passwordController.text = newValue!,
      textInputAction: TextInputAction.next,
    );

    final confirmPasswordField = TextFormField(
      controller: confirmPasswordController,
      autofocus: false,
      obscureText: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Confirm password',
        // labelText: 'Confirm Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value != passwordController.text) {
          return 'Password does not match';
        }
        return null;
      },
      onSaved: (newValue) => confirmPasswordController.text = newValue!,
      textInputAction: TextInputAction.next,
    );

    final idField = TextFormField(
      controller: idController,
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.numbers_rounded),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'ID',
        // labelText: 'ID',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your ID';
        }
        if (!RegExp(r'^[1-9][0-9]{9}$').hasMatch(value)) {
          return 'Please enter a valid ID';
        }
        return null;
      },
      onSaved: (newValue) => idController.text = newValue!,
      textInputAction: TextInputAction.next,
    );

    final phoneField = TextFormField(
      controller: phoneController,
      autofocus: false,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.phone),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Phone',
        // labelText: 'Phone',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        if (!RegExp(r"^([+]88)?01[0-9]{9}$").hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
      onSaved: (newValue) => phoneController.text = newValue!,
      textInputAction: TextInputAction.next,
    );

    final roleField = DropdownButtonFormField(
      dropdownColor: Colors.blueGrey[300],
      focusColor: Colors.blueGrey[800],
      autofocus: false,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Role',
        // labelText: 'Role',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: 'student',
          child: Text('Student'),
        ),
        DropdownMenuItem(
          value: 'teacher',
          child: Text('Teacher'),
        ),
        DropdownMenuItem(
          value: 'staff',
          child: Text('Staff'),
        ),
      ],
      onChanged: (value) {
        roleController = value!.toString();
      },
      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return 'Please enter your role';
        }
        return null;
      },
      onSaved: (newValue) => roleController = newValue!.toString(),
    );

    final signupButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color.fromARGB(255, 4, 94, 116),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            if (passwordController.text == confirmPasswordController.text) {
              signUp();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password does not match'),
                ),
              );
            }
          }
        },
        child: const Text(
          'Register',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 6, 194, 153),
      //   title: const Text('Bitfest-22',
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 25,
      //       )),
      // ),
      body: Center(
        child: SingleChildScrollView(
          // padding: const EdgeInsets.all(20),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 15),
                    const Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Color.fromARGB(255, 3, 134, 106),
                    ),
                    const SizedBox(height: 15),
                    nameField,
                    const SizedBox(height: 15),
                    emailField,
                    const SizedBox(height: 15),
                    passwordField,
                    const SizedBox(height: 15),
                    confirmPasswordField,
                    const SizedBox(height: 15),
                    idField,
                    const SizedBox(height: 15),
                    phoneField,
                    const SizedBox(height: 15),
                    roleField,
                    const SizedBox(height: 15),
                    signupButton,
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    // show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await auth
        .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
        .then((value) => {
              print(value.user!.uid),
              saveToFirestore(),
            })
        .catchError((error) {
      Fluttertoast.showToast(
        msg: error.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  saveToFirestore() async {
    final ref = FirebaseDatabase.instance;
    // ref.enableNetwork();
    final doc = ref.refFromURL(DefaultFirebaseOptions.databaseURL)
        .child('users')
        .child(auth.currentUser!.uid);

    final User? user = auth.currentUser;

    final userModel = UserModel(
      uid: user!.uid,
      name: nameController.text,
      email: emailController.text,
      id: idController.text,
      phone: phoneController.text,
      role: roleController,
      verified: false,
    );

    await doc.set({
      'uid': userModel.uid,
      'name': userModel.name,
      'email': userModel.email,
      'id': userModel.id,
      'phone': userModel.phone,
      'role': userModel.role,
      'verified': userModel.verified,
    }).then((value) => {
          Navigator.of(context).pop(),
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      user: userModel,
                    )),
            (route) => false,
          ),
        });

    Fluttertoast.showToast(
      msg: 'Sign Up Successful',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
