import 'package:flutter/material.dart';
import 'package:trivo/lists/list_categories.dart';
import 'package:trivo/lists/list_districts.dart';
import 'package:trivo/screens/admin/screens/db_admin.dart';

ValueNotifier<List<String>> selectedFilters = ValueNotifier<List<String>>([]);
ValueNotifier<List<String>> selectedFiltershome =
    ValueNotifier<List<String>>([]);

// ignore: must_be_immutable
class FilterSelecter extends StatelessWidget {
  FilterSelecter(
      {super.key, required this.list, required this.selectedFilters});

  List list;
  ValueNotifier<List<String>> selectedFilters;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35,
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(list.length,
                (index) => ListSelecterMaker(index: index, list: list))));
  }
}

// ignore: must_be_immutable
class ListSelecterMaker extends StatefulWidget {
  ListSelecterMaker({super.key, required this.index, required this.list});

  final int index;
  final List list;
  late bool isSelected = selectedCategories!.contains(list[index]);
  late bool isSelectedd = selectedDistricts!.contains(list[index]);

  @override
  State<ListSelecterMaker> createState() => _ListSelecterMakerState();
}

class _ListSelecterMakerState extends State<ListSelecterMaker> {

  @override
  Widget build(BuildContext context) {
    return widget.list == categories
        ? InkWell(
            onTap: () async {
              setState(() {
                widget.isSelected = !widget.isSelected;
                if (widget.isSelected) {
                  selectedCategories!.add(widget.list[widget.index]);
                } else {
                  selectedCategories!.remove(widget.list[widget.index]);
                }
              });
              await getFiltered();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                decoration: widget.isSelected
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 0, 0, 0),
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: .3),
                        color: const Color.fromARGB(255, 255, 255, 255)),
                child: Align(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    categories[widget.index],
                    style: widget.isSelected
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(color: Colors.black),
                  ),
                )),
              ),
            ),
          )
        : InkWell(
            onTap: () async {
              setState(() {
                widget.isSelectedd = !widget.isSelectedd;
                if (widget.isSelectedd) {
                  selectedDistricts!.add(widget.list[widget.index]);
                } else {
                  selectedDistricts!.remove(widget.list[widget.index]);
                }
              });
              await getFiltered();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                decoration: widget.isSelectedd
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 0, 0, 0),
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: .3),
                        color: const Color.fromARGB(255, 255, 255, 255)),
                child: Align(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    districts[widget.index],
                    style: widget.isSelectedd
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(color: Colors.black),
                  ),
                )),
              ),
            ),
          );
  }
}
