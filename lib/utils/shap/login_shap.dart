import 'package:flutter/cupertino.dart';


class TCustomCurvedEdges extends CustomClipper<Path>{

  @override
  bool shouldReclip(covariant CustomClipper<Path>oldClipper){
    return true;
  }

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0,size.height);
    final firstCurve =Offset(0,size.height-12, );
    final lastCurve =Offset(0,size.height-300, );
    path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);
    final secodFirstCurve =Offset(1,size.height-10, );
    final secodLastCurve =Offset(size.width-0,size.height-0, );
    path.quadraticBezierTo(secodFirstCurve.dx, secodFirstCurve.dy, secodLastCurve.dx, secodLastCurve.dy);
    final thirdFirstCurve = Offset(size.width, size.height-20,);
    final thirdLastCurve = Offset(size.width, size.height,);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy, thirdLastCurve.dx, thirdLastCurve.dy);
    path.lineTo(size.width, 2);
    path.close();
    return path;
  }
}



