
import 'dart:developer';

import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
            ],
          ),

          body: cubit.userModel != null
              ? cubit.screens[cubit.currentIndex]
              : const Center(child: CircularProgressIndicator()),

          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
