part of '../index.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  final iconList = <IconData>[
    FontAwesomeIcons.home,
    FontAwesomeIcons.receipt,
  ];
  

  var widgets = [const HomeScreen(), const DataAbsensiScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.elementAt(selectedIndex),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        onPressed: () {
          if (storagePermission!.isGranted || locationPermission!.isGranted || cameraPermission!.isGranted) {
            Navigator.pushNamed(context, absensiScreen);
          } else {
            BlocProvider.of<CheckPermissionCubit>(context).checkPermissionGranted(context);
          }
        },
        child: const Icon(FontAwesomeIcons.fingerprint, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? hijauLight : Colors.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconList[index], size: 26, color: color),
              const SizedBox(height: 4),
              if (index == 0) Text('Home', style: TextStyle(color: color, fontSize: 13, fontFamily: 'JakartaSansSemibold')),
              if (index == 1) Text('Data Absensi', style: TextStyle(color: color, fontSize: 13, fontFamily: 'JakartaSansSemibold')),
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: selectedIndex,
        splashColor: hijauLight,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
