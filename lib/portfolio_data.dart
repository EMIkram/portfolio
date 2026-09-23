import 'package:flutter/material.dart';

const projectIcons = {
  'AMS': 'assets/images/icon-ams.png',
  'Sabzi Shop': 'assets/images/icon-sabzi-shop.jpg',
  'PSX Ascend': 'assets/images/icon-psx-ascend.jpg',
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
  'Sabzi Shop': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.sabzishop.sbs&hl=en',
    ),
    ('App Store', 'https://apps.apple.com/us/app/sabzi-shop/id6757521101'),
  ],
  'PSX Ascend': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.psxascend.app&hl=en',
    ),
    ('App Store', 'https://apps.apple.com/us/app/psxascend/id1547303438'),
  ],
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
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=io.invoicelabs.app',
    ),
    ('Website', 'https://www.invoicelabs.io/'),
  ],
  'AMS': [
    (
      'Google Play',
      'https://play.google.com/store/apps/details?id=com.smartattendance.sbs&hl=en',
    ),
    (
      'App Store',
      'https://apps.apple.com/us/app/smart-attendance-sbs/id6446618329',
    ),
    ('GitHub', 'https://github.com/EMIkram/face_n_qr_recognition'),
  ],
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
    this.facts = const [],
    this.emphasis = const [],
    this.achievements = const [],
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
  final List<(String, String)> facts;
  final List<String> emphasis;
  final List<(String, String)> achievements;
}

