import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/modules/home/home.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    const String imgUrl = 'https://i.imgur.com/wXFHbEN.png';
    return Scaffold(
        backgroundColor: const Color(0xff176daa),
        appBar: AppBar(
          backgroundColor: const Color(0xff176daa),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.offAll(() => const MyHomePage());
            },
          ),
          centerTitle: false,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Hi Nikita Verma",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height / 12,
              ),
              CircleAvatar(
                radius: _width < _height ? _width / 3.5 : _height / 4,
                backgroundImage: const NetworkImage(imgUrl),
              ),
              SizedBox(
                height: _height / 25.0,
              ),
              Text(
                'Nikita Verma',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _width / 15,
                    color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _height / 30, left: _width / 8, right: _width / 8),
                child: Text(
                  'Shift Name \\ ${Strings.shiftName} !  : ${Strings.morning}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: _width / 25,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                  height: _height / 30, color: Colors.white.withOpacity(0.3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '${Strings.inTime}  : ${Strings.morning}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 25,
                        color: Colors.white),
                  ),
                ],
              ),
              Divider(
                  height: _height / 30, color: Colors.white.withOpacity(0.3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '${Strings.outTime}   : ${Strings.morning}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 25,
                        color: Colors.white),
                  ),
                ],
              ),
              Divider(
                  height: _height / 30, color: Colors.white.withOpacity(0.3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '${Strings.responseTime}  \\ Response Time:  11:254',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 25,
                        color: Colors.white),
                  ),
                ],
              ),
              new Divider(
                  height: _height / 30, color: Colors.white.withOpacity(0.3)),
              new Padding(
                padding: EdgeInsets.only(left: _width / 8, right: _width / 8),
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.blue[50],
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //new Icon(Icons.person),
                      //new SizedBox(width: _width/30,),
                      Text('Ok  \\ LOG OUT ')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
