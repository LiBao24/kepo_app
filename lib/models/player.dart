import 'dart:convert';

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
  Data data;

  Player({
    required this.data,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String firstName;
  String lastName;
  String position;
  String? height;
  String? weight;
  String? jerseyNumber;
  String? college;
  String country;
  int? draftYear;
  int? draftRound;
  int? draftNumber;
  Team team;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    this.height,
    this.weight,
    this.jerseyNumber,
    this.college,
    required this.country,
    this.draftYear,
    this.draftRound,
    this.draftNumber,
    required this.team,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        position: json["position"],
        height: json["height"],
        weight: json["weight"],
        jerseyNumber: json["jersey_number"],
        college: json["college"],
        country: json["country"],
        draftYear: json["draft_year"] as int? ?? 0,
        draftRound: json["draft_round"] as int? ?? 0,
        draftNumber: json["draft_number"] as int? ?? 0,
        team: Team.fromJson(json["team"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "position": position,
        "height": height,
        "weight": weight,
        "jersey_number": jerseyNumber,
        "college": college,
        "country": country,
        "draft_year": draftYear,
        "draft_round": draftRound,
        "draft_number": draftNumber,
        "team": team.toJson(),
      };
}

class Team {
  int id;
  String conference;
  String division;
  String city;
  String name;
  String fullName;
  String abbreviation;

  Team({
    required this.id,
    required this.conference,
    required this.division,
    required this.city,
    required this.name,
    required this.fullName,
    required this.abbreviation,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        conference: json["conference"],
        division: json["division"],
        city: json["city"],
        name: json["name"],
        fullName: json["full_name"],
        abbreviation: json["abbreviation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conference": conference,
        "division": division,
        "city": city,
        "name": name,
        "full_name": fullName,
        "abbreviation": abbreviation,
      };
}
