import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/auth/models/user.dart';
import 'package:mybookstore/employee/controller.dart';
import 'package:mybookstore/employee/models/employee.dart';
import 'package:mybookstore/profile/widgets/profile_avatar.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({super.key});

  EmployeeController get controller => EmployeeController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Employee>>(
          future: controller.loadEmployees(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            final employees = snapshot.data ?? [];
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16.0,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Funcionários',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 32.0,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    for (final employee in employees)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              spacing: 16.0,
                              children: [
                                ProfileAvatar(
                                  user: User(
                                    id: employee.id,
                                    name: employee.username,
                                    photo: employee.photo,
                                    email: 'Employee',
                                  ),
                                  radius: 20,
                                ),
                                Text(
                                  employee.name,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    letterSpacing: 0.25,
                                    color: bodyColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Positioned(
                  bottom: 72,
                  right: 16,
                  child: InkWell(
                    onTap: () async {
                      // await goTo(context, ProfileEditPage());
                      // setState(() {});
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: Ink(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: lineColor, width: 2.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          plusIconImage,
                          color: Colors.white,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
