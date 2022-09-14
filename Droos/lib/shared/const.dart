
import 'package:flutter/material.dart';

import '../models/user_model.dart';

const blue = Color(0xff6688FF);
const darkText = Color(0xff1F1A3D);
const lightText = Color(0xff999999);
const textFieldColor = Color(0xffF5F6FA);
const borderColor = Color(0xffD9D9D9);

int index = 0 ;
bool changePass =false;

Icon iconVisible =const Icon(Icons.visibility);
Icon iconNotVisible =const Icon(Icons.visibility_off);
String? id;
late UserModel userModel ;

late String malzamaUrl ;