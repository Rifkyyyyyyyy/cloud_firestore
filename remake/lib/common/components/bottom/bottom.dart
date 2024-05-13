import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:remake/common/components/add/add.dart';
import 'package:remake/common/style/colors/colors.dart';


class BottomNav extends StatelessWidget {
 final StatefulNavigationShell shellBranch;

  const BottomNav({Key? key, required this.shellBranch})
      : super(key: key ?? const ValueKey<String>('bottomnav'));
  @override
  Widget build(BuildContext context) {
    return 
Scaffold(
      backgroundColor: ColorsApp.body,
      body: shellBranch,
      floatingActionButton: const AddButton() ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.transparent,
        color: ColorsApp.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.01,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            selectedItemColor: ColorsApp.kPrimary,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(LucideIcons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(LucideIcons.barChart2), label: 'Test'),
              BottomNavigationBarItem(
                  icon: Icon(LucideIcons.calendar), label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: Icon(LucideIcons.user), label: 'Profile'),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  }


