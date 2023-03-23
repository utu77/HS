import 'package:intl/intl.dart';
import 'package:demo_project/homeModel.dart';
import 'package:flutter/material.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketTask extends StatefulWidget {
  const WebSocketTask({super.key});

  @override
  State<WebSocketTask> createState() => _WebSocketTaskState();
}

class _WebSocketTaskState extends State<WebSocketTask> {
  List<Model> datas = [];

  @override
  void initState() {
    super.initState();
    // sliptedFun();
  }

  //api call
  WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://207.154.227.183:8888/ws?account_id=3&group=*&pair=*'),
  );

  // void sliptedFun() {
  //   channel.stream.listen((message) {
  //     spplited = message.split(",");
  //     homedata.addAll(spplited);
  //     // list.add(spplited);
  //     // print(list[1]);
  //     //   setState(() {});
  //     print("Spplited Data : ${spplited}");
  //     // print("Split list : ${join}");
  //     print("Main List : ${homedata}");
  //     // });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Currencies Prices Data "),
        ),
        body: SafeArea(
            child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     onChanged: (value) {
            //       SearchName(value);
            //     },
            //     //controller: editingController,
            //     decoration: InputDecoration(
            //         labelText: "Search",
            //         hintText: "Search",
            //         prefixIcon: Icon(Icons.search),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            //   ),
            // ),
            //
            _titleBar(),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )),
                  );
                } else if (snapshot.hasData) {
                  String s = snapshot.data.toString();
                  // "11419468, any,type=AUDJPY@FXCMA0-FX ,bid=90.099,ask=90.103,high=90.523,low=89.992,close=0,open=0,volume=0,newAskFlag=0,newBidFlag=0,sourceTime=1678390578000000000 ,1678379776192549677";

                  List replacedList =
                      s.replaceAll(' ', ",").split(",").toList();

                  //Assign data to model
                  Model m = Model(
                    id: int.parse(replacedList[0]),
                    name: replacedList[1],
                    typeName:
                        replacedList[2].toString().replaceAll('type=', ''),
                    bidPrice: double.parse(
                        replacedList[3].toString().replaceAll('bid=', '')),
                    askPrice: double.parse(
                        replacedList[4].toString().replaceAll('ask=', '')),
                    highPrice: double.parse(
                        replacedList[5].toString().replaceAll('high=', '')),
                    lowPrice: double.parse(
                        replacedList[6].toString().replaceAll('low=', '')),
                    sourceTime: replacedList[12].replaceAll('sourceTime=', ''),
                    sourceTime2: replacedList[13].toString(),
                  );

                  //Add Data To model
                  if (datas.isEmpty) {
                    datas.add(m);
                  } else {
                    if (datas
                        .where((element) => element.typeName == m.typeName)
                        .toList()
                        .isEmpty) {
                      datas.add(m);
                    } else {
                      int ind = datas.indexOf(datas
                          .where((element) => element.typeName == m.typeName)
                          .first);
                      datas[ind] = m;
                    }
                  }

                  // print('datas-->${datas.length}');
                  // datas
                  //     .firstWhere((element) => element.typeName == m.typeName)
                  //     .setid(m.id ?? 1);
                  // datas
                  //     .firstWhere((element) => element.typeName == m.typeName)
                  //     .setbidPrice(m.bidPrice ?? 0);
                  // datas
                  //     .firstWhere((element) => element.typeName == m.typeName)
                  //     .setaskPrice(m.askPrice ?? 0);
                  // datas
                  //     .firstWhere((element) => element.typeName == m.typeName)
                  //     .sethighPrice(m.highPrice ?? 0);
                  // datas
                  //     .firstWhere((element) => element.typeName == m.typeName)
                  //     .setlowPrice(m.lowPrice ?? 0);
                  // datas
                  //     .firstWhere((element) => element.typeName == m.typeName)
                  //     .setsourceTime(m.sourceTime ?? '');
                  // datas
                  //     .firstWhere((element) => element.typeName == m.typeName)
                  //     .setsourceTime2(m.sourceTime2 ?? '');

                  // Display data
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: datas.length,
                      itemBuilder: (context, index) {
                        // print(datas[index].sourceTime);
                        int timestamp =
                            int.parse(datas[index].sourceTime2.toString());
                        DateTime date = DateTime.fromMicrosecondsSinceEpoch(
                            timestamp ~/ 1000);
                        // var inputFormat = DateFormat.yMd().add_jm();
                        String finalDate = DateFormat().format(date);
                        return Column(
                          children: [
                            _mainData(
                                typeName: datas[index].typeName!,
                                bid: datas[index].bidPrice,
                                ask: datas[index].askPrice,
                                low: datas[index].lowPrice,
                                high: datas[index].highPrice,
                                date: finalDate.toString()),
                            Divider()
                          ],
                        );
                      },
                    ),
                  );
                  // print(m.bidPrice);
                  // for (int i = 0; i < replacedList.length; i++) {
                  //   print('Index $i ${replacedList[i]}');

                  //   // if (i == 1) {
                  //   //   List l = replacedList[i].split(' ').toList();
                  //   // }
                  // }
                  // List part1 = s.split(',').toList();
                  // for (int i = 0; i < part1.length; i++) {
                  //   print('Index $i ${part1[i]}');
                  //   if (i == 1) {
                  //     List l = part1[i].split(' ').toList();
                  //   }
                  // }
                  //  List part1= s.split(',').toList();

                  // return Center(
                  //     child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(snapshot.hasData ? '${snapshot.data}' : 'erro'),
                  // )); // ;
                }

                return SizedBox.shrink();
              },
            ),
          ],
        )));
  }

  Widget _titleBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color.fromARGB(255, 26, 83, 129),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Symbol",
              style: TextStyle(
                  color: Color.fromARGB(255, 241, 241, 241),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Bid",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Ask",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainData({
    String? typeName,
    double? bid,
    double? ask,
    double? low,
    double? high,
    String? date,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          left: 18,
          right: 18,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${typeName}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Column(
                    children: [
                      Text(
                        "${bid}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Low : ${low}",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.25,
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Text(
                        "${ask}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "High : ${high}",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "DateTime : ${date}",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
