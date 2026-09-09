import 'package:flutter/material.dart';

const projectIcons = {
  'Carbee': 'assets/images/icon-carbee.webp',
  'Carpool': 'assets/images/icon-carpool.webp',
  'Dr.iQ': 'assets/images/driq-logo.png',
  'Ayuda Health': 'assets/images/icon-ayuda.webp',
  'Whatsinit': 'assets/images/icon-whatsinit.png',
  'Shirleys': 'assets/images/icon-shirleys.png',
  'My Treats': 'assets/images/icon-treats.png',
  'Load a Trash': 'assets/images/icon-trash.png',
  'LSUK': 'assets/images/icon-lsuk.png',
  'Family Tutor': 'assets/images/icon-family.png',
  'Muslim World 360': 'assets/images/icon-muslim.png',
  'Invoice Labs': 'assets/images/icon-invoice.png',
};

const projectLinks = <String, List<(String, String)>>{
  'Carpool': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.carpoolingpk.carpool',
    ),
  ],
  'Dr.iQ': [('App Store', 'https://apps.apple.com/pk/app/dr-iq/id1345802108')],
  'Carbee': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.carbee.user.prod',
    ),
    ('App Store', 'https://apps.apple.com/au/app/carbee-au/id6474963233'),
    ('Website', 'https://carbee.com.au'),
  ],
  'Ayuda Health': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.ayuda.health',
    ),
    ('App Store', 'https://apps.apple.com/ca/app/ayuda-health/id6550923590'),
    ('Website', 'https://ayudahealth.com/'),
  ],
  'Shirleys': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.soft.shirleys',
    ),
    ('App Store', 'https://apps.apple.com/us/app/shirleys/id1594411301'),
  ],
  'My Treats': [
    ('App Store', 'https://apps.apple.com/gb/app/my-treats/id1553674065'),
    ('Restaurant website', 'https://mytreatsbristol.co.uk/'),
  ],
  'Load a Trash': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.softechbusinessservices.waste_management_app',
    ),
    ('App Store', 'https://apps.apple.com/us/app/load-a-trash/id1541996261'),
  ],
  'LSUK': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.org.lsuk',
    ),
    ('App Store', 'https://apps.apple.com/us/app/lsuk/id1545528069'),
  ],
  'Muslim World 360': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.muslim360.app',
    ),
    (
      'App Store',
      'https://apps.apple.com/pk/app/muslim-world-360/id1601498948',
    ),
  ],
  'Family Tutor': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.myfamilytutor.pk',
    ),
  ],
  'Whatsinit': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.twodoclt',
    ),
  ],
  'Invoice Labs': [
    ('Project listing', 'https://www.thegreatapps.com/apps/invoicelabs'),
  ],
  'AMS': [('GitHub', 'https://github.com/EMIkram/face_n_qr_recognition')],
  'Sterna Search': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.emikram.sterna_search',
    ),
  ],
};

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
    this.mobile = false,
    this.source,
    this.screens = const [],
    this.highlights = const [],
  });

  final String name, category, summary, contribution;
  final Color color;
  final IconData icon;
  final List<String> tags;
  final String? link;
  final bool mobile;
  final String? source;
  final List<(String, String)> screens;
  final List<(String, String)> highlights;
}

