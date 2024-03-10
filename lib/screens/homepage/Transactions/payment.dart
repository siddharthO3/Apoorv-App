import '../../../providers/receiver_provider.dart';
import '../../../providers/user_info_provider.dart';
import 'payment_success.dart';
import '../../../widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class Payment extends StatefulWidget {
  static const routeName = '/payment';
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Future<void> dialogBuilder(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            message,
            style: const TextStyle(
              color: Constants.blackColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Constants.yellowColor,
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  backgroundColor: Constants.blackColor),
              child: const Text(
                'Try Again',
                style: TextStyle(color: Constants.whiteColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final TextEditingController amountController = TextEditingController();

  var _myFuture;

  @override
  void initState() {
    super.initState();
    var to_uid = "123457";
    Provider.of<ReceiverProvider>(context, listen: false).setUID(to_uid);
    _myFuture = Provider.of<ReceiverProvider>(context, listen: false)
        .setReceiverData(context);
  }

  @override
  Widget build(BuildContext context) {
    // var to_uid = ModalRoute.of(context)!.settings.arguments as String?;

    var to_uid = "123457";
    // var to_user = {
    //   "uid": "123457",
    //   "name": "AbraCAdabra",
    //   "email": "user@example.com",
    // };

    return FutureBuilder(
      future: _myFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text(snapshot.error.toString())),
              );
            } else if (snapshot.hasData) {
              print(snapshot.data);
              if (snapshot.data['success']) {
                return Scaffold(
                  appBar: AppBar(
                      // title: const IconButton(onPressed: null, icon: Icon(Icons.arrow_back)),
                      ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.circle,
                          size: MediaQuery.of(context).size.width * 0.33,
                          color: Constants.yellowColor,
                        ),
                        Column(
                          children: [
                            Text(
                              "Paying ${context.read<ReceiverProvider>().userName}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              context.read<ReceiverProvider>().userEmail,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 178,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 120,
                                child: TextField(
                                  controller: amountController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(4),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: '0'),
                                  style: const TextStyle(fontSize: 50),
                                ),
                              ),
                              const Text(
                                "pts",
                                style: TextStyle(fontSize: 35),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Add Note'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: FilledButton(
                            onPressed: () async {
                              if (int.parse(amountController.text) > 0) {
                                var response = await Provider.of<UserProvider>(
                                  context,
                                  listen: false,
                                ).doATransaction(
                                  to_uid,
                                  int.parse(amountController.text),
                                );

                                if (context.mounted) {
                                  if (response['success']) {
                                    Navigator.of(context).pushReplacementNamed(
                                        PaymentSuccess.routeName);
                                  } else {
                                    dialogBuilder(context, response['message']);
                                    showSnackbarOnScreen(
                                        context, response['message']);
                                  }
                                }
                              } else {
                                showSnackbarOnScreen(context,
                                    "Amount must be greater than zero");
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Constants.redColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Constants.whiteColor)),
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
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                Future.delayed(
                  Duration.zero,
                  () => showSnackbarOnScreen(
                      context, snapshot.data['message'] + 'in else'),
                );
                return Center(child: Text(snapshot.data['message']));
              }
            } else {
              return const Scaffold(body: Text('No data'));
            }
        }
      },
    );
  }
}
