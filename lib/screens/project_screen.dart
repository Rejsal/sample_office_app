import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_office_project/models/project_model.dart';
import 'package:sample_office_project/provider/auth_provider.dart';
import 'package:sample_office_project/provider/project_provider.dart';
import 'package:sample_office_project/screens/add_project_screen.dart';
import 'package:sample_office_project/screens/job_screen.dart';
import 'package:sample_office_project/utils/constants.dart';
import 'package:sample_office_project/utils/styles.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<ProjectProvider>().loadProjects());
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
          return const AddProjectScreen();
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
        title: const Text(
          projects,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {
              context.read<AuthProvider>().clearToken();
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Selector<ProjectProvider, List<ProjectModel>>(
            builder: (_, projects, __) => projects.isNotEmpty
                ? ListView.separated(
                    itemCount: projects.length,
                    itemBuilder: (_, index) {
                      return OpenContainer(
                        closedElevation: 0.0,
                        closedColor: kPrimary,
                        transitionDuration: const Duration(milliseconds: 300),
                        transitionType: ContainerTransitionType.fade,
                        openBuilder: (BuildContext context, VoidCallback _) {
                          return JobScreen(
                            projectId: projects[index].id ?? 0,
                            projectName: projects[index].title,
                          );
                        },
                        closedBuilder:
                            (BuildContext context, VoidCallback openContainer) {
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
                                    projects[index].name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
                      noProjects,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            selector: (_, projects) => projects.projects,
          ),
        ),
      ),
    );
  }
}