const projects = [
  Project(
    'Carbee',
    'AUTOMOTIVE · MOBILE & WEB',
    'How we buy and sell cars now.',
    'I joined Carbee as one of its founding engineers, building and maintaining its dealership and admin web portals at Techtronix. Now a Senior Software Engineer and Team Lead, I manage the dealership systems, support mobile developers, and guide delivery as the product grows. Carbee now serves 40,000 users.',
    Color(0xFFFFEBB8),
    Icons.directions_car_rounded,
    ['Flutter Web', 'BLoC', 'OpenSpec · SDD', 'CI/CD'],
    link: 'https://carbee.com.au',
    achievements: [
      (
        'E2E encryption',
        'Built a service supporting all four Carbee apps, with straightforward integration through API interceptors.',
      ),
      (
        'Billing & invoice access',
        'Built the billing module with token-based access to invoices opened from email.',
      ),
      (
        'Multi-tenancy',
        'Integrated multi-tenancy so the same user can log in across each platform.',
      ),
    ],
    emphasis: [
      'founding engineers',
      'Senior Software Engineer and Team Lead',
      '40,000 users',
    ],
    facts: [
      ('40,000', 'Product users'),
      ('From day one', 'Development involvement'),
      ('Team Lead', 'Current responsibility'),
    ],
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
        'Built the dealership web portal from the start and delivered the admin portal. Continue to own requirements and design alignment, implementation, QA coordination, releases, and ongoing improvements.',
      ),
      (
        'Analytics & operational workflows',
        'Dashboards, lead insights, vehicle listings, QR statistics, notifications, and billing workflows across the product.',
      ),
      (
        'Encryption & API integration',
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
        'Created carbee_foundation using spec-driven development. Used Figma MCP to translate design foundations into Flutter typography, theming, and reusable UI components.',
      ),
      (
        'Custom responsive layouts',
        'Built a custom screen-responsiveness solution tailored to Carbee’s layouts and requirements.',
      ),
      (
        'Spec-driven development',
        'Use OpenSpec for recent features to define requirements and implementation tasks, guide coding agents, and validate changes through code review and QA.',
      ),
      (
        'Technical leadership',
        'Progressed into a senior Team Lead role, managing dealership systems and assisting mobile developers alongside web delivery. Lead feature planning, code reviews, mentoring, and release coordination; introduced Kanban workflows and bi-weekly Flutter learning sessions.',
      ),
    ],
  ),
  Project(
    'PSX Ascend',
    'POWERSPORTS · ANDROID & iOS',
    'Dealership operations, from anywhere.',
    'Worked on the iOS app and led its migration to Flutter for Android and iOS using BLoC. Later freelance contributions include new features and a UI revamp. Use OpenSpec for recent feature development to define requirements and implementation tasks before coding, review, and validation.',
    Color(0xFFDDF3FA),
    Icons.storefront_outlined,
    ['Flutter', 'BLoC', 'OpenSpec · SDD', 'Freelance'],
    mobile: true,
    link: 'https://apps.apple.com/us/app/psxascend/id1547303438',
    emphasis: ['led its migration to Flutter', 'Android and iOS'],
    source: 'Screenshots from the official App Store listing.',
    screens: [
      ('Vehicle details', 'assets/images/psx-ascend-2.jpg'),
      ('Dashboard and schedule', 'assets/images/psx-ascend-0.jpg'),
      ('Inventory search', 'assets/images/psx-ascend-1.jpg'),
      ('Customer interests', 'assets/images/psx-ascend-3.jpg'),
      ('Sales actions', 'assets/images/psx-ascend-4.jpg'),
      ('Saved appraisals', 'assets/images/psx-ascend-5.jpg'),
      ('Profile and settings', 'assets/images/psx-ascend-6.jpg'),
    ],
  ),
  Project(
    'Carpool',
    'MOBILITY · ANDROID',
    'Shared journeys. Better connections.',
    'Co-founder of Carpool, a live Flutter/Android product connecting drivers and riders. Contribute to its development and ongoing maintenance. I use it to apply AI-agent-assisted, spec-driven development across requirements, architecture, implementation, release, and iteration.',
    Color(0xFFD5EDE7),
    Icons.route_rounded,
    ['GetX', 'Flutter', 'Android', 'Co-founder', 'AI-assisted development'],
    mobile: true,
    emphasis: ['Co-founder of Carpool', 'spec-driven development'],
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
    emphasis: ['NHS patients', 'approximately 90% of the codebase'],
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
    Color(0xFFD6E9FA),
    Icons.health_and_safety_outlined,
    ['Flutter', 'BLoC/Cubit', 'Healthcare'],
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
    'My Treats',
    'FOOD & DRINK · MOBILE',
    'From the menu to your doorstep.',
    'Worked on restaurant ordering and delivery applications for My Treats in Bristol. The restaurant website is linked as business context; my contribution was to the mobile apps.',
    Color(0xFFF3E3D3),
    Icons.restaurant_outlined,
    ['GetX', 'Flutter', 'Food ordering', 'Delivery'],
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
    ['GetX', 'Flutter', 'Interpreter workflows', 'Mobile'],
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
  Project(
    'Invoice Labs',
    'BUSINESS TOOLS · MOBILE & DESKTOP',
    'Invoicing and business management, in one place.',
    'Led the migration from native Android to Flutter for Android, iOS, and Linux, including local storage, invoicing, and PDF generation. Delivered a stable Google Play release and mentored developers through implementation and review.',
    Color(0xFFFFE4D1),
    Icons.receipt_long_outlined,
    ['GetX', 'Flutter', 'Invoicing', 'PDF generation', 'Local storage'],
    mobile: true,
    link: 'https://play.google.com/store/apps/details?id=io.invoicelabs.app',
    emphasis: [
      'Led the migration',
      'Android, iOS, and Linux',
      'mentored developers',
    ],
    source: 'Screenshots of the Invoice Labs app.',
    screens: [
      ('Invoice editor', 'assets/images/invoicelabs-editor.png'),
      ('Template selection', 'assets/images/invoicelabs-template.png'),
    ],
  ),
  Project(
    'Sabzi Shop',
    'GROCERY SHOPPING · ANDROID & iOS',
    'Fresh vegetables, delivered to your doorstep.',
    'Built Sabzi Shop from scratch and deployed it to Google Play and the App Store, taking the app from initial development through to release on Android and iOS.',
    Color(0xFFA8DDBB),
    Icons.local_grocery_store_outlined,
    [
      'GetX',
      'Android & iOS',
      'E-commerce',
      'Built from scratch',
      'Store deployment',
    ],
    mobile: true,
    link:
        'https://play.google.com/store/apps/details?id=com.sabzishop.sbs&hl=en',
    source: 'Screenshots from the official App Store listing.',
    screens: [
      ('Product catalog', 'assets/images/sabzi-shop-5.jpg'),
      ('Create an account', 'assets/images/sabzi-shop-3.jpg'),
      ('Home and categories', 'assets/images/sabzi-shop-4.jpg'),
      ('Delivery introduction', 'assets/images/sabzi-shop-2.jpg'),
      ('Welcome to Sabzi Shop', 'assets/images/sabzi-shop-0.jpg'),
      ('Daily vegetable shopping', 'assets/images/sabzi-shop-1.jpg'),
    ],
  ),
  Project(
    'AMS',
    'ATTENDANCE & HR · ANDROID & iOS',
    'Smart Attendance SBS — attendance, leave, and payroll.',
    'Worked on attendance using face and QR recognition.',
    Color(0xFFF0F4FA),
    Icons.qr_code_scanner_rounded,
    ['GetX', 'Face recognition', 'QR recognition', 'Attendance'],
    mobile: true,
    link:
        'https://play.google.com/store/apps/details?id=com.smartattendance.sbs&hl=en',
    source: 'Screenshots from the official Google Play listing.',
    screens: [
      ('Attendance dashboard', 'assets/images/ams-2.png'),
      ('Attendance history', 'assets/images/ams-6.png'),
      ('Leave request', 'assets/images/ams-3.png'),
      ('Salary slip', 'assets/images/ams-4.png'),
      ('Employee profile', 'assets/images/ams-5.png'),
      ('Welcome', 'assets/images/ams-0.png'),
      ('Organization login', 'assets/images/ams-1.png'),
    ],
  ),
  Project(
    'Entimocare',
    'MOBILE & WEB · ENCRYPTION & BILLING',
    'Shared encryption across four applications.',
    'Led the end-to-end encryption module across two mobile applications and two web applications. Built the module and worked with the team to implement it across all four apps. Independently implemented billing on both web portals and collaborated with backend developers on integration.',
    Color(0xFFE8DFF7),
    Icons.lock_outline_rounded,
    ['End-to-end encryption', 'Billing', 'Module leadership'],
    emphasis: [
      'end-to-end encryption',
      'two mobile applications and two web applications',
      'Independently implemented billing',
    ],
    facts: [
      ('4 apps', 'Encryption implementation'),
      ('2 portals', 'Billing delivery'),
      ('Module lead', 'Encryption ownership'),
    ],
    highlights: [
      (
        'Encryption across mobile and web',
        'Built the end-to-end encryption module and led its implementation across two mobile apps and two web apps, coordinating the work across the team.',
      ),
      (
        'Billing on both portals',
        'Personally implemented the billing module on both web portals and worked with backend developers through integration discussions and coordination meetings.',
      ),
    ],
  ),
];

