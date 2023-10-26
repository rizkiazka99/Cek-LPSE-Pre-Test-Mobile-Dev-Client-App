import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/constants.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_button.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_card.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/profile_picture.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  PreferredSizeWidget appBar(context) {
    Widget username() {
      return Obx(() {
        if (controller.isLoading) {
          return Shimmer(
            width: MediaQuery.of(context).size.width / 2,
            height: 50.h,
          ); 
        } else {
          if (!controller.isError) {
            return Text(
              controller.profileData!.data!.username,
              style: Theme.of(context).textTheme.displayMedium,
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      });
    }

    Widget popupMenu() {
      PopupMenuItem<int> popupMenuItem({
        required int value,
        required IconData icon,
        Color? iconColor,
        required String text
      }) {
        return PopupMenuItem<int>(
          value: value,
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? AppColors.primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(text)
            ],
          )
        );
      }

      return Obx(() {
        if (controller.isLoading) {
          return Shimmer(
            width: 16.w,
            height: 45.h,
          );
        } else {
          if (!controller.isError) {
            return PopupMenuButton<int>(
              onSelected: (item) => controller.handlePopupMenuClick(item),
              itemBuilder: (context) => [
                popupMenuItem(
                  value: 0, 
                  icon: Icons.edit, 
                  text: 'Update Profile'
                ),
                popupMenuItem(
                  value: 1,
                  icon: Icons.logout_outlined,
                  iconColor: AppColors.secondaryColor,
                  text: 'Logout'
                )
              ],
              child: Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: Icon(
                  Icons.more_vert,
                  size: 25.sp,
                )
              )
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      });
    }

    return AppBar(
      title: username(),
      centerTitle: true,
      actions: [
        popupMenu()
      ]
    );
  }

  Widget profilePictureDialog(context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h
      ),
      child: Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: profilePicture(
            imageUrl: controller.profileData!.data!.profilePicture,
            borderRadius: 15
          ),
        ),
      ),
    );
  }

  Widget loadingState(context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        Center(
          child: CircleShimmer(
            width: 150.w,
            height: 150.h,
            verticalMargin: 0,
          )
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Shimmer(
            width: MediaQuery.of(context).size.width / 2,
            height: 25.h,
            verticalMargin: 0,
          ) 
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Shimmer(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 25.h,
            verticalMargin: 0,
          ) 
        ),
        SizedBox(height: 24.h),
        Divider(
          color: AppColors.contextGrey.withOpacity(0.1),
          thickness: 12,
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Shimmer(
            height: 30.h,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 12.h,
              mainAxisSpacing: 12.w
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Shimmer(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 6,
                verticalMargin: 0,
                horizontalMargin: 0,
              );
            }
          ),
        )
      ],
    );
  }

  Widget loadedState(context) {
    Widget userAvatar() {
      return Center(
        child: GestureDetector(
          onTap: () => Get.dialog(profilePictureDialog(context)),
          child: Container(
            height: 150.h,
            width: 150.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.profileData!.data!.profilePicture == 'https://cdn-icons-png.flaticon.com/512/5556/5556468.png'
                    || controller.profileData!.data!.profilePicture == 'https://cdn-icons-png.flaticon.com/512/7127/7127281.png'
                        ? AppColors.primaryColor
                        : Colors.transparent, 
                width: controller.profileData!.data!.profilePicture == 'https://cdn-icons-png.flaticon.com/512/5556/5556468.png'
                    || controller.profileData!.data!.profilePicture == 'https://cdn-icons-png.flaticon.com/512/7127/7127281.png'
                        ? 2
                        : 0
              ),
              shape: BoxShape.circle
            ),
            child: profilePicture(
              imageUrl: controller.profileData!.data!.profilePicture,
              borderRadius: 100
            ),
          ),
        ),
      );
    }

    Widget draggableMenu() {
      return Expanded(
        child: DraggableGridViewBuilder(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 12.h,
            mainAxisSpacing: 12.w
          ),
          children: List.generate(controller.draggableMenuItems.length, (index) {
            return DraggableGridItem(
              isDraggable: true,
              child: GestureDetector(
                onTap: controller.draggableMenuItems[index].onTap,
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        controller.draggableMenuItems[index].icon,
                        color: AppColors.primaryColor,
                        size: 50.sp,
                      ),
                      Text(
                        controller.draggableMenuItems[index].name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ]
                  )
                )
              )
            );
          }
        ),
        dragCompletion: (List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
          debugPrint('onDragAccept: $beforeIndex -> $afterIndex');
        },
        dragFeedback: (List<DraggableGridItem> list, int index) {
          return CustomCard(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 6,
            backgroundColor: Colors.grey.withOpacity(0.1),
            child: const SizedBox.shrink()
          );
        },
        dragPlaceHolder: (List<DraggableGridItem> list, int index) {
          return PlaceHolderWidget(
            child: Container(color: Colors.transparent));
          }
        )
      );
    }

    return Column(
      children: [
        SizedBox(height: 24.h),
        userAvatar(),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            controller.profileData!.data!.id,
            style: Theme.of(context).textTheme.bodySmall
          )
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            controller.profileData!.data!.email,
            style: Theme.of(context).textTheme.bodySmall
          )
        ),
        SizedBox(height: 24.h),
        Divider(
          color: AppColors.contextGrey.withOpacity(0.1),
          thickness: 12,
        ),
        SizedBox(height: 16.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          alignment: Alignment.centerLeft,
          child: Text(
            'Draggable and Adjustable Menu',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ),
        SizedBox(height: 16.h),
        draggableMenu()      
      ],
    );
  }

  errorState(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Image.asset(errorIllustration),
        ),
        SizedBox(height: 8.h),
        Text(
          controller.errorMessage,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(height: 16.h),
        CustomButton(
          onPressed: () => controller.getProfile(),
          buttonSize: Size(
            MediaQuery.of(context).size.width / 2,
            50.h
          ),
          text: 'Reload'
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Obx(() {
        if (controller.isLoading) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: loadingState(context)
              ),
            ),
          );
        } else {
          if (!controller.isError) {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: loadedState(context)
                ),
              ),
            );
          } else {
            return errorState(context);
          }
        }
      })
    );
  }
}
