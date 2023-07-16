import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivo/helper/size.dart';
// import 'package:trivo/main.dart';
import 'package:trivo/screens/Login_page.dart';
import 'package:trivo/widgets/bottomnavbar.dart';

// ignore: must_be_immutable
class GetStarted extends StatelessWidget {
  GetStarted({super.key, required this.logedin});

  bool logedin;

  check(context) async {
    if (logedin) {
     await Future.delayed(Duration(seconds: 3));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Navbar()));
    } else {
    await  Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    size(context);
    check(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.white
            // image: DecorationImage(
            //     image: AssetImage('assets/getstart.jpg'), fit: BoxFit.cover)
            ),
        child: Align(
          alignment: Alignment(0.0, 0.0),
          child: Column(
            children: [
              SizedBox(
                height: 190,
              ),
              Expanded(
                  child: RiveAnimation.asset(
                'assets/4523-9190-moving-car.riv',
                fit: BoxFit.contain,
              )),
              InkWell(
                onTap: () {},
                child: Text(
                  'Travisor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),
              ),
              Text('The world at your finger tips.'),
              SizedBox(
                height: 12,
              ),
              gap,
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
