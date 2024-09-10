import 'package:pompomtracker/core/hook/hook.dart';

ValueNotifier<StatementType> selectedModeNotifier =
    ValueNotifier(StatementType.both);

class ModeRadioButton extends StatelessWidget {
  final String title;
  final StatementType type;
  const ModeRadioButton({required this.title, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedModeNotifier,
            builder: (BuildContext ctx, StatementType newtask, Widget? _) {
              return Radio<StatementType>(
                value: type,
                groupValue: newtask,
                activeColor: Theme.of(context).colorScheme.secondary,
                onChanged: (value) async {
                  if (value == null) {
                    return;
                  }
                  ctx.read<RadiobuttonProvider>().changeSelectedMode(value);

                  //context.read<CollectionDrpDwnProvider>().changeSelectedVal(dtWise);

                  context.read<ElevatedBtnProvider>().changeSelectedVal(false);

                  selectedModeNotifier.value = value;
                  selectedModeNotifier.notifyListeners();
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
