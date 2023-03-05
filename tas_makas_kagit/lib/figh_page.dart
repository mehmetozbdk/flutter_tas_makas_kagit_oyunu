import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tas_makas_kagit/home_page.dart';

final scoreValue = StateProvider<int>((ref) {
  return 0;
});

final computerChoice = StateProvider<String>((ref) {
  return '';
});

class FighPage extends ConsumerWidget {
  const FighPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            score(context),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        '2. Oyuncu',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: selectMovement(),
                    ),
                    const Text(
                      'VS',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: randomMovement(ref)),
                  ],
                ),
                succesState(),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FadeIn(
                            child: const HomePage(),
                          ),
                          // sayfa durmu korunmasın
                          maintainState: false,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Tekarar Oyna',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget succesState() {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer(
            builder: (context, ref, child) {
              //scisor_btn = makas
              //rock_btn = taş
              //paper_btn = kağıt
              if (ref.watch(computerChoice) == 'scisor_btn' &&
                      ref.watch(playerChoice) == 'paper_btn' ||
                  ref.watch(computerChoice) == 'rock_btn' &&
                      ref.watch(playerChoice) == 'scisor_btn' ||
                  ref.watch(computerChoice) == 'paper_btn' &&
                      ref.watch(playerChoice) == 'rock_btn') {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    ref.read(scoreValue.notifier).state -= 1;
                  },
                );
                return const Text(
                  'Kaybettin :(',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                );
              }
              if (ref.watch(playerChoice) == ref.watch(computerChoice)) {
                return const Text(
                  'Berabere :)',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                );
              } else {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    ref.read(scoreValue.notifier).state += 1;
                  },
                );
                return const Text(
                  'Kazandın :)',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                );
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget score(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Score:',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              return Text(
                ref.watch(scoreValue).toString(),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget selectMovement() {
    return Consumer(
      builder: (context, ref, child) {
        var image = ref.watch(playerChoice);
        return Image.asset('assets/images/$image.png');
      },
    );
  }

  Widget randomMovement(WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        var value = ref.read(computerChoice);

        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Image.asset('assets/images/$value.png');
            } else {
              return Image.asset('assets/images/leading.gif');
            }
          },
        );
      },
    );
  }
}
