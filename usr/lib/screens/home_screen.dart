import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import '../widgets/earnings_header.dart';
import 'task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalEarnings = 0.0;
  List<Task> tasks = [
    Task(
      id: '1',
      title: 'Complete Survey',
      description: 'Fill out a 5-minute customer satisfaction survey',
      reward: 5.0,
      category: 'Survey',
      difficulty: 'Easy',
      timeEstimate: '5 min',
      isCompleted: false,
    ),
    Task(
      id: '2',
      title: 'Watch Video Ad',
      description: 'Watch a 30-second promotional video',
      reward: 2.0,
      category: 'Video',
      difficulty: 'Easy',
      timeEstimate: '1 min',
      isCompleted: false,
    ),
    Task(
      id: '3',
      title: 'App Installation',
      description: 'Install and open the partner app',
      reward: 10.0,
      category: 'Install',
      difficulty: 'Medium',
      timeEstimate: '3 min',
      isCompleted: false,
    ),
    Task(
      id: '4',
      title: 'Product Review',
      description: 'Write a detailed review for a product',
      reward: 15.0,
      category: 'Review',
      difficulty: 'Medium',
      timeEstimate: '10 min',
      isCompleted: false,
    ),
    Task(
      id: '5',
      title: 'Social Media Share',
      description: 'Share promotional content on social media',
      reward: 3.0,
      category: 'Social',
      difficulty: 'Easy',
      timeEstimate: '2 min',
      isCompleted: false,
    ),
    Task(
      id: '6',
      title: 'Beta Testing',
      description: 'Test new app features and provide feedback',
      reward: 25.0,
      category: 'Testing',
      difficulty: 'Hard',
      timeEstimate: '30 min',
      isCompleted: false,
    ),
  ];

  void _completeTask(Task task) {
    setState(() {
      int index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index].isCompleted = true;
        totalEarnings += task.reward;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task completed! Earned \$${task.reward.toStringAsFixed(2)}'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Task> availableTasks = tasks.where((task) => !task.isCompleted).toList();
    List<Task> completedTasks = tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Task Earning Center',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // TODO: Navigate to earnings history
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: Column(
        children: [
          EarningsHeader(totalEarnings: totalEarnings),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: TabBar(
                      labelColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Available'),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${availableTasks.length}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Completed'),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${completedTasks.length}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildTaskList(availableTasks, false),
                        _buildTaskList(completedTasks, true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<Task> taskList, bool isCompleted) {
    if (taskList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isCompleted ? Icons.check_circle_outline : Icons.inbox_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isCompleted ? 'No completed tasks yet' : 'No available tasks',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isCompleted
                  ? 'Complete tasks to see them here'
                  : 'Check back later for new tasks',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskCard(
          task: taskList[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailScreen(
                  task: taskList[index],
                  onComplete: _completeTask,
                ),
              ),
            );
          },
        );
      },
    );
  }
}