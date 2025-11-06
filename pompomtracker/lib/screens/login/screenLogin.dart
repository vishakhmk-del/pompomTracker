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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await SecurityCheck.checkAndExitIfCompromised(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff16324f),
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
                                  cursorColor: Colors.white,
                                  controller: _usercontroller,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    labelStyle:
                                        Theme.of(context).textTheme.labelSmall,
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
                                  cursorColor: Colors.white,
                                  controller: _passcontroller,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle:
                                        Theme.of(context).textTheme.labelSmall,
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
                                    await getlogin(context);
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
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenForgotPswrd(),
                                ),
                              );
                            },
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
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
    );
  }

  Future getlogin(BuildContext context) async {
    try {
      final loadingProvider =
          _scaffoldKey.currentContext!.read<LoadingProvider>();
      //False to true
      loadingProvider.toggleLoading();
      final username = _usercontroller.text;
      final password = _passcontroller.text;
      final value = await SharedPrefManager.instance.getdeviceinfo();

      final logreq = Loginreq(
          userName: username,
          pwd: password,
          phone: value.phone,
          deviceid: value.deviceid,
          phoneos: value.phoneos,
          androidid: value.androidid,
          appversion: value.appversion,
          buildnumber: value.buildnumber);

      final loginResponse = await Busdata().login(logreq);

      final resultAsjson = jsonDecode(loginResponse.toString());
      final loginval = Loginresp.fromJson(resultAsjson as Map<String, dynamic>);

      loadingProvider.reset();
      if (loginResponse == null) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (loginResponse.statusCode == 200 &&
          loginval.status == 'success') {
        //print('success');
        addLoginShareddata(
            loginval.data?.userId ?? '',
            loginval.data?.userType ?? '',
            loginval.data?.userName ?? '',
            loginval.data?.ownerName ?? '',
            loginval.data?.token ?? '');
        if (!context.mounted) return;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ScreenMainPage(),
          ),
        );
      } else if (loginval.status == 'failed') {
        if (loginval.data == null) {
          if (!context.mounted) return;
          Wklycollectfn.instance
              .showApierror(context, "Username or password Incorrect");
        } else if (loginval.data?.errorCode == 'VERSION001') {
          if (!context.mounted) return;

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ScreenError(
                message: loginval.message,
              ),
            ),
          );
        } else {
          if (!context.mounted) return;
          Wklycollectfn.instance
              .showApierror(context, "Username or password Incorrect");
        }
      } else if (loginResponse.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (loginResponse.statusCode == 408) {
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

  addLoginShareddata(userId, userType, userName, ownerName, token) async {
    final sharedPrefLogin = Sharedpref(
        userId: userId,
        userType: userType,
        userName: userName,
        ownerName: ownerName,
        token: token);

    await SharedPrefManager.instance.addSharedData(sharedPrefLogin);

    // await Wklycollectfn.instance.wklycolctfn();
  }
}
