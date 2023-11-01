import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yatrigan/controller/auth/auth_ctrl.dart';
import 'package:yatrigan/controller/auth/auth_ctrl_mdl.dart';
import 'package:yatrigan/model/init/init_data.dart';
import 'package:yatrigan/view/main/home_screen_view.dart';
import 'package:yatrigan/view/user/login/user_login_screen.dart';
import 'package:yatrigan/view/user/signup/user_signup_accept_plc.dart';
import 'package:yatrigan/view/util/margins.dart';
import 'package:yatrigan/view/widgets/text_widget.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});
  static String id = '/idukaan/user/init';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: screenMargin(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/yatrigan.png'),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              TextWidget(
                text: 'Welcome to\nYatrigan by Palanhaar',
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.03,
              ),
              const Spacer(),
              const Divider(),
              ListTile(
                title: Text(InitData.login.name),
                trailing: Icon(InitData.login.icon),
                onTap: () {
                  Navigator.pushNamed(context, UserLoginScreen.id);
                },
              ),
              const Divider(),
              ListTile(
                title: Text(InitData.signUp.name),
                trailing: Icon(InitData.signUp.icon),
                onTap: () {
                  Navigator.pushNamed(context, UserSignupAcceptPlc.id);
                },
              ),
              const Divider(),
              ListTile(
                title: Text(InitData.skip.name),
                trailing: Icon(InitData.skip.icon),
                onTap: () {
                  Navigator.pushReplacementNamed(context, HomeScreenView.id);
                  Provider.of<AuthCtrl>(context, listen: false).writeKey(
                    key: AppKey.skip.key,
                    value: '1',
                  );
                },
              ),
              const Divider(),
              const Spacer(),
              TextWidget(
                text: '',
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.03,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
