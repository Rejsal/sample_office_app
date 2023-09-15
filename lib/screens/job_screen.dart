import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_office_project/models/job_model.dart';
import 'package:sample_office_project/provider/job_provider.dart';
import 'package:sample_office_project/screens/add_job_screen.dart';
import 'package:sample_office_project/utils/constants.dart';
import 'package:sample_office_project/utils/styles.dart';

class JobScreen extends StatefulWidget {
  const JobScreen(
      {required this.projectId, required this.projectName, Key? key})
      : super(key: key);

  final int projectId;
  final String projectName;

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<JobProvider>().loadJobs(widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: OpenContainer(
        closedElevation: 0.0,
        closedColor: kPrimary,
        transitionDuration: const Duration(milliseconds: 300),
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (BuildContext context, VoidCallback _) {
          return AddJobScreen(
            projectId: widget.projectId,
          );
        },
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25.0)),
            child: const Center(
                child: Icon(
              Icons.add,
              color: Colors.white,
            )),
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.projectName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 550.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Selector<JobProvider, List<JobModel>>(
                builder: (_, jobs, __) => jobs.isNotEmpty
                    ? ListView.separated(
                        itemCount: jobs.length,
                        itemBuilder: (_, index) {
                          return Card(
                            elevation: 4.0,
                            clipBehavior: Clip.antiAlias,
                            color: Colors.black,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    jobs[index].title,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    jobs[index].description,
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                                  trailing: Text(
                                    "${jobs[index].filledCount}/${jobs[index].numberOfRequirements} filled",
                                    style: const TextStyle(
                                        color: Colors.white38, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10.0,
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          noJobs,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                selector: (_, job) => job.jobs,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
