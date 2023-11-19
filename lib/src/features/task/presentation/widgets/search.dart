import 'package:app/src/config/app_colors.dart';
import 'package:app/src/features/task/presentation/widgets/simple_field.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 16,
          ),
          Icon(
            Icons.search,
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: SimpleField(border: UnderlineInputBorder(borderSide: BorderSide.none), enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.close,
                size: 20,
              )),
          SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
