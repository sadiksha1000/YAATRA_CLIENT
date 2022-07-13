import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaatra_client/core/server/server.dart';
import 'package:yaatra_client/core/widgets/custom_popup_message.dart';
import 'package:yaatra_client/features/passenger/profile/domain/enities/passenger_profile.dart';
import 'package:yaatra_client/features/passenger/profile/presentation/cubit/passenger_profile_cubit.dart';
import 'package:yaatra_client/features/shared/image/domain/entities/upload_image.dart';
import 'package:yaatra_client/features/shared/image/presentation/image_cubit/image_cubit.dart';

import '../../../../../core/config/size.dart';
import '../../../../../core/utils/status.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../core/widgets/custom_button_widget.dart';
import '../../../../../core/widgets/custom_drawer.dart';
import '../../../../../core/widgets/custom_intro_header.dart';
import '../../../../../core/widgets/custom_number_form_field.dart';
import '../../../../../core/widgets/custom_textformfield_widget.dart';
import '../../../../../core/widgets/dotted_border_widget.dart';
import '../../../../authentication/presentation/blocs/cubit/auth_cubit.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/passenger/account';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  PassengerProfile initProfile = PassengerProfile.empty;
  bool isInit = true;

  @override
  void initState() {
    AuthCubit _authCubit = BlocProvider.of<AuthCubit>(context);
    print("User is state ${_authCubit.state.user}");

    PassengerProfileCubit _passengerCubit =
        BlocProvider.of<PassengerProfileCubit>(context);
    print("Passenger here ${_passengerCubit.state.currentCreatedProfile}");
    _passengerCubit
        .createdaddress(_passengerCubit.state.currentCreatedProfile.address);
    _passengerCubit
        .createdname(_passengerCubit.state.currentCreatedProfile.name);
    _passengerCubit
        .createdphone(_passengerCubit.state.currentCreatedProfile.phone);
    _passengerCubit.createprofileUrl(
        _passengerCubit.state.currentCreatedProfile.profileUrl);
    super.initState();
  }

  Widget showProfileImage(PassengerProfileCubit _passengerCubit) {
    return CircleAvatar(
      radius: size(context).height * 0.05,
      backgroundImage: NetworkImage(
          "$serverUrl/${_passengerCubit.state.currentCreatedProfile.profileUrl}"),
    );
  }

  Widget uploadProfileImage(PassengerProfileCubit _passengerProfileCubit) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(size(context).height * 0.02),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DotBorder(
                imageUpload: (List<String> path) {
                  print("This is profile image url ${path[0]}");
                  _passengerProfileCubit.createprofileUrl(path[0]);
                },
              ),
            ),
          ),
        ),
        SizedBox(width: size(context).width * 0.05),
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text("Upload Photo"),
            Text("Prefered photo size: 400*400"),
            Text("Supports: JPG, PNG")
          ],
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && isInit) {
      isInit = false;
      initProfile = arguments as PassengerProfile;
      PassengerProfileCubit _passengerProfileCubit =
          BlocProvider.of<PassengerProfileCubit>(context);
      _passengerProfileCubit.createdname(initProfile.name);
      _passengerProfileCubit.createdphone(initProfile.phone);
      _passengerProfileCubit.createdaddress(initProfile.address);
      // _passengerProfileCubit.createprofileUrl(initProfile.profileUrl);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    PassengerProfileCubit _passengerProfileCubit =
        BlocProvider.of<PassengerProfileCubit>(context);
    return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: customAppBar(
        title: 'Profile',
        context: context,
        isBackButton: false,
      ),
      body: Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            return _passengerProfileCubit.refreshProfile();
          },
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: SingleChildScrollView(
                  child: BlocConsumer<PassengerProfileCubit,
                      PassengerProfileState>(
                    listener: (context, state) {
                      if (state.saveProfileStatus == Status.success) {
                        customPopMessage(context,
                            message: state.successMessage);
                      } else if (state.saveProfileStatus == Status.error) {
                        customPopMessage(context,
                            message: state.errorMessage, isError: true);
                      }
                    },
                    builder: (context, state) {
                      return SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IntroHeader(
                                introHeader: "Update Profile",
                                introDesc: "Update Profile Detail",
                                size1: size(context).height * 0.025,
                              ),
                              _passengerProfileCubit.state.currentCreatedProfile
                                      .profileUrl.isNotEmpty
                                  ? Center(child:
                                      BlocBuilder<ImageCubit, ImageState>(
                                      builder: (context, state) {
                                        return GestureDetector(
                                          onTap: () async {
                                            ImageCubit _imageCubit =
                                                context.read<ImageCubit>();
                                            _imageCubit.setImageUploadStatus(
                                                Status.initial);
                                            await _imageCubit
                                                .showImageUploadSheet(context);

                                            state.status == Status.success
                                                ? _passengerProfileCubit
                                                    .createprofileUrl(
                                                        state.uploadedImages[0])
                                                : [''];
                                          },
                                          child: state.status == Status.loading
                                              ? const CircularProgressIndicator()
                                              : showProfileImage(
                                                  _passengerProfileCubit),
                                        );
                                      },
                                    ))
                                  : uploadProfileImage(_passengerProfileCubit),
                              SizedBox(height: size(context).height * 0.02),
                              Column(
                                children: [
                                  CustomTextFormField(
                                    hintText: 'Enter Your Name',
                                    errorText: '',
                                    icon: Icons.person,
                                    onChanged:
                                        _passengerProfileCubit.createdname,
                                    initialValue: _passengerProfileCubit
                                        .state.currentCreatedProfile.name,
                                  ),
                                  SizedBox(
                                    height: size(context).height * 0.02,
                                  ),
                                  CustomNumberFormField(
                                      hintText: 'Your Phone Number',
                                      icon: Icons.phone,
                                      onChanged:
                                          _passengerProfileCubit.createdphone,
                                      initialValue: _passengerProfileCubit
                                          .state.currentCreatedProfile.phone),
                                  SizedBox(
                                    height: size(context).height * 0.02,
                                  ),
                                  CustomTextFormField(
                                      hintText: 'Your Address',
                                      errorText: '',
                                      icon: Icons.place,
                                      onChanged:
                                          _passengerProfileCubit.createdaddress,
                                      initialValue: _passengerProfileCubit
                                          .state.currentCreatedProfile.address),
                                  SizedBox(
                                    height: size(context).height * 0.02,
                                  ),
                                  SizedBox(
                                    height: size(context).height * 0.02,
                                  ),
                                  CustomButton(
                                    disable: false,
                                    onPressed: () {
                                      _passengerProfileCubit.createProfile(
                                        passengerdata: initProfile,
                                      );
                                    },
                                    label: "Submit",
                                  ),
                                  SizedBox(
                                    height: size(context).height * 0.02,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
