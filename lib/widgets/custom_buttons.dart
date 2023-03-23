import 'package:flutter/material.dart';

class FavRed extends StatefulWidget {
  const FavRed({Key? key}) : super(key: key);

  @override
  _FavRedState createState() => _FavRedState();
}

class _FavRedState extends State<FavRed> {
  bool liked = false;
  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Add to favorites',
        icon: Icon(liked ? Icons.favorite : Icons.favorite_outline),
        color: Theme.of(context).colorScheme.tertiary,
        iconSize: 18,
        onPressed: () => _pressed());
  }
}
