import '../models/models.dart';

class MockDataService {
  static final UserModel currentUser = UserModel(
    id: 'IJS35700075',
    name: 'Radhika Chandraprakash Jaiswal',
    role: 'Staff - Teaching',
    designation: 'Secondary Teacher',
    school: 'Infant Jesus High School, Nallasopara',
    joinDate: '2017-06-01',
    academicYear: '2026-2027',
  );

  static final StaffAttendanceModel currentAttendance = StaffAttendanceModel(
    date: '23 Jul 2026',
    day: 'Thursday',
    shift: 'SECONDARY TEACHER (6:45 AM - 1:00 PM)',
    firstCheckIn: null,
    lastCheckOut: null,
    locationUpdated: false,
    upcomingHoliday: null,
    upcomingLeave: null,
  );

  static final List<MenuSection> menuSections = [
    MenuSection(title: 'ERP', items: [
      MenuItem(label: 'SIS', icon: 'people'),
      MenuItem(label: 'Period Wise Attendance Report', icon: 'assignment'),
      MenuItem(label: 'Period Wise Attendance Percentage Report', icon: 'pie_chart'),
      MenuItem(label: 'Give PTM Feedback', icon: 'feedback'),
      MenuItem(label: 'Manage PTM', icon: 'event'),
      MenuItem(label: 'Student Report', icon: 'analytics'),
      MenuItem(label: 'Give Attendance', icon: 'check_circle'),
      MenuItem(label: 'Period Wise Attendance', icon: 'schedule'),
      MenuItem(label: 'Professional Student Attendance', icon: 'how_to_reg'),
      MenuItem(label: 'Parent Notes / Leave Intimations', icon: 'note'),
      MenuItem(label: 'Learning Based Assessment', icon: 'school'),
      MenuItem(label: 'Time Table', icon: 'table_chart'),
      MenuItem(label: 'Fee Collection', icon: 'receipt_long'),
      MenuItem(label: 'Transport', icon: 'directions_bus'),
      MenuItem(label: 'ID Card', icon: 'badge'),
      MenuItem(label: 'Library', icon: 'menu_book'),
      MenuItem(label: 'Certificates', icon: 'description'),
    ]),
    MenuSection(title: 'HR', items: [
      MenuItem(label: 'HR', icon: 'business'),
      MenuItem(label: 'Staff Wall', icon: 'wall_art'),
      MenuItem(label: 'Staff Meetings', icon: 'groups'),
      MenuItem(label: 'Payslip', icon: 'receipt'),
      MenuItem(label: 'Leave Application', icon: 'leave_bags_at_home'),
      MenuItem(label: 'Staff Directory', icon: 'contact_phone'),
    ]),
    MenuSection(title: 'GRADE BOOK', items: [
      MenuItem(label: 'CBSE and State', icon: 'menu_book'),
      MenuItem(label: 'Subject Outcomes', icon: 'trending_up'),
      MenuItem(label: 'Test and Marks', icon: 'grading'),
      MenuItem(label: 'Examination Marks', icon: 'emoji_events'),
      MenuItem(label: 'CoScholastic Grade Entry', icon: 'star'),
      MenuItem(label: 'Student Remarks', icon: 'remark'),
      MenuItem(label: 'Class Teacher Remarks', icon: 'rate_review'),
    ]),
    MenuSection(title: 'LMS', items: [
      MenuItem(label: 'Assignments', icon: 'assignment_turned_in'),
      MenuItem(label: 'Online Worksheet', icon: 'edit_note'),
      MenuItem(label: 'Reading Assignment', icon: 'auto_stories'),
    ]),
    MenuSection(title: 'CONNECT', items: [
      MenuItem(label: 'SMS', icon: 'sms'),
      MenuItem(label: 'Send SMS', icon: 'send'),
      MenuItem(label: 'Announcements', icon: 'campaign'),
      MenuItem(label: 'Calendar', icon: 'calendar_month'),
      MenuItem(label: 'Chat', icon: 'chat'),
      MenuItem(label: 'Gallery', icon: 'photo_library'),
    ]),
    MenuSection(title: 'ADMIN', items: [
      MenuItem(label: 'SQAA', icon: 'verified'),
      MenuItem(label: 'NAAC and NIRF', icon: 'assessment'),
    ]),
  ];

  static final List<ClassSection> classSections = [
    ClassSection(className: '9', section: 'A', color: '#E8342A'),
    ClassSection(className: '9', section: 'E', color: '#FF6A3D'),
    ClassSection(className: '10', section: 'A', color: '#3CB878'),
    ClassSection(className: '10', section: 'B', color: '#1976D2'),
    ClassSection(className: '10', section: 'D', color: '#9C27B0'),
    ClassSection(className: '10', section: 'F', color: '#FF9800'),
  ];

  static final List<NaacSection> naacSections = [
    NaacSection(name: 'Curricular Aspects', keyIndicators: [
      NaacKeyIndicator(id: 'ki1', code: '(U)', title: 'Curriculum Design and Development'),
      NaacKeyIndicator(id: 'ki2', code: '(A)', title: 'Curricular Planning and Implementation'),
      NaacKeyIndicator(id: 'ki3', title: 'Academic Flexibility'),
      NaacKeyIndicator(id: 'ki4', title: 'Curriculum Enrichment'),
      NaacKeyIndicator(id: 'ki5', title: 'Feedback System'),
    ]),
    NaacSection(name: 'Teaching-Learning and Evaluation', keyIndicators: [
      NaacKeyIndicator(id: 'ki6', title: 'Student Enrolment and Profile'),
      NaacKeyIndicator(id: 'ki7', title: 'Catering to Student Diversity'),
      NaacKeyIndicator(id: 'ki8', title: 'Teaching-Learning Process'),
      NaacKeyIndicator(id: 'ki9', title: 'Teacher Profile and Quality'),
      NaacKeyIndicator(id: 'ki10', title: 'Evaluation Process and Reforms'),
    ]),
  ];

  static final List<NirfParameter> nirfParameters = [
    NirfParameter(parameter: 'Teaching, Learning & Resources', weightage: 0.30, statements: 4, benchmarks: 13),
    NirfParameter(parameter: 'Research and Professional Practice', weightage: 0.30, statements: 4, benchmarks: 9),
    NirfParameter(parameter: 'Graduation Outcomes', weightage: 0.20, statements: 4),
  ];

