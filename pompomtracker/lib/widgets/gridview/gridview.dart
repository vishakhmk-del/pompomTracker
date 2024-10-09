import 'package:pompomtracker/core/hook/hook.dart';

class BusGridView extends StatelessWidget {
  const BusGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 200,
      ),
      children: [
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(context, Approutes().busmasterscreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryFixed),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/home/bus_ad.png'),
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                ),
                Text(
                  "Add Bus",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(context, Approutes().routemasterscreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryFixed),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/home/add_route.png'),
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                ),
                Text(
                  'Add Route',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
            InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(context, Approutes().linkbusroutescreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryFixed),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/home/link_route.png'),
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                ),
                Text(
                  'Link Bus Route',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(context, Approutes().tripListScreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryFixed),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/home/add_trip.png'),
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                ),
                Text(
                  'Add Trip',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(context, Approutes().stoppmasterscreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryFixed),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/home/add_stop.png'),
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                ),
                Text(
                  'Add Stop',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
    
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondaryFixed,
          onTap: () {
            Navigator.pushReplacement(context, Approutes().conductoscreen);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryFixed),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/home/conductor.png'),
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                ),
                Text(
                  'Add Conductor',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
