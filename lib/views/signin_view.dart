//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../views/constants.dart';
import '../shared/ui_helpers.dart';
import '../viewmodels/signin_view_model.dart';

class SignInView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  //final String emailValue = '';
  //final String passwordValue = '';
  //final String firstNameValue = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: WillPopScope(
            onWillPop: () async => false,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      verticalSpaceMassive,
                      FormBuilder(
                        key: _fbKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                                height: 40,
                                child: !model.busy != false
                                    ? Text(
                                        model.getErrormessage(),
                                        style: TextStyle(
                                          color: Colors.redAccent[700],
                                        ),
                                      )
                                    : Text("")
                                //child:_image,

                                ),
                            verticalSpaceMedium,
                            FormBuilderTextField(
                              attribute: "E-mail",
                              controller: emailController,
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.email,
                                  color: kPrimaryColor,
                                ),
                                hintText: "E-mail",
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              validators: [
                                FormBuilderValidators.required(
                                    errorText: "E-mail cannot be empty"),
                                FormBuilderValidators.minLength(6,
                                    errorText:
                                        "E-mail cannot be less than 6 digit"),
                                //FormBuilderValidators.pattern(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',errorText: "Please enter a Valid e-mail id"),
                              ],
                            ),
                            FormBuilderTextField(
                              obscureText: true,
                              onChanged: (val) => passwordController.text,
                              attribute: "Password",
                              controller: passwordController,
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: kPrimaryColor,
                                ),
                                hintText: "Password",
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              maxLines: 1,
                              validators: [
                                FormBuilderValidators.required(
                                    errorText: "Password cannot be empty"),
                                FormBuilderValidators.minLength(3,
                                    errorText:
                                        "Password cannot be less than 3 digit"),
                                //FormBuilderValidators.pattern(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceMedium,
                      Row(
                        //mainAxisSize: MainAxisSize.max,
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: size.width * 0.7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                color: kPrimaryColor,
                                onPressed: () {
                                  if (_fbKey.currentState.validate()) {
                                    model.signIn(
                                        email: emailController.text
                                            .trim()
                                            .toLowerCase(),
                                        password:
                                            passwordController.text.trim(),
                                        context: context);
                                  } else {
                                    return null;
                                  }
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don’t have an Account ? ",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.navigateToSignUp();
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 17,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Text("OR"),
                      RaisedButton(
                        color: kPrimaryColor,
                        child: Text(
                          "Login Using Mobile",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          model.navigateToMobileView();
                        },
                      ),
                      verticalSpaceMedium,
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
