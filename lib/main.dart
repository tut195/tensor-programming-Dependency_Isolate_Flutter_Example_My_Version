import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'injector.dart';
import 'model.dart';

void main() {
  Injector.configure(RepoType.PROD);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Injector injector;

  @override
  void initState() {
    injector = Injector();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DI and IsolateDemo'),
      ),
      body: FutureBuilder<List<Photo>>(
        future: injector.photoRepo.fetchPhotos(http.Client()),
        builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          return snapshot.hasData ? PhotoGrid(photos: snapshot.data) : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotoGrid extends StatelessWidget {
  final List<Photo> photos;

  const PhotoGrid({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: photos.length,
        itemBuilder: (BuildContext context, int index) => Image.network(photos[index].url));
  }
}
