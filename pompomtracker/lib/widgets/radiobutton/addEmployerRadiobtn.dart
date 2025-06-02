import 'package:pompomtracker/core/hook/hook.dart';

ValueNotifier<StatementType> selectedEmployerNotifier =
    ValueNotifier(StatementType.conductor);

class EmployerRadioButton extends StatelessWidget {
  final String title;
  final StatementType type;

  const EmployerRadioButton(
      {required this.title, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedEmployerNotifier,
            builder: (BuildContext ctx, StatementType newtask, Widget? _) {
              return Radio<StatementType>(
                value: type,
                groupValue: newtask,
                activeColor: Theme.of(context).colorScheme.onSecondary,
                onChanged: (value) async {
                  if (value == null) {
                    return;
                  }
                  ctx.read<RadiobuttonProvider>().changeSelectedEmployee(value);

                  selectedEmployerNotifier.value = value;
                  selectedEmployerNotifier.notifyListeners();
                },
              );
            }),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