  static final List<StudentAttendanceRecord> attendanceStudents = [
    StudentAttendanceRecord(admissionNo: 'IJS001', name: 'Aarav Sharma', rollNo: '01'),
    StudentAttendanceRecord(admissionNo: 'IJS002', name: 'Ananya Patel', rollNo: '02'),
    StudentAttendanceRecord(admissionNo: 'IJS003', name: 'Arjun Singh', rollNo: '03', status: 'P'),
    StudentAttendanceRecord(admissionNo: 'IJS004', name: 'Diya Gupta', rollNo: '04'),
    StudentAttendanceRecord(admissionNo: 'IJS005', name: 'Ishaan Verma', rollNo: '05', status: 'P'),
    StudentAttendanceRecord(admissionNo: 'IJS006', name: 'Kavya Reddy', rollNo: '06'),
    StudentAttendanceRecord(admissionNo: 'IJS007', name: 'Nikhil Kumar', rollNo: '07', status: 'P'),
    StudentAttendanceRecord(admissionNo: 'IJS008', name: 'Priya Nair', rollNo: '08'),
  ];

  static final List<StaffWallPost> staffWallPosts = [
    StaffWallPost(id: 'SW001', author: 'Principal Thomas', category: 'Announcement', content: 'School will remain closed on 25th July 2026 due to heavy rain warning. All staff and students take note.', date: '23 Jul 2026', type: 'Announcement'),
    StaffWallPost(id: 'SW002', author: 'Vice Principal', category: 'Announcement', content: 'Staff meeting scheduled for 25th July at 2:00 PM in the Conference Hall. All teaching staff mandatory.', date: '22 Jul 2026', type: 'Announcement'),
    StaffWallPost(id: 'SW003', author: 'Amit Kumar', category: 'System Group', content: 'Congratulations to all students who participated in the inter-school science exhibition! Our school won 2 gold medals.', date: '21 Jul 2026', type: 'System Group'),
    StaffWallPost(id: 'SW004', author: 'Radhika Jaiswal', category: 'Custom', content: 'Class 9-A students have been doing excellent work in Computer Science. Keep up the good work!', date: '20 Jul 2026', type: 'Custom'),
    StaffWallPost(id: 'SW005', author: 'Sneha Reddy', category: 'Announcement', content: 'Library will have extended hours next week for exam preparation. Open till 4:00 PM.', date: '19 Jul 2026', type: 'Announcement'),
  ];

  static final List<Assignment> assignments = [
    Assignment(id: 'A001', title: 'Chapter 3 - Data Structures Worksheet', className: '9-A', subject: 'Computer', dateRange: '20 Jul 2026 - 27 Jul 2026', status: 'Active'),
    Assignment(id: 'A002', title: 'Quadratic Equations Practice', className: '9-A', subject: 'Mathematics', dateRange: '18 Jul 2026 - 25 Jul 2026', status: 'Active'),
    Assignment(id: 'A003', title: 'Essay on Environmental Pollution', className: '10-A', subject: 'English', dateRange: '15 Jul 2026 - 22 Jul 2026', status: 'Completed'),
    Assignment(id: 'A004', title: 'Science Lab Report - Acids & Bases', className: '10-A', subject: 'Science', dateRange: '22 Jul 2026 - 29 Jul 2026', status: 'Active'),
    Assignment(id: 'A005', title: 'History Chapter 5 - Notes', className: '10-B', subject: 'Social Science', dateRange: '19 Jul 2026 - 26 Jul 2026', status: 'Active'),
  ];

  static final List<PtmEvent> ptmEvents = [
    PtmEvent(id: 'PTM001', title: 'PTM Class 9 - Term I', date: '25 Jul 2026', status: 'Upcoming'),
    PtmEvent(id: 'PTM002', title: 'PTM Class 10 - Term I', date: '26 Jul 2026', status: 'Upcoming'),
    PtmEvent(id: 'PTM003', title: 'PTM Class 9 - Mid Term Review', date: '15 Jun 2026', status: 'Past'),
    PtmEvent(id: 'PTM004', title: 'PTM Class 10 - Annual Review', date: '10 Mar 2026', status: 'Past'),
  ];

  static final List<NotificationItem> notifications = [
    NotificationItem(id: 'N001', title: 'Attendance Marked', body: 'Your attendance for 23 Jul 2026 has been recorded.', date: '23 Jul 2026', type: 'info'),
    NotificationItem(id: 'N002', title: 'PTM Scheduled', body: 'Parent-Teacher Meeting for Class 9 is scheduled on 25 Jul 2026.', date: '22 Jul 2026', type: 'event', isRead: true),
    NotificationItem(id: 'N003', title: 'Assignment Due', body: 'Chapter 3 - Data Structures Worksheet is due on 27 Jul 2026.', date: '21 Jul 2026', type: 'warning'),
    NotificationItem(id: 'N004', title: 'Payslip Generated', body: 'Your July 2026 payslip has been generated. Check HR module.', date: '20 Jul 2026', type: 'info', isRead: true),
    NotificationItem(id: 'N005', title: 'Leave Approved', body: 'Your Casual Leave request for 25 Jul 2026 has been approved.', date: '19 Jul 2026', type: 'success', isRead: true),
  ];

