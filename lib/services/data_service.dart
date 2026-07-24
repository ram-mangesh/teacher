import '../mock/mock_data.dart';
import '../models/models.dart';

class DataService {
  UserModel get currentUser => MockDataService.currentUser;
  StaffAttendanceModel get currentAttendance => MockDataService.currentAttendance;
  List<MenuSection> get menuSections => MockDataService.menuSections;
  List<ClassSection> get classSections => MockDataService.classSections;
  List<NaacSection> get naacSections => MockDataService.naacSections;
  List<NirfParameter> get nirfParameters => MockDataService.nirfParameters;
  List<StudentAttendanceRecord> get attendanceStudents => MockDataService.attendanceStudents;
  List<StaffWallPost> get staffWallPosts => MockDataService.staffWallPosts;
  List<Assignment> get assignments => MockDataService.assignments;
  List<String> get subjects => MockDataService.subjects;
  List<String> get terms => MockDataService.terms;
  List<FeeRecord> get feeRecords => MockDataService.feeRecords;
  List<TransportRecord> get transportRecords => MockDataService.transportRecords;
  IdCardRecord get currentIdCard => MockDataService.currentIdCard;
  List<LibraryBook> get libraryBooks => MockDataService.libraryBooks;
  List<CertificateRecord> get certificates => MockDataService.certificates;
  List<PayslipRecord> get payslips => MockDataService.payslips;
  List<LeaveApplication> get leaveApplications => MockDataService.leaveApplications;
  List<StaffDirectoryEntry> get staffDirectory => MockDataService.staffDirectory;
  List<ChatConversation> get chatConversations => MockDataService.chatConversations;
  List<ChatMessage> get chatMessages => MockDataService.chatMessages;
  List<GalleryAlbum> get galleryAlbums => MockDataService.galleryAlbums;
  List<SqaDetailItem> get sqaHseItems => MockDataService.sqaHseItems;
  List<SqaDetailItem> get sqaComplianceItems => MockDataService.sqaComplianceItems;
  List<SqaDetailItem> get sqaFrameworkItems => MockDataService.sqaFrameworkItems;
  List<String> get feeTypes => MockDataService.feeTypes;
  List<String> get certificateTypes => MockDataService.certificateTypes;
  List<String> get leaveTypes => MockDataService.leaveTypes;
  List<NotificationItem> get notifications => MockDataService.notifications;
  List<TimetableEntry> get timetableEntries => MockDataService.timetableEntries;
  List<ParentNote> get parentNotes => MockDataService.parentNotes;
  List<LearningAssessment> get learningAssessments => MockDataService.learningAssessments;
  List<PeriodAttendanceRecord> get periodAttendance => MockDataService.periodAttendance;
  List<AttendanceReportRecord> get attendanceReportData => MockDataService.attendanceReportData;
  List<AttendancePercentageRecord> get attendancePercentages => MockDataService.attendancePercentages;
  List<NaacDocument> get naacDocuments => MockDataService.naacDocuments;
  List<SmsMessage> get smsMessages => MockDataService.smsMessages;
  List<Announcement> get announcements => MockDataService.announcements;
  List<CalendarEvent> get calendarEvents => MockDataService.calendarEvents;
  List<StaffMeeting> get staffMeetings => MockDataService.staffMeetings;
  List<OnlineWorksheet> get onlineWorksheets => MockDataService.onlineWorksheets;
  List<ReadingAssignment> get readingAssignments => MockDataService.readingAssignments;
  List<TeacherActivity> get teacherActivities => MockDataService.teacherActivities;
  List<PtmFeedback> get ptmFeedbacks => MockDataService.ptmFeedbacks;
  List<PtmEvent> get ptmEvents => MockDataService.ptmEvents;
  List<SubjectOutcomeRecord> get subjectOutcomes => MockDataService.subjectOutcomes;
  List<TestMarkRecord> get testMarks => MockDataService.testMarks;
  List<ExamMarkRecord> get examMarks => MockDataService.examMarks;
  List<CoScholasticRecord> get coScholasticRecords => MockDataService.coScholasticRecords;
  List<StudentRemarkRecord> get studentRemarks => MockDataService.studentRemarks;
  List<ClassTeacherRemarkRecord> get classTeacherRemarks => MockDataService.classTeacherRemarks;

  List<String> getEvaluations(String type) {
    return MockDataService.evaluationTypes[type] ?? [];
  }
}

final dataService = DataService();
