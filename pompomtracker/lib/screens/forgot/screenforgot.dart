import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/forget/frgtreq/frgtreq.dart';

class ScreenForgotPswrd extends StatefulWidget {
  const ScreenForgotPswrd({super.key});

  @override
  State<ScreenForgotPswrd> createState() => _ScreenForgotPswrdState();
}

class _ScreenForgotPswrdState extends State<ScreenForgotPswrd> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _usernamecontroller = TextEditingController();
  final _newpswrdcontroller = TextEditingController();
  final _cnfrmpswrdcontroller = TextEditingController();
  bool passtoggle = true;
  String? selectedBusType;
  List<String> busTypeList = [];
  String? penNo;
  String? newpswrd;
  String? cnfrmpswrd;
  int? refid;

  @override
  void initState() {
    super.initState();
    // fetchBusList();
    Future.delayed(Duration.zero, () {
      context.read<ElevatedBtnProvider>().changeSelectedVal(false);
    });
    //context.read<ElevatedBtnProvider>().changeSelectedVal(false);
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.push(context, Approutes().loginscreen);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          if (didPop) return;
          await popscreen(context);
        }
        log('BackButton pressed!');
      },
      child: Scaffold(
        key: _scafoldkey,
        //backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  _scafoldkey.currentContext!, Approutes().loginscreen);
            },
          ),
        ),
        body: Center(
          child: ListView(children: [
            Card(
                margin: const EdgeInsets.all(10),
                elevation: 3,
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary
                          ]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Theme(
                          data: MyTheme.googleFormTheme,
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Text(
                                  'Forgot Password',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    controller: _usernamecontroller,
                                    keyboardType: TextInputType.phone,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile No',
                                      labelStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      hintText:
                                          'Enter Registered Mobile Number',
                                      hintStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter mobile Number";
                                      } else if (_usernamecontroller
                                                  .text.length <
                                              10 ||
                                          _usernamecontroller.text.length >
                                              10) {
                                        return "Enter valid Mobile number";
                                      } else if (value.contains(' ')) {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Remove Space from  Mobile number",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          fontSize: 15.0,
                                        );
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                      controller: _newpswrdcontroller,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        labelText: 'New Password',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        prefixIcon: Theme(
                                          data: MyTheme.appIconTheme,
                                          child: const Icon(
                                            Icons.lock,
                                          ),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              passtoggle = !passtoggle;
                                            });
                                          },
                                          child: Theme(
                                            data: MyTheme.appIconTheme,
                                            child: Icon(
                                              passtoggle
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                          ),
                                        ),
                                      ),
                                      obscureText: passtoggle,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a password';
                                        } else if (value.length < 8) {
                                          return 'Password must be at least 8 characters';
                                        } else if (!RegExp(r'[A-Z]')
                                            .hasMatch(value)) {
                                          return 'Password must contain at least one uppercase letter';
                                        } else if (!RegExp(
                                                r'[!@#$%^&*(),.?":{}|<>]')
                                            .hasMatch(value)) {
                                          return 'Password must contain at least one special character';
                                        }
                                        return null;
                                      }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                      controller: _cnfrmpswrdcontroller,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        prefixIcon: Theme(
                                          data: MyTheme.appIconTheme,
                                          child: const Icon(
                                            Icons.lock,
                                          ),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              passtoggle = !passtoggle;
                                            });
                                          },
                                          child: Theme(
                                            data: MyTheme.appIconTheme,
                                            child: Icon(
                                              passtoggle
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                          ),
                                        ),
                                      ),
                                      obscureText: passtoggle,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please confirm your password';
                                        } else if (value !=
                                            _newpswrdcontroller.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.black54,
                                            Colors.black87
                                          ])),
                                  child: Theme(
                                    data: MyTheme.buttonStyleTheme,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          context
                                              .read<ElevatedBtnProvider>()
                                              .changeSelectedVal(true);
                                          setState(() {
                                            penNo = _usernamecontroller.text;
                                            newpswrd = _newpswrdcontroller.text;
                                            cnfrmpswrd =
                                                _cnfrmpswrdcontroller.text;
                                          });
                                          final req = Frgtreq(
                                              mobileNo: penNo, pwd: cnfrmpswrd);
                                          resetPswrdFun(req, context);
                                        }
                                      },
                                      child: Text('RESET',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Consumer<LoadingProvider>(
                                    builder: (context, loadingProvider, child) {
                                  return loadingProvider.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Color.fromARGB(255, 2, 128, 6),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                }),
                              ],
                            ),
                          )),
                    ))),
          ]),
        ),
      ),
    );
  }

  resetPswrdFun(Frgtreq val, BuildContext context) async {
    try {
      dio.Response<dynamic>? chngresp;
      chngresp = await Busdata().frgtPswrd(val);

      final resultAsjson = jsonDecode(chngresp.toString());
      final changeval =
          ConductorResp.fromJson(resultAsjson as Map<String, dynamic>);
      if (chngresp == null) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (chngresp.statusCode == 200 && changeval.status == 'success') {
        Fluttertoast.showToast(
            msg: "Password Changed Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 15.0);
        Navigator.push(_scafoldkey.currentContext!, Approutes().loginscreen);
      } else if (changeval.status == 'failure') {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, changeval.message);
      } else if (chngresp.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (chngresp.statusCode == 408) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }
}
