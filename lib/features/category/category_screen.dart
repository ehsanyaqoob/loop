import 'package:gap/gap.dart';
import 'package:loop/core/models/league_model.dart';
import 'package:loop/export.dart';
import 'package:loop/providers/leagues_provider.dart';
import 'package:loop/widget/common/common_image.dart';
import 'package:loop/widget/common/dot-loader.dart';
import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LeaguesCategoryScreen extends StatefulWidget {
  const LeaguesCategoryScreen({super.key});

  @override
  State<LeaguesCategoryScreen> createState() => _LeaguesCategoryScreenState();
}

class _LeaguesCategoryScreenState extends State<LeaguesCategoryScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    // Page load hote hi data fetch 
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    // Thoda delay dekar ensure karo context available hai
    await Future.delayed(Duration.zero);
    if (mounted) {
      await context.read<LeaguesProvider>().fetchLeagues();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<LeaguesProvider>().fetchLeagues();
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BackPressHandler.handleBackPress(context),
      child: Scaffold(
        backgroundColor: context.scaffoldBackground,
        body: SafeArea(
          child: Consumer<LeaguesProvider>(
            builder: (context, provider, _) {
              // Agar data load ho raha hai aur koi league nahi hai, to directly LoopLoader dikhao
              if (provider.isLoading && provider.leagues.isEmpty) {
                return const Center(child: LoopLoader());
              }

              // FIX: Use CustomScrollView to prevent entire page bouncing
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                header: CustomHeader(
                  builder: (_, __) => Center(child: LoopLoader()),
                ),
                // FIX: Add physics to prevent bouncing
                physics: const ClampingScrollPhysics(),
                child: provider.leagues.isEmpty
                    ? const Center(
                        child: MyText(
                          text: 'No leagues available',
                          size: 14,
                          color: Colors.grey,
                        ),
                      )
                    : _buildContent(),
              );
            },
          ),
        ),
      ),
    );
  }

  // FIX: Separate content builder to use proper scroll physics
  Widget _buildContent() {
    return CustomScrollView(
      // FIX: Use ClampingScrollPhysics to prevent bouncing on entire page
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: AppSizes.DEFAULT,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _ScreenHeader(),
                const Gap(24),
                const _FeaturedCountdownSection(),
                const Gap(24),
                const _LeaguesListHeader(),
              ],
            ),
          ),
        ),
        const _LeaguesListSection(),
      ],
    );
  }
}

class _ScreenHeader extends StatelessWidget {
  const _ScreenHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: 'Cricket Leagues',
          color: context.text,
          size: 28.0,
          weight: FontWeight.bold,
        ),
        const Gap(4),
        MyText(
          text: 'Stay updated with upcoming tournaments',
          color: context.subtitle,
          size: 14,
        ),
      ],
    );
  }
}

class _FeaturedCountdownSection extends StatelessWidget {
  const _FeaturedCountdownSection();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LeaguesProvider>();
    final nearestLeague = provider.nearestLeague;

    if (nearestLeague == null) {
      return const _NoUpcomingLeaguesCard();
    }

    return _CountdownCard(league: nearestLeague);
  }
}

class _NoUpcomingLeaguesCard extends StatelessWidget {
  const _NoUpcomingLeaguesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(Icons.schedule, size: 40, color: context.primary),
          const Gap(12),
          MyText(
            text: 'No upcoming leagues',
            color: context.text,
            size: 16,
            weight: FontWeight.w600,
          ),
          const Gap(4),
          MyText(
            text: 'Check back later for new tournaments',
            color: context.subtitle,
            size: 12,
          ),
        ],
      ),
    );
  }
}

class _CountdownCard extends StatefulWidget {
  final League league;

  const _CountdownCard({required this.league});

  @override
  State<_CountdownCard> createState() => __CountdownCardState();
}

class __CountdownCardState extends State<_CountdownCard> {
  Timer? _timer;
  Duration _timeRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _updateCountdown();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateCountdown(),
    );
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final difference = widget.league.expectedStartDate.difference(now);
    if (mounted) {
      setState(() {
        _timeRemaining = difference.isNegative ? Duration.zero : difference;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _timeRemaining.inDays;
    final hours = _timeRemaining.inHours % 24;
    final minutes = _timeRemaining.inMinutes % 60;
    final seconds = _timeRemaining.inSeconds % 60;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.primary.withOpacity(0.15),
            context.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CommonImageView(
                  url: widget.league.logoUrl,
                  fit: BoxFit.contain,
                  radius: 8,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: widget.league.name,
                      color: context.text,
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                    const Gap(4),
                    MyText(
                      text: widget.league.country,
                      color: context.subtitle,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _TimeUnit(value: days, label: 'DAYS'),
              _TimeUnit(value: hours, label: 'HOURS'),
              _TimeUnit(value: minutes, label: 'MINS'),
              _TimeUnit(value: seconds, label: 'SECS'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeUnit extends StatelessWidget {
  final int value;
  final String label;

  const _TimeUnit({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: context.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: MyText(
            text: value.toString().padLeft(2, '0'),
            color: context.text,
            size: 16,
            weight: FontWeight.bold,
          ),
        ),
        const Gap(6),
        MyText(
          text: label,
          color: context.subtitle,
          size: 10,
          weight: FontWeight.w600,
        ),
      ],
    );
  }
}

class _LeaguesListHeader extends StatelessWidget {
  const _LeaguesListHeader();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LeaguesProvider>();

    return Row(
      children: [
        MyText(
          text: 'All Leagues',
          color: context.text,
          size: 18,
          weight: FontWeight.bold,
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: context.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: MyText(
            text: '${provider.leagues.length} leagues',
            color: context.primary,
            size: 12,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}class _LeaguesListSection extends StatelessWidget {
  const _LeaguesListSection();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LeaguesProvider>();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final league = provider.sortedLeagues[index];
          
          return Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: _LeagueListItem(league: league),
          );
        },
        childCount: provider.sortedLeagues.length,
      ),
    );
  }
}

class _LeagueListItem extends StatelessWidget {
  final League league;

  const _LeagueListItem({required this.league});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CommonImageView(
              url: league.logoUrl,
              fit: BoxFit.contain,
              radius: 6,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: league.name,
                  size: 16,
                  weight: FontWeight.w600,
                  color: context.text,
                ),
                const Gap(2),
                MyText(
                  text: league.country,
                  size: 12,
                  color: context.subtitle,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(league),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: MyText(
                  text: _getStatusText(league),
                  size: 10,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Gap(4),
              MyText(
                text: _formatDate(league.expectedStartDate),
                size: 10,
                color: context.subtitle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(League league) {
    final now = DateTime.now();
    final isUpcoming = league.expectedStartDate.isAfter(now);
    final isOngoing = league.expectedStartDate.isBefore(now) && 
                     now.difference(league.expectedStartDate).inDays <= 30;

    if (isUpcoming) return Colors.blue;
    if (isOngoing) return Colors.green;
    return Colors.grey;
  }

  String _getStatusText(League league) {
    final now = DateTime.now();
    final isUpcoming = league.expectedStartDate.isAfter(now);
    final isOngoing = league.expectedStartDate.isBefore(now) && 
                     now.difference(league.expectedStartDate).inDays <= 30;

    if (isUpcoming) return 'UPCOMING';
    if (isOngoing) return 'ONGOING';
    return 'PAST';
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}