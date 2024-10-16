import 'package:pompomtracker/core/hook/hook.dart';

ValueNotifier<StatementType> selectedFormatNotifier =
    ValueNotifier(StatementType.before);

class FormatRadioButton extends StatelessWidget {
  final String title;
  final StatementType type;
  final TextStyle? txtstyl;
  final Color? color;

  const FormatRadioButton(
      {required this.title,
      required this.type,
      required this.txtstyl,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedFormatNotifier,
            builder: (BuildContext ctx, StatementType newtask, Widget? _) {
              return Radio<StatementType>(
                value: type,
                groupValue: newtask,
                activeColor: color,
                onChanged: (value) async {
                  if (value == null) {
                    return;
                  }
                  ctx.read<RadiobuttonProvider>().changeSelectedFormat(value);

                  selectedFormatNotifier.value = value;
                  selectedFormatNotifier.notifyListeners();
                },
              );
            }),
        Text(
          title,
          style: txtstyl,
        ),
      ],
    );
  }
}