const additionalProjects = [
  (
    'Whatsinit',
    'Built the application from scratch to help people discover the ingredients in their food. Built with Flutter and GetX.',
    Icons.eco_rounded,
  ),
  (
    'Afterlife AI',
    'Worked on an AI application for creating avatars and chatting with public avatars. Built with Flutter and GetX.',
    Icons.auto_awesome_outlined,
  ),
  (
    'Muslim World 360',
    'Prayer times, Quran and Hadith reading, and searchable content for Android and iOS. Built with Flutter and GetX.',
    Icons.nights_stay_outlined,
  ),
  (
    'Shirleys',
    'E-commerce clothing application for browsing and purchasing clothes. Built with Flutter and GetX.',
    Icons.shopping_bag_outlined,
  ),
  (
    'Load a Trash',
    'A UK application connecting people with useful unwanted items to buyers. Built with Flutter and GetX.',
    Icons.recycling_outlined,
  ),
  (
    'Cam translator',
    'Camera-based recognition and translation with Google ML Kit. Built with Flutter and GetX.',
    Icons.camera_alt_outlined,
  ),
  (
    'Sterna Search',
    'Search and travel application. Built with Flutter and GetX.',
    Icons.travel_explore_rounded,
  ),
  (
    'Family Tutor',
    'An educational hub for tutors and students. Built with Flutter and GetX.',
    Icons.school_outlined,
  ),
];