  static final List<TimetableEntry> timetableEntries = [
    TimetableEntry(day: 'Monday', period: '1', startTime: '7:00 AM', endTime: '7:40 AM', subject: 'Mathematics', className: '9', section: 'A'),
    TimetableEntry(day: 'Monday', period: '2', startTime: '7:40 AM', endTime: '8:20 AM', subject: 'English', className: '9', section: 'A'),
    TimetableEntry(day: 'Monday', period: '3', startTime: '8:20 AM', endTime: '9:00 AM', subject: 'Science', className: '9', section: 'A'),
    TimetableEntry(day: 'Monday', period: '4', startTime: '9:15 AM', endTime: '9:55 AM', subject: 'Computer', className: '9', section: 'A'),
    TimetableEntry(day: 'Monday', period: '5', startTime: '9:55 AM', endTime: '10:35 AM', subject: 'Marathi', className: '9', section: 'A'),
    TimetableEntry(day: 'Monday', period: '6', startTime: '10:35 AM', endTime: '11:15 AM', subject: 'Hindi', className: '9', section: 'A'),
    TimetableEntry(day: 'Tuesday', period: '1', startTime: '7:00 AM', endTime: '7:40 AM', subject: 'Science', className: '9', section: 'A'),
    TimetableEntry(day: 'Tuesday', period: '2', startTime: '7:40 AM', endTime: '8:20 AM', subject: 'Mathematics', className: '9', section: 'A'),
    TimetableEntry(day: 'Tuesday', period: '3', startTime: '8:20 AM', endTime: '9:00 AM', subject: 'English', className: '9', section: 'A'),
    TimetableEntry(day: 'Tuesday', period: '4', startTime: '9:15 AM', endTime: '9:55 AM', subject: 'Social Science', className: '9', section: 'A'),
    TimetableEntry(day: 'Tuesday', period: '5', startTime: '9:55 AM', endTime: '10:35 AM', subject: 'Computer', className: '9', section: 'A'),
    TimetableEntry(day: 'Tuesday', period: '6', startTime: '10:35 AM', endTime: '11:15 AM', subject: 'Hindi', className: '9', section: 'A'),
    TimetableEntry(day: 'Wednesday', period: '1', startTime: '7:00 AM', endTime: '7:40 AM', subject: 'English', className: '9', section: 'A'),
    TimetableEntry(day: 'Wednesday', period: '2', startTime: '7:40 AM', endTime: '8:20 AM', subject: 'Science', className: '9', section: 'A'),
    TimetableEntry(day: 'Wednesday', period: '3', startTime: '8:20 AM', endTime: '9:00 AM', subject: 'Mathematics', className: '9', section: 'A'),
    TimetableEntry(day: 'Wednesday', period: '4', startTime: '9:15 AM', endTime: '9:55 AM', subject: 'Marathi', className: '9', section: 'A'),
    TimetableEntry(day: 'Wednesday', period: '5', startTime: '9:55 AM', endTime: '10:35 AM', subject: 'Social Science', className: '9', section: 'A'),
    TimetableEntry(day: 'Wednesday', period: '6', startTime: '10:35 AM', endTime: '11:15 AM', subject: 'Computer', className: '9', section: 'A'),
    TimetableEntry(day: 'Thursday', period: '1', startTime: '7:00 AM', endTime: '7:40 AM', subject: 'Marathi', className: '9', section: 'A'),
    TimetableEntry(day: 'Thursday', period: '2', startTime: '7:40 AM', endTime: '8:20 AM', subject: 'Mathematics', className: '9', section: 'A'),
    TimetableEntry(day: 'Thursday', period: '3', startTime: '8:20 AM', endTime: '9:00 AM', subject: 'English', className: '9', section: 'A'),
    TimetableEntry(day: 'Thursday', period: '4', startTime: '9:15 AM', endTime: '9:55 AM', subject: 'Science', className: '9', section: 'A'),
    TimetableEntry(day: 'Thursday', period: '5', startTime: '9:55 AM', endTime: '10:35 AM', subject: 'Hindi', className: '9', section: 'A'),
    TimetableEntry(day: 'Thursday', period: '6', startTime: '10:35 AM', endTime: '11:15 AM', subject: 'Social Science', className: '9', section: 'A'),
    TimetableEntry(day: 'Friday', period: '1', startTime: '7:00 AM', endTime: '7:40 AM', subject: 'Hindi', className: '9', section: 'A'),
    TimetableEntry(day: 'Friday', period: '2', startTime: '7:40 AM', endTime: '8:20 AM', subject: 'Science', className: '9', section: 'A'),
    TimetableEntry(day: 'Friday', period: '3', startTime: '8:20 AM', endTime: '9:00 AM', subject: 'Computer', className: '9', section: 'A'),
    TimetableEntry(day: 'Friday', period: '4', startTime: '9:15 AM', endTime: '9:55 AM', subject: 'Mathematics', className: '9', section: 'A'),
    TimetableEntry(day: 'Friday', period: '5', startTime: '9:55 AM', endTime: '10:35 AM', subject: 'English', className: '9', section: 'A'),
    TimetableEntry(day: 'Friday', period: '6', startTime: '10:35 AM', endTime: '11:15 AM', subject: 'Marathi', className: '9', section: 'A'),
    TimetableEntry(day: 'Saturday', period: '1', startTime: '7:00 AM', endTime: '7:40 AM', subject: 'Social Science', className: '9', section: 'A'),
    TimetableEntry(day: 'Saturday', period: '2', startTime: '7:40 AM', endTime: '8:20 AM', subject: 'Computer', className: '9', section: 'A'),
    TimetableEntry(day: 'Saturday', period: '3', startTime: '8:20 AM', endTime: '9:00 AM', subject: 'Marathi', className: '9', section: 'A'),
  ];

  static final List<ParentNote> parentNotes = [
    ParentNote(id: 'PN001', studentName: 'Aarav Sharma', className: '9-A', parentName: 'Mr. Sharma', message: 'Aarav will be absent today due to fever. Please excuse his absence.', date: '23 Jul 2026', type: 'Leave'),
    ParentNote(id: 'PN002', studentName: 'Diya Gupta', className: '9-A', parentName: 'Mrs. Gupta', message: 'Diya has a dental appointment and will leave early today.', date: '23 Jul 2026', type: 'Leave'),
    ParentNote(id: 'PN003', studentName: 'Ishaan Verma', className: '9-A', parentName: 'Mr. Verma', message: 'Ishaan will be participating in the district-level cricket tournament next week. Please grant leave from 28-30 Jul.', date: '22 Jul 2026', type: 'Leave'),
    ParentNote(id: 'PN004', studentName: 'Kavya Reddy', className: '9-A', parentName: 'Mrs. Reddy', message: 'Kavya has been unwell since Monday. She will rejoin on Thursday.', date: '20 Jul 2026', type: 'Leave'),
  ];

  static final List<LearningAssessment> learningAssessments = [
    LearningAssessment(id: 'LA001', studentName: 'Aarav Sharma', className: '9-A', subject: 'Computer', assessment: 'Programming Fundamentals', score: '85/100', date: '20 Jul 2026'),
    LearningAssessment(id: 'LA002', studentName: 'Ananya Patel', className: '9-A', subject: 'Computer', assessment: 'Data Structures Basics', score: '92/100', date: '20 Jul 2026'),
    LearningAssessment(id: 'LA003', studentName: 'Arjun Singh', className: '9-A', subject: 'Mathematics', assessment: 'Algebra Test', score: '78/100', date: '18 Jul 2026'),
    LearningAssessment(id: 'LA004', studentName: 'Diya Gupta', className: '9-A', subject: 'English', assessment: 'Essay Writing', score: '88/100', date: '17 Jul 2026'),
    LearningAssessment(id: 'LA005', studentName: 'Ishaan Verma', className: '9-A', subject: 'Science', assessment: 'Lab Practical', score: '95/100', date: '15 Jul 2026'),
  ];

