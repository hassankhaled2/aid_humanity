import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:aid_humanity/core/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CardDeliverWidget extends StatelessWidget {
  const CardDeliverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column
      (
      children:
      [
        Padding(
          padding:  EdgeInsets.only(left:context.getDefaultSize()*3.4,right:context.getDefaultSize()*3.4 ,bottom:context.getDefaultSize()*1.4 ),
          child: Card(
            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
            elevation: 3,
              child: Column
                (
                children:
                [
                  Container(
                    decoration:BoxDecoration(borderRadius:BorderRadius.circular(18) ),
                    clipBehavior:Clip.antiAliasWithSaveLayer,
                      width: context.getDefaultSize()*40,
                    child:  Image(
                      height:context.getDefaultSize()*13,
                      fit: BoxFit.cover,
                      image:NetworkImage(
"https://wallerassoc.com/wp-content/uploads/iStock-897280394_res-uai-258x117.jpg"                      ),),
                  ),
                 Padding(
                   padding:  EdgeInsets.only(left: context.getDefaultSize()*.9,top: context.getDefaultSize()*.8),
                   child: Row
                     (
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:
                     [
                       Text("ffdfdddd",style:TextStyle(fontWeight:FontWeight.bold,fontSize: context.getDefaultSize()*2.1),overflow: TextOverflow.ellipsis,),
                       SizedBox(width:context.getDefaultSize()*15 ,),
                       Text("20 min ago",style:TextStyle(color:Colors.orange,height: context.getDefaultSize()*.23 ),),


                     ],
                   ),
                 ),
    Padding(
    padding:  EdgeInsets.only(left: context.getDefaultSize()*.9,bottom: context.getDefaultSize()*.6),
       child: Column
          (

          children:
          [
            Row(children:
            [
              Text('fffffffffff'),

            ],)
          ],
        )
    ),
    Padding(
    padding:  EdgeInsets.only(left: context.getDefaultSize()*2,bottom: context.getDefaultSize()*1),
      child:  Row(children:
      [
        Icon(FontAwesomeIcons.arrowUpRightFromSquare,size: 12,color: Colors.grey[600],),
        SizedBox(width: context.getDefaultSize()*1,),
        Text("8 km",style: TextStyle(fontSize:context.getDefaultSize() * 1.7,color: Colors.grey[600]),),
        SizedBox(width: context.getDefaultSize()*11,),
        DefaultElevatedButton(onPressed: ()
        {
          GoRouter.of(context).push(AppRouter.kDeliveryViewDetails);
        }, text: "View Details", radius: 10,height:context.getDefaultSize()*2.85,width:context.getDefaultSize()*14.2 ,)
      ],),
    ),




                ],
              ),

          ),
        ),


      ],
    );
  }
}
