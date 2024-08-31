import 'package:pompomtracker/core/hook/hook.dart';

ValueNotifier<StatementType> selectedTaskNotifier =
    ValueNotifier(StatementType.collectionType);

class RadioButton extends StatelessWidget {
  final String title;
  final StatementType type;
  const RadioButton({required this.title, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedTaskNotifier,
            builder: (BuildContext ctx, StatementType newtask, Widget? _) {
              return Radio<StatementType>(
                value: type,
                groupValue: newtask,
                activeColor: Theme.of(context).colorScheme.onSecondary,
                onChanged: (value) async {
                  if (value == null) {
                    return;
                  }
                  ctx.read<RadiobuttonProvider>().changeSelectedType(value);

                  context
                      .read<CollectionDrpDwnProvider>()
                      .changeSelectedVal(dtWise);

                  context.read<ElevatedBtnProvider>().changeSelectedVal(false);

                  selectedTaskNotifier.value = value;
                  selectedTaskNotifier.notifyListeners();
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
