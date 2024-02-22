
import 'package:aid_humanity/Features/donation_details/presentaion/widgets/choose_item_wigdet.dart';
import 'package:flutter/material.dart';

class BabiesItemsItem extends StatelessWidget {
  const BabiesItemsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 25,
      ),
      children: [
        ChooseItemWidget(
          path:
              "lib/core/utils/assets_images/babies clothes/clothing-sets-0-24m-autumn-infant-baby-girls.jpg",
          title: "Suit",
          season: "Winter",
        ),
        ChooseItemWidget(
          path:
              "lib/core/utils/assets_images/babies clothes/crochet-scarf-for-child-free-pattern-768x768.jpg",
          title: "Scarf",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/OIP (1).jpeg",
          title: "Jump suit",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/OIP (2).jpeg",
          title: "Shoes",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/OIP (3).jpeg",
          title: "Jumpsuit",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/OIP (4).jpeg",
          title: "trouser",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/OIP (5).jpeg",
          title: "Scarf and hat",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/R (1).jpeg",
          title: "Closed Trouser",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/R (2).jpeg",
          title: "IceCap",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/R (3).jpeg",
          title: "Hat",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/R (4).jpeg",
          title: "Jacket",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/R (5).jpeg",
          title: "casual shoes",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/babies clothes/R.jpeg",
          title: "Tshirt",
          season: "Summer",
        ),
        ChooseItemWidget(
          path:
              "lib/core/utils/assets_images/babies clothes/tender-Babies-Baby-Clothing-2018-New-Newborn-Baby-Boy-Girl-Romper-Clothes-Long-Sleeve-Infant.webp",
          title: "fur jumpsuit",
          season: "Winter",
        ),
      ],
    );
  }
}
