class UserModel {
  final String id;
  final String name;
  final String role;
  final String designation;
  final String school;
  final String joinDate;
  final String academicYear;
  final String photoUrl;
  final List<String> sessions;

  UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.designation,
    required this.school,
    required this.joinDate,
    required this.academicYear,
    this.photoUrl = '',
    this.sessions = const ['2026-2027', '2025-2026', '2024-2025', '2023-2024', '2022-2023'],
  });

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) return '${parts.first[0]}${parts.last[0]}';
    return name.substring(0, name.length.clamp(0, 2));
  }
}

class StaffAttendanceModel {
  final String date;
  final String day;
  final String shift;
  final String? firstCheckIn;
  final String? lastCheckOut;
  final bool locationUpdated;
  final String? upcomingHoliday;
  final String? upcomingLeave;

  StaffAttendanceModel({
    required this.date,
    required this.day,
    required this.shift,
    this.firstCheckIn,
    this.lastCheckOut,
    this.locationUpdated = false,
    this.upcomingHoliday,
    this.upcomingLeave,
  });
}

class MenuItem {
  final String label;
  final String? icon;
  final bool hasChildren;
  final List<String>? children;

  MenuItem({
    required this.label,
    this.icon,
    this.hasChildren = false,
    this.children,
  });
}

class MenuSection {
  final String title;
  final List<MenuItem> items;

  MenuSection({required this.title, required this.items});
}

class NaacKeyIndicator {
  final String id;
  final String? code;
  final String title;
  String? grade;
  String? remarks;

  NaacKeyIndicator({
    required this.id,
    this.code,
    required this.title,
    this.grade,
    this.remarks,
  });
}

class NaacSection {
  final String name;
  final List<NaacKeyIndicator> keyIndicators;

  NaacSection({required this.name, required this.keyIndicators});
}

class NirfParameter {
  final String parameter;
  final double weightage;
  final int statements;
  int? benchmarks;
  String? score;

  NirfParameter({
    required this.parameter,
    required this.weightage,
    required this.statements,
    this.benchmarks,
    this.score,
  });
}

class StudentAttendanceRecord {
  final String admissionNo;
  final String name;
  final String rollNo;
  String status;
  bool isExcused;

  StudentAttendanceRecord({
    required this.admissionNo,
    required this.name,
    required this.rollNo,
    this.status = 'A',
    this.isExcused = false,
  });
}

class ClassSection {
  final String className;
  final String section;
  final String color;

  ClassSection({
    required this.className,
    required this.section,
    required this.color,
  });

  String get label => '$className-$section';
}

class StaffWallPost {
  final String id;
  final String author;
  final String category;
  final String content;
  final String date;
  final String type;

  StaffWallPost({
    required this.id,
    required this.author,
    required this.category,
    required this.content,
    required this.date,
    required this.type,
  });
}

class Assignment {
  final String id;
  final String title;
  final String className;
  final String subject;
  final String dateRange;
  final String status;

  Assignment({
    required this.id,
    required this.title,
    required this.className,
    required this.subject,
    required this.dateRange,
    this.status = 'Active',
  });
}

class PtmEvent {
  final String id;
  final String title;
  final String date;
  final String status;

  PtmEvent({
    required this.id,
    required this.title,
    required this.date,
    this.status = 'Upcoming',
  });
}

class GradeBookFormDefaults {
  final String? className;
  final String? section;
  final String? terms;
  final String? evaluation;
  final String? subject;
  final String? learningGoal;

  GradeBookFormDefaults({
    this.className,
    this.section,
    this.terms,
    this.evaluation,
    this.subject,
    this.learningGoal,
  });
}

class FeeRecord {
  final String id;
  final String studentName;
  final String className;
  final String feeType;
  final double amount;
  final double paid;
  final String dueDate;
  final String status;

  FeeRecord({
    required this.id,
    required this.studentName,
    required this.className,
    required this.feeType,
    required this.amount,
    this.paid = 0,
    required this.dueDate,
    this.status = 'Pending',
  });

  double get pending => amount - paid;
}

class TransportRecord {
  final String id;
  final String busNo;
  final String route;
  final String pickupPoint;
  final String pickupTime;
  final String dropTime;
  final String driverName;
  final String driverPhone;

  TransportRecord({
    required this.id,
    required this.busNo,
    required this.route,
    required this.pickupPoint,
    required this.pickupTime,
    required this.dropTime,
    required this.driverName,
    required this.driverPhone,
  });
}

class IdCardRecord {
  final String id;
  final String name;
  final String designation;
  final String staffId;
  final String school;
  final String joinDate;
  final String bloodGroup;
  final String phone;
  final String address;

