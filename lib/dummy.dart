import 'package:flutter/material.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({super.key});

  @override
  State<DummyPage> createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 937,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 44,
            child: Container(
              width: 375,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [],
                    ),
                  ),
                  const SizedBox(width: 291),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 2),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 17,
            top: 270,
            child: Container(
              height: 153,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 342,
                    height: 153,
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFE6E6E6)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x14141414),
                          blurRadius: 24,
                          offset: Offset(0, 1),
                          spreadRadius: 8,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 120,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://via.placeholder.com/90x120"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 77,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Green Chilli',
                                    style: TextStyle(
                                      color: Color(0xFF414042),
                                      fontSize: 18,
                                      fontFamily: 'Epilogue',
                                      fontWeight: FontWeight.w700,
                                      height: 0.06,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'Cafeteria | All types of food \navailable\n',
                                          style: TextStyle(
                                            color: Color(0xFF414042),
                                            fontSize: 14,
                                            fontFamily: 'Epilogue',
                                            fontWeight: FontWeight.w400,
                                            height: 0.10,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '9:30 am to 8:00 pm',
                                          style: TextStyle(
                                            color: Color(0xFF414042),
                                            fontSize: 14,
                                            fontFamily: 'Epilogue',
                                            fontWeight: FontWeight.w700,
                                            height: 0.10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 375,
              height: 44,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 30,
                    top: 16,
                    child: Text(
                      '9:41',
                      style: TextStyle(
                        color: Color(0xFF141414),
                        fontSize: 16,
                        fontFamily: 'Epilogue',
                        fontWeight: FontWeight.w500,
                        height: 0.06,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 288,
                    top: 20.50,
                    child: Container(
                      width: 18,
                      height: 10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/18x10"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 311,
                    top: 19,
                    child: Container(
                      width: 15.27,
                      height: 10.97,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/15x11"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 332,
                    top: 18,
                    child: Container(
                      width: 26.98,
                      height: 13,
                      child: Stack(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 1,
            top: 863,
            child: Container(
              width: 375,
              height: 74,
              child: Stack(
                children: [
                  Positioned(
                    left: 98,
                    top: 25,
                    child: Container(width: 26, height: 28, child: Stack()),
                  ),
                  Positioned(
                    left: 23,
                    top: 24,
                    child: Container(width: 28, height: 27, child: Stack()),
                  ),
                  Positioned(
                    left: 324,
                    top: 23,
                    child: Container(
                      width: 28,
                      height: 28,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 1,
                            top: 2,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 3),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 189,
                    top: 15,
                    child: Container(
                      width: 14.56,
                      height: 17.24,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 4.18,
                            top: 2.24,
                            child: Text(
                              '4',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 251,
                    top: 27,
                    child: Container(width: 26, height: 26, child: Stack()),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 105,
            child: SizedBox(
              width: 330,
              child: Text(
                'From where would you like to order?',
                style: TextStyle(
                  color: Color(0xFF313642),
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 0.04,
                ),
              ),
            ),
          ),
          Positioned(
            left: 25,
            top: 194,
            child: Container(
              width: 325,
              height: 51,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 256,
                      height: 51,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 256,
                              height: 51,
                              decoration: ShapeDecoration(
                                color: Color(0xFFFBFCFC),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFFEFEFEF)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 18,
                            top: 17,
                            child: Container(
                              width: 140,
                              height: 21,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 26,
                                    top: 0,
                                    child: Text(
                                      'Search Canteen',
                                      style: TextStyle(
                                        color: Color(0xFF9A9FB3),
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 274,
                    top: 0,
                    child: Container(
                      width: 51,
                      height: 51,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 51,
                              height: 51,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x7FE9EDF2),
                                    blurRadius: 30,
                                    offset: Offset(0, 15),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            top: 35,
                            child: Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 0.0)
                                ..rotateZ(-1.57),
                              child: Container(
                                width: 18,
                                height: 18.28,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Transform(
                                        transform: Matrix4.identity()
                                          ..translate(0.0, 0.0)
                                          ..rotateZ(-1.57),
                                        child: Container(
                                          width: 6,
                                          height: 18.28,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 18.28,
                                                top: -2.88,
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(0.0, 0.0)
                                                    ..rotateZ(1.57),
                                                  child: Container(
                                                      height: 18.28,
                                                      child: Stack()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 18.28,
                                      top: -18,
                                      child: Transform(
                                        transform: Matrix4.identity()
                                          ..translate(0.0, 0.0)
                                          ..rotateZ(1.57),
                                        child: Container(
                                          width: 6,
                                          height: 18.28,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: -18.28,
                                                top: 2.88,
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(0.0, 0.0)
                                                    ..rotateZ(-1.57),
                                                  child: Container(
                                                      height: 18.28,
                                                      child: Stack()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