  static final List<PeriodAttendanceRecord> periodAttendance = [
    PeriodAttendanceRecord(period: '1', subject: 'Mathematics', startTime: '7:00 AM', endTime: '7:40 AM', totalStudents: 42, presentStudents: 38),
    PeriodAttendanceRecord(period: '2', subject: 'English', startTime: '7:40 AM', endTime: '8:20 AM', totalStudents: 42, presentStudents: 40),
    PeriodAttendanceRecord(period: '3', subject: 'Science', startTime: '8:20 AM', endTime: '9:00 AM', totalStudents: 42, presentStudents: 39),
    PeriodAttendanceRecord(period: '4', subject: 'Computer', startTime: '9:15 AM', endTime: '9:55 AM', totalStudents: 42, presentStudents: 41),
    PeriodAttendanceRecord(period: '5', subject: 'Marathi', startTime: '9:55 AM', endTime: '10:35 AM', totalStudents: 42, presentStudents: 37),
    PeriodAttendanceRecord(period: '6', subject: 'Hindi', startTime: '10:35 AM', endTime: '11:15 AM', totalStudents: 42, presentStudents: 40),
  ];

  static final List<AttendanceReportRecord> attendanceReportData = [
    AttendanceReportRecord(studentName: 'Aarav Sharma', rollNo: '01', periodStatus: {'1': 'P', '2': 'A', '3': 'P', '4': 'P', '5': 'P', '6': 'A'}),
    AttendanceReportRecord(studentName: 'Ananya Patel', rollNo: '02', periodStatus: {'1': 'P', '2': 'P', '3': 'P', '4': 'P', '5': 'P', '6': 'P'}),
    AttendanceReportRecord(studentName: 'Arjun Singh', rollNo: '03', periodStatus: {'1': 'A', '2': 'P', '3': 'P', '4': 'A', '5': 'P', '6': 'P'}),
    AttendanceReportRecord(studentName: 'Diya Gupta', rollNo: '04', periodStatus: {'1': 'P', '2': 'P', '3': 'A', '4': 'P', '5': 'P', '6': 'P'}),
    AttendanceReportRecord(studentName: 'Ishaan Verma', rollNo: '05', periodStatus: {'1': 'P', '2': 'P', '3': 'P', '4': 'P', '5': 'P', '6': 'P'}),
  ];

  static final List<AttendancePercentageRecord> attendancePercentages = [
    AttendancePercentageRecord(subject: 'Computer', percentage: 94.5, totalClasses: 22, attendedClasses: 21),
    AttendancePercentageRecord(subject: 'English', percentage: 88.2, totalClasses: 22, attendedClasses: 19),
    AttendancePercentageRecord(subject: 'Marathi', percentage: 91.0, totalClasses: 22, attendedClasses: 20),
    AttendancePercentageRecord(subject: 'Hindi', percentage: 85.7, totalClasses: 22, attendedClasses: 19),
    AttendancePercentageRecord(subject: 'Mathematics', percentage: 92.3, totalClasses: 22, attendedClasses: 20),
    AttendancePercentageRecord(subject: 'Science', percentage: 89.5, totalClasses: 22, attendedClasses: 20),
    AttendancePercentageRecord(subject: 'Social Science', percentage: 87.0, totalClasses: 22, attendedClasses: 19),
  ];

  static final List<NaacDocument> naacDocuments = [
    NaacDocument(id: 'ND001', title: 'Curriculum Design Framework 2026', category: 'Curricular Aspects', uploadDate: '01 Jun 2026', uploadedBy: 'Dr. Priya Sharma'),
    NaacDocument(id: 'ND002', title: 'Teaching Learning Methodology', category: 'Teaching-Learning', uploadDate: '15 May 2026', uploadedBy: 'Mr. Amit Kumar'),
    NaacDocument(id: 'ND003', title: 'Student Assessment Policy', category: 'Assessment', uploadDate: '10 Apr 2026', uploadedBy: 'Mrs. Radhika Jaiswal'),
    NaacDocument(id: 'ND004', title: 'Research Publications 2025-26', category: 'Research', uploadDate: '01 Mar 2026', uploadedBy: 'Dr. Priya Sharma'),
    NaacDocument(id: 'ND005', title: 'Infrastructure Development Plan', category: 'Infrastructure', uploadDate: '15 Feb 2026', uploadedBy: 'Mr. Rajesh Patil'),
  ];

  static final List<SmsMessage> smsMessages = [
    SmsMessage(id: 'SMS001', recipient: 'All Parents - Class 9', message: 'Dear Parents, PTM is scheduled on 25 Jul 2026. Please attend between 9 AM - 12 PM.', date: '22 Jul 2026', status: 'Sent'),
    SmsMessage(id: 'SMS002', recipient: 'All Parents - Class 10', message: 'Reminder: Pre-board exams start from 1 Aug 2026. Ensure students prepare well.', date: '21 Jul 2026', status: 'Sent'),
    SmsMessage(id: 'SMS003', recipient: 'Mr. Sharma (Aarav)', message: 'Aarav was absent today. Please submit a leave application.', date: '20 Jul 2026', status: 'Sent'),
    SmsMessage(id: 'SMS004', recipient: 'All Staff', message: 'Staff meeting on 25 Jul at 2 PM in Conference Hall. Mandatory attendance.', date: '22 Jul 2026', status: 'Sent'),
  ];

  static final List<Announcement> announcements = [
    Announcement(id: 'AN001', title: 'School Holiday - Heavy Rain', body: 'School will remain closed on 25th July 2026 due to heavy rainfall warning by IMD. All exams scheduled for that day will be rescheduled.', date: '23 Jul 2026', author: 'Principal', priority: 'High'),
    Announcement(id: 'AN002', title: 'Annual Day Celebration', body: 'Annual Day celebration will be held on 15th August 2026. Cultural programs to start at 10:00 AM. Parents are cordially invited.', date: '20 Jul 2026', author: 'Principal', priority: 'Normal'),
    Announcement(id: 'AN003', title: 'Sports Day Schedule', body: 'Inter-house sports competition will be conducted from 1st to 3rd August 2026. Students should come in sports uniform.', date: '18 Jul 2026', author: 'Sports Dept', priority: 'Normal'),
    Announcement(id: 'AN004', title: 'Science Exhibition Results', body: 'Congratulations to all participants! Results of the inter-school science exhibition will be announced on 26 Jul 2026.', date: '15 Jul 2026', author: 'Science Dept', priority: 'Normal'),
  ];

