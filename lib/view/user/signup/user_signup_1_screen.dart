import 'package:flutter/material.dart';
import 'package:yatrigan/controller/user/user_ctrl.dart';
import 'package:yatrigan/model/user/util/user_icon.dart';
import 'package:yatrigan/model/user/util/user_texts.dart';
import 'package:yatrigan/view/user/signup/user_signup_2_screen.dart';
import 'package:yatrigan/view/util/app_bar.dart';
import 'package:yatrigan/view/util/margins.dart';
import 'package:yatrigan/view/widgets/buttons/elevated_button_widget.dart';
import 'package:yatrigan/view/widgets/fields/textformfield_widget.dart';
import 'package:provider/provider.dart';

class UserSignup1Screen extends StatelessWidget {
  const UserSignup1Screen({super.key});
  static String id = '/idukaan/user/signup/1';

  @override
  Widget build(BuildContext context) {
    final userSignup1Key = GlobalKey<FormState>();
    return Consumer<UserCtrl>(
      builder: (context, ctrl, _) {
        return Scaffold(
          appBar: appBar(
            context: context,
            title: UserSignupText.appBarTitle,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: userSignup1Key,
              child: Container(
                margin: screenMargin(context),
                child: Column(
                  children: [
                    const ListTile(
                      title: Text(UserSignupText.title1),
                      subtitle: Text(UserSignupText.desc1),
                    ),
                    const Divider(),
                    TextFormFieldWidget(
                      prefixWidget: Icon(UserIcons.name.icon),
                      keyboardType: TextInputType.name,
                      labelText: 'First Name',
                      onFieldSubmitted: ctrl.userSignUpReq.setFirstName,
                    ),
                    TextFormFieldWidget(
                      prefixWidget: Icon(UserIcons.name.icon),
                      keyboardType: TextInputType.name,
                      labelText: 'Last Name',
                      onFieldSubmitted: ctrl.userSignUpReq.setLastName,
                    ),
                    ElevatedButtonWidget(
                      title: 'Next',
                      onPressed: () {
                        if (userSignup1Key.currentState!.validate()) {
                          Navigator.pushNamed(context, UserSignup2Screen.id);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
