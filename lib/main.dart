import 'package:api_stars_assignment/API_pull.dart';
import 'package:api_stars_assignment/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;

void main() {
// getStarWarsPlanets();
  runApp(StarPlanets());
}

//https://swapi.dev/api/planets/
class StarPlanets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

StarPlanetsAPI starPlanetsAPI = StarPlanetsAPI();

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planets"),
        centerTitle: true,
      ),
      body: FutureBuilder<Welcome>(
        future: starPlanetsAPI.getStarWarsPlanets(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(snapshot.data.toString());
          }
          // return Text( snapshot.data!.next );
          return ListView.builder(
            itemCount: snapshot.data!.results.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(snapshot.data!.results[index].name),
              trailing: IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  await canLaunch(snapshot.data!.results[index].url)
                      ? launch(snapshot.data!.results[index].url)
                      : throw "Can't launch ${snapshot.data!.results[index].url}";
                },
              ),
            ),
          );
        },
      ),
    );
  }
// void getStarWarsPlanets() async {
//   var response = await http.get(Uri.https('swapi.dev', 'api/planets/'));
//   if (response.statusCode == 200) {
//     print(response.body);
//   }
// }

}