  static final List<CalendarEvent> calendarEvents = [
    CalendarEvent(id: 'CE001', title: 'School Holiday - Rain', date: '25 Jul 2026', type: 'Holiday'),
    CalendarEvent(id: 'CE002', title: 'PTM Class 9', date: '25 Jul 2026', time: '9:00 AM - 12:00 PM', type: 'Event'),
    CalendarEvent(id: 'CE003', title: 'PTM Class 10', date: '26 Jul 2026', time: '9:00 AM - 12:00 PM', type: 'Event'),
    CalendarEvent(id: 'CE004', title: 'Independence Day', date: '15 Aug 2026', type: 'Holiday'),
    CalendarEvent(id: 'CE005', title: 'Sports Day - Day 1', date: '01 Aug 2026', time: '7:00 AM - 1:00 PM', type: 'Event'),
    CalendarEvent(id: 'CE006', title: 'Sports Day - Day 2', date: '02 Aug 2026', time: '7:00 AM - 1:00 PM', type: 'Event'),
    CalendarEvent(id: 'CE007', title: 'Sports Day - Day 3', date: '03 Aug 2026', time: '7:00 AM - 1:00 PM', type: 'Event'),
    CalendarEvent(id: 'CE008', title: 'Pre-Board Exam Starts', date: '01 Aug 2026', type: 'Exam'),
    CalendarEvent(id: 'CE009', title: 'Teachers Day', date: '05 Sep 2026', type: 'Event'),
    CalendarEvent(id: 'CE010', title: 'Ganesh Chaturthi', date: '27 Aug 2026', type: 'Holiday'),
  ];

  static final List<StaffMeeting> staffMeetings = [
    StaffMeeting(id: 'SM001', title: 'Monthly Staff Meeting', date: '25 Jul 2026', time: '2:00 PM', venue: 'Conference Hall', organizer: 'Principal'),
    StaffMeeting(id: 'SM002', title: 'Curriculum Review Meeting', date: '18 Jul 2026', time: '3:00 PM', venue: 'Staff Room', organizer: 'Vice Principal'),
    StaffMeeting(id: 'SM003', title: 'PTM Planning Meeting', date: '12 Jul 2026', time: '2:30 PM', venue: 'Conference Hall', organizer: 'Principal'),
    StaffMeeting(id: 'SM004', title: 'Sports Day Coordination', date: '05 Jul 2026', time: '3:00 PM', venue: 'Staff Room', organizer: 'Sports Dept'),
    StaffMeeting(id: 'SM005', title: 'Examination Committee Meeting', date: '28 Jun 2026', time: '2:00 PM', venue: 'Conference Hall', organizer: 'Exam Cell'),
  ];

  static final List<OnlineWorksheet> onlineWorksheets = [
    OnlineWorksheet(id: 'OW001', title: 'Python Basics Quiz', className: '9-A', subject: 'Computer', assignedDate: '20 Jul 2026', dueDate: '27 Jul 2026', status: 'Active'),
    OnlineWorksheet(id: 'OW002', title: 'Algebra Worksheet', className: '9-A', subject: 'Mathematics', assignedDate: '18 Jul 2026', dueDate: '25 Jul 2026', status: 'Active'),
    OnlineWorksheet(id: 'OW003', title: 'Grammar Test - Tenses', className: '10-A', subject: 'English', assignedDate: '15 Jul 2026', dueDate: '22 Jul 2026', status: 'Completed'),
  ];

  static final List<ReadingAssignment> readingAssignments = [
    ReadingAssignment(id: 'RA001', title: 'Chapter 5 - The Story of My Life', className: '9-A', subject: 'English', bookTitle: 'The Story of My Life - Helen Keller', assignedDate: '20 Jul 2026', dueDate: '30 Jul 2026', status: 'Active'),
    ReadingAssignment(id: 'RA002', title: 'Chapter 3 - Our Environment', className: '9-A', subject: 'Science', bookTitle: 'NCERT Science Class 9', assignedDate: '15 Jul 2026', dueDate: '25 Jul 2026', status: 'Active'),
    ReadingAssignment(id: 'RA003', title: 'Poem - The Road Not Taken', className: '10-A', subject: 'English', bookTitle: 'First Flight - NCERT', assignedDate: '10 Jul 2026', dueDate: '20 Jul 2026', status: 'Completed'),
  ];

  static final List<TeacherActivity> teacherActivities = [
    TeacherActivity(id: 'TA001', title: 'Class 9-A Computer Lab', description: 'Conducted practical session on Python programming', date: '23 Jul 2026', type: 'Teaching'),
    TeacherActivity(id: 'TA002', title: 'PTM Preparation', description: 'Prepared progress reports for Class 9 students', date: '22 Jul 2026', type: 'Administrative'),
    TeacherActivity(id: 'TA003', title: 'Science Exhibition Supervision', description: 'Supervised student projects for inter-school exhibition', date: '20 Jul 2026', type: 'Event'),
    TeacherActivity(id: 'TA004', title: 'Assignment Grading', description: 'Graded Chapter 2 assignments for Class 9-A and 9-E', date: '19 Jul 2026', type: 'Administrative'),
  ];

  static final List<PtmFeedback> ptmFeedbacks = [
    PtmFeedback(id: 'PF001', studentName: 'Aarav Sharma', className: '9-A', parentName: 'Mr. Sharma', feedback: 'Aarav is doing well in academics. Needs to improve handwriting.', date: '15 Jun 2026', status: 'Completed'),
    PtmFeedback(id: 'PF002', studentName: 'Ananya Patel', className: '9-A', parentName: 'Mrs. Patel', feedback: 'Ananya is very attentive in class. Should participate more in sports.', date: '15 Jun 2026', status: 'Completed'),
    PtmFeedback(id: 'PF003', studentName: 'Arjun Singh', className: '9-A', parentName: 'Mr. Singh', feedback: 'Arjun needs to work on Mathematics. Suggested extra practice.', date: '15 Jun 2026', status: 'Completed'),
    PtmFeedback(id: 'PF004', studentName: 'Diya Gupta', className: '9-A', parentName: 'Mrs. Gupta', feedback: 'Diya is an excellent student. Keep up the good work!', date: '15 Jun 2026', status: 'Completed'),
  ];

  static final List<String> subjects = [
    'Computer',
    'English',
    'Marathi',
    'Hindi',
    'Mathematics',
    'Science',
    'Social Science',
  ];

  static final List<String> terms = [
    'TERM-I (01 Jun 2026 to 31 Oct 2026)',
    'TERM-II (01 Nov 2026 to 31 Mar 2027)',
  ];

