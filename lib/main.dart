import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MainAp());
}

class MainAp extends StatelessWidget {
  const MainAp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //instead of using string for icons, I will use FontAwesomeIcons
  //I could use list of image instead of FontAwesomeIcons
  //but I will use FontAwesomeIcons for simplicity
  //here is the list of images
  //final List<image> choices = [
  //  'assets/images/rock.png', 'assets/images/paper.png', 'assets/images/scissors.png']
  final List<IconData> choices = [
    FontAwesomeIcons.solidHandScissors,
    FontAwesomeIcons.solidHand,
    FontAwesomeIcons.handFist,
  ];
  int userScore = 0;
  int computerScore = 0;
  int draw = 0;
  IconData userchoice = Icons.question_mark;
  IconData computerchoice = Icons.question_mark;
  String result = '';

  void playGame(int userIndex) {
    setState(() {
      userchoice = choices[userIndex];
      int computerIndex = Random().nextInt(3);
      computerchoice = choices[computerIndex];
      if (userIndex == computerIndex) {
        result = 'draw!';
        draw++;
      } else if ((userIndex == 0 && computerIndex == 1) ||
          (userIndex == 1 && computerIndex == 2) ||
          (userIndex == 2 && computerIndex == 0)) {
        result = 'You win!';
        userScore++;
      } else {
        computerScore++;
        result = 'You lose!';
      }
    });
  }

  void resetGame() {
    setState(() {
      userScore = 0;
      computerScore = 0;
      draw = 0;
      userchoice = Icons.question_mark;
      computerchoice = Icons.question_mark;
      result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              const Color.fromARGB(204, 104, 58, 183),
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Let's play rock paper scissors",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(userchoice, size: 30, color: Colors.red),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Computer: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(computerchoice, size: 30, color: Colors.red),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //here I used List.generate to create a list of 3 icons
                children: List.generate(3, (index) {
                  return GestureDetector(
                    onTap: () {
                      playGame(index);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(choices[index], size: 30, color: Colors.red),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Text(
                result,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Your score: $userScore   Computer score: $computerScore    draw: $draw',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 30),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  size: 40,
                  color: Colors.red,
                  weight: 20,
                ),
                onPressed: () {
                  resetGame();
                },
              ),
              Text(
                'Click To Reset The Game',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
