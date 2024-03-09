import '../../utils/constants.dart';
import '../homepage/homepage.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/provider/user_info_provider.dart';
import 'letsgo.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up-1';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPhNoController = TextEditingController();
  final TextEditingController userRollNoController = TextEditingController();
  final TextEditingController userCollegeNameController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    userRollNoController.dispose();
    userCollegeNameController.dispose();
    userPhNoController.dispose();
    super.dispose();
  }

  bool isChecked = true;

  bool popStatus = true;

  @override
  void initState() {
    super.initState();
    popScreen(context);
  }

  Future <void> popScreen(BuildContext context) async{
    popStatus = await Navigator.maybePop(context);
    if (mounted) {
      setState(() {});
    }
  }

  void showAppCloseConfirmation (BuildContext context){
    final snackBar = SnackBar(
      content: Text("Do you want to exit? Confirm and click back"),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Yes',
        onPressed: (){
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          setState(() {
            popStatus=true;
          });

        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return PopScope(child:
    Scaffold(
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              // reverse: false,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                        style: TextStyle(
                            fontFamily: 'Libre Baskerville', fontSize: 22),
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
                              controller: userNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                filled: true,
                                fillColor: Constants.yellowColor,
                                hintText: "Full Name",
                                hintStyle: const TextStyle(color: Colors.black),
                              )),
                          Constants.gap,
                          TextFormField(
                              controller: userPhNoController,
                              // TODO: Fix phone number length, currently max
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Only Numbers!";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                filled: true,
                                fillColor: Constants.yellowColor,
                                hintText: 'Phone Number',
                                hintStyle: const TextStyle(color: Colors.black),
                              )),
                          Constants.gap,
                          if (isChecked)
                            Column(
                              children: [
                                TextFormField(
                                    controller: userRollNoController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          !RegExp(r"(2020|2021|2022|2023)(bcs|bec|bcy|bds)0\d{3}")
                                              .hasMatch(value.toLowerCase())) {
                                        return "You know the format";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                          const BorderSide(width: 50),
                                          borderRadius:
                                          BorderRadius.circular(16)),
                                      filled: true,
                                      fillColor: Constants.yellowColor,
                                      hintText: 'Roll Number',
                                      hintStyle:
                                      const TextStyle(color: Colors.black),
                                    )),
                                Constants.gap,
                              ],
                            ),
                          if (!isChecked)
                            Column(
                              children: [
                                TextFormField(
                                    controller: userCollegeNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Fill your college name!";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(16)),
                                      filled: true,
                                      fillColor: Constants.yellowColor,
                                      hintText: "College Name",
                                      hintStyle:
                                      const TextStyle(color: Colors.black),
                                    )),
                                Constants.gap,
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    userCollegeNameController.clear();
                                    userRollNoController.clear();
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              const Text(
                                  style: TextStyle(fontSize: 17),
                                  "From IIIT Kottayam"),
                            ],
                          ),
                          Constants.gap,
                          FilledButton(
                            onPressed: () {
                              // context.read<UserProvider>().changeUserName(newUserName: newUserName)
                              if (_formKey.currentState!.validate()) {
                                userProvider.fromCollege = isChecked;
                                if (isChecked) {
                                  userProvider.changeSameCollegeDetails(
                                      newUserName: userNameController.text,
                                      newUserRollNo: userRollNoController.text,
                                      newUserPhNo: userPhNoController.text);
                                } else {
                                  userProvider.changeOtherCollegeDetails(
                                      newUserName: userNameController.text,
                                      newUserCollegeName:
                                          userCollegeNameController.text,
                                      newUserPhNo: userPhNoController.text);
                                }
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(content: Text('Logging In')),
                                //   );
                                Navigator.of(context)
                                    .pushNamed(LetsGoPage.routeName);
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Constants.redColor),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.white)),
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
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
              ),
            );
          }
          ),
        ),
      ),
      // ),
      ),
      canPop: popStatus,
      onPopInvoked: (bool didPop) async{
        if (didPop) {
          return;
        }
        showAppCloseConfirmation(context);
      },
    );
  }
}
