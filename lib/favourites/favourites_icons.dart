
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivo/favourites/favourites_models.dart';

ValueNotifier<List<String>> allFavoriteIds = ValueNotifier<List<String>>([]);

class IconFavorite extends StatefulWidget {
  const IconFavorite(
      {Key? key,
      this. size = 20,
      required this.destinationId,
      })
      : super(key: key);

  final String destinationId;
  final double  size;

  @override
  State<IconFavorite> createState() => _IconFavoriteState();
}

class _IconFavoriteState extends State<IconFavorite> {
  void favoriteChanger(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context, listen: false);
    if (favoriteModel.favorites.contains(widget.destinationId)) {
      favoriteModel.removeFavorite(widget.destinationId);
    } else {
      favoriteModel.addFavorite(widget.destinationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);

    return InkWell( 
      onTap: () async {
        favoriteChanger(context);
              await favoriteModel.initFavorites(currentUserId);
              setState(() {});
      },
      child: favoriteModel.favorites.contains(widget.destinationId)
          ? Icon(
              Icons.favorite,
              size: widget.size,
              color: Colors.red,
            )
          : Icon(
              Icons.favorite_border,
              color: Colors.grey ,
              size: widget.size,
            ),
    );
  } 
}
