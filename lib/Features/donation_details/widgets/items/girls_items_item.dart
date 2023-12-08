import 'package:aid_humanity/Features/donation_details/widgets/choose_item_wigdet.dart';
import 'package:flutter/material.dart';

class GirlsItemsItem extends StatelessWidget {
  const GirlsItemsItem({super.key});

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
              "lib/core/utils/assets_images/girls clothes/2016-Fashion-Kids-Summer-Dress-Little-Girls-Clothes-Princess-Girl-Evening-Layered-Dress-Children-s-Clothing.webp",
          title: "Dress",
          season: "Summer",
        ),
        ChooseItemWidget(
          path:
              "lib/core/utils/assets_images/girls clothes/Baby-Girls-White-Dresses-for-Wedding-and-Party-Wear-Girl-Princess-Dress-Kids-Lace-Clothes-Children.webp",
          title: "Dresst",
          season: "Winter",
        ),
        ChooseItemWidget(
          path:
              "lib/core/utils/assets_images/girls clothes/ccea7a6971408643c18c2f0dd8abc5cb.jpg",
          title: "Scraf",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/edb818256b0fc20b31848183152ad790.png",
          title: "Skirt",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/OIP (1).jpeg",
          title: "Tshirt",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/OIP (2).jpeg",
          title: "Blouse",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/OIP (3).jpeg",
          title: "Troures",
          season: "Summer/Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/OIP (4).jpeg",
          title: "Shoes",
          season: "Winter/Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/OIP (5).jpeg",
          title: "Tshirt",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/OIP (6).jpeg",
          title: "Bijama",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/OIP.jpeg",
          title: "Suit",
          season: "Summer",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/R (1).jpeg",
          title: "Jeans Trouser",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/R (2).jpeg",
          title: "Pumb jaacket",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/R (3).jpeg",
          title: "Casual shoes",
          season: "Summer/Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/R (4).jpeg",
          title: "Bijama",
          season: "Winter",
        ),
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/R.jpeg",
          title: "Stretch",
          season: "Winter/Summer",
        ),
       
        ChooseItemWidget(
          path: "lib/core/utils/assets_images/girls clothes/Y9790A6_23SP_BK27_08_02.webp",
          title: "Leather jacket",
          season: "Summer",
        ),
       
      ],
    );
  }
}
