import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // To access global state

class FakeWhatsAppScreen extends StatefulWidget {
  const FakeWhatsAppScreen({super.key});

  @override
  State<FakeWhatsAppScreen> createState() => _FakeWhatsAppScreenState();
}

class _FakeWhatsAppScreenState extends State<FakeWhatsAppScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.index == 2) { // Index 2 is "Updates/Channels"
      if (isBlockingEnabled) {
        // Immediately revert tab to prevent viewing (visual trick)
        _tabController.animateTo(0); 
        // Show lock screen
        Navigator.pushNamed(context, '/lock');
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: const Text('WhatsApp', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Chats'),
            Tab(text: 'Calls'),
            Tab(text: 'Updates'), // Channels live here
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatsList(),
          const Center(child: Text('Call History')),
          _buildChannelsList(), // This will be blocked if enabled
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF25D366),
        child: const Icon(Icons.message, color: Colors.white),
      ),
    );
  }

  Widget _buildChatsList() {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, color: Colors.grey.shade600),
          ),
          title: Text('Contact ${index + 1}'),
          subtitle: const Text('Hey, are we still meeting today?'),
          trailing: Text('10:${index + 10} AM', style: const TextStyle(color: Colors.grey)),
        );
      },
    );
  }

  Widget _buildChannelsList() {
    // This content should theoretically be hidden, but we handle the block on tab switch
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('User'),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Channels', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        // Mock Channels
        for (int i = 0; i < 5; i++)
          ListTile(
            leading: const CircleAvatar(backgroundImage: NetworkImage('https://placeholder.com/50')),
            title: Text('Public Channel ${i + 1}'),
            subtitle: Text('${(i + 1) * 100}K followers'),
            trailing: FilledButton.tonal(
              onPressed: () {},
              child: const Text('Follow'),
            ),
          ),
      ],
    );
  }
}
