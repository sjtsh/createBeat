import 'package:flutter/material.dart';

class DistributorsList extends StatelessWidget {
  final Function distributorTap;
  final bool onDistributorTapped;

  DistributorsList(this.distributorTap, this.onDistributorTapped);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.1)),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  distributorTap(onDistributorTapped);
                },
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: onDistributorTapped
                        ? Color(0xff6C63FF) : Color(0xffE7E7E7),
                  ),
                  child: Icon(Icons.done,
                      color: onDistributorTapped
                          ? Colors.white : Colors.transparent,
                      size: 24),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "05- Saaru Enterprises- Pokhara",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff676767),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