  static final Map<String, List<String>> evaluationTypes = {
    'subjectOutcomes': ['Term Wise', 'Year Wise'],
    'testAndMarks': ['FIRST UNIT TEST:2025-2026 (Formative)', 'SECOND UNIT TEST:2025-2026 (Formative)', 'FIRST TERMINAL:2025-2026 (Summative)'],
    'examinationMarks': ['FIRST TERMINAL:2025-2026 (Summative)', 'ANNUAL:2025-2026 (Summative)'],
  };

  static final List<FeeRecord> feeRecords = [
    FeeRecord(id: 'F001', studentName: 'Aarav Sharma', className: '9-A', feeType: 'Tuition Fee', amount: 15000, paid: 15000, dueDate: '30 Jun 2026', status: 'Paid'),
    FeeRecord(id: 'F002', studentName: 'Ananya Patel', className: '9-A', feeType: 'Tuition Fee', amount: 15000, paid: 7500, dueDate: '30 Jun 2026', status: 'Partial'),
    FeeRecord(id: 'F003', studentName: 'Arjun Singh', className: '9-A', feeType: 'Lab Fee', amount: 3000, paid: 0, dueDate: '15 Jul 2026', status: 'Pending'),
    FeeRecord(id: 'F004', studentName: 'Diya Gupta', className: '9-A', feeType: 'Transport Fee', amount: 8000, paid: 0, dueDate: '30 Jun 2026', status: 'Overdue'),
    FeeRecord(id: 'F005', studentName: 'Ishaan Verma', className: '9-A', feeType: 'Tuition Fee', amount: 15000, paid: 15000, dueDate: '30 Jun 2026', status: 'Paid'),
    FeeRecord(id: 'F006', studentName: 'Kavya Reddy', className: '9-A', feeType: 'Library Fee', amount: 2000, paid: 0, dueDate: '15 Jul 2026', status: 'Pending'),
  ];

  static final List<TransportRecord> transportRecords = [
    TransportRecord(id: 'T001', busNo: 'MH-04-AB-1234', route: 'Nallasopara → School (Morning)', pickupPoint: 'Bus Stop, Nalasopara East', pickupTime: '6:15 AM', dropTime: '1:15 PM', driverName: 'Ramesh Patil', driverPhone: '9876543210'),
    TransportRecord(id: 'T002', busNo: 'MH-04-CD-5678', route: 'Vasai → School (Morning)', pickupPoint: 'Vasai Station West', pickupTime: '5:45 AM', dropTime: '1:30 PM', driverName: 'Sunil Deshmukh', driverPhone: '9876543211'),
  ];

  static final IdCardRecord currentIdCard = IdCardRecord(
    id: 'ID001',
    name: 'Radhika Chandraprakash Jaiswal',
    designation: 'Secondary Teacher',
    staffId: 'IJS35700075',
    school: 'Infant Jesus High School, Nallasopara',
    joinDate: '2017-06-01',
    bloodGroup: 'B+',
    phone: '9876543210',
    address: 'Nallasopara East, Palghar, Maharashtra',
  );

  static final List<LibraryBook> libraryBooks = [
    LibraryBook(id: 'LB001', title: 'NCERT Mathematics Class 9', author: 'NCERT', isbn: '978-81-7450-631-3', category: 'Textbook', isAvailable: true),
    LibraryBook(id: 'LB002', title: 'Science for Class 9', author: 'Lakhmir Singh', isbn: '978-81-7450-551-8', category: 'Textbook', isAvailable: false, issuedTo: 'Aarav Sharma', dueDate: '30 Jul 2026'),
    LibraryBook(id: 'LB003', title: 'English Hornbill', author: 'NCERT', isbn: '978-81-7450-544-7', category: 'Textbook', isAvailable: true),
    LibraryBook(id: 'LB004', title: 'Harry Potter and the Philosopher\'s Stone', author: 'J.K. Rowling', isbn: '978-0-7475-3269-9', category: 'Fiction', isAvailable: false, issuedTo: 'Ananya Patel', dueDate: '25 Jul 2026'),
    LibraryBook(id: 'LB005', title: 'Wings of Fire', author: 'A.P.J. Abdul Kalam', isbn: '978-81-7370-443-3', category: 'Non-Fiction', isAvailable: true),
  ];

  static final List<CertificateRecord> certificates = [
    CertificateRecord(id: 'C001', type: 'Transfer Certificate', studentName: 'Aarav Sharma', requestDate: '20 Jul 2026', status: 'Approved', issueDate: '22 Jul 2026'),
    CertificateRecord(id: 'C002', type: 'Bonafide Certificate', studentName: 'Ananya Patel', requestDate: '21 Jul 2026', status: 'Pending'),
    CertificateRecord(id: 'C003', type: 'Migration Certificate', studentName: 'Arjun Singh', requestDate: '22 Jul 2026', status: 'Pending'),
  ];

  static final List<PayslipRecord> payslips = [
    PayslipRecord(id: 'P001', month: 'July', year: '2026', basicPay: 45000, hra: 13500, da: 6750, ta: 3000, pf: 5400, pt: 200, it: 4500, status: 'Generated'),
    PayslipRecord(id: 'P002', month: 'June', year: '2026', basicPay: 45000, hra: 13500, da: 6750, ta: 3000, pf: 5400, pt: 200, it: 4500, status: 'Generated'),
    PayslipRecord(id: 'P003', month: 'May', year: '2026', basicPay: 42000, hra: 12600, da: 6300, ta: 2800, pf: 5040, pt: 200, it: 4000, status: 'Generated'),
  ];

  static final List<LeaveApplication> leaveApplications = [
    LeaveApplication(id: 'L001', leaveType: 'Casual Leave', fromDate: '25 Jul 2026', toDate: '25 Jul 2026', totalDays: 1, reason: 'Personal work', status: 'Approved'),
    LeaveApplication(id: 'L002', leaveType: 'Medical Leave', fromDate: '10 Jul 2026', toDate: '12 Jul 2026', totalDays: 3, reason: 'Fever and cold', status: 'Approved'),
    LeaveApplication(id: 'L003', leaveType: 'Earned Leave', fromDate: '01 Aug 2026', toDate: '02 Aug 2026', totalDays: 2, reason: 'Family function', status: 'Pending'),
  ];

