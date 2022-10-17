import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_dapp_front/todo_list_model.dart';

showTodoBottomSheet(BuildContext context, {Task? task}) {
  TextEditingController _titleController =
      TextEditingController(text: task?.taskName ?? "");
  var listModel = Provider.of<TodoListModel>(context, listen: false);

  // Display a bottom sheet where you can create, update, and delete tasks
  return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.all(10),
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 6,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 14.0,
                      bottom: 20.0,
                      top: 20.0,
                    ),
                    hintText: "Enter a search term",
                    hintStyle: TextStyle(fontSize: 20),
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 12),
                if (task == null)
                  buildButton("Created", () {
                    listModel.addTask(_titleController.text);
                    Navigator.pop(context);
                  }),
                if (task != null)
                  buildButton("Updated", () {
                    listModel.updateTask(task.id!, _titleController.text);
                    Navigator.pop(context);
                  }),
                if (task != null)
                  buildButton("Delete", () {
                    listModel.deleteTask(task.id!);
                    Navigator.pop(context);
                  }),
              ],
            ),
          ),
        );
      });
}

TextButton buildButton(String text, void Function()? onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Container(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: text == "Delete" ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
