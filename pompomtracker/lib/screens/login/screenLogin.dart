import 'package:pompomtracker/core/hook/hook.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  // final SharedPrefManager sharedprefmanager = SharedPrefManager();

  final _usercontroller = TextEditingController();

  final _passcontroller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  bool passtoggle = true;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(50),
            elevation: 3,
            shadowColor: Theme.of(context).colorScheme.primary,
            child: SizedBox(
              width: 300,
              height: 450,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary
                        ])),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Theme(
                        data: MyTheme.googleFormTheme,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              //backgroundColor: Colors.red,
                              backgroundImage:
                                  AssetImage('assets/login/login_bus.png'),
                              radius: 50,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 5),
                                child: TextFormField(
                                    controller: _usercontroller,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter valid Username";
                                      } else if (value.contains('.') ||
                                          value.contains("-") ||
                                          value.contains(" ") ||
                                          value.contains(",")) {
                                        return "Enter valid Username";
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: TextFormField(
                                    controller: _passcontroller,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
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
                                      if (value!.isEmpty) {
                                        return 'Enter password';
                                      }
                                      // else if (_passcontroller.text.length <
                                      //     8) {
                                      //   return 'Please enter atleast 8 characters';
                                      // }
                                      else if (value.contains(' ')) {
                                      }
                                      // else if (_passcontroller.text.length < 8) {
                                      //   return 'Please enter atleast 8 characters';
                                      // }
                                      else if (value.contains(' ')) {
                                        return 'Remove space from password';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 35,
                              width: 200,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.black54, Colors.black87],
                                ),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Theme(
                                data: MyTheme.buttonStyleTheme,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      await getlogin();
                                    }
                                  },
                                  child: Text(
                                    'LOGIN',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot password?',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            const SizedBox(height: 10),
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }

  Future getlogin() async {
    final loadingProvider =
        _scaffoldKey.currentContext!.read<LoadingProvider>();
    //False to true
    loadingProvider.toggleLoading();
    final username = _usercontroller.text;
    final password = _passcontroller.text;

    final logreq = Loginreq.req(userName: username, pwd: password);

    final loginResponse = await Busdata().login(logreq);
    final resultAsjson = jsonDecode(loginResponse.toString());
    final loginval = Loginresp.fromJson(resultAsjson as Map<String, dynamic>);
    //factory Loginresp.fromJson(Map<String, dynamic> json)
    //final status = loginval.status;

    //True To False
    loadingProvider.toggleLoading();
    if (loginResponse == null) {
      showLoginerror(_scaffoldKey.currentContext!, 1);
    } else if (loginResponse.statusCode == 200 &&
        loginval.status == 'success') {
      //print('success');
      addLoginShareddata(loginval.status, loginval.userId, loginval.userType,
          loginval.userName, loginval.ownerName);
      /*wklycollection function */

      /**************************/

      Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Screenhome(),
        ),
      );

      //showLoginerror(_scaffoldKey.currentContext!);
    } else if (loginval.status == 'Failed') {
      showLoginerror(_scaffoldKey.currentContext!, 2);
    } else {
      showLoginerror(_scaffoldKey.currentContext!, 3);
    }
  }

  Future showLoginerror(BuildContext? context, stat) async {
    //print('hi');
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Username or password incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  addLoginShareddata(status, userId, userType, userName, ownerName) async {
    final sharedPrefLogin = Sharedpref(
      status: status,
      userId: userId,
      userType: userType,
      userName: userName,
      ownerName: ownerName,
    );

    await SharedPrefManager.instance.addSharedData(sharedPrefLogin);
    // final getLoginData = await SharedPrefManager().getSharedData();
    // for (var data in getLoginData) {
    //   print(data.userId);
    // }

    await Wklycollectfn.instance.wklycolctfn();
  }
}
