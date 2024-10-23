import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/player.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Player App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlayerPage(),
    );
  }
}

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late Future<Player> player;

  Future<Player> fetchPlayer() async {
    final response = await http.get(
      Uri.parse('https://api.balldontlie.io/v1/players/115'),
      headers: {
        'Authorization': '54a33d13-d204-4f87-9b5d-4abef3c688a6',
      },
    );

    if (response.statusCode == 200) {
      return playerFromJson(response.body);
    } else {
      throw Exception('Failed to load player');
    }
  }

  @override
  void initState() {
    super.initState();
    player = fetchPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Details'),
      ),
      body: Center(
        child: FutureBuilder<Player>(
          future: player,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var playerData = snapshot.data!.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${playerData.firstName} ${playerData.lastName}'),
                  Text('Position: ${playerData.position}'),
                  Text('Team: ${playerData.team.fullName}'),
                  Text('Height: ${playerData.height ?? 'N/A'}'),
                  Text('Weight: ${playerData.weight ?? 'N/A'}'),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
