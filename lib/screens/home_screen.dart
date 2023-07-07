import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/themes/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  List<String> flags = [];
  int currentTimeInSeconds = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  double percent = 1.0;
  bool timerIsStarted = false;

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  void start(int time) {
    setState(() {
      timerIsStarted = !timerIsStarted;
    });

    if (!timerIsStarted && timer != null) {
      stop();
      return;
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTimeInSeconds++;
        time = currentTimeInSeconds;
        hours = ((time / 3600) % 24).floor();
        minutes = ((time % 3600) / 60).floor();
        seconds = (time % 60).floor();
        percent = ((seconds / 60)).clamp(0.0, 1);
      });
    });
  }

  void stop() {
    timer!.cancel();
  }

  void reset() {
    stop();
    timerIsStarted = false;
    flags.clear();
    currentTimeInSeconds = 0;
    percent = 1;
    hours = 0;
    minutes = 0;
    seconds = 0;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              provider.toggleTheme();
            },
            icon: Icon(
              Icons.color_lens_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 340,
                      height: 340,
                      child: CircularProgressIndicator(
                        strokeWidth: 20,
                        value: percent,
                        backgroundColor:
                            const Color.fromARGB(155, 224, 190, 193),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${hours.toString().padLeft(2, "0")} : ",
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${minutes.toString().padLeft(2, "0")} :",
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " ${seconds.toString().padLeft(2, "0")}",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 160,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => setState(() => reset()),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Icon(
                      Icons.restore_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => start(currentTimeInSeconds),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Icon(
                      !timerIsStarted
                          ? Icons.play_arrow_rounded
                          : Icons.stop_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (currentTimeInSeconds >= 5) {
                          currentTimeInSeconds -= 5;
                        } else {
                          currentTimeInSeconds = 0;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Icon(
                      Icons.skip_previous_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
