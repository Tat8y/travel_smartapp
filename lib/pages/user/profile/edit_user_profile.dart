import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/authentication/auth_service.dart';
import 'package:travel_smartapp/domain/cloud_services/user_service.dart';
import 'package:travel_smartapp/domain/models/user_model.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';
import 'package:travel_smartapp/widgets/text_feild/form_text_feild.dart';

class EditProfileContent extends StatefulWidget {
  final UserModel? user;
  const EditProfileContent({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {
  late TextEditingController fnameEditingController;
  late TextEditingController lnameEditingController;
  late TextEditingController emailEditingController;
  late TextEditingController newPassEditingController;
  late TextEditingController confirmPassEditingColler;

  @override
  void initState() {
    fnameEditingController = TextEditingController();
    lnameEditingController = TextEditingController();
    emailEditingController = TextEditingController();
    newPassEditingController = TextEditingController();
    confirmPassEditingColler = TextEditingController();

    fnameEditingController.text = widget.user?.firstName ?? "";
    lnameEditingController.text = widget.user?.secondName ?? "";
    emailEditingController.text = widget.user?.email ?? "";

    super.initState();
  }

  @override
  void dispose() {
    fnameEditingController.dispose();
    lnameEditingController.dispose();
    emailEditingController.dispose();
    newPassEditingController.dispose();
    confirmPassEditingColler.dispose();
    super.dispose();
  }

  Future<void> updateUser() async {
    UserModel? _user = widget.user?.copyWith(
      firstName: fnameEditingController.text,
      secondName: lnameEditingController.text,
    );
    //Provider.of<AuthService>(context, listen: false).setUserModel(_user!);
    await UserService.firebase()
        .update(id: _user!.uid!, json: _user.toMap())
        .then(
          (value) => Navigator.of(context).pop(),
        );
  }

  bool passwordValidation(String password, String confirmPass) {
    return password.trim() == confirmPass.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Transform.translate(
        offset: const Offset(0, -50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  foregroundImage: CachedNetworkImageProvider(kDefaultAvatar),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kPadding * .5),
                child: Text(
                    "${widget.user?.firstName ?? ""} ${widget.user?.secondName ?? ""}",
                    style: const TextStyle(
                      fontSize: kFontSize * .9,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: kPadding / 2),
                child: CustomFormTextFeild(
                  controller: fnameEditingController,
                  hint: "First Name",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: kPadding / 2),
                child: CustomFormTextFeild(
                  controller: lnameEditingController,
                  hint: "Last Name",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: kPadding / 2),
                child: CustomFormTextFeild(
                  controller: emailEditingController,
                  hint: "Email",
                  enabled: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: kPadding / 2),
                child: CustomFormTextFeild(
                  controller: newPassEditingController,
                  hint: "New Password",
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: kPadding / 2),
                child: CustomFormTextFeild(
                  controller: confirmPassEditingColler,
                  hint: "Confirm Password",
                  obscureText: true,
                ),
              ),
              const SizedBox(height: kPadding / 2),
              CustomButton(
                text: "Update",
                onPressed: updateUser,
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - kPadding * 2,
                  minHeight: 50,
                ),
              ),
              const SizedBox(height: kPadding / 2),
            ],
          ),
        ),
      ),
    );
  }
}
