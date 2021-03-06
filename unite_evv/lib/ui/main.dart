/*
  This file  contains the code for the intiial app screen that oAuths to CMS BlueButton API,
  Intitates the Auth Widget for oAuth2 Authentication

  This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
    
*/

import 'package:flutter/material.dart';
import 'widgets/security/auth.dart';
import 'widgets/care/care_list.dart';
import 'widgets/care/banner.dart';
import 'widgets/care/banner.dart';

void main() {
  initApp();
  runApp(new MaterialApp(
//    home: new AuthWidget()

  home: new CareList2()
  ));
}

initApp() {
  //populatePatientList();
  createBlankPatientList();
}