import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_application_5/list_info.dart';
import 'package:flutter_application_5/info.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

List<InfoList> info = [];
late bool isLaoading;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
        MyHomePage.routeName: (context) => const MyHomePage(),
        MyHotelPage.routeName: (context) => const MyHotelPage()
      },
    );
  }
}

late int number;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const String routeName = '/home-list';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyHotelPage extends StatefulWidget {
  const MyHotelPage({Key? key}) : super(key: key);
  static const String routeName = '/hotel-list';
  @override
  State<MyHotelPage> createState() => _MyHotelPageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> addInfo = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  bool hasError = false;
  bool appbarIcon = true;

  getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301'));
      final productData = await json.decode(response.body);
      var list = productData as List<dynamic>;
      info = list.map((e) => InfoList.fromJson(e)).toList();
    } catch (e) {
      setState(() {
        hasError = true;
        print("hasError $hasError");
      });
    }
    setState(() {
      addInfo.clear();

      for (int i = 0; i < info.length.toInt(); i++) {
        if (appbarIcon) {
          addInfo.add(Padding(
              padding: EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                      width: 500,
                      height: 230,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              "assets/images/${info[i].poster}",
                              fit: BoxFit.fill,
                            )),
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3, right: 8),
                    child: ElevatedButton(
                        onPressed: () {
                          print("Container 1 clicked");
                          setState(() {
                            number = i;
                            isLaoading = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHotelPage()));
                        },
                        child: Container(
                          width: 120,
                          height: 35,
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              "Подробнее",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 16, right: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          info[i].name,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ))
                ],
              )));
        } else {
          addInfo.add(Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.asset(
                        "assets/images/${info[i].poster}",
                        height: 100,
                        width: 400,
                        fit: BoxFit.fill,
                      )),
                ),
                Container(
                  color: Colors.white,
                  height: 40,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        info[i].name,
                        maxLines: 2,
                        style: TextStyle(),
                      )),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        print("Container clicked");
                        setState(() {
                          number = i;
                          isLaoading = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHotelPage()));
                      },
                      child: Container(
                        width: 400,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Подробнее",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ))
              ])));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 233, 232, 232),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.format_list_bulleted),
              onPressed: () {
                setState(() {
                  if (!appbarIcon) {
                    appbarIcon = true;
                    getData();
                  }
                  print(appbarIcon);
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: IconButton(
                icon: const Icon(Icons.apps),
                onPressed: () {
                  setState(() {
                    appbarIcon = false;
                    getData();
                    print(appbarIcon);
                  });
                },
              ),
            )
          ],
        ),
        body: hasError
            ? Center(
                child: Text("Error"),
              )
            : appbarIcon
                ? ListView(
                    children: <Widget>[]..addAll(addInfo),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: addInfo.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return addInfo[index];
                        })));
  }
}

class _MyHotelPageState extends State<MyHotelPage> {
  Map<String, dynamic>? infoHotel;
  bool getPressHasError = false;
  getDataDio(String uuid) async {
    try {
      final response =
          await http.get(Uri.parse('https://run.mocky.io/v3/$uuid'));
      infoHotel = jsonDecode(response.body);
      Info.fromJson(infoHotel!);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 233, 232, 232),
        appBar: AppBar(
          title: Text(info[number].name),
        ),
        body: FutureBuilder(
          future: getDataDio(info[number].uuid),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (infoHotel == null) {
                  return Center(child: Text('Контент недоступен'));
                } else {
                  if (infoHotel!.length.toInt() == 1) {
                    print('${infoHotel}');
                    return Center(child: Text('Контент временно недоступен'));
                  } else {
                    return Column(children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                        ),
                        itemCount: infoHotel!['photos'].length,
                        itemBuilder: (context, itemIndex, realIndex) {
                          return Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                  width: 400,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/${infoHotel!['photos'][itemIndex]}"),
                                          fit: BoxFit.cover))));
                        },
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Страна: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        infoHotel!['address']['country']
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Улица: ",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                              infoHotel!['address']['street']
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ))
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Text("Город: ",
                                              style: TextStyle(fontSize: 15)),
                                          Text(
                                              infoHotel!['address']['city']
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ))
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Text("Рейтинг: ",
                                              style: TextStyle(fontSize: 15)),
                                          Text(infoHotel!['rating'].toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ))
                                        ],
                                      )),
                                ],
                              ))),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 30, left: 10),
                            child: Text("Сервисы",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w400)),
                          )),
                      Row(
                        children: [
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 15, left: 10, right: 15),
                              child: Container(
                                  width: 170,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text("Платные",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          width: 170, // constrain height
                                          height: 300,
                                          child: ListView.builder(
                                              itemCount: infoHotel!['services']
                                                      ['paid']
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Column(children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                          infoHotel!['services']
                                                                      ['paid']
                                                                  [index]
                                                              .toString()))
                                                ]);
                                              }),
                                        ),
                                      ),
                                    ],
                                  ))),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 15, left: 10, right: 15),
                              child: Container(
                                  width: 170,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text("Бесплатно",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          width: 170, // constrain height
                                          height: 300,
                                          child: ListView.builder(
                                              itemCount: infoHotel!['services']
                                                      ['free']
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Column(children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                          infoHotel!['services']
                                                                      ['free']
                                                                  [index]
                                                              .toString()))
                                                ]);
                                              }),
                                        ),
                                      ),
                                    ],
                                  ))),
                        ],
                      )
                    ]);
                  }
                }
            }
          },
        ));
  }
}
