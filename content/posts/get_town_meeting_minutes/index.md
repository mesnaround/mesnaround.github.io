+++
date = '2025-11-05T20:58:30-05:00'
draft = true
title = 'Get_town_meeting_minutes'
+++

I have the start of an idea. I don't know where it will lead, but it starts with a problem.

The town where I live posts meeting agendas and minutes on their [website](https://www.oldlyme-ct.gov). I would like to follow what's going on in these meetings by reading the minutes. They offer some options to automatically notify when they arrive. You can subscribe to email updates for specific commissions of which there are many, or you can just navigate to the specific minutes e.g. [top entry](https://www.oldlyme-ct.gov/AgendaCenter/ViewFile/Minutes/_03142023-255). There is also this [handy page](https://www.oldlyme-ct.gov/agendacenter) which has all the links in one long scrollable page.

What I don't like is that I have to click on "Minutes" for each meeting I want minutes for. If you click on one of these you will see a PDF document. I would prefer:
  * for the emails to see the text directly without having to click on 3 links. 
  * to have a view where I can see the notes in one long scrollable document, going back in a toggleable amount.

There are many RSS feed links but none of them give the actual meeting minutes.

I'm wondering if I can code something up to scrape the website, pull the meeting minutes, identify, define, and organize off of key metadata, and put it in a database. From there I could better visualize this text. Down the road, also seems like a natural extension to use a LLM to offer summaries of minutes + tracking topics over time.

I see that the website is created by [CivicPlus](https://www.civicplus.com/) which specializes in local websites.

These are all PDF files, so if I can pull all of the PDF files then I can operate locally. Also making sure to not pull files more than once to eliminate redundancy.

I copied one of the links in Firefox and started looking through the page source. Now mind you, I am not a web developer. I have dabbled in HTML+CSS, Django, Jekyll, and now Hugo, but honestly I have always been averse to web development. I know I have a lot to learn in this department. I have successfully put together some scraping projects with BeautifulSoup and Selenium back in 2017/2018.

Here is one section of the page source which matches my link
```
<tr id="row3033fda42fc4" class="catAgendaRow">
	<td>
		<h3 class="noMargin" id="h408192025-3033">
			<a id="_08192025-3033" name="_08192025-3033"></a>
			<strong aria-label="Agenda for August 19, 2025"><abbr title="August">Aug</abbr> 19, 2025</strong>
			
				&thinsp;&mdash;&thinsp;Amended <abbr title="July">Jul</abbr> 28, 2025 3:49 PM
			
			</h3>
	<p>
	
			<a id="08192025-3033" name="3033" href="/AgendaCenter/ViewFile/Agenda/_08192025-3033" target="_blank" aria-describedby="h408192025-3033">
		Old Lyme Zoning Commission Special Meeting Agenda - 8/19/2025
	</a></p>
		
	</td>
		<!--This TD actually needs to be empty of all whitespace for matching :empty css selector.-->
		<td class="minutes"><a href="/AgendaCenter/ViewFile/Minutes/_08192025-3033" aria-label="August 19, 2025, Old Lyme Zoning Commission Special Meeting Agenda - 8/19/2025. Minutes" target="_blank"><img src="/Areas/AgendaCenter/Assets/Images/HomeIconMinutes.png" alt="Minutes"></a></td>
	

	<td class="media">
		
			<span id="media" class="videos" style="display: inline-block;">
			<a href="https://youtu.be/2DkV6AleOYc?si=Nmtd4JNDNXgGeycY" onkeypress="this.onclick();" onclick="return showExternalSiteDialog(this);" aria-label="August 19, 2025, Old Lyme Zoning Commission Special Meeting Agenda - 8/19/2025. Media" >
				<img  src="/Areas/AgendaCenter/Assets/Images/HomeIconVideos.png" alt="Videos">
			</a></span>
		
	</td>
	<td class="downloads">
		
		<div id="downloadContainer3033" class="popoutContainer">
			<a href="" id="btnAgendaDD3033" data-cp-toggle="dropdown" aria-controls="agendaDD3033" aria-haspopup="true" aria-expanded="false" role="button" class="button"><span id="spanDD3033">Download&nbsp;&#9660;</span></a>
			<div class="popout popUp" id="agendaDD3033" style="display:none;">
		
				<div class="popoutTop">
					<div class="popoutBtm">
						<ol role="menu">
								
									<li><a  role="menuitem" aria-label="August 19, 2025, Old Lyme Zoning Commission Special Meeting Agenda - 8/19/2025. Agenda" class="pdf" href="/AgendaCenter/ViewFile/Agenda/_08192025-3033" id="anch23033fda42fc4" target="_blank">Agenda</a></li>
								
									<li><a role="menuitem" aria-label="August 19, 2025, Old Lyme Zoning Commission Special Meeting Agenda - 8/19/2025. Previous Version" id="anch43033fda42fc4" class="previous" href="/AgendaCenter/PreviousVersions/_08192025-3033">Previous Versions</a></li>
								
						</ol>
					</div>
				</div>
			</div>
		</div>
	</td>
</tr>
```

Probably something relatively simple on the backend. To my untrained eye, it looks like these files are just getting uploaded and then served up. The menu entry is created automatically somehow, and this is why my lack of experience gives me halt. I guess I'll look through some of the other Tools in Firefox, but after a few minutes I'm not sniffing out any leads. I'm going to start talking with an LLM
Probably something relatively simple on the backend. To my untrained eye, it looks like these files are just getting uploaded and then served up. The menu entry is created automatically somehow, and this is why my lack of experience gives me halt. I guess I'll look through some of the other Tools in Firefox, but after a few minutes I'm not sniffing out any leads. I'm going to start talking with an LLM.

Ok so I am using Claude Sonnet 4.5. This is my initial and follow up prompt.
```
I am trying to scrape a website where there is tabular data. In the second column sometimes there is a PDF and sometimes nothing. I know this website uses javascript. I am a developer but not at all a web developer. I do have experience with Python, HTML, and CSS, but I don't understand how to code websites apart from manually assembling HTML and CSS, using Python Scrapy, Selenium, BeautifulSoup, or using Markdown, or a no-code tool. Can you help guide me and teach me what you know along the way?
```
```
This is the URL, https://www.oldlyme-ct.gov/agendacenter. I am able to just curl the links directly. Do you see the column that says Minutes where each populated entry has an icon with a box and a green check mark in it? It's those links that contain the PDFs that I want to pull.
```

The output of the second prompte is a long Python script that it is asking me to try. I will setup my environment, review the script, and give it a go.

Ok so I setup my environment with uv and python3.14 which took me a couple minutes to work through as I'm newish to uv. The script looked ok to try but failed initially. I started step-by-step debugging it and it seems that it's pointing to the wrong column. It's pointing to the Media column and not the Minutes column. Easy fix!
