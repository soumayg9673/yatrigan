import 'package:flutter/material.dart';
import 'package:yatrigan/controller/user/user_ctrl.dart';
import 'package:yatrigan/model/user/util/user_icon.dart';
import 'package:yatrigan/model/user/util/user_texts.dart';
import 'package:yatrigan/view/init/init_view.dart';
import 'package:yatrigan/view/main/home_screen_view.dart';
import 'package:yatrigan/view/util/app_bar.dart';
import 'package:yatrigan/view/util/margins.dart';
import 'package:yatrigan/view/widgets/buttons/elevated_button_widget.dart';
import 'package:yatrigan/view/widgets/fields/textformfield_widget.dart';
import 'package:yatrigan/view/widgets/list_tile_error_widget.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});
  static String id = '/idukaan/user/login';

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  void _successResponseUserVerified({
    required String message,
  }) {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreenView.id, ModalRoute.withName(InitView.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _failedResponse({
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hi User,'),
        content: Text(message),
        actions: const [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userLoginKey = GlobalKey<FormState>();
    return Consumer<UserCtrl>(
      builder: (context, ctrl, _) {
        return Scaffold(
          appBar: appBar(
            context: context,
            title: UserLoginText.appBarTitle,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: userLoginKey,
              child: Container(
                margin: screenMargin(context),
                child: Column(
                  children: [
                    if (ctrl.userLoginRes != null &&
                        ctrl.userLoginRes!.userFObj != null)
                      Card(
                        child: Column(
                          children: [
                            ListTileErrorWidget(
                              title: 'Attention Required',
                              subtitle: ctrl.userLoginRes!.message,
                            ),
                            if (ctrl
                                .userLoginRes!.userFObj!.username.isNotEmpty)
                              ListTileErrorWidget(
                                title: 'Username',
                                subtitle: ctrl.userLoginRes!.userFObj!.username,
                              ),
                            if (ctrl
                                .userLoginRes!.userFObj!.password.isNotEmpty)
                              ListTileErrorWidget(
                                title: 'Password',
                                subtitle: ctrl.userLoginRes!.userFObj!.password,
                              ),
                          ],
                        ),
                      ),
                    const ListTile(
                      title: Text(UserLoginText.title),
                      subtitle: Text(UserLoginText.desc),
                    ),
                    const Divider(),
                    TextFormFieldWidget(
                      prefixIcon: UserIcons.username.icon,
                      keyboardType: TextInputType.name,
                      labelText: 'Username',
                      onFieldSubmitted: ctrl.userLoginReq.setUsername,
                    ),
                    TextFormFieldWidget(
                      prefixIcon: UserIcons.pwd.icon,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      labelText: 'Password',
                      onFieldSubmitted: ctrl.userLoginReq.setPwd,
                    ),
                    ElevatedButtonWidget(
                      title: 'Login',
                      onPressed: () async {
                        if (userLoginKey.currentState!.validate()) {
                          await ctrl.postUserLoginApi(
                            context: context,
                          );
                          if (ctrl.userLoginRes != null) {
                            if (ctrl.userLoginRes!.userSObj != null &&
                                ctrl.userLoginRes!.userSObj!.isVer) {
                              _successResponseUserVerified(
                                message: ctrl.userLoginRes!.message,
                              );
                            } else {
                              _failedResponse(
                                message: ctrl.userLoginRes!.message,
                              );
                            }
                          }
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Having trouble logging in?'),
                        ),
                      ],
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
