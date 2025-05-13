import 'package:flutter/material.dart';
import 'package:erp_project/widgets/bottom_nav_bar.dart';
import 'package:erp_project/theme/app_theme.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor,
            AppTheme.secondaryColor,
            AppTheme.secondaryColor,
            AppTheme.secondaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Inbox',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12, // Reduced font size
                  ),
                  padding: EdgeInsets.zero, // Remove padding
                  tabAlignment: TabAlignment.fill,
                  tabs: [
                    SizedBox(
                      // Wrap Tab in SizedBox for fixed width
                      width: MediaQuery.of(context).size.width / 3 - 16,
                      child: const Tab(
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.comment_outlined, size: 20),
                            SizedBox(width: 4), // Reduced spacing
                            Text('Comments'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3 - 16,
                      child: const Tab(
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.forum_outlined, size: 20),
                            SizedBox(width: 4),
                            Text('Discussion'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3 - 16,
                      child: const Tab(
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.notifications_outlined, size: 20),
                            SizedBox(width: 4),
                            Text('Alerts'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: TabBarView(
                controller: _tabController,
                children: const [
                  CommentsTab(),
                  DiscussionTab(),
                  NotificationsTab(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 1,
          onTap: (index) {
            // Handle navigation
          },
          onFabPressed: () {
            // Handle FAB press
          },
        ),
      ),
    );
  }
}

class CommentsTab extends StatelessWidget {
  const CommentsTab({super.key});

  String _getInitials(String name) {
    final nameParts = name.split(' ');
    return nameParts.map((part) => part[0]).take(2).join('').toUpperCase();
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    return colors[name.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _sampleComments.length,
      itemBuilder: (context, index) {
        final comment = _sampleComments[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _getAvatarColor(comment.author),
                      child: Text(
                        _getInitials(comment.author),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.author,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            comment.timeAgo,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz),
                      onPressed: () {},
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (comment.text.startsWith('@'))
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        comment.text.split(':')[0],
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                Text(
                  comment.text.split(':').length > 1
                      ? comment.text.split(':')[1].trim()
                      : comment.text,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildActionButton(
                      icon: Icons.thumb_up_outlined,
                      label: '12',
                      onPressed: () {},
                    ),
                    const SizedBox(width: 16),
                    _buildActionButton(
                      icon: Icons.reply_outlined,
                      label: 'Reply',
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class Comment {
  final String author;
  final String text;
  final String timeAgo;

  const Comment({
    required this.author,
    required this.text,
    required this.timeAgo,
  });
}

final _sampleComments = [
  Comment(
    author: 'John Doe',
    text:
        '@Task-143: UI Design - I\'ve completed the wireframes for the dashboard. Ready for review.',
    timeAgo: '5m ago',
  ),
  Comment(
    author: 'Sarah Smith',
    text:
        '@Project-ERP: Dependencies updated in Sprint 3. We need to address the API integration issues.',
    timeAgo: '15m ago',
  ),
  Comment(
    author: 'Mike Johnson',
    text:
        '@Task-156: Backend - Database schema updated. Please review the changes and update your models.',
    timeAgo: '1h ago',
  ),
  Comment(
    author: 'Emily Brown',
    text:
        '@Project-Mobile: Milestone 2 completed ahead of schedule. QA team can start testing.',
    timeAgo: '2h ago',
  ),
];

class ChatThread {
  final String id;
  final String title;
  final List<Comment> messages;
  final List<String> participants;
  final String lastMessageTime;

  const ChatThread({
    required this.id,
    required this.title,
    required this.messages,
    required this.participants,
    required this.lastMessageTime,
  });
}

class DiscussionTab extends StatefulWidget {
  const DiscussionTab({super.key});

  @override
  State<DiscussionTab> createState() => _DiscussionTabState();
}

class _DiscussionTabState extends State<DiscussionTab> {
  ChatThread? selectedThread;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Stack(
      children: [
        if (isSmallScreen) _buildMobileView() else _buildDesktopView(),
        if (!isSmallScreen || selectedThread == null)
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: _showNewDiscussionDialog,
              backgroundColor: AppTheme.primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildMobileView() {
    return selectedThread == null
        ? _buildThreadList()
        : _buildChatView(selectedThread!);
  }

  Widget _buildDesktopView() {
    return Row(
      children: [
        SizedBox(width: 300, child: _buildThreadList()),
        const VerticalDivider(width: 1),
        Expanded(
          child:
              selectedThread == null
                  ? const Center(
                    child: Text('Select a discussion to view messages'),
                  )
                  : _buildChatView(selectedThread!),
        ),
      ],
    );
  }

  Widget _buildThreadList() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search discussions...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _sampleThreads.length,
            itemBuilder: (context, index) {
              final thread = _sampleThreads[index];
              return ListTile(
                selected: selectedThread?.id == thread.id,
                selectedTileColor: Colors.blue.shade50,
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text(_getInitials(thread.title)),
                ),
                title: Text(
                  thread.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${thread.participants.length} participants',
                  style: TextStyle(color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      thread.lastMessageTime,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    if (thread.messages.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          thread.messages.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () => setState(() => selectedThread = thread),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChatView(ChatThread thread) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              if (MediaQuery.of(context).size.width < 600)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => setState(() => selectedThread = null),
                ),
              Expanded(
                child: Text(
                  thread.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: thread.messages.length,
            itemBuilder: (context, index) {
              final message = thread.messages[index];
              final isMe = message.author == 'Me';
              return _buildMessageBubble(message, isMe);
            },
          ),
        ),
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildMessageBubble(Comment message, bool isMe) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Text(
                _getInitials(message.author),
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue.shade100 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      if (!isMe)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            message.author,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      Text(message.text),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    message.timeAgo,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ),
          if (isMe) const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.send, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  void _showNewDiscussionDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('New Discussion'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Discussion Title',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Add Participants',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Create'),
              ),
            ],
          ),
    );
  }

  String _getInitials(String name) {
    final nameParts = name.split(' ');
    return nameParts.map((part) => part[0]).take(2).join('').toUpperCase();
  }
}

final _sampleThreads = [
  ChatThread(
    id: '1',
    title: 'Project ERP Discussion',
    messages: _sampleMessages,
    participants: ['Sarah Smith', 'John Doe', 'Me'],
    lastMessageTime: '10:31 AM',
  ),
  ChatThread(
    id: '2',
    title: 'Mobile App Team',
    messages: [],
    participants: ['Emily Brown', 'Mike Johnson', 'Me'],
    lastMessageTime: 'Yesterday',
  ),
  ChatThread(
    id: '3',
    title: 'Backend Integration',
    messages: [],
    participants: ['Mike Johnson', 'Sarah Smith', 'Me'],
    lastMessageTime: '2d ago',
  ),
];

final _sampleMessages = [
  Comment(
    author: 'Sarah Smith',
    text: 'Has anyone started working on the new feature implementation?',
    timeAgo: '10:23 AM',
  ),
  Comment(
    author: 'Me',
    text:
        'Yes, I\'m currently working on it. Should be ready for review by EOD.',
    timeAgo: '10:25 AM',
  ),
  Comment(
    author: 'John Doe',
    text: 'Great! Let me know if you need any help with the integration.',
    timeAgo: '10:30 AM',
  ),
  Comment(
    author: 'Me',
    text: 'Thanks! I might need help with the API endpoints.',
    timeAgo: '10:31 AM',
  ),
];

class Notification {
  final String title;
  final String description;
  final String timeAgo;
  final IconData icon;
  final Color color;
  final bool isRead;

  const Notification({
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.icon,
    required this.color,
    this.isRead = false,
  });
}

final _sampleNotifications = [
  Notification(
    title: 'Task Assignment',
    description: 'You have been assigned to "API Integration" task',
    timeAgo: '2m ago',
    icon: Icons.assignment,
    color: Colors.blue,
  ),
  Notification(
    title: 'Meeting Reminder',
    description: 'Project Status Meeting in 30 minutes',
    timeAgo: '15m ago',
    icon: Icons.event,
    color: Colors.orange,
  ),
  Notification(
    title: 'Deadline Alert',
    description: 'Task "Dashboard UI" is due tomorrow',
    timeAgo: '1h ago',
    icon: Icons.warning,
    color: Colors.red,
  ),
  Notification(
    title: 'Comment on Task',
    description: 'Sarah Smith commented on your task',
    timeAgo: '2h ago',
    icon: Icons.comment,
    color: Colors.green,
    isRead: true,
  ),
  Notification(
    title: 'Project Update',
    description: 'New version deployed to staging',
    timeAgo: '3h ago',
    icon: Icons.update,
    color: Colors.purple,
    isRead: true,
  ),
];

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _sampleNotifications.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final notification = _sampleNotifications[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: notification.color.withOpacity(0.2),
            child: Icon(notification.icon, color: notification.color, size: 20),
          ),
          title: Text(
            notification.title,
            style: TextStyle(
              fontWeight:
                  notification.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(notification.description),
              const SizedBox(height: 4),
              Text(
                notification.timeAgo,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          isThreeLine: true,
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
