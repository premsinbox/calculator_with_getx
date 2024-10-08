import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/calculator_controller.dart';

class CalculatorScreen extends StatelessWidget {
  final CalculatorController controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3, 
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Obx(() => Text(
                                controller.input.value,
                                style: TextStyle(
                                  fontSize: 40,
                                  color: const Color.fromARGB(255, 55, 114, 57),
                                ),
                                textAlign: TextAlign.right,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Obx(() => Text(
                                controller.output.value,
                                style: TextStyle(
                                  fontSize: 32,
                                  color: const Color.fromARGB(217, 45, 91, 46),
                                ),
                                textAlign: TextAlign.right,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.history),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: Obx(() => ListView.builder(
                                    itemCount: controller.history.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(controller.history[index]),
                                        trailing: IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () =>
                                              controller.clearHistoryEntry(index),
                                        ),
                                      );
                                    },
                                  )),
                            );
                          },
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.clearAll();
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.backspace),
                      onPressed: controller.clearLast,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CalculatorButton(
                          label: '7',
                          onTap: () {
                            controller.appendValue('7');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '8',
                          onTap: () {
                            controller.appendValue('8');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '9',
                          onTap: () {
                            controller.appendValue('9');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '/',
                          onTap: () {
                            controller.appendValue('/');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CalculatorButton(
                          label: '4',
                          onTap: () {
                            controller.appendValue('4');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '5',
                          onTap: () {
                            controller.appendValue('5');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '6',
                          onTap: () {
                            controller.appendValue('6');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '*',
                          onTap: () {
                            controller.appendValue('*');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CalculatorButton(
                          label: '1',
                          onTap: () {
                            controller.appendValue('1');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '2',
                          onTap: () {
                            controller.appendValue('2');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '3',
                          onTap: () {
                            controller.appendValue('3');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '-',
                          onTap: () {
                            controller.appendValue('-');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CalculatorButton(
                          label: '.',
                          onTap: () {
                            controller.appendValue('.');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '0',
                          onTap: () {
                            controller.appendValue('0');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '+',
                          onTap: () {
                            controller.appendValue('+');
                          },
                        ),
                      ),
                      Expanded(
                        child: CalculatorButton(
                          label: '=',
                          onTap: () {
                            controller.calculateResult();
                          },
                          color: Colors.green,  
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? color; 

  CalculatorButton({required this.label, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4),
         height: 70,
        decoration: BoxDecoration(
          color: color ?? Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 36), 
          ),
        ),
      ),
    );
  }
}