  static final List<StaffDirectoryEntry> staffDirectory = [
    StaffDirectoryEntry(id: 'SD001', name: 'Radhika Jaiswal', designation: 'Secondary Teacher', department: 'Computer Science', phone: '9876543210', email: 'radhika@infantjesus.edu'),
    StaffDirectoryEntry(id: 'SD002', name: 'Priya Sharma', designation: 'Primary Teacher', department: 'English', phone: '9876543211', email: 'priya@infantjesus.edu'),
    StaffDirectoryEntry(id: 'SD003', name: 'Amit Kumar', designation: 'HOD', department: 'Mathematics', phone: '9876543212', email: 'amit@infantjesus.edu'),
    StaffDirectoryEntry(id: 'SD004', name: 'Rajesh Patil', designation: 'Admin Staff', department: 'Administration', phone: '9876543213', email: 'rajesh@infantjesus.edu'),
    StaffDirectoryEntry(id: 'SD005', name: 'Sneha Reddy', designation: 'Librarian', department: 'Library', phone: '9876543214', email: 'sneha@infantjesus.edu'),
    StaffDirectoryEntry(id: 'SD006', name: 'Vikram Singh', designation: 'Sports Teacher', department: 'Physical Education', phone: '9876543215', email: 'vikram@infantjesus.edu'),
  ];

  static final List<ChatConversation> chatConversations = [
    ChatConversation(id: 'CC001', name: 'Priya Sharma', lastMessage: 'Can you share the class 9 notes?', time: '10:30 AM', unreadCount: 2),
    ChatConversation(id: 'CC002', name: 'Amit Kumar', lastMessage: 'Meeting rescheduled to Friday', time: 'Yesterday', unreadCount: 0),
    ChatConversation(id: 'CC003', name: 'Admin Group', lastMessage: 'Staff meeting at 3 PM', time: 'Yesterday', unreadCount: 5),
  ];

  static final List<ChatMessage> chatMessages = [
    ChatMessage(id: 'CM001', sender: 'Priya Sharma', message: 'Hi, do you have the class 9 notes?', time: '10:25 AM', isMe: false),
    ChatMessage(id: 'CM002', sender: 'Me', message: 'Yes, I\'ll share them after lunch', time: '10:28 AM', isMe: true),
    ChatMessage(id: 'CM003', sender: 'Priya Sharma', message: 'Can you share the class 9 notes?', time: '10:30 AM', isMe: false),
  ];

  static final List<GalleryAlbum> galleryAlbums = [
    GalleryAlbum(id: 'GA001', title: 'Annual Day 2026', date: '15 Mar 2026', photoCount: 124),
    GalleryAlbum(id: 'GA002', title: 'Sports Day', date: '20 Jan 2026', photoCount: 89),
    GalleryAlbum(id: 'GA003', title: 'Science Exhibition', date: '05 Nov 2025', photoCount: 56),
    GalleryAlbum(id: 'GA004', title: 'Teachers Day', date: '05 Sep 2025', photoCount: 34),
  ];

  static final List<SqaDetailItem> sqaHseItems = [
    SqaDetailItem(id: 'HSE001', title: 'Safety Policies', description: 'School safety policies and emergency procedures', status: 'Active', lastUpdated: '01 Jun 2026'),
    SqaDetailItem(id: 'HSE002', title: 'Health Protocols', description: 'COVID-19 health protocols and hygiene standards', status: 'Active', lastUpdated: '15 May 2026'),
    SqaDetailItem(id: 'HSE003', title: 'Environment Guidelines', description: 'Green school initiative and environment conservation guidelines', status: 'Active', lastUpdated: '10 Apr 2026'),
  ];

  static final List<SqaDetailItem> sqaComplianceItems = [
    SqaDetailItem(id: 'CMP001', title: 'Regulatory Compliance', description: 'CBSE affiliation and state board compliance documents', status: 'Active', lastUpdated: '20 Mar 2026'),
    SqaDetailItem(id: 'CMP002', title: 'Internal Audits', description: 'Annual internal audit reports and corrective actions', status: 'Active', lastUpdated: '15 Feb 2026'),
  ];

  static final List<SqaDetailItem> sqaFrameworkItems = [
    SqaDetailItem(id: 'FW001', title: 'Quality Framework', description: 'SQAA quality assurance framework and standards', status: 'Active', lastUpdated: '01 Jan 2026'),
    SqaDetailItem(id: 'FW002', title: 'Policy Documents', description: 'School policies including anti-ragging, grievance redressal', status: 'Active', lastUpdated: '10 Dec 2025'),
  ];

  static final List<String> feeTypes = ['Tuition Fee', 'Lab Fee', 'Transport Fee', 'Library Fee', 'Exam Fee', 'Activity Fee'];
  static final List<String> certificateTypes = ['Transfer Certificate', 'Bonafide Certificate', 'Migration Certificate', 'Character Certificate', 'Leaving Certificate'];
  static final List<String> leaveTypes = ['Casual Leave', 'Medical Leave', 'Earned Leave', 'Maternity Leave', 'Compensatory Off'];

  static final List<SubjectOutcomeRecord> subjectOutcomes = [
    SubjectOutcomeRecord(studentName: 'Aarav Sharma', rollNo: '01', classSection: '9-A', subject: 'Computer', learningGoal: 'Programming Basics', term: 'TERM-I', grade: 'A', remarks: 'Excellent understanding of concepts'),
    SubjectOutcomeRecord(studentName: 'Ananya Patel', rollNo: '02', classSection: '9-A', subject: 'Computer', learningGoal: 'Programming Basics', term: 'TERM-I', grade: 'B+', remarks: 'Good grasp, needs more practice'),
    SubjectOutcomeRecord(studentName: 'Arjun Singh', rollNo: '03', classSection: '9-A', subject: 'Computer', learningGoal: 'Programming Basics', term: 'TERM-I', grade: 'A+', remarks: 'Outstanding performance'),
    SubjectOutcomeRecord(studentName: 'Diya Gupta', rollNo: '04', classSection: '9-A', subject: 'Computer', learningGoal: 'Programming Basics', term: 'TERM-I', grade: 'B', remarks: 'Satisfactory, needs improvement'),
    SubjectOutcomeRecord(studentName: 'Vihaan Kumar', rollNo: '05', classSection: '9-A', subject: 'Computer', learningGoal: 'Programming Basics', term: 'TERM-I', grade: 'A', remarks: 'Very good understanding'),
  ];