  IdCardRecord({
    required this.id,
    required this.name,
    required this.designation,
    required this.staffId,
    required this.school,
    required this.joinDate,
    this.bloodGroup = 'B+',
    this.phone = '',
    this.address = '',
  });
}

class LibraryBook {
  final String id;
  final String title;
  final String author;
  final String isbn;
  final String category;
  final bool isAvailable;
  final String? issuedTo;
  final String? dueDate;

  LibraryBook({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.category,
    this.isAvailable = true,
    this.issuedTo,
    this.dueDate,
  });
}

class CertificateRecord {
  final String id;
  final String type;
  final String studentName;
  final String requestDate;
  final String status;
  final String? issueDate;

  CertificateRecord({
    required this.id,
    required this.type,
    required this.studentName,
    required this.requestDate,
    this.status = 'Pending',
    this.issueDate,
  });
}

class PayslipRecord {
  final String id;
  final String month;
  final String year;
  final double basicPay;
  final double hra;
  final double da;
  final double ta;
  final double pf;
  final double pt;
  final double it;
  final String status;

  PayslipRecord({
    required this.id,
    required this.month,
    required this.year,
    required this.basicPay,
    this.hra = 0,
    this.da = 0,
    this.ta = 0,
    this.pf = 0,
    this.pt = 0,
    this.it = 0,
    this.status = 'Generated',
  });

  double get grossEarnings => basicPay + hra + da + ta;
  double get totalDeductions => pf + pt + it;
  double get netPay => grossEarnings - totalDeductions;
}

class LeaveApplication {
  final String id;
  final String leaveType;
  final String fromDate;
  final String toDate;
  final int totalDays;
  final String reason;
  final String status;

  LeaveApplication({
    required this.id,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.totalDays,
    required this.reason,
    this.status = 'Pending',
  });
}

class StaffDirectoryEntry {
  final String id;
  final String name;
  final String designation;
  final String department;
  final String phone;
  final String email;

  StaffDirectoryEntry({
    required this.id,
    required this.name,
    required this.designation,
    required this.department,
    required this.phone,
    required this.email,
  });
}

class ChatMessage {
  final String id;
  final String sender;
  final String message;
  final String time;
  final bool isMe;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.message,
    required this.time,
    this.isMe = false,
  });
}

class ChatConversation {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;

  ChatConversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });
}

class GalleryAlbum {
  final String id;
  final String title;
  final String date;
  final int photoCount;
  final String thumbnailUrl;

  GalleryAlbum({
    required this.id,
    required this.title,
    required this.date,
    required this.photoCount,
    this.thumbnailUrl = '',
  });
}

class SqaDetailItem {
  final String id;
  final String title;
  final String description;
  final String status;
  final String? lastUpdated;
  final List<String>? documents;

  SqaDetailItem({
    required this.id,
    required this.title,
    required this.description,
    this.status = 'Active',
    this.lastUpdated,
    this.documents,
  });
}

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String date;
  final String type;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.type = 'info',
    this.isRead = false,
  });
}

class TimetableEntry {
  final String day;
  final String period;
  final String startTime;
  final String endTime;
  final String subject;
  final String className;
  final String section;

  TimetableEntry({
    required this.day,
    required this.period,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.className,
    required this.section,
  });
}

class ParentNote {
  final String id;
  final String studentName;
  final String className;
  final String parentName;
  final String message;
  final String date;
  final String type;

  ParentNote({
    required this.id,
    required this.studentName,
    required this.className,
    required this.parentName,
    required this.message,
    required this.date,
    this.type = 'Leave',
  });
}

class LearningAssessment {
  final String id;
  final String studentName;
  final String className;
  final String subject;
  final String assessment;
  final String score;
  final String date;

  LearningAssessment({
    required this.id,
    required this.studentName,
    required this.className,
    required this.subject,
    required this.assessment,
    required this.score,
    required this.date,
  });
}

class PeriodAttendanceRecord {
  final String period;
  final String subject;
  final String startTime;
  final String endTime;
  final int totalStudents;
  final int presentStudents;
  final String status;

  PeriodAttendanceRecord({
    required this.period,
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.totalStudents,
    required this.presentStudents,
    this.status = 'Taken',
  });
}

class AttendanceReportRecord {
  final String studentName;
  final String rollNo;
  final Map<String, String> periodStatus;

  AttendanceReportRecord({
    required this.studentName,
    required this.rollNo,
    required this.periodStatus,
  });
}

class AttendancePercentageRecord {
  final String subject;
  final double percentage;
  final int totalClasses;
  final int attendedClasses;

  AttendancePercentageRecord({
    required this.subject,
    required this.percentage,
    required this.totalClasses,
    required this.attendedClasses,
  });
}

