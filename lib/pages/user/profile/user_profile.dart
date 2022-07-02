import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/authentication/auth_service.dart';
import 'package:travel_smartapp/domain/cloud_services/user_service.dart';
import 'package:travel_smartapp/domain/models/user_model.dart';
import 'package:travel_smartapp/domain/providers/prefernce_provider.dart';
import 'package:travel_smartapp/extension/context/localization.dart';
import 'package:travel_smartapp/extension/context/themes.dart';
import 'package:travel_smartapp/pages/tickets/tickets.dart';
import 'package:travel_smartapp/pages/user/points.dart';
import 'package:travel_smartapp/pages/user/profile/edit_user_profile.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    final PrefernceProvider prefernceProvider =
        Provider.of<PrefernceProvider>(context);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
          title: Text(context.loc!.user_profile),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {
                prefernceProvider.darkMode = !prefernceProvider.darkMode;
              },
              icon: prefernceProvider.darkMode
                  ? const Icon(Icons.dark_mode_rounded, color: kSecondaryColor)
                  : const Icon(Icons.light_mode_rounded),
            )
          ]),
      body: StreamBuilder<UserModel>(
          stream: UserService.firebase()
              .readDoc(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            UserModel? user = snapshot.data;

            return Stack(
              fit: StackFit.expand,
              children: [
                Transform.translate(
                  offset: const Offset(0.0, 100),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.themes.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(kBorderRadius),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: const Offset(0.0, 50),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            foregroundImage:
                                CachedNetworkImageProvider(kDefaultAvatar),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: kPadding * .5),
                          child: Text(
                              "${user?.firstName ?? ""} ${user?.secondName ?? ""}",
                              style: const TextStyle(
                                fontSize: kFontSize * .9,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Text(user?.email ?? context.loc!.wating,
                            style: const TextStyle(
                              fontSize: kFontSize * .7,
                            )),
                        const SizedBox(height: kPadding),
                        CustomButton(
                          text: context.loc!.past_travels,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return TicketsPage();
                            }));
                          },
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width -
                                kPadding * 2,
                            minHeight: 50,
                          ),
                        ),
                        const SizedBox(height: kPadding * .5),
                        CustomButton(
                          text: context.loc!.points,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => PointsView(
                                user: user,
                              ),
                            );
                          },
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width -
                                kPadding * 2,
                            minHeight: 50,
                          ),
                        ),
                        const SizedBox(height: kPadding * .5),
                        CustomButton(
                          text: context.loc!.edit_profile,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  EditProfileContent(user: user),
                              isScrollControlled: true,
                              enableDrag: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(kBorderRadius))),
                            );
                          },
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width -
                                kPadding * 2,
                            minHeight: 50,
                          ),
                        ),
                        const SizedBox(height: kPadding * .5),
                        CustomButton(
                          text: context.loc!.logout,
                          onPressed: () {
                            Provider.of<PrefernceProvider>(context,
                                    listen: false)
                                .clear();
                            authService.logout();
                          },
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width -
                                kPadding * 2,
                            minHeight: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
