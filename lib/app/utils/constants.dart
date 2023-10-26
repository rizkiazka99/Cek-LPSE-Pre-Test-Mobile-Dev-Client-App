import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:flutter/material.dart';

/* Emulator, Local BE */
const baseUrl = 'http://10.0.2.2:3000/api';
const baseUrlImg = 'http://10.0.2.2:3000/uploads/';

/* Real device, Local BE - Use your own IP Address, make sure your device and server are in the same network
const baseUrl = 'http://192.168.144.101/api';
const baseUrlImg = 'http://192.168.144.101/uploads/';
*/

/* Hosted BE, TBA
const baseUrl = '';
const baseUrlImg = '';
*/

List<BoxShadow> boxShadows = [
  const BoxShadow(
    color: AppColors.shadowColor,
    blurRadius: 12,
    spreadRadius: 0,
    offset: Offset(2, 2)
  )
];

const authBackground = 'assets/img/background.png';
const authClock = 'assets/img/clock.png';
const lightOn = 'assets/img/light-1.png';
const lightOff = 'assets/img/light-2.png';
const errorIllustration = 'assets/img/error.png';
const verifyPasswordIllustration = 'assets/img/verify_password.png';