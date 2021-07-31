

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:untitled2/service/universal/cubit/universal_cubit.dart';
import 'package:untitled2/service/universal/universal_repository.dart';
import 'package:untitled2/widgets/appbar_widget.dart';

class UniversalPage extends StatefulWidget{
  UniversalPage({
    Key key,
    @required this.productSlug,
  }) : super(key: key);

  final String productSlug;

  @override
  _UniversalPagePageState createState() => _UniversalPagePageState();
}

class _UniversalPagePageState extends State<UniversalPage>{
  var productRepository = UniversalRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UniversalCubit>(
        create: (context) =>
        UniversalCubit(productRepository)..getById(widget.productSlug),
        child: Scaffold(
          appBar: CustomAppBar(backButton: true,isSearch: false,),
          body:
          BlocBuilder<UniversalCubit, UniversalState>(builder: (context, state){
            if (state is UniversalInitial || state is UniversalLoadingState){
              return Center(child: CircularProgressIndicator(),);
            }else if(state is UniversalLoadedState){
           print("html="+json.decode(state.list)['page']['content'].toString());

            //  return Center(child: CircularProgressIndicator(),);
              return  ListView(
                children: [
                  Html(
                    data: """ <div> ${json.decode(state.list)['page']['content']} </div> """,
                  )
                ],
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
          ),
        )
    );
  }

}