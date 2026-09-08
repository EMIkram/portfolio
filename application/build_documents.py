from pathlib import Path
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.colors import HexColor
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.enums import TA_LEFT
import shutil

OUT = Path(__file__).parent
pdfmetrics.registerFont(TTFont('Arial', 'C:/Windows/Fonts/arial.ttf'))
pdfmetrics.registerFont(TTFont('ArialBold', 'C:/Windows/Fonts/arialbd.ttf'))
pdfmetrics.registerFontFamily('Arial', normal='Arial', bold='ArialBold')
styles = {
    'title': ParagraphStyle('title', fontName='ArialBold', fontSize=23, leading=28, spaceAfter=6),
    'subtitle': ParagraphStyle('subtitle', fontName='ArialBold', fontSize=11, leading=16, textColor=HexColor('#354B68'), spaceAfter=7),
    'contact': ParagraphStyle('contact', fontName='Arial', fontSize=9, leading=14, textColor=HexColor('#465363'), spaceAfter=10),
    'heading': ParagraphStyle('heading', fontName='ArialBold', fontSize=11, leading=15, textColor=HexColor('#354B68'), spaceBefore=13, spaceAfter=7, keepWithNext=True),
    'role': ParagraphStyle('role', fontName='ArialBold', fontSize=10.5, leading=15, spaceBefore=8, spaceAfter=3, keepWithNext=True),
    'body': ParagraphStyle('body', fontName='Arial', fontSize=10.5, leading=15, spaceAfter=7),
    'bullet': ParagraphStyle('bullet', fontName='Arial', fontSize=10.5, leading=15, leftIndent=11, firstLineIndent=-9, spaceAfter=5),
}
contact = 'Islamabad, Pakistan | +92 309 525 1250 | <link href="mailto:emikramulhaq@gmail.com">emikramulhaq@gmail.com</link><br/><link href="https://www.linkedin.com/in/em-ikram-a718a9145/">LinkedIn</link> | <link href="https://github.com/EMIkram">Project portfolio on GitHub</link> | Available for remote work'
resume = [
('title', 'Muhammad Ikram Ul Haq'),
('subtitle', 'Mobile Engineer | iOS and Android | Flutter and Native iOS'),
('contact', contact),
('heading', 'Professional profile'),
('body', 'Mobile engineer and team lead with 6+ years of experience across Flutter, native iOS, and production application delivery. Hands-on experience with Swift, UIKit, iOS concurrency, secure API integrations, and App Store workflows. Contributed to a UK healthcare application serving NHS patients and currently lead Carbee’s Flutter Web team while supporting mobile delivery. Apply AI-agent-assisted and spec-driven development across planning, implementation, testing, and review.'),
('heading', 'Technical skills'),
('body', '<b>Native iOS:</b> Swift, UIKit, CoreData, UserDefaults, GCD, async/await, APNs, App Store deployment and maintenance.<br/><b>Cross-platform:</b> Flutter, Dart, BLoC/Cubit, responsive UI, asynchronous programming and streams.<br/><b>Integration:</b> REST APIs, JSON modeling, Firebase, FCM, network interceptors, encryption, centralized error handling, Sqflite and SharedPreferences.<br/><b>Architecture and delivery:</b> Clean Architecture, MVVM, SOLID, reusable packages, GitHub Actions, CI/CD, Jira, Kanban, code reviews and mentoring.<br/><b>AI-related work:</b> AI-assisted and spec-driven development; project experience with avatar chat and Google ML Kit recognition and translation.'),
('heading', 'Professional experience'),
('role', 'Techtronix | Team Lead Flutter Developer | Mar 2024 – Present'),
('bullet', '• Lead Carbee’s Flutter Web team, with primary ownership of admin and dealership portals and collaboration across mobile, backend, QA, and product teams.'),
('bullet', '• Build reusable foundations for secure networking, interceptors, centralized errors, request/response tracing, and encryption handling.'),
('bullet', '• Own CI/CD and release workflows, including GitHub–Jira automation, QA handoffs, validation, and development, QA, staging, and production environments.'),
('bullet', '• Support Android/iOS product delivery, review code, mentor engineers, and apply AI-agent-assisted workflows with structured requirements and implementation plans.'),
('role', 'AT-Tech | Software Engineer, Flutter and Native iOS | Jun 2022 – Mar 2024'),
('bullet', '• Enhanced production native-iOS features and modules for Dr.iQ, a UK digital healthcare product serving NHS patients, working alongside the iOS team.'),
('bullet', '• Contributed to a major codebase refactor for maintainable architecture, alongside Firebase, persistence, notifications, and iOS deployment workflows.'),
('bullet', '• Led the PSX Ascend migration initiative from an existing native iOS application to Flutter for Android and iOS, retaining core product functionality.'),
('break', ''),
('heading', 'Earlier experience'),
('role', 'Heuristify | Flutter Developer | Jan 2022 – Jun 2022'),
('bullet', '• Led Invoice Labs redevelopment from native Android to Flutter for Android, iOS, and Linux; implemented local persistence and delivered a stable Google Play release.'),
('bullet', '• Mentored product-team members and interns through implementation and code review.'),
('role', 'SBS | Associate Software Engineer | Nov 2020 – Jan 2022'),
('bullet', '• Developed and deployed 8+ cross-platform Android/iOS applications.'),
('bullet', '• Enhanced LSUK with travel-distance calculation, UI improvements, feature delivery, and architecture cleanup for its UK interpreter workflows.'),
('role', 'Independent | Freelance Mobile App Developer | Aug 2019 – Sep 2020'),
('body', 'Delivered mobile development work for Android and iOS.'),
('heading', 'Selected mobile and AI-related products'),
('role', 'Dr.iQ | Native iOS healthcare'),
('body', 'Production iOS engineering and architecture refactoring for online healthcare consultations and patient services. <link href="https://apps.apple.com/pk/app/dr-iq/id1345802108">View on the App Store</link>.'),
('role', 'Carpool | Independent Flutter and Android product'),
('body', 'Independently developed and maintain a live local carpooling product. Use it to apply AI-agent-assisted, spec-driven development from specification and architecture through release and iteration. <link href="https://play.google.com/store/apps/details?id=com.carpoolingpk.carpool">View on Google Play</link>.'),
('role', 'Afterlife AI and Cam Translator | AI-related mobile experience'),
('body', 'Worked on Afterlife AI, an avatar creation and chat application, and Cam Translator, a Google ML Kit-based camera application for text/object recognition and translation.'),
('role', 'My Treats and LSUK | Released mobile applications'),
('body', 'Restaurant ordering and delivery applications for My Treats in Bristol, and interpreter workflows for LSUK. <link href="https://apps.apple.com/gb/app/my-treats/id1553674065">My Treats on the App Store</link> · <link href="https://apps.apple.com/us/app/lsuk/id1545528069">LSUK on the App Store</link>.'),
('heading', 'Education'),
('body', '<b>Bachelor of Computer Science</b><br/>Federal Urdu University, Islamabad | 2016–2020 | CGPA 3.59'),
]
letter = [
('title', 'Muhammad Ikram Ul Haq'),
('subtitle', 'Application for Mobile Engineer iOS and Android'),
('contact', contact),
('body', 'Dear Hiring Team,'),
('body', 'I’m applying for your remote Mobile Engineer position. I bring 6+ years of mobile development experience, combining Flutter delivery for Android and iOS with native iOS work in Swift and UIKit. Your focus on reliable mobile applications and AI-powered experiences is closely aligned with the products I have worked on and the engineering practices I use today.'),
('body', 'At AT-Tech, I worked with the iOS team on Dr.iQ, a production healthcare application serving NHS patients. I enhanced features and modules and contributed to a major architecture refactor. My iOS experience includes concurrency with GCD and async/await, persistence, notifications, and App Store deployment and maintenance workflows.'),
('body', 'At Techtronix, I lead Carbee’s Flutter Web team while supporting mobile delivery. My responsibilities include secure API integration, centralized error handling, reusable architecture, CI/CD, QA handoffs, and release coordination. This work requires close collaboration with backend, mobile, QA, and product colleagues to resolve issues and maintain dependable delivery.'),
('body', 'My project experience also includes Afterlife AI, an avatar and chat application, and a Google ML Kit-based recognition and translation app. Separately, I actively use AI-agent-assisted and spec-driven development for planning, implementation, testing, and review. I would welcome a technical discussion about how this experience can contribute to your mobile and AI product work.'),
('body', 'You can explore my project portfolio at <link href="https://github.com/EMIkram">https://github.com/EMIkram</link>, including links to published applications. I am based in Islamabad and available for remote work, and I am open to discussing either full-time or contract engagement.'),
('body', 'Thank you for considering my application. I would welcome the opportunity to discuss my work and the needs of your team.'),
('body', 'Best regards,<br/><b>Muhammad Ikram Ul Haq</b>'),
]

