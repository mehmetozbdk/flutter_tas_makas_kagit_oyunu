import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tas_makas_kagit/figh_page.dart';

final playerChoice = StateProvider<String>((ref) {
  return '';
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
        child: Consumer(
          builder: (context, ref, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                score(context),
                game(ref),
                fighFunction(context, ref),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget fighFunction(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          List<String> imageList = ['rock_btn', 'paper_btn', 'scisor_btn'];
          int randomIndex = Random().nextInt(imageList.length);
          String value = imageList[randomIndex];
          ref.read(computerChoice.notifier).state = value;
          if (ref.watch(playerChoice).isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FadeIn(child: const FighPage()),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text("Lütfen Bir El Haraketi Seçin"),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Kapışmaya başla',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget game(WidgetRef ref) => Column(
        children: [
          const Text(
            'El Hareketini Seç',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Ink(
            child: InkWell(
              hoverColor: Colors.red,
              focusColor: Colors.red,
              onTap: () {
                ref.read(playerChoice.notifier).state = 'paper_btn';
              },
              child: Image.asset('assets/images/paper_btn.png'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                hoverColor: Colors.red,
                focusColor: Colors.red,
                onTap: () {
                  ref.read(playerChoice.notifier).state = 'rock_btn';
                },
                child: Image.asset('assets/images/rock_btn.png'),
              ),
              InkWell(
                hoverColor: Colors.red,
                focusColor: Colors.red,
                onTap: () {
                  ref.read(playerChoice.notifier).state = 'scisor_btn';
                },
                child: Image.asset('assets/images/scisor_btn.png'),
              ),
            ],
          )
        ],
      );

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
        children: const [
          Text(
            'Score:',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '0',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
