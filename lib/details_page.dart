import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/circle_button.dart';
import 'package:myapp/colors.dart';

const price = 0.39;

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int numberOfCandles = 1;

  @override
  Widget build(BuildContext context) {
    handleIncreaseNumberOfCandles() {
      setState(() {
        numberOfCandles++;
      });
    }

    handleDecreaseNumberOfCandles() {
      setState(() {
        numberOfCandles--;
        if (numberOfCandles < 1) {
          numberOfCandles = 1;
        }
      });
    }

    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: purple,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Watermelon Candle',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white, fontSize: 24)),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset('images/candle.svg', height: 290),
                    Positioned(
                        top: 20, 
                        right: -20,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              'images/ornament.svg',
                              height: 80,
                            ),
                            const Text(
                              '€ 0,39',
                              style: TextStyle(
                                  color: purple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ))
                  ],
                ),
                const Text(
                    "This candle is as tasty as beautiful. it's digital watermelon aroma reaches out to yo uwithin your imagination as soon as you lit it! Definitely the best pick for a hot summer afternoon.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white, fontSize: 12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleButton(
                        onTap: handleDecreaseNumberOfCandles,
                        image: 'images/symbol_minus.svg'),
                    SizedBox(
                      width: 120,
                      child: Text('$numberOfCandles',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: white, fontSize: 28)),
                    ),
                    CircleButton(
                        onTap: handleIncreaseNumberOfCandles,
                        image: 'images/symbol_plus.svg'),
                  ],
                ),
                const Text("Anyone with at least 5 will get a Superblo!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white, fontSize: 11)),
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (_) => Container(
                              width: double.infinity,
                              height: 100,
                              padding: const EdgeInsets.all(12),
                              color: purpleLight,
                              child: Center(
                                child: Text(
                                  buildModalText(numberOfCandles),
                                  style: const TextStyle(
                                      color: white, fontSize: 20),
                                ),
                              ),
                            ));
                    setState(() {
                      numberOfCandles = 1;
                    });
                  },
                  child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 10),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: purpleLight,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        buildButtonText(numberOfCandles),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ],
            ),
          )),
    );
  }

  String buildButtonText(int numberOfCandles) {
    final total = numberOfCandles * price;
    return 'BUY $numberOfCandles FOR € ${total.toStringAsFixed(2)}';
  }

  String buildModalText(int numberOfCandles) {
    final total = numberOfCandles * price;
    return 'You bought $numberOfCandles candles for € ${total.toStringAsFixed(2)}';
  }
}
