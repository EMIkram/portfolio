from pathlib import Path
import re
import zipfile
from reportlab.platypus import SimpleDocTemplate, Paragraph, PageBreak
from reportlab.lib.colors import HexColor
from build_documents import resume, styles

OUT = Path(__file__).parent / 'resume_versions'
OUT.mkdir(exist_ok=True)

variants = {
    'Senior_Software_Engineer_Flutter': {
        'title': 'Senior Software Engineer | Flutter Mobile and Web | Native iOS',
        'summary': 'Senior Software Engineer with 6+ years of experience, currently working as Tech Lead — Flutter & Mobile/Web Engineering. Bring 2.5 years of team leadership alongside hands-on delivery of Flutter applications for Android, iOS, and web, with additional native iOS experience in Swift and UIKit. Own features from architecture and API integration through testing, release, and production support. Combine strong implementation skills with mentoring and cross-functional delivery, with a strong interest in technical leadership and project management.',
        'skills': '<b>Application development:</b> Flutter, Dart, Android, iOS, Flutter Web, Swift, UIKit, BLoC/Cubit, responsive UI, asynchronous programming and streams.<br/><b>Architecture and integration:</b> Clean Architecture, MVVM, SOLID, REST APIs, JSON, Firebase, secure networking, encryption and error handling.<br/><b>Platform and data:</b> GCD, async/await, CoreData, UserDefaults, APNs/FCM, Sqflite and SharedPreferences.<br/><b>Engineering delivery:</b> GitHub Actions, CI/CD, environment management, App Store and Google Play delivery, testing, code reviews and production support.<br/><b>Leadership and ways of working:</b> Mentoring, feature planning, Jira, Kanban/Scrum, QA coordination, AI-agent-assisted and spec-driven development.',
        'bullets': [
            'Lead Carbee’s Flutter Web team as primary owner of admin and dealership portals; continue supporting Android/iOS applications alongside web delivery.',
            'Design and implement reusable architecture, secure API integrations, network interceptors, centralized error handling, request/response tracing, and encryption services.',
            'Gather requirements and plan delivery in Jira; own CI/CD, QA handoffs, and releases across development, staging, and production.',
            'Remain hands-on in feature delivery while reviewing code, mentoring engineers, guiding architecture decisions, and running bi-weekly Flutter learning sessions.',
        ],
    },
    'Tech_Lead': {
        'title': 'Senior Software Engineer | Tech Lead | Mobile and Web',
        'summary': 'Senior Software Engineer currently working as Tech Lead — Flutter & Mobile/Web Engineering, with 6+ years of experience and 2.5 years of team leadership. Combine hands-on Flutter mobile and web engineering with architecture, mentoring, and release ownership. Lead delivery across engineering, QA, and product stakeholders. Seeking Tech Lead opportunities, with a strong interest in project management and team development.',
        'skills': '<b>Technical leadership:</b> Architecture guidance, feature planning, mentoring, code reviews, engineering standards and cross-functional collaboration.<br/><b>Application engineering:</b> Flutter, Dart, Android/iOS and web applications, Swift/UIKit, BLoC/Cubit, Clean Architecture, MVVM and SOLID.<br/><b>Integration and reliability:</b> REST APIs, JSON, Firebase, secure networking, encryption, centralized errors and request/response tracing.<br/><b>Delivery ownership:</b> GitHub Actions, CI/CD, release validation, multi-environment architecture, versioning and production support.<br/><b>Team workflows:</b> Jira, Kanban/Scrum, QA handoffs, GitHub–Jira automation, technical documentation, AI-agent-assisted and spec-driven development.',
        'bullets': [
            'Lead Carbee’s Flutter Web team and serve as primary technical owner of admin and dealership portals, coordinating decisions with mobile, backend, QA, and product stakeholders.',
            'Gather requirements, guide technical planning and architecture, and review code while contributing hands-on; mentor developers and run bi-weekly Flutter learning sessions.',
            'Establish shared foundations for networking, encryption, centralized errors, and environment configuration to improve consistency across application development.',
            'Own release practices, CI/CD, and GitHub–Jira automation; introduced Kanban workflows and coordinated QA handoffs, validation, and production deployment.',
        ],
    },
    'Technical_Project_Management': {
        'title': 'Senior Software Engineer | Tech Lead | Technical Delivery',
        'summary': 'Senior Software Engineer working as Tech Lead — Flutter & Mobile/Web Engineering, with 6+ years of experience and 2.5 years of team leadership across Flutter mobile and web applications. Coordinate requirements, feature planning, QA handoffs, and releases with engineering and product stakeholders. Strong interest in technical project management, combining hands-on engineering with structured coordination, delivery ownership, and process improvement.',
        'skills': '<b>Planning and coordination:</b> Requirements translation, feature planning, ticket grooming, sprint planning, priority coordination and stakeholder communication.<br/><b>Delivery management:</b> Jira, Kanban/Scrum, QA coordination, release validation, versioning, deployment tracking and production handoffs.<br/><b>Process improvement:</b> GitHub–Jira automation, CI/CD workflows, environment promotion and development-to-release process ownership.<br/><b>Team leadership:</b> Mentoring, code reviews, architectural guidance, knowledge sharing and collaboration across product, backend, mobile and QA teams.<br/><b>Technical foundation:</b> Flutter/Dart mobile and web, Swift/UIKit, REST APIs, Firebase, Clean Architecture, AI-assisted planning and spec-driven development.',
        'bullets': [
            'Lead delivery for Carbee’s Flutter Web team, coordinating admin and dealership portal work with mobile, backend, QA, and product stakeholders.',
            'Gather requirements and translate them into feature plans and Jira work items; coordinate ticket grooming, sprint planning, Kanban workflows, and implementation discussions.',
            'Own development-to-deployment processes covering QA handoffs, versioning, release validation, and production deployment; identify and address workflow gaps.',
            'Introduce GitHub–Jira automation for branch/ticket linking, status transitions, and deployment tracking while remaining hands-on in engineering and mentoring.',
        ],
    },
}

