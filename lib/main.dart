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
  late Future<Player>? player;
  final TextEditingController _controller = TextEditingController();

  Future<Player> fetchPlayer(String playerId) async {
    final response = await http.get(
      Uri.parse('https://api.balldontlie.io/v1/players/$playerId'),
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

  void _searchPlayer() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        player = fetchPlayer(_controller.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Player ID',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _searchPlayer,
              child: const Text('Search Player'),
            ),
            const SizedBox(height: 20),
            FutureBuilder<Player>(
              future: player,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  var playerData = snapshot.data!.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Name: ${playerData.firstName} ${playerData.lastName}'),
                      Text('Position: ${playerData.position}'),
                      Text('Team: ${playerData.team.fullName}'),
                      Text(
                          'Height: ${playerData.height != 0 ? playerData.height : 'N/A'}'),
                      Text(
                          'Weight: ${playerData.weight != 0 ? playerData.weight : 'N/A'}'),
                      Text(
                          'Draft Year: ${playerData.draftYear != 0 ? playerData.draftYear : 'N/A'}'),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
