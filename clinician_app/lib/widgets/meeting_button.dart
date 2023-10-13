import 'package:flutter/material.dart';

class MeetingButton extends StatefulWidget {
  const MeetingButton({super.key});

  @override
  State<MeetingButton> createState() {
    return _MeetingState();
  }
}

class _MeetingState extends State<MeetingButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_call,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 15,
            ),
          ),
        ),
        const Expanded(child: Text('Call')),
        Expanded(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.accessibility_new,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 15,
            ),
          ),
        ),
        const Expanded(child: Text('RDV')),
        Expanded(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.question_mark,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 15,
            ),
          ),
        ),
        const Expanded(child: Text('QoR')), //Question Or Remark
      ],
    );
  }
}



    // Container(
    //   decoration: const BoxDecoration(
    //       gradient: LinearGradient(
    //         colors: [
    //           Color.fromARGB(255, 112, 82, 163),
    //           Color.fromARGB(255, 127, 78, 159),
    //         ],
    //         begin: Alignment.topLeft,
    //         end: Alignment.bottomRight,
    //       ),
    //       borderRadius: BorderRadius.only(
    //         bottomLeft: Radius.circular(10),
    //         bottomRight: Radius.circular(10),
    //       )),
    //   width: 200,
    //   height: 200 * 3 / 20,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       OutlinedButton.icon(
    //         onPressed: () {},
    //         icon: Icon(
    //           Icons.add_call,
    //           color: activeColor == Colors.black
    //               ? const Color.fromARGB(255, 0, 0, 0)
    //               : const Color.fromARGB(255, 255, 255, 255),
    //         ),
    //         label: Text(
    //           'Appel',
    //           style: TextStyle(
    //             color: activeColor == Colors.black
    //                 ? const Color.fromARGB(255, 0, 0, 0)
    //                 : const Color.fromARGB(255, 255, 255, 255),
    //             fontSize: 10,
    //           ),
    //         ),
    //       ),
    //       OutlinedButton.icon(
    //         onPressed: () {},
    //         icon: const Icon(
    //           Icons.accessibility_new,
    //           color: Color.fromARGB(255, 0, 0, 0),
    //         ),
    //         label: const Text(
    //           'RDV',
    //           style: TextStyle(
    //             color: Color.fromARGB(255, 0, 0, 0),
    //             fontSize: 10,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
