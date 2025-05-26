import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/route_config.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MAIN")),
      body: Column(
        children: [
          Text("TEST"),
          ElevatedButton(
            onPressed: (){
              context.push(RoutePaths.createTrips.path);
            },
            child: Text("Create Trip"),
          ),
        ],
      ),
    );
  }
}
