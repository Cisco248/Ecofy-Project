import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_app/core/constants/color.dart';
import 'package:wms_app/core/widgets/error_card.dart';
import 'package:wms_app/core/widgets/loader.dart';
import 'package:wms_app/core/widgets/profile_card.dart';
import 'package:wms_app/feature/profile/viewmodels/profile_view_model.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileViewModelProvider);
    DebugPrint(profileState, '[PROFILE] View Status').log;
    return Scaffold(
      body: SafeArea(
        child: profileState == null
            ? Center(
                child: Text(
                  "User Not Found!",
                  style: TextStyle(fontSize: 50, color: AppColors.error),
                ),
              )
            : profileState.when(
                loading: () => Loader(),
                error: (error, stackTrace) => ErrorCard(
                  context,
                  "Error: ${error.toString()}",
                  'Error loading profile',
                ),
                data: (profile) {
                  return Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AvatarCard(
                          context,
                          profile.fname[0].toUpperCase(),
                          'null',
                        ),
                        const SizedBox(height: 28),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            spacing: 16,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCard(
                                context,
                                Icons.person,
                                'Name',
                                '${profile.fname.toUpperCase()} ${profile.lname.toUpperCase()}',
                              ),
                              TextCard(
                                context,
                                Icons.email,
                                'Email',
                                profile.email,
                              ),
                              TextCard(
                                context,
                                Icons.phone,
                                'Mobile Number',
                                profile.mobnum,
                              ),
                              TextCard(
                                context,
                                Icons.password,
                                'Password',
                                profile.password,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
