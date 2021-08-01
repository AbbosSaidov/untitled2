import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/models/products_response.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/widgets/appbar_widget.dart';
import 'package:untitled2/widgets/product_card_widget.dart';
import 'package:untitled2/widgets/product_cards_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled2/service/filter/cubit/filter_cubit.dart';
import 'package:untitled2/service/filter/filter_repository.dart';

class ProductFilterPage extends StatefulWidget{
  ProductFilterPage({Key key,this.categorySlug,this.isAppbar=true, this.typeOpFilter,
    this.updateCarts, this.named=true}) : super(key: key);

  final String categorySlug;
  final bool isAppbar;
  final bool named;
  final String typeOpFilter;
  final updateCarts;
  @override
  _ProductFilterPageState createState()=>_ProductFilterPageState();
}

class _ProductFilterPageState extends State<ProductFilterPage>{
  String dropdownValue = null;
  String filterValue = '?';
  String mainFilterSlug = '';
  String dropdownValueSlug = 'sort_by=popular';
  final filterRepository = FilterRepository();
  bool type1=false;
  bool _switchValue =false;
  bool isFiltered =false;
  bool _switchValue2=false;
  bool _switchValue3=false;
  bool _switchValue4=false;
  bool _switchValue5=false;
  bool _switchValue6=false;
  RangeValues _currentRangeValues;
  List<List<bool>> _isChecked=[];
  List<bool> _isChecked2=[];
  List<String> list_items=['Популярные', 'Новинки', 'Сначала дешевые', 'Сначала дорогие', 'По уровню скидки'];
  TextEditingController textControllerOt = new TextEditingController();
  TextEditingController textControllerDo = new TextEditingController();
  int rowNumber=3;
  int colorId=-1;
  String brandId="null";
  int scrollL=1;

