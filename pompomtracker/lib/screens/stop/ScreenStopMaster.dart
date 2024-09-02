import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class ScreenStopMaster extends StatefulWidget {
  const ScreenStopMaster({super.key});

  @override
  State<ScreenStopMaster> createState() => _ScreenStopMasterState();
}

class _ScreenStopMasterState extends State<ScreenStopMaster> {
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _stopNameController = TextEditingController();
  final _kiloMeterController = TextEditingController();
  final _arrivingController = TextEditingController();
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  _scafoldkey.currentContext!, Approutes().homescreen);
            },
          ),
          title: Text(
            'Stop Master',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .6,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSecondary),
                  borderRadius: BorderRadius.circular(12)),
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
                          controller: _stopNameController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Stop Name',
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Stop Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: TextFormField(
                              controller: _kiloMeterController,
                              style: Theme.of(context).textTheme.bodySmall,
                              decoration: InputDecoration(
                                labelText: 'Kilo Meter',
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Kilo Meter';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            //fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                        ]),
                        // const SizedBox(height: 20),

                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _arrivingController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              labelText: 'Arriving Time',
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              suffixIcon: Theme(
                                  data: MyTheme.appIconTheme,
                                  child: const Icon(Icons.timer))),
                          onTap: () =>
                              _selectTime(context, _arrivingController),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Value';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.secondary,
                                  ])),
                          child: Theme(
                            data: MyTheme.buttonStyleTheme,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // stopMasterSave();
                                }
                              },
                              child: Text('SAVE',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Consumer<LoadingProvider>(
                            builder: (context, loadingProvider, child) {
                          return loadingProvider.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
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
        ));
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final DateFormat timeFormat = DateFormat('HH:mm');
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        final now = DateTime.now();
        final DateTime formattedTime = DateTime(
          now.year,
          now.month,
          now.day,
          newTime.hour,
          newTime.minute,
        );
        controller.text = timeFormat.format(formattedTime);
      });
    }
  }
}
