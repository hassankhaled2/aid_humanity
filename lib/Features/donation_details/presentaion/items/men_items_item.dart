
import 'package:aid_humanity/Features/donation_details/presentaion/widgets/choose_item_wigdet.dart';
import 'package:flutter/material.dart';

class MenItemsItem extends StatelessWidget {
  const MenItemsItem({super.key});

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
              "lib/core/utils/assets_images/Men clothes/Black-leather-jacket-for-men-1.jpg",
          title: "Leather jacket",
          season: "Winter",
        ),
        ChooseItemWidget(
          path:
              "lib/core/utils/assets_images/Men clothes/48c51ff921fa72c298a811545411364e.jpg",
          title: "Tshirt",
          season: "Summer",
        ),
        ChooseItemWidget(
          path:
              "lib/core/utils/assets_images/Men clothes/d2bb70f49d7edf089d59b4f1a168468a--shalwar-kameez.jpg",
          title: "Jalabiya",
          season: "summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/OIP (1).jpeg",
          title: "Sweater",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/OIP (2).jpeg",
          title: "Neck shoes",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/OIP (3).jpeg",
          title: "Milton short",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/OIP (4).jpeg",
          title: "short",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/OIP (10).jpeg",
          title: "Bijama",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/OIP (11).jpeg",
          title: "Home's trouser",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/OIP.jpeg",
          title: "Jacket",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/R (1).jpeg",
          title: "Pumb jacket",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/R (2).jpeg",
          title: "Sweater",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/R (3).jpeg",
          title: "casual shoes",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/R (4).jpeg",
          title: "Shirt",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/R (5).jpeg",
          title: "Formal shoes",
          season: "Summer/Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/R (6).jpeg",
          title: "plezer",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/R (7).jpeg",
          title: "Scarf",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/R (9).jpeg",
          title: "Bijama",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/R.jpeg",
          title: "trousers",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/Men clothes/R.png",
          title: "formal suit",
          season: "Winter/Summer",
        ),
      ],
    );
  }
}
