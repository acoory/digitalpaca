import 'package:digitalpaca/navigation/New_drawer.dart';
import 'package:digitalpaca/provider/favories_provider.dart';
import 'package:flutter/material.dart';

class FavorisView extends StatelessWidget {
  const FavorisView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final words = provider.words;
    return Scaffold(
      drawer: NewDrawer(),
      appBar: AppBar(title: const Text("Favories")),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          final word = words[index];
          return ListTile(
            title: Text(word.title),
            trailing: IconButton(
              onPressed: () {
                provider.toggleFavorite(words[index], words[index].id);
              },
              icon: provider.isExist(word)
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border),
            ),
          );
        },
      ),
    );
  }
}
