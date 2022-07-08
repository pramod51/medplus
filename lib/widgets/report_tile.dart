import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 15),
            height: 34,
            child: Row(
              children: [
                buildName(),
                const SizedBox(width: 12),
                ...buildUpdatedDate(),
              ],
            ),
          ),
          const Divider(
            height: 0,
            color: Color(0xffF8F8F8),
          ),
          Container(
            height: 58,
            padding: const EdgeInsets.only(left: 10, right: 17),
            child: Row(
              children: [
                buildReportCategory(),
                const SizedBox(width: 12),
                ...buildActions()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildName() {
    return const Expanded(
      child: Text(
        'Jane Cooperfggffgffggg (Self)',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Palette.textColor,
        ),
      ),
    );
  }

  List<Widget> buildUpdatedDate() {
    return [
      const Text(
        'Upload Date:',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Palette.textColor,
        ),
      ),
      const SizedBox(width: 3),
      const Text(
        '5/30/2022',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Palette.textColor,
        ),
      )
    ];
  }

  Widget buildReportCategory() {
    return Expanded(
      child: SizedBox(
        height: 25,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            height: 25,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 11),
            decoration: BoxDecoration(
                color: const Color(0xff948BFF),
                borderRadius: BorderRadius.circular(50)),
            child: const Text(
              'Pathology',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemCount: 3,
        ),
      ),
    );
  }

  List<Widget> buildActions() {
    return [
      GestureDetector(
        // onTap: () => ,
        child: SvgPicture.asset(Assets.ic_doc),
      ),
      const SizedBox(width: 15),
      GestureDetector(
        // onTap: () => ,
        child: SvgPicture.asset(Assets.ic_share),
      ),
      const SizedBox(width: 15),
      GestureDetector(
        // onTap: () => ,
        child: SvgPicture.asset(Assets.ic_download),
      ),
    ];
  }
}
