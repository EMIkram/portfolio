from pathlib import Path
from reportlab.platypus import SimpleDocTemplate, Paragraph, PageBreak, HRFlowable, Spacer
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.colors import HexColor
from build_documents import resume
import re
out=Path(__file__).parent
content=list(resume)
content[1]=('subtitle','Senior Software Engineer | Tech Lead | AI Engineer')
content[2]=('contact','Islamabad, Pakistan · +92 309 525 1250<br/><link href="mailto:emikramulhaq@gmail.com">Email</link> · <link href="https://www.linkedin.com/in/muhammad-ikram-ulhaq-a718a9145/">LinkedIn</link> · <link href="https://github.com/EMIkram">GitHub / Projects</link><br/>Open to on-site, hybrid and remote opportunities')
content[3]=('heading','SUMMARY')
content[4]=('body','<b>Senior Software Engineer and Tech Lead</b> with 5+ years in software engineering and 3+ years leading teams across Flutter mobile/web and native iOS. AI engineering focus: applying coding agents, prompt engineering and specification-driven workflows to plan, implement, test and review production software. Combine hands-on architecture with requirements gathering, Jira planning, mentoring and release ownership. Confident adapting to new technologies through focused R&D and careful validation.')
content[5]=('heading','TECHNICAL EXPERTISE')
content[6]=('body','<b>AI-Native Development:</b> Prompt engineering, agentic coding workflows, AI-assisted planning, spec-driven development, ChatGPT/Codex, test-driven development and human code review.<br/><b>Mobile &amp; web:</b> Flutter, Dart, Swift, UIKit, BLoC/Cubit, responsive UI, asynchronous programming and streams.<br/><b>Architecture &amp; integration:</b> Clean Architecture, MVVM, SOLID, REST APIs, Firebase, secure networking, centralized error handling and local persistence.<br/><b>Delivery &amp; leadership:</b> GitHub Actions, CI/CD, Jira, Kanban, requirements gathering, release management, App Store/Google Play delivery, mentoring and code reviews.')
content[7]=('heading','EXPERIENCE')
content[11]=('bullet','• Gather requirements, plan work in Jira, and own CI/CD, QA handoffs, release validation and deployment across environments.')
styles={}
for key in ['title','subtitle','contact','heading','role','body','bullet']:
 styles[key]=ParagraphStyle(key,fontName='Arial',fontSize=10,leading=14,textColor=HexColor('#444444'),spaceAfter=6)
styles['title']=ParagraphStyle('name',fontName='ArialBold',fontSize=26,leading=31,spaceAfter=6,textColor=HexColor('#353535'))
styles['subtitle']=ParagraphStyle('sub',fontName='ArialBold',fontSize=11,leading=15,spaceAfter=10,textColor=HexColor('#C5195B'))
styles['contact'].fontSize=9;styles['contact'].leading=13
styles['heading']=ParagraphStyle('head',fontName='ArialBold',fontSize=12,leading=16,spaceBefore=12,spaceAfter=8,keepWithNext=True,textColor=HexColor('#353535'))
styles['role']=ParagraphStyle('role',fontName='ArialBold',fontSize=10,leading=14,spaceBefore=7,spaceAfter=4,keepWithNext=True,textColor=HexColor('#C5195B'))
styles['bullet'].leftIndent=10;styles['bullet'].firstLineIndent=-9
story=[]
for i,(kind,text) in enumerate(content):
 if kind=='break':story.append(PageBreak());continue
 if kind=='title':text=text.upper()
 if kind=='heading':text=text.upper()
 story.append(Paragraph(text,styles[kind]))
 if i==2:story.extend([Spacer(1,3),HRFlowable(width='100%',thickness=3,color=HexColor('#444444')),Spacer(1,3)])
def footer(c,d):
 c.setFont('Arial',8);c.setFillColor(HexColor('#777777'));c.drawString(44,24,'MUHAMMAD IKRAM UL HAQ');c.drawRightString(568,24,str(d.page))
name='Muhammad_Ikram_AI_Engineer_CV'
SimpleDocTemplate(str(out/(name+'.pdf')),pagesize=(612,792),leftMargin=44,rightMargin=44,topMargin=32,bottomMargin=38,title='Muhammad Ikram Ul Haq — Senior Software Engineer | Tech Lead | AI Engineer',author='Muhammad Ikram Ul Haq').build(story,onFirstPage=footer,onLaterPages=footer)
(out/(name+'.md')).write_text('\n\n'.join(re.sub('<[^>]+>','',text.replace('<br/>','\n')) for kind,text in content if kind!='break'),encoding='utf8')
