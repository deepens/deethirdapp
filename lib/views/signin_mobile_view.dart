import 'package:flutter/material.dart';
import 'package:deethirdapp/shared/ui_helpers.dart';
import 'package:deethirdapp/views/constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/signin_Mobile_view_model.dart';

class SignInMobileView extends StatelessWidget {
  SignInMobileView({Key key}) : super(key: key);

  //final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final phonenoController = TextEditingController();
  final smsCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInMobileViewModel>.reactive(
      viewModelBuilder: () => SignInMobileViewModel(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _fbKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    verticalSpaceMedium,
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: SizedBox(
                        height: 50,
                        child: !model.busy != false
                            ? Text(
                                model.getErrormessage(),
                                style: TextStyle(
                                  color: Colors.redAccent[700],
                                ),
                              )
                            : Container(),
                        //child:_image,
                      ),
                    ),

                    verticalSpaceMedium,
                    model.codeSent == false
                        ? Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: FormBuilderTextField(
                              //obscureText: true,
                              keyboardType: TextInputType.phone,
                              //onChanged: (val) => phonenoController.text,
                              attribute: "Mobileno",
                              controller: phonenoController,

                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.mobile_screen_share,
                                  color: kPrimaryColor,
                                ),
                                hintText: "Enter Mobile no",
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
                                    errorText: "Mobile no cannot be empty"),
                                FormBuilderValidators.minLength(10,
                                    errorText:
                                        "Mobile no cannot be less than 10 digit"),
                                //FormBuilderValidators.pattern(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'),
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                  //obscureText: true,
                                  keyboardType: TextInputType.phone,
                                  //onChanged: (val) => smsCodeController.text,
                                  attribute: "OTP",
                                  controller: smsCodeController,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.sms,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "Enter OTP",
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor),
                                    ),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  maxLines: 1,
                                  validators: [
                                    FormBuilderValidators.required(
                                        errorText: "OTP cannot be empty"),
                                    FormBuilderValidators.minLength(6,
                                        errorText:
                                            "OTP cannot be less than 6 digit"),
                                    //FormBuilderValidators.pattern(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'),
                                  ],
                                ),
                                verticalSpaceSmall,
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: model.resetOTPTimer == true
                                      ? Text("")
                                      : model.resendOPT == 0
                                          ? Text("")
                                          : Text("OTP can be Resend in " +
                                              model.resendOPT.toString() +
                                              "sec"),
                                ),
                                model.displayResendButton == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0),
                                        child: RaisedButton(
                                          child: Text('Resend OTP'),
                                          onPressed: () {
                                            print("on Pressed===>" +
                                                model.phoneNo.toString());
                                            model.setErrormessage("");
                                            String pn = model.phoneNo;
                                            model.enterPhoneNo(
                                                phoneNo: pn, context: context);

                                            model.setresendOTP(30);
                                          },
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                    //: Container(),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: RaisedButton(
                        child: Center(
                            child: model.codeSent == false
                                ? Text('Login')
                                : Text('Verify')),
                        onPressed: () {
                          //print("on Pressed===>" + model.verificationId);
                          if (_fbKey.currentState.validate()) {
                            if (model.codeSent) {
                              model.signInUsingOTP(
                                  smsCode: smsCodeController.text,
                                  context: context);
                            } else {
                              model.enterPhoneNo(
                                  phoneNo: "+91".toString() +
                                      phonenoController.text.toString(),
                                  context: context);
                              //model.startTimer();
                            }
                          } else {
                            model.setErrormessage("");
                            return null;
                          }
                        },
                      ),
                    ),
                    verticalSpaceSmall,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//@override
//   Widget displayErrorMessage(BuildContext context) {
//     return ViewModelBuilder<SignInMobileViewModel>.reactive(
//       viewModelBuilder: () => SignInMobileViewModel(),
//       builder: (context, model, child) => Padding(
//         padding: EdgeInsets.only(left: 25.0, right: 25.0),
//         child: SizedBox(
//           height: 50,
//           child: model.busy != false
//               ? Text(
//                   model.getErrormessage(),
//                   style: TextStyle(
//                     color: Colors.redAccent[700],
//                   ),
//                 )
//               : Container(),
//           //child:_image,
//         ),
//       ),
//     );
//   }
