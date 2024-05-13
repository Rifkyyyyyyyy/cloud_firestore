import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:remake/common/components/card/card.dart';
import 'package:remake/common/components/clip/clip.dart';

import 'package:remake/common/style/colors/colors.dart';
import 'package:remake/common/style/size/size.dart';
import 'package:remake/domain/entities/task_entities.dart';
import 'package:remake/presentation/bloc/export.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listenWhen: (p, n) => p != n,
      listener: (_, state) {
        if (state is TaskOperation) {
          showDialog(
              barrierDismissible: false,
              barrierColor: Colors.black12,
              useSafeArea: false,
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: Text(state.msg!),
                );
              });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorsApp.body,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(LucideIcons.bell))
          ],
          title: Text(
            'Task Management',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: ColorsApp.white),
          ),
          leading: IconButton(onPressed: () {}, icon: Icon(LucideIcons.menu)),
          backgroundColor: ColorsApp.kPrimary,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light),
        ),
        body: Stack(
          children: [
            Positioned(top: 0, left: 0, right: 0, child: _buildHeading()),
            Positioned(bottom: 0, left: 0, right: 0, child: _buildEnd())
          ],
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return Container(
      height: 120,
      width: SizeApp.kWidth(context),
      color: Colors.transparent,
      child: Stack(
        children: [
          _buildHeaderBackground(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return ClipPath(
      clipper: ClipPathClass(),
      child: Container(
        height: 100,
        width: SizeApp.kWidth(context),
        decoration: BoxDecoration(color: ColorsApp.kPrimary),
      ),
    );
  }

  Widget _buildFooter() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Container(
        height: 70,
        width: SizeApp.kWidth(context),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: ColorsApp.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              offset: Offset(0, 4),
              blurRadius: 12,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StreamBuilder<String>(
                          initialData: '-',
                          stream: BlocProvider.of<TaskBloc>(context).allTask,
                          builder: (_, snapshot) {
                            final data = snapshot.data;
                            if (snapshot.hasData && snapshot.data != null) {
                              return Text(data!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium);
                            } else {
                              return Text(
                                '-',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              );
                            }
                          }),
                      Text(
                        'All tasks',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StreamBuilder<String>(
                          initialData: '-',
                          stream: BlocProvider.of<TaskBloc>(context).filterTime,
                          builder: (_, snapshot) {
                            final data = snapshot.data;
                            if (snapshot.hasData && snapshot.data != null) {
                              return Text(data!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                      fontSize: 18));
                            } else {
                              return Text('-');
                            }
                          }),
                      Text(
                        "Today's task",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w400, color: Colors.black54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildEnd() {
    return Container(
      height: SizeApp.kHeight(context) - 270,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: SizeApp.kWidth(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Due today'),
              GestureDetector(
                  child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    Text('Sort by'),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      LucideIcons.listFilter,
                      size: 14,
                    )
                  ]))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          _buildList()
        ],
      ),
    );
  }

  Widget _buildList() {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading || state is TaskInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TaskSuccess) {
          print('panjang task : ${state.task!.length}');
          return StreamBuilder(
            stream: BlocProvider.of<TaskBloc>(context).dataStream,
            builder: (_, snapshot) {
              print('koneksi : ${snapshot.connectionState}');
              final data = snapshot.data;
              print('snapshot has data ? ${snapshot.hasData}');
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      final TaskEntities _mytask = data[index];
                      return Dismissible(
                        key: ValueKey<TaskEntities>(_mytask),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {}
                        },
                        child: MyCard(
                          time: _mytask.task.dateTime,
                          title: _mytask.task.title,
                          color: Colors.black12,
                          priority: _mytask.priority,
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        } else if (state is TaskFailed) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            width: SizeApp.kWidth(context),
            height: 350,
            // decoration: BoxDecoration(color: Colors.black12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'lib/assets/icons/empty.png',
                  fit: BoxFit.contain, 
                ),
                Text(
                  'Oops!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  state.err!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      height: 1.2, fontWeight: FontWeight.w400, fontSize: 14),
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
