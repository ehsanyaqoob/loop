import 'package:loop/export.dart';
import 'package:loop/providers/leagues_provider.dart';
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
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
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
              if (provider.isLoading && provider.leagues.isEmpty) {
                return const Center(child: LoopLoader());
              }

              return SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                header: CustomHeader(
                  builder: (_, __) => Center(child: LoopLoader()),
                ),
                physics: ClampingScrollPhysics(),
                child: _buildContent(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return CustomScrollView(
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

    return _ExpandableCountdownCard(league: nearestLeague);
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
          SvgPicture.asset(Assets.countdown, height: 40.0, color: context.icon),
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
class _ExpandableCountdownCard extends StatefulWidget {
  final League league;

  const _ExpandableCountdownCard({required this.league});

  @override
  State<_ExpandableCountdownCard> createState() =>
      __ExpandableCountdownCardState();
}

class __ExpandableCountdownCardState extends State<_ExpandableCountdownCard> 
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  Duration _timeRemaining = Duration.zero;
  bool _isExpanded = false;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
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

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    
    if (_isExpanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  void _navigateToDetails(BuildContext context) {
    Navigate.to(AppLinks.leaguesDetails, arguments: widget.league);
  }

  void _navigateToSchedule(BuildContext context) {
    Navigate.to(AppLinks.leaguesDetails, arguments: widget.league);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _timeRemaining.inDays;
    final hours = _timeRemaining.inHours % 24;
    final minutes = _timeRemaining.inMinutes % 60;
    final seconds = _timeRemaining.inSeconds % 60;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.primary.withOpacity(0.15),
            context.primary.withOpacity(0.05),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.primary.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: context.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with progress indicator
          _buildHeader(context),
          const Gap(16),
          
          // Countdown with visual progress
          _buildCountdownSection(days, hours, minutes, seconds),
          const Gap(16),
          
          // Expandable content with smooth animation
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: _buildExpandedContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          // League logo with subtle shine effect
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CommonImageView(
                url: widget.league.logoUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Gap(16),
          
          // League info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: widget.league.name,
                  color: context.text,
                  size: 18,
                  weight: FontWeight.bold,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: context.subtitle,
                      size: 14,
                    ),
                    const Gap(4),
                    MyText(
                      text: widget.league.country,
                      color: context.subtitle,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Expand button with pulse animation
          _ExpandButton(
            isExpanded: _isExpanded,
            onTap: _toggleExpand,
            color: context.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownSection(int days, int hours, int minutes, int seconds) {
    final totalSeconds = _timeRemaining.inSeconds;
    final maxSeconds = 60 * 60 * 24 * 30; // 30 days max for progress
    final progress = totalSeconds / maxSeconds;

    return Column(
      children: [
        // Progress bar
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: context.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.primary,
                          context.primary.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const Gap(16),
        
        // Countdown numbers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _TimeUnit(
              value: days,
              label: 'DAYS',
              isHighlighted: days > 0,
              color: context.primary,
            ),
            _TimeUnit(
              value: hours,
              label: 'HOURS',
              isHighlighted: days == 0 && hours > 0,
              color: context.primary,
            ),
            _TimeUnit(
              value: minutes,
              label: 'MINS',
              isHighlighted: days == 0 && hours == 0 && minutes > 0,
              color: context.primary,
            ),
            _TimeUnit(
              value: seconds,
              label: 'SECS',
              isHighlighted: days == 0 && hours == 0 && minutes == 0,
              color: context.primary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          MyText(
            text: 'League Actions',
            color: context.text,
            size: 14,
            weight: FontWeight.w600,
          ),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ActionChip(
                icon: Icons.calendar_today,
                text: 'Schedule',
                onTap: () => _navigateToSchedule(context),
                color: context.primary,
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}

class _ExpandButton extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onTap;
  final Color color;

  const _ExpandButton({
    required this.isExpanded,
    required this.onTap,
    required this.color,
  });

  @override
  State<_ExpandButton> createState() => __ExpandButtonState();
}

class __ExpandButtonState extends State<_ExpandButton> 
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isExpanded 
              ? widget.color.withOpacity(0.2)
              : widget.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isExpanded 
                ? widget.color.withOpacity(0.4)
                : widget.color.withOpacity(0.2),
          ),
        ),
        child: ScaleTransition(
          scale: Tween(begin: 0.9, end: 1.1).animate(_pulseController),
          child: Icon(
            widget.isExpanded ? Icons.expand_less : Icons.expand_more,
            color: widget.color,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _TimeUnit extends StatelessWidget {
  final int value;
  final String label;
  final bool isHighlighted;
  final Color color;

  const _TimeUnit({
    required this.value,
    required this.label,
    required this.isHighlighted,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isHighlighted 
                ? color.withOpacity(0.15)
                : color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHighlighted 
                  ? color.withOpacity(0.3)
                  : color.withOpacity(0.1),
            ),
          ),
          child: MyText(
            text: value.toString().padLeft(2, '0'),
            color: isHighlighted ? color : context.subtitle,
            size: 16,
            weight: FontWeight.bold,
          ),
        ),
        const Gap(6),
        MyText(
          text: label,
          color: isHighlighted ? color : context.subtitle,
          size: 10,
          weight: FontWeight.w600,
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color color;

  const _ActionChip({
    required this.icon,
    required this.text,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 14),
            const Gap(6),
            MyText(
              text: text,
              color: color,
              size: 12,
              weight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}



// Add this enum for better status handling
enum LeagueStatus { upcoming, ongoing, past }

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
            size: 12.0,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _LeaguesListSection extends StatelessWidget {
  const _LeaguesListSection();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LeaguesProvider>();

    // Handle empty state
    if (provider.sortedLeagues.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: MyText(
            text: 'No leagues found',
            size: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final league = provider.sortedLeagues[index];
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: InkWell(
            onTap: () => _navigateToLeagueDetails(context, league),
            child: _LeagueListItem(league: league),
          ),
        );
      }, childCount: provider.sortedLeagues.length),
    );
  }

  void _navigateToLeagueDetails(BuildContext context, League league) {
    Navigate.to(AppLinks.leaguesDetails, arguments: league);
  }
}

class _LeagueListItem extends StatelessWidget {
  final League league;

  const _LeagueListItem({required this.league});

  LeagueStatus get _status {
    final now = DateTime.now();
    final isUpcoming = league.expectedStartDate.isAfter(now);
    final isOngoing = league.expectedStartDate.isBefore(now) && 
        now.difference(league.expectedStartDate).inDays <= 30;

    if (isUpcoming) return LeagueStatus.upcoming;
    if (isOngoing) return LeagueStatus.ongoing;
    return LeagueStatus.past;
  }

  Color _getStatusColor(LeagueStatus status) {
    switch (status) {
      case LeagueStatus.upcoming:
        return Colors.blue;
      case LeagueStatus.ongoing:
        return Colors.green;
      case LeagueStatus.past:
        return Colors.grey;
    }
  }

  String _getStatusText(LeagueStatus status) {
    switch (status) {
      case LeagueStatus.upcoming:
        return 'UPCOMING';
      case LeagueStatus.ongoing:
        return 'ONGOING';
      case LeagueStatus.past:
        return 'PAST';
    }
  }

  String _formatDate(DateTime date) {
    try {
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _status;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: context.card,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: CommonImageView(
              url: league.logoUrl,
              fit: BoxFit.contain,
              radius: 12.0,
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
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                MyText(
                  text: league.country, 
                  size: 12, 
                  color: context.subtitle,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(status),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: MyText(
                  text: _getStatusText(status),
                  size: 12.0,
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
}

