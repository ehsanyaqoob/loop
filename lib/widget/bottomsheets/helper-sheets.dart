// import 'package:country_picker/country_picker.dart';
// import 'package:nutri/constants/export.dart' hide Country;

// class BottomSheetHelper {
//   static void showPhoneUpdateSheet({
//     required String currentPhone,
//     required String currentCountryCode,
//     required Function(String, String) onUpdate,
//   }) {
//     final TextEditingController phoneController = TextEditingController(
//       text: currentPhone,
//     );
//     final RxString selectedCountryCode = RxString(currentCountryCode);
//     final RxString selectedCountryName = RxString('United States');
//     final RxString selectedCountryFlag = RxString('🇺🇸');

//     Get.bottomSheet(
//       Container(
//         height: Get.height * 0.75,
//         decoration: BoxDecoration(
//           color: kDynamicScaffoldBackground(Get.context!),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(60.0),
//             topRight: Radius.circular(60.0),
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // Handle Bar
//               Container(
//                 padding: const EdgeInsets.only(top: 12, bottom: 8),
//                 child: Center(
//                   child: Container(
//                     width: 80,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: kDynamicIcon(Get.context!).withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//               ),

//               // Header
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 44,
//                       width: 44,
//                       decoration: BoxDecoration(
//                         color: kDynamicPrimary(Get.context!).withOpacity(0.15),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           Assets.phonefilled, // Make sure this asset exists
//                           height: 24,
//                           color: kDynamicPrimary(Get.context!),
//                         ),
//                       ),
//                     ),
//                     12.width,
//                     Expanded(
//                       child: MyText(
//                         text: 'Update Phone Number',
//                         color: kDynamicText(Get.context!),
//                         size: 20,
//                         weight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               16.height,