  @override
  Widget build(BuildContext context){
    return Scaffold(
         appBar: widget.isAppbar? CustomAppBar(backButton: true,):null,
        body: BlocProvider<FilterCubit>(
            create: (context) => _initType(),
            child: BlocBuilder<FilterCubit, FilterState>(
                builder:(context, state){
                  // print("state"+state.runtimeType.toString());
                  if(state is FilterInitial || state is FilterLoadingState){
                    return Center(child: CircularProgressIndicator());
                  }else if(state is FilterLoadedMainState){
                    if(isFiltered){
                      isFiltered=false;
                      context.watch<FilterCubit>().getFilter(
                        widget.typeOpFilter,
                        mainFilterSlug!="" ? mainFilterSlug+filterValue+ dropdownValueSlug:
                        widget.categorySlug+filterValue+dropdownValueSlug,
                      );
                    }
                  //    print("Filter="+json.decode(state.res)['categories']['data'].toString());
                      _currentRangeValues =  RangeValues(json.decode(state.res)['min_price'].toDouble(),
                          json.decode(state.res)['max_price'].toDouble());
                     var data= List<ProductModel>.from(json.decode(state.res)['products']['data'].map((x) => ProductModel.fromMap(x)));
                    return NotificationListener<ScrollEndNotification>(
                        onNotification: (scrollEnd) {
                        //   print(_scrollController.position.pixels);
                        var metrics = scrollEnd.metrics;
                        if (metrics.atEdge) {
                          if (metrics.pixels == 0){
                            print('At top');
                            scrollL=1;
                            setState((){});
                          }else{
                            scrollL=scrollL+1;
                            print('At bottom');
                            setState((){});
                          }
                        }
                        return true;
                      },child:ListView(
                           children:[
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.widgets_outlined),
                                onPressed:(){if(rowNumber>2){rowNumber=1;}else{rowNumber=rowNumber+1;}setState((){});},
                              ),
                            DropdownButton<String>(
                              selectedItemBuilder: (BuildContext context)
                              {
                                return list_items.map<Widget>((String item) {
                                  return Row(children: [Text(item),Icon(Icons.arrow_drop_down_sharp)],);
                                }).toList();
                              },
                              hint:Row(children: [Text("Сортировка"),Icon(Icons.arrow_drop_down_sharp)],),
                                value: dropdownValue,
                                icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                                onTap: (){
                                setState((){});},
                                iconSize: 24,
                                elevation: 16,
                                //style: const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 0,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged:(String newValue){
                                  type1=true;
                                  switch(newValue){
                                    case "Популярные":dropdownValueSlug ="sort_by=popular";break;
                                    case "Новинки":dropdownValueSlug ="sort_by=newest";break;
                                    case "Сначала дешевые":dropdownValueSlug ="sort_by=price-asc";break;
                                    case "Сначала дорогие":dropdownValueSlug ="sort_by=price-desc";break;
                                    case "По уровню скидки":dropdownValueSlug ="sort_by=discount";break;
                                  }
                                  dropdownValue = newValue;
                                  isFiltered=true;
                                  setState((){});
                                },items:
                            list_items.map((String item) {
                              return DropdownMenuItem<String>(
                                child: Text('$item'),
                                value: item,
                              );
                            }).toList(),
                              ),
                              IconButton(
                                icon: Icon(Icons.filter_list),
                                onPressed: (){
                                  showDialogFilter(state);
                                },
                              ),
                            ],
                          ),
                        //       ListView.builder(
                        //    itemCount:data.length == null ? 0 : data.length>scrollL*9? scrollL*9 : data.length,
                        //    shrinkWrap: true,
                        //    physics: ClampingScrollPhysics(),
                        //    //physics: NeverScrollableScrollPhysics(),
                        //    itemBuilder: (BuildContext context, int index) {
                        //      return index==scrollL*9 && scrollL*9<data.length ? Center(child: CircularProgressIndicator(),) :
                        //      Container(
                        //          width: MediaQuery.of(context).size.width / rowNumber,
                        //          child:  ProductCardWidget(
                        //            updateCarts: widget.updateCarts,
                        //            rowNumber: rowNumber,
                        //            //named: widget.named,
                        //            product: data[index],
                        //            isBestSaller: false,
                        //          )
                        //      );
                        //    },
                        //  ),
                      Container(
                        width: double.infinity,
                        child:Wrap(
                          alignment: WrapAlignment.start,
                          children: List.generate(
                            data.length == null ? 0 : data.length>scrollL*20? scrollL*20 : data.length,
                                (index) => Container(
                              width: MediaQuery.of(context).size.width / rowNumber,
                              child: index==scrollL*20-1 && scrollL*20-1<data.length ? Center(child: CircularProgressIndicator(),) :
                              ProductCardWidget(
                                updateCarts: widget.updateCarts,
                                rowNumber: rowNumber,
                                named: widget.named,
                                product: data[index],
                                isBestSaller: false,
                              ),
                            ),
                          ),
                        ),
                      )
                        ],
                      ),);
                    }else{
                    return Center(child: Text("Error"),);
                  }
                }
            )
        )
    );
  }
  FilterCubit _initType(){
    FilterCubit repo = FilterCubit(filterRepository);
    return repo..getFilter(widget.typeOpFilter,widget.categorySlug);
  }
  void showDialogFilter(var state){
    showDialog(
        context: context,
        builder: (BuildContext conte) => AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(
                    Radius.circular(10.0))),
            content:  StatefulBuilder(
                builder: (BuildContext context, StateSetter setState2){
                  return Container(
                      width : MediaQuery.of(context).size.width*8/9,
                      height : MediaQuery.of(context).size.height*7/9,
                      child: Column(
                        children: [
                          Flexible(
                            child: Container(
                                height:MediaQuery.of(context).size.height*6.1/9 ,
                                child: ListView(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: json.decode(state.res)['categories']['data'].length,
                                        itemBuilder: (context, index2){
                                          return ExpansionTile(
                                            title: CheckboxListTile(
                                              title:Text(json.decode(state.res)['categories']['data'][index2]['name'].toString()) ,
                                              value: mainFilterSlug ==json.decode(state.res)['categories']['data'][index2]['slug'].toString() ? true : false,
                                              onChanged: (bool value){
                                                mainFilterSlug =json.decode(state.res)['categories']['data'][index2]['slug'].toString();
                                                setState2(() {});
                                              },
                                            ),
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: json.decode(state.res)['categories']['data'][index2]['children']['data'].length,
                                                  itemBuilder: (context, index3){
                                                    return ExpansionTile(
                                                      title: CheckboxListTile(
                                                        title:Row(
                                                          children: [
                                                            Container(width: 10,),
                                                            Text(json.decode(state.res)['categories']['data'][index2]['children']['data'][index3]['name'].toString(),
                                                              style: TextStyle(fontSize: 14),
                                                            )
                                                          ],
                                                        ) ,
                                                        value: mainFilterSlug ==json.decode(state.res)['categories']['data'][index2]['children']['data'][index3]['slug'].toString(),
                                                        onChanged: (bool value){
                                                          mainFilterSlug =json.decode(state.res)['categories']['data'][index2]['children']['data'][index3]['slug'].toString();
                                                          setState2(() {});
                                                        },
                                                      ),
                                                      children: [
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: json.decode(state.res)['categories']['data'][index2]['children']['data'][index3]['children'].length,
                                                            itemBuilder: (context, index4){
                                                              return ExpansionTile(
                                                                  title: CheckboxListTile(
                                                                    title:Row(
                                                                        children: [
                                                                          Container(width: 20,),
                                                                          Text(json.decode(state.res)['categories']['data'][index2]['children']['data'][index3]['children']['data'][index4]['name'].toString(),
                                                                              style: TextStyle(fontSize: 13)
                                                                          ) ,
                                                                        ]),
                                                                    value: mainFilterSlug ==json.decode(state.res)['categories']['data'][index2]['children']['data'][index3]['children']['data'][index4]['slug'].toString(),
                                                                    onChanged: (bool value){
                                                                      mainFilterSlug =json.decode(state.res)['categories']['data'][index2]['children']['data'][index3]['children']['data'][index4]['slug'].toString();
                                                                      setState2(() {});
                                                                    },
                                                                  ),
                                                              );
                                                            }
                                                        )
                                                      ],
                                                    );
                                                  }
                                              )
                                            ],
                                          );
                                        }
                                    ),
                                    Divider(),
                                    SwitchListTile(
                                      title: const Text('Бесплатная доставка'),
                                      value: _switchValue,
                                      onChanged: (bool value) {
                                        setState2(() {
                                          _switchValue = value;
                                        });
                                      },
                                    ),
                                    Divider(),
                                    SwitchListTile(
                                      title: const Text('Доступно в рассрочку'),
                                      value: _switchValue2,
                                      onChanged: (bool value){
                                        setState2((){
                                          _switchValue2 = value;
                                        });
                                      },
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text("Цена"),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*3/9,
                                          child:  TextField(

                                            controller: textControllerOt,
                                            cursorColor: Colors.black,
                                            keyboardType: TextInputType.number,
                                            decoration: new InputDecoration(
                                                contentPadding:
                                                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                                hintText: "от"),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width*3/9,
                                          child:  TextField(
                                            controller: textControllerDo,
                                            cursorColor: Colors.black,
                                            keyboardType: TextInputType.number,
                                            decoration: new InputDecoration(
                                                contentPadding:
                                                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                                hintText: "до"),
                                          ),
                                        )
                                      ],
                                    ),
                                    RangeSlider(
                                      values: _currentRangeValues,
                                      min: json.decode(state.res)['min_price'].toDouble() ,
                                      max: json.decode(state.res)['max_price'].toDouble() ,
                                      divisions: 15,
                                      labels: RangeLabels(
                                        _currentRangeValues.start.round().toString(),
                                        _currentRangeValues.end.round().toString(),
                                      ),
                                      onChanged: (RangeValues values) {
                                        textControllerOt.text=_currentRangeValues.start.round().toString();
                                        textControllerDo.text=_currentRangeValues.end.round().toString();

                                        setState2(() {
                                          _currentRangeValues = values;
                                        });
                                      },
                                    ),
                                    Divider(),
                                    ExpansionTile(
                                      title: Text('Бренды'),
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: json.decode(state.res)['brands']['data'].length,
                                            itemBuilder: (context, index2){
                                              return CheckboxListTile(
                                                title:Text(json.decode(state.res)['brands']['data'][index2]['name'].toString()) ,
                                                value: brandId ==json.decode(state.res)['brands']['data'][index2]['slug'].toString() ? true : false,
                                                onChanged: (bool value){
                                                  if(!value){
                                                    brandId="null";
                                                  }else{
                                                    brandId =json.decode(state.res)['brands']['data'][index2]['slug'].toString();
                                                  }
                                                  setState2(() {});
                                                },
                                              );
                                            }
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    ExpansionTile(
                                      title: Text('Цвет'),
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: json.decode(state.res)['colors'].length,
                                            itemBuilder: (context, index2){
                                              return CheckboxListTile(
                                                title:Text(json.decode(state.res)['colors'][index2]['name'].toString()) ,
                                                value: colorId ==json.decode(state.res)['colors'][index2]['id'] ? true : false,
                                                onChanged: (bool value){
                                                  if(!value){
                                                    colorId=-1;
                                                  }else{
                                                    colorId =json.decode(state.res)['colors'][index2]['id'];
                                                  }
                                                  setState2(() {});
                                                },
                                              );
                                            }
                                        )
                                      ],
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:json.decode(state.res)['attributes'].length ,
                                      itemBuilder: (context, index) {
                                        if(_isChecked.length<index+1){
                                          _isChecked.add([]);
                                        }
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Text(json.decode(state.res)['attributes'][index]['attribute'].toString()),
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: json.decode(state.res)['attributes'][index]['values'].length,
                                                itemBuilder: (context, index2){
                                                  if(_isChecked[index].length<index2+1){
                                                    _isChecked[index].add(false);
                                                  }
                                                  return CheckboxListTile(
                                                    title:Text(json.decode(state.res)['attributes'][index]['values'][index2]['name'].toString()) ,
                                                    value: _isChecked[index][index2],
                                                    onChanged: (bool value) {
                                                      setState2(() {
                                                        _isChecked[index][index2] = value;
                                                      });
                                                    },
                                                  );
                                                })
                                          ],
                                        );
                                      },
                                    ),
                                    Divider(),
                                    SwitchListTile(
                                      title: const Text('Новинки'),
                                      value: _switchValue3,
                                      onChanged: (bool value) {
                                        setState2(() {
                                          _switchValue3 = value;
                                        });
                                      },
                                    ),
                                    Divider(),
                                    SwitchListTile(
                                      title: const Text('Популярные'),
                                      value: _switchValue4,
                                      onChanged: (bool value) {
                                        setState2(() {
                                          _switchValue4 = value;
                                        });
                                      },
                                    ),
                                    Divider(),
                                    SwitchListTile(
                                      title: const Text('Рекомендуемые'),
                                      value: _switchValue5,
                                      onChanged: (bool value) {
                                        setState2(() {
                                          _switchValue5 = value;
                                        });
                                      },
                                    ),
                                    Divider(),
                                    SwitchListTile(
                                      title: const Text('Акции'),
                                      value: _switchValue6,
                                      onChanged: (bool value) {
                                        setState2(() {
                                          _switchValue6 = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                            ),
                          ),
                          Container(
                              height:MediaQuery.of(context).size.height/11 ,
                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children:[
                                    Container(
                                      width: MediaQuery.of(context).size.width*3.7/9,
                                      child:Padding(
                                        padding: EdgeInsets.all(10),
                                        child:InkWell(
                                          child: Container(
                                            child: Center(
                                              child:Text(
                                                "Закрыть",
                                                style: TextStyle(color:Colors.white
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.green,
                                                border: Border.all(color: Colors.black)
                                            ),
                                          ),
                                          onTap:(){Navigator.pop(conte) ;},
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*3.7/9,
                                      child:Padding(
                                        padding: EdgeInsets.all(10),
                                        child:InkWell(
                                          child: Container(
                                            child: Center(
                                              child:Text(
                                                "Применить",
                                                style: TextStyle(color:Colors.white
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: MyColors.customBlue,
                                                border: Border.all(color: Colors.black)
                                            ),
                                          ),
                                          onTap:(){
                                            filterValue="?";
                                            if(_switchValue6){
                                              filterValue=filterValue+"stock=true&";
                                            }
                                            if(_switchValue5){
                                              filterValue=filterValue+"recommendation=true&";
                                            }
                                            if(_switchValue4){
                                              filterValue=filterValue+"popular=true&";
                                            }
                                            if(_switchValue3){
                                              filterValue=filterValue+"new=true&";
                                            }
                                            if(_switchValue2){
                                              filterValue=filterValue+"installment=true&";
                                            }
                                            if(_switchValue){
                                              filterValue=filterValue+"freeDelevery=true&";
                                            }

                                            if(textControllerOt.text!=null && textControllerDo.text!=null &&
                                                textControllerOt.text.length>0 && textControllerDo.text.length>0
                                            ){
                                              print("nume="+textControllerOt.text);
                                              int min_price=int.parse(textControllerOt.text);
                                              int max_price=int.parse(textControllerDo.text);
                                              if(int.parse(textControllerOt.text)<json.decode(state.res)['min_price'].toDouble()){
                                                min_price=json.decode(state.res)['min_price'].toDouble();
                                              }
                                              if(int.parse(textControllerDo.text)<json.decode(state.res)['min_price'].toDouble()){
                                                max_price=json.decode(state.res)['min_price'].toDouble();
                                              }
                                              if(int.parse(textControllerOt.text)>json.decode(state.res)['max_price'].toDouble()){
                                                min_price=json.decode(state.res)['max_price'].toDouble();
                                              }
                                              if(int.parse(textControllerDo.text)>json.decode(state.res)['max_price'].toDouble()){
                                                max_price=json.decode(state.res)['max_price'].toDouble();
                                              }
                                              filterValue=filterValue+"min_price="+min_price.toString()+"&max_price="+max_price.toString()+"&";
                                            }

                                            for(int t=0;t<_isChecked.length;t++){
                                              for(int k=0;k<_isChecked[t].length;k++){
                                                if(_isChecked[t][k]){
                                                  filterValue=filterValue+"attribute"+
                                                      "[]="+json.decode(state.res)['attributes'][t]['values'][k]['id'].toString()+"&";
                                                }
                                              }
                                            }
                                            if(colorId!=-1){
                                              filterValue=filterValue+"color[]="+colorId.toString()+"&";
                                            }
                                            if(brandId!="null"){
                                              filterValue=filterValue+"brand[]="+brandId.toString()+"&";
                                            }
                                            isFiltered=true;
                                            setState((){});
                                            Navigator.pop(conte);
                                            },
                                        ),
                                      ),
                                    )
                                  ]
                              )
                          ),
                        ],
                      )
                  );
                })
        )
    );
  }
  }
