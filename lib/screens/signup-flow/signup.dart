import 'package:apoorv_app/constants.dart';
import 'package:apoorv_app/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up-1';
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    return Scaffold(
      // appBar: AppBar(
      //     centerTitle: true,
      //     title: RichText(
      //       text: const TextSpan(
      //         children: [
      //           TextSpan(text: 'Stage '),
      //           TextSpan(
      //               text: ' 1', style: TextStyle(color: Constants.redColor)),
      //           TextSpan(text: ' of 3'),
      //         ],
      //         style: TextStyle(fontSize: 24),
      //       ),
      //     )),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Give us a Quick Introduction\n',
                        style: TextStyle(color: Constants.yellowColor)),
                    TextSpan(
                        text: 'About ',
                        style: TextStyle(color: Constants.yellowColor)),
                    TextSpan(
                        text: 'Yourself',
                        style: TextStyle(color: Constants.redColor)),
                  ],
                  style:
                      TextStyle(fontFamily: 'Libre Baskerville', fontSize: 22),
                ),
                textAlign: TextAlign.center,
              ),
              Icon(
                Icons.account_circle_outlined,
                color: Constants.yellowColor,
                size: MediaQuery.of(context).size.width * 0.4,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Only Letters!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          filled: true,
                          fillColor: Constants.yellowColor,
                          hintText: 'Full Name',
                          hintStyle: const TextStyle(color: Colors.black),
                        )),
                    Constants.gap,
                    if (isChecked)
                      Column(
                        children: [
                          TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !RegExp(r"(2020|2021|2022|2023)(bcs|bec|bcy|bds|BCS|BEC|BCY|BDS)0\d{3}")
                                        .hasMatch(value!)) {
                                  return "You know the format";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 50),
                                    borderRadius: BorderRadius.circular(16)),
                                filled: true,
                                fillColor: Constants.yellowColor,
                                hintText: 'Roll Number',
                                hintStyle: TextStyle(color: Colors.black),
                              )),
                          Constants.gap,
                        ],
                      ),
                    // TextFormField(
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(16)),
                    //         filled: true,
                    //         fillColor: Constants.yellowColor,
                    //         hintText: 'Email',
                    //         hintStyle: TextStyle(color: Colors.black))),
                    // Constants.gap,
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Only Numbers!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          filled: true,
                          fillColor: Constants.yellowColor,
                          hintText: 'Phone Number',
                          hintStyle: const TextStyle(color: Colors.black),
                        )),
                    Constants.gap,
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Fill your college name!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          filled: true,
                          fillColor: Constants.yellowColor,
                          hintText: 'College Name',
                          hintStyle: const TextStyle(color: Colors.black),
                        )),
                    Constants.gap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                        ),
                        Text(
                            style: TextStyle(fontSize: 17),
                            "From IIIT Kottayam"),
                      ],
                    ),
                    Constants.gap,
                    FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logging In')),
                          );
                          Navigator.of(context).pushNamed(HomePage.routeName);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Constants.redColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          child: const Text(
                            'Continue',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
