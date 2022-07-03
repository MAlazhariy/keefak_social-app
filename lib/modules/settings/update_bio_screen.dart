import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components/custom_white_text_form.dart';
import 'package:shop_app/shared/components/components/snack_bar.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBioScreen extends StatelessWidget {
  const UpdateBioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bioController = TextEditingController();
    bioController.text = SocialCubit.get(context).userModel!.bio;

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUpdateBioSuccessState) {
          Navigator.pop(context);
          snkBar(
            context: context,
            title: 'updated successfully',
          );
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Update Bio',
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                if (state is SocialUpdateBioLoadingState)
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 11,
                    ),
                    child: LinearProgressIndicator(),
                  ),
                CustomWhiteTextForm(
                  labelText: 'bio',
                  validator: (value) {
                    if(bioController.text == cubit.userModel!.bio){
                      return 'Bio has not been changed';
                    }
                    return null;
                  },
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(
                    IconBroken.Send,
                    size: 20,
                    color: Colors.blueAccent,
                  ),
                ),
                const Spacer(),
                MaterialButton(
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    cubit.updateBio(bioController.text);
                  },
                  color: Colors.blueAccent,
                  // minWidth: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 11,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