class NaacDocument {
  final String id;
  final String title;
  final String category;
  final String uploadDate;
  final String uploadedBy;
  final String status;

  NaacDocument({
    required this.id,
    required this.title,
    required this.category,
    required this.uploadDate,
    required this.uploadedBy,
    this.status = 'Active',
  });
}

class SmsMessage {
  final String id;
  final String recipient;
  final String message;
  final String date;
  final String status;

  SmsMessage({
    required this.id,
    required this.recipient,
    required this.message,
    required this.date,
    this.status = 'Sent',
  });
}

class Announcement {
  final String id;
  final String title;
  final String body;
  final String date;
  final String author;
  final String priority;

  Announcement({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.author,
    this.priority = 'Normal',
  });
}

class CalendarEvent {
  final String id;
  final String title;
  final String date;
  final String time;
  final String type;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    this.time = '',
    this.type = 'Event',
  });
}

class StaffMeeting {
  final String id;
  final String title;
  final String date;
  final String time;
  final String venue;
  final String organizer;

  StaffMeeting({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    required this.organizer,
  });
}

class OnlineWorksheet {
  final String id;
  final String title;
  final String className;
  final String subject;
  final String assignedDate;
  final String dueDate;
  final String status;

  OnlineWorksheet({
    required this.id,
    required this.title,
    required this.className,
    required this.subject,
    required this.assignedDate,
    required this.dueDate,
    this.status = 'Active',
  });
}

class ReadingAssignment {
  final String id;
  final String title;
  final String className;
  final String subject;
  final String bookTitle;
  final String assignedDate;
  final String dueDate;
  final String status;

  ReadingAssignment({
    required this.id,
    required this.title,
    required this.className,
    required this.subject,
    required this.bookTitle,
    required this.assignedDate,
    required this.dueDate,
    this.status = 'Active',
  });
}

class TeacherActivity {
  final String id;
  final String title;
  final String description;
  final String date;
  final String type;

  TeacherActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.type = 'General',
  });
}

class PtmFeedback {
  final String id;
  final String studentName;
  final String className;
  final String parentName;
  final String feedback;
  final String date;
  final String status;

  PtmFeedback({
    required this.id,
    required this.studentName,
    required this.className,
    required this.parentName,
    required this.feedback,
    required this.date,
    this.status = 'Pending',
  });
}

class SubjectOutcomeRecord {
  final String studentName;
  final String rollNo;
  final String classSection;
  final String subject;
  final String learningGoal;
  final String term;
  final String grade;
  final String remarks;

  SubjectOutcomeRecord({
    required this.studentName,
    required this.rollNo,
    required this.classSection,
    required this.subject,
    required this.learningGoal,
    required this.term,
    required this.grade,
    required this.remarks,
  });
}

class TestMarkRecord {
  final String studentName;
  final String rollNo;
  final String classSection;
  final String subject;
  final String testName;
  final int maxMarks;
  final int marksObtained;
  final String evaluation;

  TestMarkRecord({
    required this.studentName,
    required this.rollNo,
    required this.classSection,
    required this.subject,
    required this.testName,
    required this.maxMarks,
    required this.marksObtained,
    required this.evaluation,
  });

  String get percentage => '${((marksObtained / maxMarks) * 100).toStringAsFixed(1)}%';
}

class ExamMarkRecord {
  final String studentName;
  final String rollNo;
  final String classSection;
  final String subject;
  final String examName;
  final int maxMarks;
  final int marksObtained;
  final String grade;

  ExamMarkRecord({
    required this.studentName,
    required this.rollNo,
    required this.classSection,
    required this.subject,
    required this.examName,
    required this.maxMarks,
    required this.marksObtained,
    required this.grade,
  });

  String get percentage => '${((marksObtained / maxMarks) * 100).toStringAsFixed(1)}%';
}

class CoScholasticRecord {
  final String studentName;
  final String rollNo;
  final String classSection;
  final String skill;
  final String assessment;
  final String grade;

  CoScholasticRecord({
    required this.studentName,
    required this.rollNo,
    required this.classSection,
    required this.skill,
    required this.assessment,
    required this.grade,
  });
}

class StudentRemarkRecord {
  final String studentName;
  final String rollNo;
  final String classSection;
  final String field;
  final String remark;
  final String messageType;

  StudentRemarkRecord({
    required this.studentName,
    required this.rollNo,
    required this.classSection,
    required this.field,
    required this.remark,
    this.messageType = 'Custom',
  });
}

class ClassTeacherRemarkRecord {
  final String studentName;
  final String rollNo;
  final String classSection;
  final String remark;

  ClassTeacherRemarkRecord({
    required this.studentName,
    required this.rollNo,
    required this.classSection,
    required this.remark,
  });
}