//               // Content
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       MyText(
//                         text: 'Enter your new phone number',
//                         color: kDynamicText(Get.context!).withOpacity(0.8),
//                         size: 16,
//                       ),
//                       20.height,

//                       // Country Picker
//                       Obx(
//                         () => Bounce(
//                           onTap: () {
//                             showCountryPicker(
//                               context: Get.context!,
//                               showPhoneCode: true,
//                               onSelect: (Country country) {
//                                 selectedCountryCode.value =
//                                     '+${country.phoneCode}';
//                                 selectedCountryName.value = country.name;
//                                 selectedCountryFlag.value = country.flagEmoji;
//                               },
//                               countryListTheme: CountryListThemeData(
//                                 flagSize: 25,
//                                 backgroundColor: kDynamicModalBackground(
//                                   Get.context!,
//                                 ),
//                                 textStyle: TextStyle(
//                                   color: kDynamicText(Get.context!),
//                                 ),
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   topRight: Radius.circular(20),
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: kDynamicBorder(Get.context!)!,
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Row(
//                               children: [
//                                 MyText(
//                                   text: selectedCountryFlag.value,
//                                   size: 24,
//                                 ),
//                                 12.width,
//                                 Expanded(
//                                   child: MyText(
//                                     text: selectedCountryName.value,
//                                     color: kDynamicText(Get.context!),
//                                     size: 16,
//                                   ),
//                                 ),
//                                 MyText(
//                                   text: selectedCountryCode.value,
//                                   color: kDynamicText(Get.context!),
//                                   size: 16,
//                                   weight: FontWeight.w500,
//                                 ),
//                                 8.width,
//                                 Icon(
//                                   Icons.arrow_drop_down,
//                                   color: kDynamicIcon(Get.context!),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       16.height,

//                       // Phone Input
//                       MyTextField(
//                         controller: phoneController,
//                         hint: "Enter phone number",
//                         keyboardType: TextInputType.phone,
//                         prefix: SvgPicture.asset(
//                           Assets.phonefilled,
//                           colorFilter: ColorFilter.mode(
//                             kDynamicIcon(Get.context!),
//                             BlendMode.srcIn,
//                           ),
//                         ),
//                       ),
//                       20.height,

//                       // Info Note
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: kDynamicPrimary(
//                             Get.context!,
//                           )!.withOpacity(0.08),
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: kDynamicPrimary(
//                               Get.context!,
//                             )!.withOpacity(0.2),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 SvgPicture.asset(
//                                   Assets.security, // Use existing security icon
//                                   height: 18,
//                                   color: kDynamicPrimary(Get.context!),
//                                 ),
//                                 8.width,
//                                 MyText(
//                                   text: 'Secure Verification',
//                                   color: kDynamicText(Get.context!),
//                                   size: 14,
//                                   weight: FontWeight.w600,
//                                 ),
//                               ],
//                             ),
//                             8.height,
//                             MyText(
//                               text:
//                                   'We will send a verification code to this number for security purposes.',
//                               color: kDynamicText(
//                                 Get.context!,
//                               )!.withOpacity(0.7),
//                               size: 12,
//                             ),
//                           ],
//                         ),
//                       ),
//                       40.height,
//                     ],
//                   ),
//                 ),
//               ),

//               // Buttons
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: kDynamicScaffoldBackground(Get.context!),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(60.0),
//                     topRight: Radius.circular(60.0),
//                   ),
//                   border: Border(
//                     top: BorderSide(
//                       color: kDynamicBorder(Get.context!)!,
//                       width: 1,
//                     ),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Get.back(),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           side: BorderSide(
//                             color: kDynamicPrimary(
//                               Get.context!,
//                             )!.withOpacity(0.3),
//                           ),
//                         ),
//                         child: MyText(
//                           text: 'Cancel',
//                           color: kDynamicText(Get.context!),
//                           weight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     12.width,
//                     Expanded(
//                       child: MyButton(
//                         onTap: phoneController.text.isEmpty
//                             ? null
//                             : () {
//                                 Get.back();
//                                 onUpdate(
//                                   phoneController.text,
//                                   selectedCountryCode.value,
//                                 );
//                               },
//                         buttonText: 'Update',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       enableDrag: true,
//     );
//   }

//   static void showGenderUpdateSheet({
//     required String currentGender,
//     required Function(String) onUpdate,
//   }) {
//     final RxString selectedGender = RxString(currentGender);

//     Get.bottomSheet(
//       Container(
//         height: Get.height * 0.6,
//         decoration: BoxDecoration(
//           color: kDynamicScaffoldBackground(Get.context!),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(60.0),
//             topRight: Radius.circular(60.0),
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // Handle Bar
//               Container(
//                 padding: const EdgeInsets.only(top: 12, bottom: 8),
//                 child: Center(
//                   child: Container(
//                     width: 80,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: kDynamicIcon(Get.context!).withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//               ),

//               // Header
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 44,
//                       width: 44,
//                       decoration: BoxDecoration(
//                         color: kDynamicPrimary(Get.context!).withOpacity(0.15),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           Assets.personfilled, // Use person icon
//                           height: 24,
//                           color: kDynamicPrimary(Get.context!),
//                         ),
//                       ),
//                     ),
//                     12.width,
//                     Expanded(
//                       child: MyText(
//                         text: 'Select Gender',
//                         color: kDynamicText(Get.context!),
//                         size: 20,
//                         weight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               16.height,

//               // Gender Options
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     children: [
//                       ...['Male', 'Female', 'Other', 'Prefer not to say']
//                           .map(
//                             (gender) => Obx(
//                               () => Bounce(
//                                 onTap: () {
//                                   selectedGender.value = gender;
//                                 },
//                                 child: Container(
//                                   width: double.infinity,
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 20,
//                                     vertical: 18,
//                                   ),
//                                   margin: const EdgeInsets.only(bottom: 12),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(16),
//                                     color: selectedGender.value == gender
//                                         ? kDynamicPrimary(
//                                             Get.context!,
//                                           )!.withOpacity(0.1)
//                                         : kDynamicContainer(Get.context!),
//                                     border: Border.all(
//                                       color: selectedGender.value == gender
//                                           ? kDynamicPrimary(Get.context!)!
//                                           : kDynamicBorder(Get.context!)!,
//                                       width: selectedGender.value == gender
//                                           ? 2
//                                           : 1,
//                                     ),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       MyText(
//                                         text: gender,
//                                         size: 16,
//                                         weight: FontWeight.w500,
//                                         color: kDynamicText(Get.context!),
//                                       ),
//                                       if (selectedGender.value == gender)
//                                         Icon(
//                                           Icons.check_circle,
//                                           color: kDynamicPrimary(Get.context!),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     ],
//                   ),
//                 ),
//               ),

//               // Buttons
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: kDynamicScaffoldBackground(Get.context!),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(60.0),
//                     topRight: Radius.circular(60.0),
//                   ),
//                   border: Border(
//                     top: BorderSide(
//                       color: kDynamicBorder(Get.context!)!,
//                       width: 1,
//                     ),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Get.back(),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           side: BorderSide(
//                             color: kDynamicPrimary(
//                               Get.context!,
//                             )!.withOpacity(0.3),
//                           ),
//                         ),
//                         child: MyText(
//                           text: 'Cancel',
//                           color: kDynamicText(Get.context!),
//                           weight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     12.width,
//                     Expanded(
//                       child: MyButton(
//                         onTap: selectedGender.value.isEmpty
//                             ? null
//                             : () {
//                                 Get.back();
//                                 onUpdate(selectedGender.value);
//                               },
//                         buttonText: 'Save',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       enableDrag: true,
//     );
//   }

//   static void showPrivacySheet({
//     required Function() onAccept,
//     required Function() onLearnMore,
//   }) {
//     // Controller to manage checkbox states
//     final PrivacySheetController controller = Get.put(PrivacySheetController());

//     Get.bottomSheet(
//       Container(
//         height: Get.height * 0.85,
//         decoration: BoxDecoration(
//           color: kDynamicScaffoldBackground(Get.context!),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(60.0),
//             topRight: Radius.circular(60.0),
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // Handle Bar
//               Container(
//                 padding: const EdgeInsets.only(top: 12, bottom: 8),
//                 child: Center(
//                   child: Container(
//                     width: 80,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: kDynamicIcon(Get.context!).withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//               ),

//               // Header
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 44,
//                       width: 44,
//                       decoration: BoxDecoration(
//                         color: kDynamicPrimary(Get.context!).withOpacity(0.15),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           Assets.security,
//                           height: 24,
//                           color: kDynamicPrimary(Get.context!),
//                         ),
//                       ),
//                     ),
//                     12.width,
//                     Expanded(
//                       child: MyText(
//                         text: 'Privacy & Permissions',
//                         color: kDynamicText(Get.context!),
//                         size: 20,
//                         weight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               16.height,

//               // Scrollable Section
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       MyText(
//                         text: 'To provide the best experience, Nutri needs:',
//                         color: kDynamicText(Get.context!).withOpacity(0.8),
//                         size: 16,
//                       ),
//                       20.height,

//                       // Permissions
//                       Obx(
//                         () => CustomCheckbox(
//                           text: "Camera Access",
//                           activeColor: kDynamicPrimary(Get.context!),
//                           inactiveColor: kDynamicBorder(Get.context!),
//                           textColor: kDynamicText(Get.context!),
//                           value: controller.cameraPermission.value,
//                           onChanged: controller.toggleCameraPermission,
//                         ),
//                       ),
//                       12.height,

//                       Obx(
//                         () => CustomCheckbox(
//                           text: "Photo Library Access",
//                           activeColor: kDynamicPrimary(Get.context!),
//                           inactiveColor: kDynamicBorder(Get.context!),
//                           textColor: kDynamicText(Get.context!),
//                           value: controller.photoPermission.value,
//                           onChanged: controller.togglePhotoPermission,
//                         ),
//                       ),
//                       12.height,

//                       Obx(
//                         () => CustomCheckbox(
//                           text: "Notifications",
//                           activeColor: kDynamicPrimary(Get.context!),
//                           inactiveColor: kDynamicBorder(Get.context!),
//                           textColor: kDynamicText(Get.context!),
//                           value: controller.notificationPermission.value,
//                           onChanged: controller.toggleNotificationPermission,
//                         ),
//                       ),
//                       20.height,

//                       // Terms & Conditions
//                       Obx(
//                         () => CustomCheckbox(
//                           text: "I agree to the ".tr,
//                           text2: "Terms & Conditions".tr,
//                           activeColor: kDynamicPrimary(Get.context!),
//                           inactiveColor: kDynamicBorder(Get.context!),
//                           textColor: kDynamicText(Get.context!),
//                           value: controller.agreeToTerms.value,
//                           onChanged: controller.toggleAgreeToTerms,
//                         ),
//                       ),
//                       8.height,
//                       Padding(
//                         padding: const EdgeInsets.only(left: 30.0),
//                         child: MyText(
//                           text:
//                               'By continuing, you agree to our terms and privacy policy',
//                           color: kDynamicText(Get.context!)!.withOpacity(0.6),
//                           size: 12,
//                         ),
//                       ),
//                       20.height,

//                       // Privacy Note
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: kDynamicPrimary(
//                             Get.context!,
//                           )!.withOpacity(0.08),
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: kDynamicPrimary(
//                               Get.context!,
//                             )!.withOpacity(0.2),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 SvgPicture.asset(
//                                   Assets.privacy,
//                                   height: 18,
//                                   color: kDynamicPrimary(Get.context!),
//                                 ),
//                                 8.width,
//                                 MyText(
//                                   text: 'Your Privacy Matters',
//                                   color: kDynamicText(Get.context!),
//                                   size: 14,
//                                   weight: FontWeight.w600,
//                                 ),
//                               ],
//                             ),
//                             8.height,
//                             MyText(
//                               text:
//                                   'We only process food images for nutritional analysis. Your data is never shared with third parties without your consent.',
//                               color: kDynamicText(
//                                 Get.context!,
//                               )!.withOpacity(0.7),
//                               size: 12,
//                             ),
//                           ],
//                         ),
//                       ),
//                       40.height,
//                     ],
//                   ),
//                 ),
//               ),

//               // Buttons
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: kDynamicScaffoldBackground(Get.context!),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(60.0),
//                     topRight: Radius.circular(60.0),
//                   ),
//                   border: Border(
//                     top: BorderSide(
//                       color: kDynamicBorder(Get.context!)!,
//                       width: 1,
//                     ),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: onLearnMore,
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           side: BorderSide(
//                             color: kDynamicPrimary(
//                               Get.context!,
//                             )!.withOpacity(0.3),
//                           ),
//                         ),
//                         child: MyText(
//                           text: 'Learn More',
//                           color: kDynamicText(Get.context!),
//                           weight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     12.width,
//                     Expanded(
//                       child: Obx(
//                         () => MyButton(
//                           onTap: controller.agreeToTerms.value
//                               ? () {
//                                   Get.back();
//                                   onAccept();
//                                 }
//                               : null,
//                           buttonText: 'Accept',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       enableDrag: true,
//     );
//   }

//   static void showLogoutSheet({required Function() onLogout}) {
//     Get.bottomSheet(
//       Container(
//         decoration: BoxDecoration(
//           color: kDynamicCard(Get.context!),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Handle Bar
//               Container(
//                 padding: const EdgeInsets.only(top: 12, bottom: 8),
//                 child: Center(
//                   child: Container(
//                     width: 80,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: kDynamicIcon(Get.context!).withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//               ),

//               // Header
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.red.withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           Assets.delete,
//                           height: 30,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ),
//                     const Gap(16),
//                     MyText(
//                       text: 'Logout',
//                       size: 22,
//                       weight: FontWeight.bold,
//                       color: kDynamicText(Get.context!),
//                     ),
//                     const Gap(8),
//                     MyText(
//                       text: 'Are you sure you want to logout?',
//                       size: 16,
//                       color: kDynamicSubtitleText(Get.context!),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),

//               // Buttons
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Get.back(),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           side: BorderSide(
//                             color: kDynamicBorder(Get.context!)!,
//                           ),
//                         ),
//                         child: MyText(
//                           text: 'Cancel',
//                           color: kDynamicText(Get.context!),
//                           weight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     const Gap(12),
//                     Expanded(
//                       child: MyButton(
//                         onTap: () {
//                           Get.back(); // Close the bottom sheet
//                           _showNutriLoader(
//                             message: 'Logging out...',
//                             onComplete: onLogout,
//                           );
//                         },
//                         buttonText: 'Logout',
//                         backgroundColor: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       enableDrag: true,
//     );
//   }

//   // Image Picker Bottom Sheet with Loader
//   static void showImagePickerSheet({
//     required Function() onCameraTap,
//     required Function() onGalleryTap,
//     required Function() onRemoveTap,
//     bool showRemoveOption = false,
//   }) {
//     Get.bottomSheet(
//       Container(
//         decoration: BoxDecoration(
//           color: kDynamicCard(Get.context!),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Handle Bar
//               Container(
//                 padding: const EdgeInsets.only(top: 12, bottom: 8),
//                 child: Center(
//                   child: Container(
//                     width: 80,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: kDynamicIcon(Get.context!).withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//               ),

//               // Header
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: MyText(
//                   text: 'Change Profile Picture',
//                   size: 18,
//                   weight: FontWeight.bold,
//                   color: kDynamicText(Get.context!),
//                 ),
//               ),

//               // Options
//               Column(
//                 children: [
//                   // Camera Option
//                   ListTile(
//                     onTap: () {
//                       Get.back(); // Close the bottom sheet
//                       _showNutriLoader(
//                         message: 'Opening camera...',
//                         onComplete: onCameraTap,
//                       );
//                     },
//                     leading: Container(
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         color: kDynamicPrimary(Get.context!)!.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           Assets.camera,
//                           height: 20,
//                           color: kDynamicPrimary(Get.context!),
//                         ),
//                       ),
//                     ),
//                     title: MyText(
//                       text: 'Take Photo',
//                       size: 16,
//                       color: kDynamicText(Get.context!),
//                       weight: FontWeight.w500,
//                     ),
//                     trailing: SvgPicture.asset(
//                       Assets.ahead,
//                       height: 16,
//                       color: kDynamicIcon(Get.context!),
//                     ),
//                   ),

//                   // Gallery Option
//                   ListTile(
//                     onTap: () {
//                       Get.back(); // Close the bottom sheet
//                       _showNutriLoader(
//                         message: 'Opening gallery...',
//                         onComplete: onGalleryTap,
//                       );
//                     },
//                     leading: Container(
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         color: kDynamicPrimary(Get.context!)!.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           Assets.gallery,
//                           height: 20,
//                           color: kDynamicPrimary(Get.context!),
//                         ),
//                       ),
//                     ),
//                     title: MyText(
//                       text: 'Choose from Gallery',
//                       size: 16,
//                       color: kDynamicText(Get.context!),
//                       weight: FontWeight.w500,
//                     ),
//                     trailing: SvgPicture.asset(
//                       Assets.ahead,
//                       height: 16,
//                       color: kDynamicIcon(Get.context!),
//                     ),
//                   ),

//                   // Remove Option (only show if there's an existing image)
//                   if (showRemoveOption) ...[
//                     const Divider(height: 1),
//                     ListTile(
//                       onTap: () {
//                         Get.back(); // Close the bottom sheet
//                         _showNutriLoader(
//                           message: 'Removing photo...',
//                           onComplete: onRemoveTap,
//                         );
//                       },
//                       leading: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.red.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: SvgPicture.asset(
//                             Assets.delete,
//                             height: 20,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                       title: MyText(
//                         text: 'Remove Photo',
//                         size: 16,
//                         color: Colors.red,
//                         weight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),

//               const Gap(20),
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       enableDrag: true,
//     );
//   }

//   // Generic NutriLoader Dialog
//   static void _showNutriLoader({
//     required String message,
//     required Function() onComplete,
//     String? subMessage,
//     Duration duration = const Duration(seconds: 2),
//   }) {
//     Get.dialog(
//       WillPopScope(
//         onWillPop: () async => false, // Prevent back button
//         child: Dialog(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           child: Container(
//             padding: const EdgeInsets.all(30),
//             decoration: BoxDecoration(
//               color: kDynamicCard(Get.context!),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // NutriLoader with container
//                 NutriLoader(size: 30, dotSize: 8.0),
//                 const Gap(20),
//                 MyText(
//                   text: message,
//                   size: 16,
//                   weight: FontWeight.w500,
//                   color: kDynamicText(Get.context!),
//                 ),
//                 if (subMessage != null) ...[
//                   const Gap(8),
//                   MyText(
//                     text: subMessage,
//                     size: 14,
//                     color: kDynamicSubtitleText(Get.context!),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//       barrierDismissible: false,
//     );

//     // Execute the action after 2 seconds
//     Future.delayed(duration, () {
//       Get.back(); // Close the loader
//       onComplete(); // Execute the actual function
//     });
//   }

//   // Specific loader methods for different actions
//   static void showLogoutLoader({required Function() onLogout}) {
//     _showNutriLoader(
//       message: 'Logging out...',
//       subMessage: 'Please wait a moment',
//       onComplete: onLogout,
//     );
//   }

//   static void showImageProcessingLoader({required Function() onComplete}) {
//     _showNutriLoader(
//       message: 'Processing image...',
//       subMessage: 'Updating your profile',
//       onComplete: onComplete,
//     );
//   }

//   static void showProfileUpdateLoader({required Function() onComplete}) {
//     _showNutriLoader(message: 'Updating profile...', onComplete: onComplete);
//   }
// }

// class PrivacySheetController extends GetxController {
//   final cameraPermission = true.obs;
//   final photoPermission = true.obs;
//   final notificationPermission = true.obs;
//   final agreeToTerms = false.obs;

//   void toggleCameraPermission(bool value) => cameraPermission.value = value;
//   void togglePhotoPermission(bool value) => photoPermission.value = value;
//   void toggleNotificationPermission(bool value) =>
//       notificationPermission.value = value;
//   void toggleAgreeToTerms(bool value) => agreeToTerms.value = value;

//   @override
//   void onClose() {
//     Get.delete<PrivacySheetController>();
//     super.onClose();
//   }
// }
