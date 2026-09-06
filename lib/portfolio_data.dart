import 'package:flutter/material.dart';

class Project {
  const Project(
    this.name,
    this.category,
    this.summary,
    this.contribution,
    this.color,
    this.icon,
    this.tags, {
    this.link,
    this.screens = const [],
    this.highlights = const [],
  });

  final String name, category, summary, contribution;
  final Color color;
  final IconData icon;
  final List<String> tags;
  final String? link;
  final List<(String, String)> screens;
  final List<(String, String)> highlights;
}

const projects = [
  Project(
    'Carbee',
    'AUTOMOTIVE · WEB',
    'A better way to move forward.',
    'Primary owner of the Carbee Admin and Dealer portals at Techtronix. Built the dealership web portal and led feature delivery, architecture, backend integration, multi-environment support, and release workflows.',
    Color(0xFFFFEBB8),
    Icons.directions_car_rounded,
    ['Flutter Web', 'Architecture', 'CI/CD'],
    link: 'https://carbee.com.au',
    screens: [
      ('Admin · Overview', 'assets/images/carbee-admin-overview.png'),
      ('Admin · Lead analytics', 'assets/images/carbee-admin-analytics.png'),
      ('Dealership · Dashboard', 'assets/images/carbee-dealer-dashboard.png'),
      (
        'Dealership · Notifications',
        'assets/images/carbee-dealer-notifications.png',
      ),
      (
        'Dealership · Listings & QR insights',
        'assets/images/carbee-dealer-listings.png',
      ),
      ('Foundations · Design system', 'assets/images/carbee-foundations.png'),
    ],
    highlights: [
      (
        'Admin & dealership portals',
        'Primary ownership of large-scale Flutter Web portals, with dealership delivery from the ground up and ongoing admin development.',
      ),
      (
        'Analytics & operational workflows',
        'Dashboards, lead insights, vehicle listings, QR statistics, notifications, and billing workflows across the product.',
      ),
      (
        'E2E encryption & API integration',
        'Encrypted communication handling, network interceptors, centralized errors, and request/response tracing.',
      ),
      (
        'CI/CD & release automation',
        'Automated builds, deployments, environment promotion, and GitHub–Jira workflows for smoother QA handoffs.',
      ),
      (
        'Multi-environment architecture',
        'Dynamic switching between development, staging, QA, and production environments.',
      ),
      (
        'Carbee foundations',
        'A shared visual language for colors, typography, buttons, fields, and icons, illustrated by the foundations screen.',
      ),
      (
        'Technical leadership',
        'Feature planning, architecture guidance, code reviews, mentoring, and release coordination. Introduced Kanban workflows and bi-weekly Flutter learning sessions.',
      ),
    ],
  ),
  Project(
    'Dr.iQ',
    'HEALTHCARE · iOS',
    'Care, a little closer.',
    'Collaborated with the iOS team at AT-Tech on features and modules for a UK healthcare product serving NHS patients. Contributed to refactoring approximately 90% of the codebase for cleaner architecture.',
    Color(0xFFD9EDE5),
    Icons.favorite_rounded,
    ['Native iOS', 'Healthcare', 'Refactoring'],
    link: 'https://apps.apple.com/pk/app/dr-iq/id1345802108',
  ),
  Project(
    'Afterlife AI',
    'AI · MOBILE',
    'Conversations beyond the ordinary.',
    'Worked on an AI-based application for creating avatars and chatting with public avatars.',
    Color(0xFFE7DFFD),
    Icons.auto_awesome_rounded,
    ['AI', 'Avatars', 'Mobile'],
  ),
  Project(
    'Invoice Labs',
    'BUSINESS · CROSS-PLATFORM',
    'Less paperwork. More possibility.',
    'Led the redevelopment of an Android-native product in Flutter for Android, iOS, and Linux. Implemented local storage and supported client, item, invoice, business information, and PDF generation workflows. Deployed a stable release on Google Play.',
    Color(0xFFF3E3CE),
    Icons.receipt_long_rounded,
    ['Flutter', 'Local storage', 'PDF generation'],
    link: 'https://www.thegreatapps.com/apps/invoicelabs',
  ),
  Project(
    'Muslim World 360',
    'LIFESTYLE · MOBILE',
    'A daily moment of connection.',
    'Worked on a mobile app featuring prayer times, Quran and Hadith reading, and search functionality.',
    Color(0xFFDCE6D8),
    Icons.nights_stay_rounded,
    ['Android', 'iOS', 'Search'],
    link: 'https://apps.apple.com/pk/app/muslim-world-360/id1601498948',
  ),
  Project(
    'Whatsinit',
    'FOOD · MOBILE',
    'Know what goes into your food.',
    'Built the application from scratch to help people discover the ingredients in their food.',
    Color(0xFFF4DFD6),
    Icons.eco_rounded,
    ['Mobile', 'Food discovery', 'From scratch'],
    link: 'https://www.producthunt.com/products/whatsinit',
  ),
];

const additionalProjects = [
  (
    'Ayuda Health',
    'Patient engagement and appointment booking.',
    Icons.medical_services_outlined,
  ),
  (
    'LSUK',
    'Interpreter workflows, distance calculation, and UI improvements.',
    Icons.translate_rounded,
  ),
  (
    'Cam translator',
    'Camera-based recognition and translation with Google ML Kit.',
    Icons.camera_alt_outlined,
  ),
  (
    'AMS',
    'Attendance using face and QR recognition.',
    Icons.qr_code_scanner_rounded,
  ),
  (
    'Sterna Search',
    'Search and travel application.',
    Icons.travel_explore_rounded,
  ),
  (
    'Family Tutor',
    'An educational hub for tutors and students.',
    Icons.school_outlined,
  ),
];
