import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/size.dart';
import '../../../../../core/utils/status.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../core/widgets/custom_button_widget.dart';
import '../../../../../core/widgets/custom_document_submit.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../core/widgets/custom_textformfield_widget.dart';
import '../../../../app/presentation/blocs/app/app_bloc.dart';
import '../cubits/cubit/apply_as_agent_cubit.dart';

class ApplyAsAgentScreen extends StatelessWidget {
  static const routeName = '/apply-as-agent';
  const ApplyAsAgentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplyAsAgentCubit _applyAsAgentCubit =
        BlocProvider.of<ApplyAsAgentCubit>(context);
    print("User${context.read<AppBloc>().state.user.uid}");
    // _applyAsAgentCubit.refreshState(context.read<AppBloc>().state.user.uid);
    return Scaffold(
      appBar: customAppBar(
        title: 'Apply as Agent',
        context: context,
        isDrawerEnabled: false,
      ),
      body: SizedBox(
        width: double.infinity,
        height: size(context).height,
        child: SingleChildScrollView(
          child: BlocConsumer<ApplyAsAgentCubit, ApplyAsAgentState>(
            listener: (context, state) {
              if (state.status == Status.error) {
                customSnackbar(
                    context: context,
                    isError: true,
                    message: state.errorMessage);
              } else if (state.status == Status.success) {
                customSnackbar(
                  context: context,
                  isError: false,
                  message: state.successMessage,
                );
              } else if (state.status == Status.noNetwork) {
                customSnackbar(
                  context: context,
                  isError: true,
                  message: state.errorMessage,
                );
              }
            },
            builder: (context, state) {
              return state.isApplied
                  ? Padding(
                      padding: EdgeInsets.all(size(context).width * 0.05),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You have already applied as Agent",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: size(context).height * 0.05,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Full Name: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  state.agent.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Address: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  state.agent.address,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Phone Number: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  state.agent.phone,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                            const Text("Document"),
                            Text(
                              "Is Verified: ${state.agent.isVerified.toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),

                            Padding(
                              padding:
                                  EdgeInsets.all(size(context).width * 0.35),
                              child: TextButton(
                                  onPressed: () {
                                    _applyAsAgentCubit.refreshState(
                                      context.read<AppBloc>().state.user.uid,
                                    );
                                  },
                                  child: const Text("Refresh")),
                            )
                            // Image.network("$serverUrl/${state.owner.documentUrl[0]}"),
                          ]),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: size(context).height * 0.04,
                        ),
                        StreamBuilder<bool>(
                          stream: _applyAsAgentCubit.isFullNameValid,
                          builder: (context, snapshot) {
                            return CustomTextFormField(
                              icon: Icons.account_circle_rounded,
                              onChanged: _applyAsAgentCubit.fullNameChanged,
                              hintText: "Enter your full name",
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : "",
                            );
                          },
                        ),
                        SizedBox(
                          height: size(context).height * 0.02,
                        ),
                        StreamBuilder<bool>(
                            stream: _applyAsAgentCubit.isAddressValid,
                            builder: (context, snapshot) {
                              return CustomTextFormField(
                                icon: Icons.location_city,
                                onChanged: _applyAsAgentCubit.addressChanged,
                                hintText: "Enter your address",
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : '',
                              );
                            }),
                        SizedBox(
                          height: size(context).height * 0.02,
                        ),
                        StreamBuilder<bool>(
                            stream: _applyAsAgentCubit.isPhoneValid,
                            builder: (context, snapshot) {
                              return CustomTextFormField(
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'))
                                ],
                                icon: Icons.phone,
                                onChanged:
                                    _applyAsAgentCubit.phoneNumberChanged,
                                hintText: "Enter your phone number",
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : '',
                              );
                            }),
                        SizedBox(
                          height: size(context).height * 0.02,
                        ),
                        DocumentSubmit(
                          onImageUploaded: (List<String> path) {
                            _applyAsAgentCubit.documentUrlChanged(path);
                          },
                        ),
                        SizedBox(
                          height: size(context).height * 0.04,
                        ),
                        StreamBuilder<bool>(
                          stream: _applyAsAgentCubit.isApplyFormValid,
                          builder: (context, snapshot) {
                            return state.status == Status.loading
                                ? const CircularProgressIndicator()
                                : CustomButton(
                                    onPressed: () {
                                      _applyAsAgentCubit.applyAsAgent(context
                                          .read<AppBloc>()
                                          .state
                                          .user
                                          .uid);
                                    },
                                    label: "Apply",
                                    disable: snapshot.hasError ? true : false,
                                  );
                          },
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
