import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/family_response.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';
import 'package:medplus/ui/home/home_page_controller.dart';
import 'package:medplus/ui/search/search_page_controller.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/app_snackbar.dart';
import 'package:medplus/widgets/input_form_field.dart';
import 'package:medplus/widgets/radio_button.dart';

class AddMemberDilog extends StatefulWidget {
  final String name;
  final String relation;
  final bool isMale;
  final String familyId;
  const AddMemberDilog({
    Key? key,
    this.familyId = '',
    this.name = '',
    this.relation = '',
    this.isMale = true,
  }) : super(key: key);

  @override
  State<AddMemberDilog> createState() => _AddMemberDilogState();
}

class _AddMemberDilogState extends State<AddMemberDilog> {
  bool isMale = true;
  final nameTextEditingController = TextEditingController();
  final relationTextEditingController = TextEditingController();
  final controller = Get.find<AppPageController>();
  @override
  void initState() {
    super.initState();
    nameTextEditingController.text = widget.name;
    relationTextEditingController.text = widget.relation;
    isMale = widget.isMale;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildCloseButton,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'add_family_member'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Palette.textColor,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Amet minim mollit non deserunt ullamco ',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Palette.textColor,
                ),
              ),
              const SizedBox(height: 23),
              InputFormField(
                controller: nameTextEditingController,
                hint: 'name_req'.tr,
              ),
              const SizedBox(height: 18),
              InputFormField(
                controller: relationTextEditingController,
                hint: 'relation_req'.tr,
              ),
              const SizedBox(height: 25),
              buildRadioBtn,
              const SizedBox(height: 28),
              buildActionButton,
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget get buildCloseButton => Row(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: IconButton(
              onPressed: (() => Get.back()),
              icon: SvgPicture.asset(Assets.ic_close),
              splashRadius: 20,
            ),
          ),
          const SizedBox(width: 4),
        ],
      );

  Widget get buildRadioBtn {
    return Row(
      children: [
        AppRadioButton(
          value: isMale,
          label: 'male'.tr,
          onTap: () => setState(() {
            isMale = !isMale;
          }),
        ),
        const SizedBox(width: 20),
        AppRadioButton(
          value: !isMale,
          label: 'female'.tr,
          onTap: () => setState(() {
            isMale = !isMale;
          }),
        ),
      ],
    );
  }

  Widget get buildActionButton {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'cancel'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  color: Palette.textColor,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 25),
        AppElevatedBtn(
          onPressed: addMember,
          text: widget.familyId.isNotEmpty ? 'update'.tr : 'add_member'.tr,
          textColor: Colors.white,
        ),
      ],
    );
  }

  void addMember() async {
    if (nameTextEditingController.text.isEmpty) {
      AppSnackBar.onSuccess('fill_name'.tr);
      return;
    }
    if (relationTextEditingController.text.isEmpty) {
      AppSnackBar.onSuccess('fill_realtion'.tr);
      return;
    }
    controller.showProgress();
    if (widget.familyId.isEmpty) {
      addFamily();
    } else {
      updateFamily();
    }
  }

  void addFamily() async {
    final service = Get.put(ApiService());

    final apiResponse = await service.addFamily(
      name: nameTextEditingController.text,
      relation: relationTextEditingController.text,
      gender: isMale ? 'male'.tr : 'female'.tr,
    );
    if (apiResponse.success) {
      final data = AddFamily.fromMap(apiResponse.data);
      final homepageData = Get.find<HomePageController>().homePageData;
      Get.put(SearchPageController()).familyNameMap[data.data.id!] =
          data.data.name;
      if (homepageData != null) {
        homepageData.myFamily.add(data.data);
        for (FamilyData f in homepageData.myFamily) {
          print(f.name);
        }
      }
      controller.hideProgress();
      Get.back();
      AppSnackBar.onSuccess('added_succesfully'.tr);
    } else {
      controller.hideProgress();
      AppSnackBar.onError(apiResponse.message);
    }
  }

  void updateFamily() async {
    final service = Get.put(ApiService());

    final apiResponse = await service.updateFamily(
      id: widget.familyId,
      name: nameTextEditingController.text,
      relation: relationTextEditingController.text,
      gender: isMale ? 'male'.tr : 'female'.tr,
    );
    if (apiResponse.success) {
      // final data = AddFamily.fromMap(apiResponse.data);
      final homepageData = Get.find<HomePageController>().homePageData;
      if (homepageData != null && homepageData.myFamily.isNotEmpty) {
        homepageData.myFamily[homepageData.myFamily
                .indexWhere((e) => e.id?.toString() == widget.familyId)] =
            FamilyData(
          id: int.tryParse(widget.familyId),
          user_id: -1,
          relation: relationTextEditingController.text,
          name: nameTextEditingController.text,
          phone: '',
          sex: isMale ? 'male'.tr : 'female'.tr,
          age: -1,
          status: 1,
          created_at: '',
          updated_at: '',
          isSelected: false,
        );
      }

      Get.put(SearchPageController())
              .familyNameMap[int.parse(widget.familyId)] =
          nameTextEditingController.text;
      //     data.data.name;
      // if (homepageData != null) {
      //   homepageData.myFamily.add(data.data);
      //   for (FamilyData f in homepageData.myFamily) {
      //     print(f.name);
      //   }
      // }
      controller.hideProgress();
      Get.back();
      if (widget.familyId.isEmpty) {
        AppSnackBar.onSuccess('added_succesfully'.tr);
      } else {
        AppSnackBar.onSuccess('updated_succesfully'.tr);
      }
    } else {
      controller.hideProgress();
      AppSnackBar.onError(apiResponse.message);
    }
  }
}
