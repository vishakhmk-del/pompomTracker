import 'package:pompomtracker/core/hook/hook.dart';

class ScreenRoutemasterNew extends StatefulWidget {
  const ScreenRoutemasterNew({super.key});

  @override
  State<ScreenRoutemasterNew> createState() => _ScreenRoutemasterNewState();
}

class _ScreenRoutemasterNewState extends State<ScreenRoutemasterNew> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _viaController = TextEditingController();

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.push(context, Approutes().settingscreen);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          await popscreen(context);
        }
      },
      child: Stack(
        children: [
          BackgroundColorGradient(),
          Scaffold(
            backgroundColor: Colors.transparent,
            key: _scafoldkey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      _scafoldkey.currentContext!, Approutes().settingscreen);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              title: const Text(
                'Add Route',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  elevation: 3,
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Theme(
                          data: MyTheme.googleFormTheme,
                          child: Column(
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/bus/busmaster.png'),
                                radius: 50,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _fromController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                  labelText: 'From Station',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter From Station';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _toController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                  labelText: 'To Station',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter To Station';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _viaController,
                                style: Theme.of(context).textTheme.bodySmall,
                                decoration: InputDecoration(
                                  labelText: 'Via',
                                  labelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Value';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.secondary,
                                    ],
                                  ),
                                ),
                                child: Theme(
                                  data: MyTheme.buttonStyleTheme,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await routeMasterSave(context);
                                      }
                                    },
                                    child: Text(
                                      'SAVE',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
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
                                              Colors.orange,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                },
                              ),
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
        ],
      ),
    );
  }

  Future<void> routeMasterSave(BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadingProvider.toggleLoading(); // Start loading
    });

    final fromStation = _fromController.text;
    final toStation = _toController.text;
    final via = _viaController.text;
    final value = await SharedPrefManager.instance.getSharedData();

    final routeMasReq = RouteMasterReq(
      from: fromStation,
      to: toStation,
      via: via,
      userId: value!.userId,
    );

    final routeMasterResp = await Busdata().routeMasterSave(routeMasReq);
    final resultAsJson = jsonDecode(routeMasterResp.toString());
    final resValue =
        RouteMasterResp.fromJson(resultAsJson as Map<String, dynamic>);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadingProvider.toggleLoading(); // Stop loading
    });

    if (!mounted) return;

    if (resValue.status == 'success') {
      Fluttertoast.showToast(
        msg: "Route details saved successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 15.0,
      );
      if (!context.mounted) return;
      Navigator.push(context, Approutes().settingscreen);
    } else if (resValue.status == 'Failed') {
      showError(_scafoldkey.currentContext, 2);
    } else {
      showError(_scafoldkey.currentContext, 3);
    }
  }

  void showError(BuildContext? context, int stat) {
    String msg = stat == 2 ? "Route details not saved" : "Something went wrong";
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 15.0,
    );
  }
}