def footer(canvas, doc):
    canvas.setFont('Arial', 8)
    canvas.setFillColor(HexColor('#657180'))
    canvas.drawString(44, 25, 'Muhammad Ikram Ul Haq | Mobile Engineer')
    canvas.drawRightString(568, 25, str(doc.page))

def build(name, content):
    story=[]
    for kind, text in content:
        story.append(PageBreak() if kind == 'break' else Paragraph(text, styles[kind]))
    SimpleDocTemplate(str(OUT / (name+'.pdf')), pagesize=(612,792), leftMargin=44, rightMargin=44, topMargin=36, bottomMargin=40, title=name.replace('_',' '), author='Muhammad Ikram Ul Haq').build(story, onFirstPage=footer, onLaterPages=footer)
    import re
    (OUT / (name+'.md')).write_text('\n\n'.join(re.sub('<[^>]+>', '', text.replace('<br/>','\n')) for kind,text in content if kind != 'break'), encoding='utf8')

build('Muhammad_Ikram_Mobile_Engineer_Resume', resume)
build('Muhammad_Ikram_Mobile_Engineer_Cover_Letter', letter)
shutil.copy2(OUT/'Muhammad_Ikram_Mobile_Engineer_Resume.pdf', OUT.parent/'web/resume.pdf')
