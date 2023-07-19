import 'package:flutter/material.dart';
import 'package:trivo/lists/category.dart';
import 'package:trivo/lists/districts.dart';
import 'package:trivo/screens/admin/screens/db_admin.dart';

// ignore: must_be_immutable
class FilterSelecter extends StatelessWidget {
   FilterSelecter({super.key,required this.list,});

  List list;

  @override
  Widget build(BuildContext context) {
    return SizedBox (
      height: 50,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children:List.generate(list.length, (index) => ListSelecterMaker(index: index, list: list))
          
  ));}
  }


// ignore: must_be_immutable
class ListSelecterMaker extends StatefulWidget {
   ListSelecterMaker({super.key,required this.index,required this.list});

  final int index;
  final List list;
  bool isSelected=false;

  @override
  State<ListSelecterMaker> createState() => _ListSelecterMakerState();
}

class _ListSelecterMakerState extends State<ListSelecterMaker> {
  @override
  Widget build(BuildContext context) {
    return  widget.list== categories?
    InkWell(
      onTap: () {
        setState(() {
          widget.isSelected=!widget.isSelected;
          if(widget.isSelected){
            selectedCategories!.add(widget.list[widget.index]);
          }else{
            selectedCategories!.remove(widget.list[widget.index]);
          }
          getFiltered();
        });
      },
      child: Container(
        child: Text(categories[widget.index]),
        decoration: widget.isSelected?BoxDecoration(
          color: Colors.amber
        ):BoxDecoration(
          color: Colors.white
        ),
    
      ),
    ):InkWell(
       onTap: () {
        setState(() {
          widget.isSelected=!widget.isSelected;
          if(widget.isSelected){
            selectedDistricts!.add(widget.list[widget.index]);
          }else{
            selectedDistricts!.remove(widget.list[widget.index]);
          }
          getFiltered();
        });
      },
      child: Container(
         decoration: widget.isSelected?BoxDecoration(
          color: Colors.amber
        ):BoxDecoration(
          color: Colors.white
        ),
        child: Text(districts[widget.index]),
      ),
    );

  }
}