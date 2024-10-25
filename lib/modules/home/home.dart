
import 'package:flutter/material.dart';
import 'package:online/modules/auth/login_screen.dart';
import 'package:online/modules/auth/sign-up.dart';
import 'package:online/widgets/footer_widget.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool loading = false;

  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff176daa),
      body: !loading
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(), // Takes up remaining space
                        Icon(Icons.more_vert, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Higher Education Department's",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 170),

                  // Centering the logo and text
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const Image(
                              image: AssetImage('assets/logo.png'),
                              height: 88,
                              width: 88,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Secure and Smart Online Attendance System",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        // Center the buttons
                        // buildButton(
                        //   context,
                        //   'LOGIN',
                        //   Colors.white,
                        //   Colors.blueAccent,
                        //   Icons.login,
                        //       () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             const LoginPage(), // Replace with your SignUp screen
                        //       ),
                        //     );
                        //   },
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginPage(), // Replace with your SignUp screen
                              ),
                            );
                          },
                          child: const Text('LOGIN'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // buildButton(
                        //   context,
                        //   'SIGN UP',
                        //   Colors.blueAccent,
                        //   Colors.white,
                        //   Icons.person_add,
                        //       () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             SignUp(), // Replace with your SignUp screen
                        //       ),
                        //     );
                        //   },
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SignUp(), // Replace with your SignUp screen
                              ),
                            );
                          },
                          child: const Text('SIGN UP'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomSheet: FooterWidget(),
    );
  }
}
