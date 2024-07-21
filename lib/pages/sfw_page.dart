// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SFWPage extends StatefulWidget {
  const SFWPage({super.key});

  @override
  _SFWPageState createState() => _SFWPageState();
}

class _SFWPageState extends State<SFWPage> {
  final CardSwiperController controller = CardSwiperController();

  List<Container> cards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWaifuImages();
  }

  Future<void> fetchWaifuImages() async {
    final response = await http.post(
      Uri.parse('https://api.waifu.pics/many/sfw/waifu'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'exclude': []}),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> files = data['files'];
      setState(() {
        cards = files.map((url) {
          return Container(
            alignment: Alignment.center,
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          );
        }).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load waifu images');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
          ? const Center(child: CircularProgressIndicator()):
            Column(
              children: [
                Flexible(
                  child: CardSwiper(
                  controller: controller,
                  cardsCount: cards.length,
                  onSwipe: _onSwipe,
                  onUndo: _onUndo,
                  numberOfCardsDisplayed: 3,
                  padding: const EdgeInsets.all(24.0),
                  cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                  ) =>
                    cards[index],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            onPressed: () => controller.swipe(CardSwiperDirection.left),
                            backgroundColor: Colors.red,
                            shape: const CircleBorder(),
                            child: const Icon(Icons.clear, color: Colors.white),
                          ),
                          FloatingActionButton(
                            onPressed: () => controller.swipe(CardSwiperDirection.right),
                            backgroundColor: Colors.green,
                            shape: const CircleBorder(),
                            child: const Icon(Icons.check, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      FloatingActionButton(
                        onPressed: controller.undo,
                        backgroundColor: Colors.grey,
                        shape: const CircleBorder(),
                        child: const Icon(Icons.rotate_left, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}