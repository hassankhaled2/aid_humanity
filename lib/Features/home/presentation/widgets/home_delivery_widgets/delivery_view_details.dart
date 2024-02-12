import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';


class DeliveryViewDetails  extends StatelessWidget {
  const DeliveryViewDetails ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: context.getDefaultSize() * 2),
      child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 240,
                  flexibleSpace: FlexibleSpaceBar
                    (
                      
                    title: Text("Hassan Khaled",style: TextStyle(color: Color(0xFFF8B145)),),
                    background: Image.network
                      (


                      "https://img.freepik.com/premium-vector/warehouse-outside-view-warehouse-facade-trucks-forklift-stacks-boxes-city-background_625536-26.jpg?w=1480",
                      fit: BoxFit.fill,

                    ),

                  ),
                  floating: true,
                  pinned: true,

                ),
              ];
            },
            body: Column
              (
              children:
              [
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children:
               [
                 SizedBox(height: 200,),
                 DefaultElevatedButton(onPressed: (){}, text:"Call", radius:10,

                 ),
                 SizedBox(width: 40,),
                 DefaultElevatedButton(onPressed: (){}, text:"Chat", radius:10,
                 ),
               ],
             )
              ],
            )
          )),
 );
  }
}
