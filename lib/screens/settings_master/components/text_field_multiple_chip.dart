import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';

class TextFieldMultipleChip extends StatefulWidget {
  final String label;
  final String tooltipMessage;
  final Function(String) onDeleted;
  final Function(String) onSubmitted;
  final List<String> initialChips; // List of initial chip values
  final bool allowMultipleChips; // New parameter to control multiple chips

  const TextFieldMultipleChip({
    Key? key,
    required this.label,
    required this.tooltipMessage,
    required this.onDeleted,
    required this.onSubmitted,
    required this.initialChips,
    this.allowMultipleChips = true, // Default to allowing multiple chips
  }) : super(key: key);

  @override
  _TextFieldMultipleChipState createState() => _TextFieldMultipleChipState();
}

class _TextFieldMultipleChipState extends State<TextFieldMultipleChip> {
  bool showChips = false;
  final TextEditingController _controller = TextEditingController();
  List<String> chips = [];

  @override
  void initState() {
    super.initState();
    chips.addAll(widget.initialChips);
    showChips = chips.isNotEmpty;
  }

  void _unfocusTextField() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(fontSize: 16),
            ),
            Tooltip(
              message: widget.tooltipMessage,
              child: IconButton(
                icon: const Icon(Icons.help_outline),
                onPressed: () {},
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  onSubmitted: (text) {
                    if (text.isNotEmpty) {
                      setState(() {
                        if (!widget.allowMultipleChips) {
                          chips
                              .clear(); // Clear existing chips if not allowed multiple
                        }
                        chips.add(text);
                        showChips = true;
                      });
                      _controller.clear();
                      widget.onSubmitted(text);
                    }
                  },
                  decoration: InputDecoration(
                    hintText:
                        "Press enter or click + button to submit".hardcoded,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add_circle, color: kPrimary),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          setState(() {
                            if (!widget.allowMultipleChips) {
                              chips
                                  .clear(); // Clear existing chips if not allowed multiple
                            }
                            chips.add(_controller.text);
                            showChips = true;
                            _unfocusTextField();
                          });
                          _controller.clear();
                          widget.onSubmitted(_controller.text);
                        }
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showChips)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: chips.map<Widget>((chipText) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Chip(
                    label:
                        Text(chipText, style: const TextStyle(color: kWhite)),
                    backgroundColor: kPrimary,
                    deleteIcon: const Icon(Icons.close, color: kWhite),
                    onDeleted: () {
                      setState(() {
                        chips.remove(chipText);
                        if (chips.isEmpty) {
                          showChips = false;
                        }
                      });
                      widget.onDeleted(chipText);
                    },
                  ),
                );
              }).toList(),
            ),
          )
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:shadowinner_master_settings/constants.dart';
// import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';

// class TextFieldMultipleChip extends StatefulWidget {
//   final String label;

//   final String tooltipMessage;

//   final Function(String) onDeleted;
//   final Function(String) onSubmitted;
//   final List<String> initialChips; // List of initial chip values

//   const TextFieldMultipleChip({
//     Key? key,
//     required this.label,
//     required this.tooltipMessage,
//     required this.onDeleted,
//     required this.onSubmitted,
//     required this.initialChips,
//   }) : super(key: key);

//   @override
//   _TextFieldMultipleChipState createState() =>
//       _TextFieldMultipleChipState();
// }

// class _TextFieldMultipleChipState extends State<TextFieldMultipleChip> {
//   bool showChips = false;
//   final TextEditingController _controller = TextEditingController();
//   List<String> chips = [];

//   @override
//   void initState() {
//     super.initState();
//     chips.addAll(widget.initialChips);
//     showChips = chips.isNotEmpty;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               widget.label,
//               style: const TextStyle(fontSize: 16),
//             ),
//             Tooltip(
//               message: widget.tooltipMessage,
//               child: IconButton(
//                 icon: const Icon(Icons.help_outline),
//                 onPressed: () {},
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _controller,
//                   onSubmitted: (text) {
//                     if (text.isNotEmpty) {
//                       setState(() {
//                         chips.add(text);
//                         showChips = true;
//                       });
//                       _controller.clear();
//                       widget.onSubmitted(text);
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText:
//                         "Press enter or click + button to submit".hardcoded,
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.add_circle, color: kPrimary),
//                       onPressed: () {
//                         if (_controller.text.isNotEmpty) {
//                           setState(() {
//                             chips.add(_controller.text);
//                             showChips = true;
//                           });
//                           _controller.clear();
//                           widget.onSubmitted(_controller.text);
//                         }
//                       },
//                     ),
//                     border: const OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (showChips)
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: chips.map<Widget>((chipText) {
//                 return Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Chip(
//                     label:
//                         Text(chipText, style: const TextStyle(color: kWhite)),
//                     backgroundColor: kPrimary,
//                     deleteIcon: const Icon(Icons.close, color: kWhite),
//                     onDeleted: () {
//                       setState(() {
//                         chips.remove(chipText);
//                         if (chips.isEmpty) {
//                           showChips = false;
//                         } else {
//                           widget.onDeleted(chipText);
//                         }
//                       });
//                     },
//                   ),
//                 );
//               }).toList(),
//             ),
//           )
//       ],
//     );
//   }
// }