def footer(canvas, doc):
    canvas.setFont('Arial', 8)
    canvas.setFillColor(HexColor('#657180'))
    canvas.drawString(44, 25, 'Muhammad Ikram Ul Haq | Senior Software Engineer')
    canvas.drawRightString(568, 25, str(doc.page))

def content_for(v):
    content = [(kind, text.replace('Available for remote work', 'Open to on-site, hybrid and remote opportunities')) for kind, text in resume]
    content[1] = ('subtitle', v['title'])
    content[4] = ('body', v['summary'])
    content[5] = ('heading', 'Core capabilities')
    content[6] = ('body', v['skills'])
    start = next(i for i,x in enumerate(content) if x[0]=='role' and x[1].startswith('Techtronix')) + 1
    content[start:start+4] = [('bullet', '• '+b) for b in v['bullets']]
    i = next(i for i,x in enumerate(content) if x[1]=='Selected mobile and AI-related products')
    content[i] = ('heading', 'Selected products and initiatives')
    content[i+1:i+1] = [
        ('role', 'Carbee | Flutter Web and mobile product delivery'),
        ('body', 'Lead admin and dealership portal engineering within an automotive product spanning mobile and web. Own shared foundations and delivery workflows. <link href="https://carbee.com.au">Product website</link>.'),
    ]
    return content

for name, variant in variants.items():
    content = content_for(variant)
    filename = 'Muhammad_Ikram_'+name
    story = [PageBreak() if kind=='break' else Paragraph(text, styles[kind]) for kind,text in content]
    SimpleDocTemplate(str(OUT/(filename+'.pdf')), pagesize=(612,792), leftMargin=44, rightMargin=44, topMargin=36, bottomMargin=40, title=variant['title'], author='Muhammad Ikram Ul Haq').build(story, onFirstPage=footer, onLaterPages=footer)
    def editable(kind, text):
        text = text.replace('<br/>', '\n')
        text = re.sub(r'<link href="([^"]+)">([^<]+)</link>', r'[\2](\1)', text)
        text = text.replace('<b>','**').replace('</b>','**')
        return ('# ' if kind=='title' else '## ' if kind=='heading' else '### ' if kind=='role' else '') + text
    (OUT/(filename+'.md')).write_text('\n\n'.join(editable(kind,text) for kind,text in content if kind!='break'), encoding='utf8')

with zipfile.ZipFile(OUT/'Muhammad_Ikram_Resume_Pack.zip','w',zipfile.ZIP_DEFLATED) as pack:
    for path in sorted(OUT.glob('*')):
        if path.suffix in ('.pdf','.md'):
            pack.write(path, path.name)