const projects = [
  Project(
    'Carbee',
    'AUTOMOTIVE · MOBILE & WEB',
    'How we buy and sell cars now.',
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
      (
        'Customer mobile · AIBee search',
        'assets/images/carbee-customer-search.jpg',
      ),
      (
        'Dealer mobile · Video showcase',
        'assets/images/carbee-mobile-video.png',
      ),
      ('Customer web · Video feed', 'assets/images/carbee-customer-web.png'),
      (
        'Foundation · Component gallery',
        'assets/images/carbee-foundation-overview.png',
      ),
      ('Dealer mobile · Lead capture', 'assets/images/carbee-mobile-leads.png'),
      (
        'Dealer mobile · Real-time chat',
        'assets/images/carbee-mobile-chat.png',
      ),
      ('Dealer mobile · Welcome', 'assets/images/carbee-mobile-welcome.png'),
      (
        'Customer mobile · Store preview 1',
        'assets/images/carbee-store-0.webp',
      ),
      (
        'Customer mobile · Store preview 2',
        'assets/images/carbee-store-1.webp',
      ),
      (
        'Customer mobile · Store preview 3',
        'assets/images/carbee-store-2.webp',
      ),
      (
        'Customer mobile · Store preview 4',
        'assets/images/carbee-store-3.webp',
      ),
      (
        'Customer mobile · Welcome',
        'assets/images/carbee-customer-welcome.png',
      ),
      (
        'Customer mobile · Sell a car',
        'assets/images/carbee-customer-sell.png',
      ),
      (
        'Customer mobile · Meet AiBee',
        'assets/images/carbee-customer-aibee.png',
      ),
      (
        'Customer mobile · Explore videos',
        'assets/images/carbee-customer-video.png',
      ),
      ('Admin · Lead performance', 'assets/images/carbee-admin-leads-new.png'),
      ('Admin · Listing analytics', 'assets/images/carbee-admin-listings.png'),
      ('Admin · Billing & invoices', 'assets/images/carbee-admin-billing.png'),
      (
        'Dealership · Notification centre',
        'assets/images/carbee-dealer-notifications-new.png',
      ),
    ],
    highlights: [
      (
        'The product',
        'Carbee brings buyers and sellers together through video listings, AI-assisted discovery, direct conversations, and test-drive booking.',
      ),
      (
        'From discovery to dealership operations',
        'Customer mobile app, dealer mobile app, customer web app, admin web portal, and dealership web portal — supported by the Carbee Foundation package and its component gallery.',
      ),
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
    'Carpool',
    'MOBILITY · ANDROID',
    'Shared journeys. Better connections.',
    'Independently developed and maintain Carpool, a live Flutter/Android product connecting drivers and riders. I use it to apply AI-agent-assisted, spec-driven development across requirements, architecture, implementation, release, and iteration.',
    Color(0xFFD5EDE7),
    Icons.route_rounded,
    ['Flutter', 'Android', 'Independent delivery', 'AI-assisted development'],
    mobile: true,
    link:
        'https://play.google.com/store/apps/details?id=com.carpoolingpk.carpool&hl=en',
    source: 'Screenshots from the official Google Play listing.',
    screens: [
      ('Find a ride', 'assets/images/carpool-1.webp'),
      ('Ride requests', 'assets/images/carpool-2.webp'),
      ('Create a ride', 'assets/images/carpool-3.webp'),
      ('My rides', 'assets/images/carpool-4.webp'),
      ('Request a seat', 'assets/images/carpool-5.webp'),
      ('Account & tools', 'assets/images/carpool-6.webp'),
      ('Welcome', 'assets/images/carpool-0.webp'),
    ],
  ),
  Project(
    'Dr.iQ',
    'HEALTHCARE · NATIVE iOS',
    'Making everyday healthcare more accessible.',
    'Collaborated with the iOS team at AT-Tech on features and modules for a UK healthcare product serving NHS patients. Contributed to refactoring approximately 90% of the codebase for cleaner architecture.',
    Color(0xFFDCE5FB),
    Icons.favorite_rounded,
    ['Swift', 'UIKit', 'Native iOS', 'App Store delivery'],
    mobile: true,
    link: 'https://apps.apple.com/pk/app/dr-iq/id1345802108',
    source:
        'Product screenshots supplied by Ikram. Work at AT-Tech: June 2022–March 2024.',
    screens: [
      ('Home', 'assets/images/driq-home.png'),
      ('Online consultation', 'assets/images/driq-consultation.png'),
      ('Repeat medication', 'assets/images/driq-medication.png'),
      ('Welcome', 'assets/images/driq-welcome.png'),
      ('Appointments', 'assets/images/driq-appointments.png'),
    ],
  ),
  Project(
    'Ayuda Health',
    'DIGITAL HEALTH · MOBILE',
    'A clearer picture of everyday wellbeing.',
    'Worked on Ayuda Health, a healthcare solution for patient engagement and appointment booking. The product brings medication reminders, symptom diaries, and health readings together in one mobile experience.',
    Color(0xFFE6E2F2),
    Icons.health_and_safety_outlined,
    ['Healthcare', 'Patient engagement', 'Mobile'],
    mobile: true,
    link: 'https://ayudahealth.com/',
    source:
        'Screenshots from ayudahealth.com. Current product visuals may differ from the version I contributed to.',
    screens: [
      ('Vitals dashboard', 'assets/images/ayuda-vitals.jpg'),
      ('Medication reminders', 'assets/images/ayuda-reminders.jpg'),
      ('Symptom diary', 'assets/images/ayuda-diary.jpg'),
    ],
  ),
  Project(
    'Whatsinit',
    'FOOD DISCOVERY · MOBILE',
    'A little more knowledge in every bite.',
    'Built the application from scratch to help people discover the ingredients in their food.',
    Color(0xFFE7EBCF),
    Icons.eco_rounded,
    ['Built from scratch', 'Food discovery', 'Mobile'],
    mobile: true,
    link: 'https://www.producthunt.com/products/whatsinit',
    source: 'Screenshots from my GitHub project showcase.',
    screens: [
      ('Ingredient search', 'assets/images/whatsinit-0.png'),
      ('Browse ingredients', 'assets/images/whatsinit-1.png'),
      ('Ingredient details', 'assets/images/whatsinit-2.png'),
    ],
  ),
  Project(
    'My Treats',
    'FOOD & DRINK · MOBILE',
    'From the menu to your doorstep.',
    'Worked on restaurant ordering and delivery applications for My Treats in Bristol. The restaurant website is linked as business context; my contribution was to the mobile apps.',
    Color(0xFFF3E3D3),
    Icons.restaurant_outlined,
    ['Flutter', 'Food ordering', 'Delivery'],
    mobile: true,
    link: 'https://apps.apple.com/gb/app/my-treats/id1553674065',
    source: 'Screenshots from the UK App Store listing.',
    screens: [
      ('Menu', 'assets/images/treats-2.jpg'),
      ('Restaurant discovery', 'assets/images/treats-4.jpg'),
      ('Welcome', 'assets/images/treats-0.jpg'),
      ('Navigation', 'assets/images/treats-3.jpg'),
      ('Bristol restaurant', 'assets/images/treats-5.jpg'),
      ('Sign in', 'assets/images/treats-1.jpg'),
    ],
  ),
  Project(
    'LSUK',
    'LANGUAGE SERVICES · MOBILE',
    'Connecting interpreters with opportunities.',
    'Contributed to interpreter workflows, distance calculation, and interface improvements for Language Services UK. The app helps registered interpreters manage assignments, timesheets, messages, and payment records.',
    Color(0xFFD9EAF3),
    Icons.translate_rounded,
    ['Flutter', 'Interpreter workflows', 'Mobile'],
    mobile: true,
    link: 'https://play.google.com/store/apps/details?id=com.org.lsuk',
    source:
        'Screenshots from the official Google Play listing. Current store visuals may differ from the version I contributed to.',
    screens: [
      ('Job dashboard', 'assets/images/lsuk-1.webp'),
      ('Workflow preview', 'assets/images/lsuk-2.webp'),
      ('Interpreter tools', 'assets/images/lsuk-3.webp'),
      ('Welcome', 'assets/images/lsuk-0.webp'),
      ('App preview', 'assets/images/lsuk-4.webp'),
      ('Services', 'assets/images/lsuk-5.webp'),
    ],
  ),
];

const additionalProjects = [
  (
    'Afterlife AI',
    'Worked on an AI application for creating avatars and chatting with public avatars.',
    Icons.auto_awesome_outlined,
  ),
  (
    'Muslim World 360',
    'Prayer times, Quran and Hadith reading, and searchable content for Android and iOS.',
    Icons.nights_stay_outlined,
  ),
  (
    'Shirleys',
    'E-commerce clothing application for browsing and purchasing clothes.',
    Icons.shopping_bag_outlined,
  ),
  (
    'Load a Trash',
    'A UK application connecting people with useful unwanted items to buyers.',
    Icons.recycling_outlined,
  ),
  (
    'Invoice Labs',
    'Led the migration from native Android to Flutter for Android, iOS, and Linux, including local storage, invoicing, and PDF generation.',
    Icons.receipt_long_outlined,
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