  static final List<TestMarkRecord> testMarks = [
    TestMarkRecord(studentName: 'Aarav Sharma', rollNo: '01', classSection: '9-A', subject: 'Computer', testName: 'First Unit Test', maxMarks: 25, marksObtained: 22, evaluation: 'Formative'),
    TestMarkRecord(studentName: 'Ananya Patel', rollNo: '02', classSection: '9-A', subject: 'Computer', testName: 'First Unit Test', maxMarks: 25, marksObtained: 19, evaluation: 'Formative'),
    TestMarkRecord(studentName: 'Arjun Singh', rollNo: '03', classSection: '9-A', subject: 'Computer', testName: 'First Unit Test', maxMarks: 25, marksObtained: 24, evaluation: 'Formative'),
    TestMarkRecord(studentName: 'Diya Gupta', rollNo: '04', classSection: '9-A', subject: 'Computer', testName: 'First Unit Test', maxMarks: 25, marksObtained: 17, evaluation: 'Formative'),
    TestMarkRecord(studentName: 'Vihaan Kumar', rollNo: '05', classSection: '9-A', subject: 'Computer', testName: 'First Unit Test', maxMarks: 25, marksObtained: 21, evaluation: 'Formative'),
    TestMarkRecord(studentName: 'Aarav Sharma', rollNo: '01', classSection: '9-A', subject: 'Computer', testName: 'Second Unit Test', maxMarks: 25, marksObtained: 23, evaluation: 'Formative'),
    TestMarkRecord(studentName: 'Ananya Patel', rollNo: '02', classSection: '9-A', subject: 'Computer', testName: 'Second Unit Test', maxMarks: 25, marksObtained: 20, evaluation: 'Formative'),
    TestMarkRecord(studentName: 'Arjun Singh', rollNo: '03', classSection: '9-A', subject: 'Computer', testName: 'Second Unit Test', maxMarks: 25, marksObtained: 25, evaluation: 'Formative'),
    TestMarkRecord(studentName: 'Diya Gupta', rollNo: '04', classSection: '9-A', subject: 'Computer', testName: 'Second Unit Test', maxMarks: 25, marksObtained: 18, evaluation: 'Formative'),
    TestMarkRecord(studentName: 'Vihaan Kumar', rollNo: '05', classSection: '9-A', subject: 'Computer', testName: 'Second Unit Test', maxMarks: 25, marksObtained: 22, evaluation: 'Formative'),
  ];

  static final List<ExamMarkRecord> examMarks = [
    ExamMarkRecord(studentName: 'Aarav Sharma', rollNo: '01', classSection: '9-A', subject: 'Computer', examName: 'First Terminal', maxMarks: 80, marksObtained: 72, grade: 'A'),
    ExamMarkRecord(studentName: 'Ananya Patel', rollNo: '02', classSection: '9-A', subject: 'Computer', examName: 'First Terminal', maxMarks: 80, marksObtained: 65, grade: 'B+'),
    ExamMarkRecord(studentName: 'Arjun Singh', rollNo: '03', classSection: '9-A', subject: 'Computer', examName: 'First Terminal', maxMarks: 80, marksObtained: 78, grade: 'A+'),
    ExamMarkRecord(studentName: 'Diya Gupta', rollNo: '04', classSection: '9-A', subject: 'Computer', examName: 'First Terminal', maxMarks: 80, marksObtained: 58, grade: 'B'),
    ExamMarkRecord(studentName: 'Vihaan Kumar', rollNo: '05', classSection: '9-A', subject: 'Computer', examName: 'First Terminal', maxMarks: 80, marksObtained: 70, grade: 'A'),
  ];

  static final List<CoScholasticRecord> coScholasticRecords = [
    CoScholasticRecord(studentName: 'Aarav Sharma', rollNo: '01', classSection: '9-A', skill: 'Art & Craft', assessment: 'Assessment 1', grade: 'A1'),
    CoScholasticRecord(studentName: 'Ananya Patel', rollNo: '02', classSection: '9-A', skill: 'Art & Craft', assessment: 'Assessment 1', grade: 'A2'),
    CoScholasticRecord(studentName: 'Arjun Singh', rollNo: '03', classSection: '9-A', skill: 'Art & Craft', assessment: 'Assessment 1', grade: 'B1'),
    CoScholasticRecord(studentName: 'Diya Gupta', rollNo: '04', classSection: '9-A', skill: 'Art & Craft', assessment: 'Assessment 1', grade: 'A1'),
    CoScholasticRecord(studentName: 'Vihaan Kumar', rollNo: '05', classSection: '9-A', skill: 'Art & Craft', assessment: 'Assessment 1', grade: 'B2'),
  ];

  static final List<StudentRemarkRecord> studentRemarks = [
    StudentRemarkRecord(studentName: 'Aarav Sharma', rollNo: '01', classSection: '9-A', field: 'MyGoals', remark: 'Aim to score above 85% in all subjects this term.'),
    StudentRemarkRecord(studentName: 'Ananya Patel', rollNo: '02', classSection: '9-A', field: 'MyGoals', remark: 'Improve participation in class discussions.'),
    StudentRemarkRecord(studentName: 'Arjun Singh', rollNo: '03', classSection: '9-A', field: 'MyGoals', remark: 'Focus on completing assignments on time.'),
    StudentRemarkRecord(studentName: 'Diya Gupta', rollNo: '04', classSection: '9-A', field: 'MyGoals', remark: 'Work on handwriting improvement.'),
    StudentRemarkRecord(studentName: 'Vihaan Kumar', rollNo: '05', classSection: '9-A', field: 'MyGoals', remark: 'Participate actively in science projects.'),
  ];

  static final List<ClassTeacherRemarkRecord> classTeacherRemarks = [
    ClassTeacherRemarkRecord(studentName: 'Aarav Sharma', rollNo: '01', classSection: '9-A', remark: 'Aarav is a bright student with excellent academic performance. He is always punctual and helps classmates.'),
    ClassTeacherRemarkRecord(studentName: 'Ananya Patel', rollNo: '02', classSection: '9-A', remark: 'Ananya is a dedicated student. She should participate more in sports and extracurricular activities.'),
    ClassTeacherRemarkRecord(studentName: 'Arjun Singh', rollNo: '03', classSection: '9-A', remark: 'Arjun shows great potential in academics. He needs to be more consistent with homework submissions.'),
    ClassTeacherRemarkRecord(studentName: 'Diya Gupta', rollNo: '04', classSection: '9-A', remark: 'Diya is a sincere student. She should work on building confidence in public speaking.'),
    ClassTeacherRemarkRecord(studentName: 'Vihaan Kumar', rollNo: '05', classSection: '9-A', remark: 'Vihaan is an enthusiastic learner. He should focus more on developing writing skills.'),
  ];
}
