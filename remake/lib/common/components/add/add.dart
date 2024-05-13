import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:remake/common/style/colors/colors.dart';
import 'package:remake/common/style/size/size.dart';
import 'package:remake/domain/entities/task_entities.dart';
import 'package:remake/presentation/bloc/export.dart';
import 'package:table_calendar/table_calendar.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final TextEditingController _tittleController = TextEditingController();
  final DateTime _now = DateTime.now();
  Priority? _selectedPriority;
  DateTime? _selectedTime;
  DateTime? _selectedDate;

  void _onSelectedDate(DateTime date , DateTime b) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showDialog(),
      backgroundColor: ColorsApp.kPrimary,
      child: const Icon(LucideIcons.plus),
    );
  }

  void _reset() {
    _tittleController.clear();
    _selectedPriority = null;
    context.pop();
  }

  void _showDialog() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        isScrollControlled: true,
        context: context,
        builder: (_) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: _buildField(),
            ));
  }

  void _showCalendar() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              content: Builder(builder: (context) => _buildCalendarField()),
            ));
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: _now.hour, minute: _now.minute));
    if (picked != null) {
      setState(() {
        _selectedTime = DateTime(_selectedDate!.year, _selectedDate!.month,
            _selectedDate!.day, picked.hour, picked.minute);
      });
    }
  }

  Widget _buildField() {
    return SizedBox(
      height: 180,
      width: SizeApp.kWidth(context),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Positioned(top: 0, left: 0, right: 0, child: _buildTaskTitleField()),
            Positioned(bottom: 0, left: 0, child: _buildBottomField()),
            Positioned(bottom: 0, right: 0, child: _buildSendButton())
          ],
        ),
      ),
    );
  }

  Widget _buildTaskTitleField() {
    return Container(
      height: 80,
      width: SizeApp.kWidth(context),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black , width: 1)
      ),
      child: TextField(
        maxLines: 3, 
        controller: _tittleController,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Enter new assignment',
          hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 14 
          ) ,
          contentPadding: const EdgeInsets.all(10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildBottomField() {
    return Container(
      height: 50,
      width: SizeApp.kWidth(context) * 0.5,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_buildDropdown(), _buildCalendarIcon()],
      ),
    );
  }

  Widget _buildDropdown() {
    return FormField(builder: (FormFieldState<Priority> state) {
      return Expanded(
        child: InputDecorator(
            isEmpty: _selectedPriority == null,
            decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 14),
                hintText: 'Please select priority',
                border: InputBorder.none),
            child: DropdownButtonHideUnderline(
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black12 , width: 1)),
                  child: DropdownButton<Priority>(
                    icon: const SizedBox.shrink(),
                              dropdownColor: ColorsApp.white,
                              elevation: 0,
                              value: _selectedPriority,
                              isDense: true,
                              items: Priority.values
                    .map((e) => DropdownMenuItem(

                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                              onChanged: (value) {
                  setState(() {
                    _selectedPriority = value!;
                    state.didChange(value);
                  });
                              },
                            ),
                ))),
      );
    });
  }

  Widget _buildCalendarIcon() {
    return IconButton(
        onPressed: () => _showCalendar(),
        icon: Icon(
          LucideIcons.calendar,
          color: ColorsApp.kPrimary,
        ));
  }

  Widget _buildCalendarField() {
    return Container(
      width: SizeApp.kWidth(context) - 30,
      height: SizeApp.kHeight(context) - 170,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(flex: 2, child: _buildCalendar()),
          Flexible(flex: 1, child: _buildTime())
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      rowHeight: 44,
      headerStyle:  HeaderStyle(
        titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w800
        ),
        titleCentered: true,
        formatButtonVisible: false,
      ),
      daysOfWeekHeight: 25,
      
      daysOfWeekStyle: DaysOfWeekStyle(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black , width: 1)
        ),
        weekdayStyle: Theme.of(context).textTheme.titleSmall! ,
        weekendStyle: Theme.of(context).textTheme.titleSmall!
      ),
      calendarStyle: CalendarStyle(
          weekendTextStyle: Theme.of(context).textTheme.titleSmall!,
          defaultTextStyle: Theme.of(context).textTheme.titleSmall!, ) ,
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2000),
      lastDay: DateTime.utc(2050),
      onDaySelected: (selectedDay, focusedDay) => _onSelectedDate(selectedDay, focusedDay),
    );
  }

  Widget _buildTime() {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context);
        await _showTimePicker();
        _showCalendar();
      },
      child: Container(
        width: SizeApp.kWidth(context),
        height: 50,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        child: Row(
          children: [],
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12, width: 1)),
      child: IconButton(
        onPressed: () {
          if (_selectedPriority == null || _selectedTime == null) return;
          final selectedDateTime = DateTime(
              _selectedDate!.year,
              _selectedDate!.month,
              _selectedDate!.day,
              _selectedTime!.hour,
              _selectedTime!.minute);
          context.read<TaskBloc>().add(AddTasksEvents(
              task: TaskEntities(
                  priority: _selectedPriority!,
                  task: TaskData(
                      title: _tittleController.text,
                      dateTime: selectedDateTime))));
          _reset();
        },
        icon: Transform.rotate(
          angle: -3 / 4,
          child: Icon(
            LucideIcons.send,
            color: ColorsApp.kPrimary,
          ),
        ),
      ),
    );
  }
}
