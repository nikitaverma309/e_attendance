
import 'package:flutter/material.dart';
import 'package:online/sign-up.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          elevation: 0,
          backgroundColor: Colors.transparent,

        ),
        body: !loading
            ? SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10), // Image ko thoda rounded karne ke liye
                          child: Image(
                            image: AssetImage('assets/images/cglogo.png'),

                            height:99,// Set height
                            width:99, // Set width
                            fit: BoxFit.cover, // Crop karne ke liye BoxFit.cover
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            children: [
                              Text(
                                "Secure and Smart Online Attendance System",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 55,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10), // Image ko thoda rounded karne ke liye
                          child: Image(
                            image: AssetImage('assets/logo.png'),

                            height:88,// Set height
                            width:88, // Set width
                            fit: BoxFit.cover, // Crop karne ke liye BoxFit.cover
                          ),
                        ),


                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) => SignIn(),
                                //   ),
                                // );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.1),
                                      blurRadius: 1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 16),
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'LOGIN',
                                      style: TextStyle(color: Color(0xFF0F0BDB)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.login, color: Color(0xFF0F0BDB))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => SignUp(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF0F0BDB),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.1),
                                      blurRadius: 1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 16),
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'SIGN UP',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.person_add, color: Colors.white)
                                  ],
                                ),
                              ),
                            ),
      
      
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
        bottomSheet: Footerwidget(),
      ),
    );
  }
}
