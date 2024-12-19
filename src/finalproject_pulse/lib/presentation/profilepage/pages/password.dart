import 'package:finalproject_pulse/presentation/profilepage/pages/profilepage.dart';
import 'package:finalproject_pulse/presentation/profilepage/pages/schedule.dart';
import 'package:finalproject_pulse/presentation/profilepage/pages/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/common/helpr/navigator/app_navigator.dart';

class Password extends StatelessWidget {
  const Password({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greenlight,
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        body: Row(
          children: [
            Expanded(
              child: Container(
                  color: Color(0xff22422F),
                  width: 50,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        leading: Image.asset('assets/Images/User_off.png'),
                        title: Text(
                          'User Profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          AppNavigator.pushReplacement(
                              context, const Profilepage());
                        },
                      ),
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        leading: Image.asset('assets/Images/sessions_off.png'),
                        title: Text(
                          'Sessions',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          AppNavigator.pushReplacement(
                              context, const Sessions());
                        },
                      ),
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        leading: Image.asset('assets/Images/password_on.png'),
                        title: Text(
                          'Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xffF3ED92)),
                        ),
                        onTap: () {
                          AppNavigator.pushReplacement(
                              context, const Password());
                        },
                      ),
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        leading: Image.asset('assets/Images/Schedule_off.png'),
                        title: Text(
                          'Schedule',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          AppNavigator.pushReplacement(
                              context, const Schedule());
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 300, horizontal: 100),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text("Log Out"),
                        ),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffE4E2C5),
                  border: Border.all(color: Color(0xffE4E2C5)),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(40),
                          child: Text(
                            "Password",
                            style: TextStyle(fontSize: 36),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: Text(
                            "Old Password",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: Text(
                            "New Password",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: Text(
                            "Confirm New Password",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: ElevatedButton(
                              onPressed: null, child: Text("Confirm")),
                        )
                      ],
                    )
                  ],
                ),
                height: 1000,
                width: 900,
              ),
            )
          ],
        ));
    ;
  }
}
