import 'package:loop/export.dart';
import 'package:loop/widget/common/custom_appbar.dart';

class LeagueDetailsScreen extends StatefulWidget {
  final League league;

  const LeagueDetailsScreen({super.key, required this.league});

  @override
  State<LeagueDetailsScreen> createState() => _LeagueDetailsScreenState();
}

class _LeagueDetailsScreenState extends State<LeagueDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              showLeading: true,
              title: widget.league.name,
              subtitle: widget.league.country,
              logoUrl: widget.league.logoUrl,
              showShareIcon: true,
            ),
            const Gap(20),
            _LeagueDetailsTabs(league: widget.league),
          ],
        ),
      ),
    );
  }
}

class _LeagueDetailsTabs extends StatefulWidget {
  final League league;

  const _LeagueDetailsTabs({required this.league});

  @override
  State<_LeagueDetailsTabs> createState() => _LeagueDetailsTabsState();
}

class _LeagueDetailsTabsState extends State<_LeagueDetailsTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: context.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: context.primary.withOpacity(0.6),
              indicator: BoxDecoration(
                gradient: LinearGradient(
                  colors: [context.primary, context.primary.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.people, size: 16),
                      const Gap(6),
                      Text('TEAMS'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today, size: 16),
                      const Gap(6),
                      Text('SCHEDULE'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.leaderboard, size: 16),
                      const Gap(6),
                      Text('RECORD'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _TeamsView(league: widget.league),
                _ScheduleView(league: widget.league),
                _RecordView(league: widget.league),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamsView extends StatelessWidget {
  final League league;
  const _TeamsView({required this.league});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.card,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.people, color: context.primary),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: 'Team ${index + 1}',
                      color: context.text,
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    const Gap(2),
                    MyText(
                      text: '${index + 5} Players',
                      color: context.subtitle,
                      size: 12,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: context.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MyText(
                  text: '${index * 3 + 10} pts',
                  color: context.primary,
                  size: 12,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScheduleView extends StatelessWidget {
  final League league;
  const _ScheduleView({required this.league});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.primary.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: context.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: MyText(
                      text: 'Match ${index + 1}',
                      color: context.primary,
                      size: 12,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  MyText(
                    text: '${index + 10}:00 AM',
                    color: context.subtitle,
                    size: 12,
                  ),
                ],
              ),
              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.people, size: 16, color: context.primary),
                        ),
                        const Gap(8),
                        Expanded(
                          child: MyText(
                            text: 'Team A',
                            color: context.text,
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: context.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: MyText(
                      text: '2 - 1',
                      color: context.primary,
                      size: 14,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: MyText(
                            text: 'Team B',
                            color: context.text,
                            size: 14,
                            weight: FontWeight.w600,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const Gap(8),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.people, size: 16, color: context.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RecordView extends StatelessWidget {
  final League league;
  const _RecordView({required this.league});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.card,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index < 3 ? context.primary.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: MyText(
                  text: '${index + 1}',
                  color: index < 3 ? context.primary : Colors.grey,
                  size: 16,
                  weight: FontWeight.bold,
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: 'Player ${index + 1}',
                      color: context.text,
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    const Gap(2),
                    MyText(
                      text: 'Team ${index + 1}',
                      color: context.subtitle,
                      size: 12,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MyText(
                    text: '${(index + 1) * 25} pts',
                    color: context.text,
                    size: 14,
                    weight: FontWeight.bold,
                  ),
                  const Gap(2),
                  MyText(
                    text: '${index + 8} goals',
                    color: context.subtitle,
                    size: 12,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}