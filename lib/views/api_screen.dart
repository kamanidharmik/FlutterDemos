import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiDemo extends StatefulWidget {
  ApiDemo({super.key});

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  late Map mapresponse;
  List data = [];

  getdatafrominternet() async {
    final response =
        await http.get(Uri.parse("https://randomuser.me/api/?results=20"));
    if (response.statusCode == 200) {
      setState(() {
        mapresponse = json.decode(response.body);
        data = mapresponse['results'];
      });
    } else {
      throw Exception("Data No Found");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdatafrominternet();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: data.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading:
                                Image.network(data[index]['picture']['medium']),
                            title: Text(
                                "${data[index]['name']['title'].toString()} ${data[index]['name']['first'].toString()} ${data[index]['name']['last'].toString()}"),
                            subtitle: Text(data[index]['email'].toString()),
                          );
                        },
                      ),
                    )),
          Text("data")
        ],
      ),
    );
  }
}


// @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: GetBuilder(
//             builder: (controller) {
//               return data.isEmpty
//                   ? const CircularProgressIndicator()
//                   : ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: data.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           leading:
//                               Image.network(data[index]['picture']['medium']),
//                           title: Text(
//                               "${data[index]['name']['title'].toString()} ${data[index]['name']['first'].toString()} ${data[index]['name']['last'].toString()}"),
//                           subtitle: Text(data[index]['email'].toString()),
//                         );
//                       },
//                     );
//             },
//           ),
//         ),
//         Text("data")
//       ],
//     );
//   }
// }
