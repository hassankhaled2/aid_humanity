import 'package:aid_humanity/Features/donation_details/presentaion/widgets/choose_item_wigdet.dart';
import 'package:flutter/material.dart';

class BoysItemsItem extends StatelessWidget {
  const BoysItemsItem({super.key});

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
          path: "lib/core/utils/assets_images/boys clothes/mm.jpeg",
          title: "shirt",
          season: "Summer",
        ),
        ChooseItemWidget(
          path:
              "lib/core/utils/assets_images/boys clothes/Baby-Denim-Shirt-2018-Spring-New-Boys-Kids-Children-Lapel-Tops-YF02.webp",
          title: "Jeans jacket",
          season: "summer/Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/boys clothes/OIP (1).jpeg",
          title: "Pumb jacket",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/boys clothes/OIP (2).jpeg",
          title: "formal shoes",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/boys clothes/OIP (3).jpeg",
          title: "casual shoes",
          season: "Summer/Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/boys clothes/OIP (4).jpeg",
          title: "Tshirt",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/boys clothes/OIP (5).jpeg",
          title: "Tshirt",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/boys clothes/OIP (6).jpeg",
          title: "Bijama",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/boys clothes/OIP (7).jpeg",
          title: "Bijama",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/boys clothes/OIP.jpeg",
          title: "Jeans trouser",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/boys clothes/R (2).jpeg",
          title: "Milton trousers",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/boys clothes/R.jpeg",
          title: "Shirt",
          season: "Winter",
        ),
      ],
    );
  }
}
