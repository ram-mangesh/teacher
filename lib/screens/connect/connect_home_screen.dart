import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../components/feature_grid_tile.dart';
import '../../services/data_service.dart';
import 'send_sms_screen.dart';
import 'chat_screen.dart';
import 'gallery_screen.dart';
import '../../utils/page_transitions.dart';

class ConnectHomeScreen extends StatelessWidget {
  const ConnectHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeatureGridTile(
                icon: Icons.sms,
                label: 'SMS',
                badgeCount: 1,
                onTap: () => Navigator.push(context, SlideRightRoute(page: const SmsListScreen())),
              ),
              FeatureGridTile(
                icon: Icons.send,
                label: 'Send SMS',
                onTap: () => Navigator.push(context, SlideRightRoute(page: const SendSmsScreen())),
              ),
              FeatureGridTile(
                icon: Icons.campaign,
                label: 'Announcements',
                onTap: () => Navigator.push(context, SlideRightRoute(page: const AnnouncementsScreen())),
              ),
              FeatureGridTile(
                icon: Icons.calendar_month,
                label: 'Calendar',
                onTap: () => Navigator.push(context, SlideRightRoute(page: const CalendarScreen())),
              ),
              FeatureGridTile(
                icon: Icons.chat,
                label: 'Chat',
                badgeCount: 2,
                onTap: () => Navigator.push(context, SlideRightRoute(page: const ChatListScreen())),
              ),
              FeatureGridTile(
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: () => Navigator.push(context, SlideRightRoute(page: const GalleryScreen())),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SmsListScreen extends StatelessWidget {
  const SmsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('SMS'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: dataService.smsMessages.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final sms = dataService.smsMessages[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryRed,
              child: Text(sms.recipient[0], style: const TextStyle(color: Colors.white, fontSize: 14)),
            ),
            title: Text(sms.recipient, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                sms.message.length > 60 ? '${sms.message.substring(0, 60)}...' : sms.message,
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(sms.date, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: sms.status == 'Sent' ? AppColors.accentGreen : AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(sms.status, style: const TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryRed,
        onPressed: () => Navigator.push(context, SlideRightRoute(page: const SendSmsScreen())),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Announcements'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: dataService.announcements.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final announcement = dataService.announcements[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        announcement.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: announcement.priority == 'High' ? AppColors.primaryRed : AppColors.accentGreen,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        announcement.priority,
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  announcement.body,
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'By ${announcement.author}',
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                    const Spacer(),
                    Text(
                      announcement.date,
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Calendar'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: dataService.calendarEvents.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final event = dataService.calendarEvents[index];
          Color badgeColor;
          switch (event.type) {
            case 'Holiday':
              badgeColor = AppColors.primaryRed;
              break;
            case 'Exam':
              badgeColor = AppColors.primaryOrange;
              break;
            default:
              badgeColor = AppColors.linkBlue;
          }
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                event.type == 'Holiday' ? Icons.celebration : event.type == 'Exam' ? Icons.quiz : Icons.event,
                color: badgeColor,
                size: 22,
              ),
            ),
            title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, size: 12, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(event.date, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  if (event.time.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Icon(Icons.access_time, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(event.time, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ],
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(event.type, style: const TextStyle(color: Colors.white, fontSize: 10)),
            ),
          );
        },
      ),
    );
  }
}
