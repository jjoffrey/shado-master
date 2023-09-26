import 'package:flutter/material.dart';
import 'package:shadowinner_master_settings/constants.dart';
import 'package:shadowinner_master_settings/localization/string_hardcoded.dart';

class DropdownFieldWithChips extends StatefulWidget {
  final String tooltipMessage;
  final Function(String) onDeleted;
  final Function(String) onSubmitted;
  final List<String> initialChipsList; // Initial list of chips
  final Map<String, List<String>>?
      initialChipsMap; // Initial map of chips if dropdownItems is not null

  const DropdownFieldWithChips({
    Key? key,
    required this.tooltipMessage,
    required this.onDeleted,
    required this.onSubmitted,
    required this.initialChipsList,
    this.initialChipsMap,
  }) : super(key: key);

  @override
  _DropdownFieldWithChipsState createState() => _DropdownFieldWithChipsState();
}

class _DropdownFieldWithChipsState extends State<DropdownFieldWithChips> {
  bool showChips = false;
  final TextEditingController _controller = TextEditingController();
  List<String> chips = [];
  String? selectedDropdownItem;

  @override
  void initState() {
    super.initState();
    if (widget.initialChipsMap != null) {
      selectedDropdownItem = widget.initialChipsMap!.keys.first;
      chips.addAll(widget.initialChipsMap![selectedDropdownItem!] ?? []);
    } else {
      chips.addAll(widget.initialChipsList);
    }
    showChips = chips.isNotEmpty;
  }

  void _unfocusTextField() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final filteredChips = chips
        .where((chipText) =>
            selectedDropdownItem == null ||
            (widget.initialChipsMap != null &&
                (widget.initialChipsMap![selectedDropdownItem!] ?? [])
                    .contains(chipText)))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.initialChipsMap != null) ...[
          Row(
            children: [
              DropdownButton<String>(
                value: selectedDropdownItem,
                items: widget.initialChipsMap!.keys
                    .map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDropdownItem = value;
                    chips.clear();
                    chips.addAll(
                        widget.initialChipsMap![selectedDropdownItem!] ?? []);
                    showChips = chips.isNotEmpty;
                  });
                },
              ),
              const SizedBox(width: 10),
              Tooltip(
                message: widget.tooltipMessage,
                child: IconButton(
                  icon: const Icon(Icons.help_outline),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
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
                        chips.add(text);
                        if (widget.initialChipsMap != null) {
                          if (!widget.initialChipsMap!
                              .containsKey(selectedDropdownItem)) {
                            widget.initialChipsMap![selectedDropdownItem!] = [];
                          }
                          widget.initialChipsMap![selectedDropdownItem!]!
                              .add(text);
                        } else {
                          widget.initialChipsList.add(text);
                        }
                        showChips = true;
                      });
                      _controller.clear();
                      widget.onSubmitted(text);
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add_circle, color: kPrimary),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          setState(() {
                            chips.add(_controller.text);
                            if (widget.initialChipsMap != null) {
                              if (!widget.initialChipsMap!
                                  .containsKey(selectedDropdownItem)) {
                                widget.initialChipsMap![selectedDropdownItem!] =
                                    [];
                              }
                              widget.initialChipsMap![selectedDropdownItem!]!
                                  .add(_controller.text);
                            } else {
                              widget.initialChipsList.add(_controller.text);
                            }
                            showChips = true;
                          });
                          _controller.clear();
                          widget.onSubmitted(_controller.text);
                          _unfocusTextField();
                        }
                      },
                    ),
                    hintText:
                        "Press enter or click + button to submit".hardcoded,
                    border: OutlineInputBorder(),
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
              children: filteredChips.map<Widget>((chipText) {
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
                        } else {
                          widget.onDeleted(chipText);
                        }
                      });
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
