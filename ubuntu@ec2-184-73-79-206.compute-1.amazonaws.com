--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: additional_texts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY additional_texts (id, article_id, bullet, location, created_at, updated_at) FROM stdin;
7	11	<span style="font-size:14px">Major quakes jolted wide areas of Asia, scientists warn of strong quakes in future.<br />\r\n-7.8 magnitude earthquake hit Iran on Apr 16<br />\r\n-6.2 magnitude temblor struck Japan on Apr 21<br />\r\n-7.2&nbsp;&nbsp;magnitude earthquake hit Kuril Island, southeast Russia on Apr 19</span>	0	2013-04-23 05:30:39.200707	2013-04-23 05:35:18.00153
8	13	<strong>Miranda rights</strong> is the rights to protect oneself in custody from self-incrimination. He must be informed that he has the right to remain silent and to have an attorney present during questioning, prior to interrogation.	0	2013-04-23 07:30:07.395303	2013-04-23 07:30:07.395303
2	8	<strong>Tim Cook</strong><br />\r\n&ldquo;Our teams are hard at work on some amazing new hardware, software and services, and we are very excited about the products in our pipeline.&rdquo;	0	2013-04-16 13:02:33.159699	2013-04-23 23:52:50.924021
3	8	<strong>Comparision (2Q 2012 - 2Q 2013)</strong><br />\r\nRevenue: $39.2B &lt; $43.6B<br />\r\n&nbsp; &nbsp; &nbsp;iPhone sales: 35.1M &lt; 37.4M<br />\r\n&nbsp; &nbsp; &nbsp;iPad sales: 11.8M &lt; 19.5M<br />\r\nNet profit: $11.6B &gt; $9.5B&nbsp;<br />\r\nGross margin: 47.4% &gt; 37.5%	1	2013-04-16 13:02:33.189522	2013-04-23 23:52:50.93624
9	22	Previous polls showed that 55-60% of French citizens supported gay marriage, but only about 50% supported gay adoption.	0	2013-04-24 07:14:08.809515	2013-04-24 07:14:08.809515
10	23	<strong>Paul Kevin Curtis</strong><br />\r\n&quot;I respect President Obama.&quot;<br />\r\n&quot;I love my country.&quot;<br />\r\n(On &#39;ricin&#39;) &quot;I thought they said rice. I said I don&#39;t even eat rice.&quot;	0	2013-04-24 08:29:20.860812	2013-04-24 08:29:20.860812
11	23	<strong>Everett Dutschke</strong><br />\r\nRan for Missisippi House of Representatives in 2007 as the Repulican candidate. He lost to the incumbent Democratic Representative Stephen Holland, whose mother was one of the ricin letter recepients, Judge Sadie Holland. &nbsp;	1	2013-04-24 08:29:20.862574	2013-04-24 08:29:20.862574
\.


--
-- Name: additional_texts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('additional_texts_id_seq', 11, true);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY articles (id, title, city, country, previous_summary, current_content, created_at, updated_at, status, contributor_id, editor_id, temporary_title, instruction, category, published_at) FROM stdin;
13	No miranda rights for Boston marathon suspect	Boston 	USA	<strong>Boston Marathon explosions </strong>killed three, injured 144. on Monday. A prime suspect, Tamerlan Tsarnaev, 26, was killed in firefight with police on early Friday. Dzhokhar Tsarnaev, 19, a younger brother of dead suspect, was captured alive on Friday night.&nbsp;	Federal authorities invoked <u>a public safety exemption</u> on Sunday, questioned Dzhokhar Tsarnaev for first 48 hours without first reading his<strong>&nbsp;Miranda rights.&nbsp;</strong>	2013-04-21 07:51:50.014271	2013-04-23 07:30:15.81048	Need Review	2	2	No miranda rights for Boston marathon suspect	FYI: what's miranda rights?	Politics	\N
20	\N	\N	\N	\N	\N	2013-04-23 07:45:22.974212	2013-04-23 07:45:22.974212	Assigned	2	2	Burma accused of ethnic cleansing	Background: history of ethnic cleansing\r\n(use number info)\r\nFYI: any similar case?\r\n	World	\N
8	Apple sales up, profits down in 2Q	Cupertino	California	Apple&#39;s stock price has steadily declined 40% over the past two quarters and closed at a 52-week low of $390 last Friday. There have been unconfirmed rumors that Apple investors want Tim Cook fired.	Despite increased iPhone/iPad sales, Apple&#39;s fiscal 2013 second quarter profit fell 18% and gross profit margins dropped nearly 10% compared to the same quarter a year ago. Consumers&#39; preference for lower margin products - <strong>older iPhones</strong> and iPad minis - has reportedly contributed to the first year-to-year profit decline in nearly a decade. Apples plans to increase <strong>dividends </strong>and <strong>share buyback</strong>&nbsp;to placate worried investors.<br />\r\n&nbsp;	2013-04-16 12:58:24.106586	2013-04-23 23:58:17.519971	Published	3	3	\N	\N	Economy	2013-04-23 23:58:17.518762
19	test6	test	test	tes	res	2013-04-21 14:10:25.176579	2013-04-21 14:11:14.304253	Approved	1	1	test6	test6	World	\N
11	China Earthquake	Sichuan	China	<span style="font-size:14px"><span style="color:rgb(66, 72, 88)">Sinchuan is the area where 7.9 magnitude quake&nbsp;killed 70,000 people with 19,000 missing in 2008.</span></span><br />\r\n&nbsp;	<span style="font-size:14px"><span style="color:rgb(0, 0, 0)"><strong>6.6 magnitude earthquake</strong> struck <strong>Sichuan </strong>on early Saturday killed 192 people, injured&nbsp;11,200. China earmarked 1 billion yuan ($162 M), dispatched 18,000 soldiers and officers for rescue and relief work.&nbsp;</span></span>	2013-04-21 06:24:28.370702	2013-04-23 05:36:14.649062	Need Review	2	2	China Earthquake	Earthquake strikes wide area of Asia\r\n(China, Japan, Iran, Korea )	World	\N
21	Industry and Lawmakers Criticize FAA Furlough	Washington DC	USA	<span style="font-size:12px"><span style="color:rgb(0, 0, 0)">The FAA furlough went into effect on Sunday, affecting 47,000 workers including 15,000 air traffic controllers, who will be forced to take unpaid leaves of up to 11 days&nbsp;over the rest of the fiscal year. More than 1,200 flights were delayed in major airports throughout the country on Monday.</span></span>	Airline for America (A4A), a top industry group, filed a motion in court to stop the air traffic furlough, urging the FAA to find <strong>alternative ways</strong> to comply with federal budget cuts. <strong>Senators</strong> from both parties have made similar requests, conveying serious concerns over its impact. The <strong>White House</strong> said it was open to working with Congress to send air controllers back to work.&nbsp;	2013-04-24 01:08:01.518739	2013-04-24 02:12:03.624692	Published	3	3	faa furlough	keep up the good work\r\n	Politics	2013-04-24 02:12:03.623767
23	Charges Dropped Against Ricin Suspect	Tupelo	Mississippi	Earlier this month, threat letters containing lethal poison, ricin, were delievered to President Obama, a US Senator and a state judge. Paul Kevin Curtis, an Elvis impersonator from Missisippi, was arrested as the primary suspect shortly after. FBI searched his house and vehicle, but found no evidence of ricin or related searches on his computer.	Paul Kevin Curtis, who was <strong>arrested</strong> for sending ricin letters to the President, was freed after the FBI failed to find incriminating evidence in his house and vehicle. Prosecutors declined to elaborate on dropping charges against him. His lawyer argued that he was framed by a personal enemy, <strong>Everett Dutschke</strong>, who is currently being investigated. Dutschke is denying involvement.	2013-04-24 07:32:15.894724	2013-04-24 08:41:27.376354	Published	3	3	ricin suspect dropped	none	Politics	2013-04-24 08:41:27.375535
24	Open to Dialogue, but Can't Give Up Nukes	Geneva	Switzerland		Iran asserted that it could be a <strong>&#39;reliable partner&#39;</strong> in the Middle East if western powers took a more cooperative stance towards its nuclear program, insisting the sanctions approach will prove fruitless. Half way around the world, North Korea began to mention the possibility of holding talks with the US, but only as a recognized nuclear weapons state. US quickly dismissed Pyongyang&#39;s <strong>call for nuclear status</strong> and refrained from commenting on Iran&#39;s proposal.	2013-04-24 09:50:15.649688	2013-04-24 09:58:38.001525	Published	3	3	nuclear	none	World	2013-04-24 09:58:37.999214
22	France Legalizes Gay Marriage Amid Protests	Paris	France	&#39;Marrige for all&#39; law has been met with fierce opposition over the past few months. Some 340,000 citizens took the streets in protest in January. The law is considered socialist President Hollande&#39;s flagship social reform policy and the most significant of its kind since Mitterand abolished death penalty in 1981.&nbsp;	<strong>French National Assembly</strong>&nbsp;passed a bill legalizing gay marriage allowing same-sex couples to marry and adopt children. The <strong>decision</strong> came after an intense public debate in recent months, which involved massive street protests and several homophobic attacks. Opposing conservatives immediately appealed to France&#39;s constitutional council to repeal the law.	2013-04-24 06:10:22.356339	2013-04-24 07:17:43.694213	Published	3	3	france gay marriage	none	World	2013-04-24 07:17:43.690659
26	\N	\N	\N	\N	\N	2013-04-26 11:37:32.635556	2013-04-26 11:37:32.635556	Assigned	1	1	new article	instruction	World	\N
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('articles_id_seq', 26, true);


--
-- Data for Name: citations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY citations (id, article_id, author, title, published_date, publisher, link, created_at, updated_at, accessed_date) FROM stdin;
2	11	Armand Vervaeck, James Daniell, Jens Skapski,Carlos Robles	Deadly earthquake Sichuan (Ya’an), China-– Death toll now at 192 	2013-04-22	Earthquake-report	http://earthquake-report.com/2013/04/20/very-strong-earthquake-sichuan-china-on-april-20-2013/	2013-04-23 05:30:39.243534	2013-04-23 05:30:39.243534	2013-04-23
3	13	Earl Warren	Miranda v. Arizona	1966-03-01	US Earl WarrenSupreme Court	http://www.law.cornell.edu/supct/html/historics/USSC_CR_0384_0436_ZS.html	2013-04-23 07:30:07.413242	2013-04-23 07:30:07.413242	2013-04-22
4	8	David Goldman	Apple sells 48 million iPhones, but profit squeezed	2013-04-24	CNN Money	http://money.cnn.com/2013/01/23/technology/apple-earnings/index.html?iid=EL	2013-04-23 23:55:50.573781	2013-04-23 23:55:50.573781	2013-04-24
5	22	Angelique Chrisafis	France approves same-sex marriage	2013-04-23	Guardian	http://www.guardian.co.uk/world/2013/apr/23/france-approves-same-sex-marriage	2013-04-24 07:14:08.884407	2013-04-24 07:14:08.884407	2013-04-24
6	23	Robbie Brown	Man Is Freed as U.S. Questions Another Over Poisoned Mail	2013-04-23	New York Times	http://www.nytimes.com/2013/04/24/us/suspect-in-ricin-case-released-from-mississippi-jail.html?_r=0	2013-04-24 08:29:20.866448	2013-04-24 08:29:20.866448	2013-04-24
\.


--
-- Name: citations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('citations_id_seq', 6, true);


--
-- Data for Name: ckeditor_assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ckeditor_assets (id, data_file_name, data_content_type, data_file_size, assetable_id, assetable_type, type, width, height, created_at, updated_at) FROM stdin;
\.


--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ckeditor_assets_id_seq', 1, false);


--
-- Data for Name: employee_position_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employee_position_types (id, position_type, number_of_levels, created_at, updated_at) FROM stdin;
5	Administrator	1	2013-04-16 04:34:20.313717	2013-04-16 04:34:20.313717
6	Editor	1	2013-04-16 04:34:27.548214	2013-04-16 04:34:27.548214
7	Contributor	1	2013-04-16 04:34:34.287905	2013-04-16 04:34:34.287905
8	Intern	1	2013-04-16 04:34:42.550618	2013-04-16 04:34:42.550618
\.


--
-- Name: employee_position_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('employee_position_types_id_seq', 9, false);


--
-- Data for Name: employee_positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employee_positions (id, employee_id, "position", level, created_at, updated_at) FROM stdin;
4	2	Editor	1	2013-04-16 06:27:36.791103	2013-04-16 06:27:36.791103
5	2	Contributor	1	2013-04-16 06:27:36.825414	2013-04-16 06:27:36.825414
6	3	Editor	1	2013-04-16 06:28:02.076534	2013-04-16 06:28:02.076534
7	3	Contributor	1	2013-04-16 06:28:02.080162	2013-04-16 06:28:02.080162
8	4	Editor	1	2013-04-16 06:28:24.209263	2013-04-16 06:28:24.209263
9	4	Contributor	1	2013-04-16 06:28:24.21217	2013-04-16 06:28:24.21217
14	5	Administrator	1	2013-04-16 09:46:55.761731	2013-04-16 09:46:55.761731
15	5	Editor	1	2013-04-16 09:46:55.806498	2013-04-16 09:46:55.806498
16	5	Contributor	1	2013-04-16 09:46:55.814338	2013-04-16 09:46:55.814338
17	5	Intern	1	2013-04-16 09:46:55.818022	2013-04-16 09:46:55.818022
18	6	Intern	1	2013-04-19 03:01:44.311083	2013-04-19 03:01:44.311083
19	1	Administrator	1	2013-04-19 11:08:51.460845	2013-04-19 11:08:51.460845
20	1	Editor	1	2013-04-19 11:08:51.592845	2013-04-19 11:08:51.592845
21	1	Contributor	1	2013-04-19 11:08:51.603284	2013-04-19 11:08:51.603284
22	7	Intern	1	2013-04-21 07:06:41.967521	2013-04-21 07:06:41.967521
\.


--
-- Name: employee_positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('employee_positions_id_seq', 22, true);


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employees (id, first_name, email, created_at, updated_at, password_digest, last_name, create_account_token, create_account_sent_at, account_create_time, latest_login_at, password_reset_token, password_reset_sent_at) FROM stdin;
2	Kelly	kelly.chae@gmail.com	2013-04-16 06:27:36.747507	2013-04-23 05:43:39.931592	$2a$10$3GYwfMqqxBZ8GN9KpQlBIuJQMb1HbWZIs51YoRpKLLFPTNsNlOizq	Chae	bpuF6Va9oEYMZ2OqoNUovw	2013-04-16 06:27:36.840477	2013-04-16 06:33:28	2013-04-23 05:43:39.925784	\N	\N
1	Han	han.lee0707@gmail.com	2013-04-16 02:43:25.413666	2013-04-24 01:48:57.066286	$2a$10$M/cBT2tsBzF1UmTwZQJqbeEDD8bSK0K9W9X..Vj1fV6oXA7S1MWyu	Lee	oPFiHceWBjGgQb39E2YQgw	2013-04-16 02:43:25.476468	2013-04-16 02:44:39	2013-04-24 01:48:57.037378	4EvapzdG5cpNAQ8boQQDhQ	2013-04-21 06:51:26.658643
4	Gilwoo	gilwoo.lee.87@gmail.com	2013-04-16 06:28:24.206005	2013-04-26 01:16:38.647825	$2a$10$iz1Otr59IO.5ybh2TaSFnuZsOD2EMjBQ3dd//r5Fusz1GkOZZsL.m	Lee	MWUGJFHtumpoUQ1_qVjcmw	2013-04-16 06:28:24.221332	2013-04-17 03:58:43	2013-04-26 01:16:38.638312	\N	\N
3	Sungmin	sungmin.cho.kr@gmail.com	2013-04-16 06:28:02.07211	2013-04-22 04:29:21.691343	$2a$10$CZdksf7RfYN2To4bVdqs7eXubEDl7ax1FE071oypNsvX9W47TrUj2	Cho	OcaU8qguVoBWVnIc0EJ7zA	2013-04-16 06:28:02.090986	2013-04-16 06:33:43	2013-04-22 04:29:21.415504	\N	\N
7	Han Gyul	han_lee0707@hotmail.com	2013-04-21 07:06:41.712489	2013-04-21 07:08:51.587572	$2a$10$LA6E.1SxZtgTkylEU15xbO66xlWIf0GQhWbhfd7hQ50L1i2kCclAa	Lee	So_sqIHzw1ZZTQ9A0LaA0Q	2013-04-21 07:06:42.17092	\N	\N	VoZ4KnD1yPUVG52B6c3wEw	2013-04-21 07:06:58.015769
6	gist	temp.gist.team@gmail.com	2013-04-19 03:01:43.38502	2013-04-25 07:12:32.803012	$2a$10$Vo.UgFJW7wKMgmSDRnPTTuEJv2f4trb1mQDu9D/P.9bZdnEFAlZTG	team	99ei_NkLjlqXqX4JDanygg	2013-04-19 03:01:44.349216	2013-04-19 03:02:07	2013-04-25 07:12:32.786286	\N	\N
5	Youngsun	drctrek@gmail.com	2013-04-16 06:28:49.631009	2013-04-26 00:11:51.189547	$2a$10$zEDHCIuh3CcHxmJw2qX0guLuhJYFYIN7XzgPQ.PD8QjRB7PO4Dt7i	Kim	KnrKPZPrN7S6nSHR6hRTXQ	2013-04-16 06:28:49.647994	2013-04-16 06:34:29	2013-04-26 00:11:50.928623	\N	\N
\.


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('employees_id_seq', 7, true);


--
-- Data for Name: extra_informations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY extra_informations (id, article_id, phrase, explanation, created_at, updated_at) FROM stdin;
6	8	older iPhones	iPhone 5 accounted for less than half of the record number of iPhones sold by Verizion in 4Q 2012.	2013-04-23 23:51:45.853678	2013-04-23 23:51:45.853678
7	8	dividends	Increased by&nbsp;15% to $3.05 per share, payable on May 13.	2013-04-23 23:51:45.868518	2013-04-23 23:51:45.868518
8	8	share buyback	$50 billion added to the existing $10 billion share buyback program.&nbsp;	2013-04-23 23:51:45.870648	2013-04-23 23:51:45.870648
9	21	White House	<span style="font-size:12px"><span style="color:rgb(0, 0, 0)">&quot;If Congress has another idea about how to alleviate the challenges that sequester has caused for the FAA and for American travelers, we are open to looking at that,&quot;<br />\r\nWhite House spokesman Jay Carney</span></span>	2013-04-24 02:10:55.135829	2013-04-24 02:10:55.135829
10	21	alternative ways	<span style="color:rgb(0, 0, 0); font-size:12px">Consultancy fees and grant programs including $50 million in unused FAA research and capital fund.</span>	2013-04-24 02:10:55.184222	2013-04-24 02:10:55.184222
11	21	Senators	<span style="color:rgb(0, 0, 0); font-size:12px">Republican Jerry Moran of Kansas and Democrat Richard Blumenthal of Connecticut asked the FAA to delay the furlough for another 30 days and scrap plans to close 149 air control towers.</span>	2013-04-24 02:10:55.316042	2013-04-24 02:10:55.316042
12	22	French National Assembly	Socialists have an absolute majority in the lower house National Assembly.	2013-04-24 07:14:08.778947	2013-04-24 07:14:08.778947
13	22	decision	334 voted for and 225 voted against gay marriage.	2013-04-24 07:14:08.807524	2013-04-24 07:14:08.807524
15	23	Everett Dutschke	Martial arts instructor. Subject of local police investigation for child molestation. (<em>More on Dutschke in DETAILS.)</em>	2013-04-24 08:29:20.858945	2013-04-24 08:29:20.858945
14	23	arrested	He was arrested at home on April 17 and has been denying charges since. The letters were postmarked Memphis (close to his Corinth home), initialed &#39;KC&#39; and contained language with striking resemblance to his past writings.	2013-04-24 08:29:20.856898	2013-04-24 08:39:58.45132
16	23	ricin	Highly lethal poison made from castor oil. &nbsp;	2013-04-24 08:39:58.454144	2013-04-24 08:39:58.454144
17	24	reliable partner	<span style="color:rgb(0, 0, 0); font-size:14px">&quot;Western countries are advised to change gear from confrontation to cooperation, the window of opportunity to enter into negotiation for long-term strategic cooperation with Iran, the most reliable, strong and stable partner in the region, is still open.&quot;<br />\r\n<em>Iran&#39;s Ambassador to the UN in an NPT meeting in Geneva</em></span>	2013-04-24 09:56:11.217118	2013-04-24 09:58:16.328246
18	24	call for nuclear status	<span style="color:rgb(0, 0, 0); font-size:14px">&quot;If the DPRK sits at a table with the U.S., it has to be a dialogue between nuclear weapons states, not one side forcing the other to dismantle nuclear weapons&quot;<br />\r\n<em>Rodong Shinmun</em></span>	2013-04-24 09:56:11.24648	2013-04-24 09:58:16.331528
\.


--
-- Name: extra_informations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('extra_informations_id_seq', 18, true);


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY images (id, article_id, image_name, image_type, created_at, updated_at, location) FROM stdin;
3	11	earthquake.jpg	GIST	2013-04-23 05:30:39.163729	2013-04-23 05:30:39.163729	\N
\.


--
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('images_id_seq', 3, true);


--
-- Data for Name: numbers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY numbers (id, article_id, value, created_at, updated_at, explanation) FROM stdin;
9	11	 6.6	2013-04-23 05:30:38.959235	2013-04-23 05:30:38.959235	magnitude 
10	11	192	2013-04-23 05:30:39.154655	2013-04-23 05:30:39.154655	death toll
11	11	220,000	2013-04-23 05:30:39.156819	2013-04-23 05:30:39.156819	evacuee
13	11	¥ 3.84 B	2013-04-23 05:30:39.160687	2013-04-23 05:34:40.367665	Total loss
12	11	2283	2013-04-23 05:30:39.158827	2013-04-23 05:36:07.533039	aftershocks reported after 2pm yesterday
14	21	1200	2013-04-24 02:10:55.028199	2013-04-24 02:10:55.028199	flights delayed nationwide on Monday
15	21	33	2013-04-24 02:10:55.127627	2013-04-24 02:10:55.127627	Senators sponsored legislation proposed by Moran and Bluementhal
16	21	70%	2013-04-24 02:10:55.132297	2013-04-24 02:10:55.132297	of FAA budget comes from personnel costs
17	22	14th	2013-04-24 07:14:08.754673	2013-04-24 07:14:08.754673	country to legalize same-sex marriage (Ninth in Europe)
18	22	172+	2013-04-24 07:14:08.775636	2013-04-24 07:14:08.775636	hours legislators spent on debating the issue
19	22	200+	2013-04-24 07:14:08.777272	2013-04-24 07:14:08.777272	right-wing protesters arrested in recent weeks
\.


--
-- Name: numbers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('numbers_id_seq', 19, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20130308011658
20130308021503
20130311033547
20130311120124
20130311161656
20130318072815
20130318172538
20130323054131
20130323064916
20130324230610
20130401060143
20130401091207
20130401172731
20130401175505
20130402024049
20130402130113
20130402130252
20130402130425
20130402130723
20130402131350
20130404044407
20130404112122
20130404132101
20130406115500
20130406115928
20130406122229
20130407084047
20130407084415
20130407091222
20130407154029
20130409021145
20130411062738
20130411134632
20130412020443
20130415145928
20130416045906
20130416050008
20130417151317
20130417151338
20130418120540
20130418183732
20130420101736
20130420104304
20130421062902
20130422073504
20130422113848
20130422113923
20130422134321
\.


--
-- Data for Name: taggings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY taggings (id, tag_id, taggable_id, taggable_type, tagger_id, tagger_type, context, created_at) FROM stdin;
15	13	11	Article	\N	\N	tags	2013-04-21 06:24:29.49999
16	14	13	Article	\N	\N	tags	2013-04-21 07:51:50.053582
21	10	19	Article	\N	\N	tags	2013-04-21 14:10:25.321405
22	15	11	Article	\N	\N	tags	2013-04-23 05:30:39.338828
24	17	8	Article	\N	\N	tags	2013-04-23 23:52:51.18402
25	18	8	Article	\N	\N	tags	2013-04-23 23:52:51.326417
26	19	8	Article	\N	\N	tags	2013-04-23 23:55:50.657827
27	20	21	Article	\N	\N	issues	2013-04-24 01:08:01.954562
30	23	22	Article	\N	\N	tags	2013-04-24 07:17:07.997091
31	24	22	Article	\N	\N	issues	2013-04-24 07:17:08.048308
32	25	23	Article	\N	\N	issues	2013-04-24 07:32:15.927754
33	5	24	Article	\N	\N	tags	2013-04-24 09:50:15.715268
34	26	24	Article	\N	\N	tags	2013-04-24 09:50:15.756315
35	27	24	Article	\N	\N	issues	2013-04-24 09:50:15.781171
37	29	26	Article	\N	\N	issues	2013-04-26 11:37:33.027457
\.


--
-- Name: taggings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('taggings_id_seq', 37, true);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tags (id, name) FROM stdin;
1	cyprus bank run
2	lobby
3	facebook
4	zuckerburg
5	north korea
6	google glass
7	google
8	bomb threat
9	eiffel tower
10	test
11	boston
12	bombing
13	earthquake
14	boston marathon
15	sichuan
16	apple earnings in 2q 2013
17	apple
18	iphone
19	tim cook
20	faa furlough
21	same-sex marriage
22	same-sex marriage in france
23	gay marriage
24	gay marriage in france
25	ricin letters
26	iran
27	nuclear ambitions
28	iphone 6 release
29	boston bombing
\.


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 29, true);


--
-- Data for Name: user_archived_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_archived_articles (id, user_id, article_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: user_archived_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_archived_articles_id_seq', 13, true);


--
-- Data for Name: user_followed_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_followed_articles (id, article_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: user_followed_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_followed_articles_id_seq', 1, false);


--
-- Data for Name: user_read_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_read_articles (id, article_id, user_id, created_at, updated_at) FROM stdin;
9	8	6	2013-04-24 00:04:50.106946	2013-04-24 00:04:50.106946
10	21	6	2013-04-24 03:02:37.454186	2013-04-24 03:02:37.454186
11	24	6	2013-04-25 06:04:37.66365	2013-04-25 06:04:37.66365
12	22	6	2013-04-26 09:04:50.591302	2013-04-26 09:04:50.591302
13	23	6	2013-04-26 09:06:51.530439	2013-04-26 09:06:51.530439
\.


--
-- Name: user_read_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_read_articles_id_seq', 13, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, first_name, last_name, email, password_digest, create_account_token, create_account_sent_at, password_reset_token, password_reset_sent_at, created_at, updated_at, latest_login_at) FROM stdin;
3	Han Gyul	Lee	han_lee0707@hotmail.com	$2a$10$D3QWglKXK0MDlTBTtSM6qeGeLL/ONr3sFO/oVU72VQCdU0P1ivl/e	\N	\N	\N	\N	2013-04-21 06:37:42.462985	2013-04-21 06:37:42.462985	\N
5	Jaewoo	Jung	jaewooj12@gmail.com	$2a$10$4PpCAtQVX48RVn/seUA9V.cXDRWS/rkCeA.MzsWTnPaKVWoPBtVN.	\N	\N	\N	\N	2013-04-21 06:56:11.048294	2013-04-21 06:56:11.048294	\N
6	Gilwoo	Lee	gilwoo301@gmail.com	$2a$10$zcmMEtIl0Yi2dpz43rI2Me4y5zQuouXkNjFZ8rrCWd8GoBctYLFUe	\N	\N	\N	\N	2013-04-24 00:03:52.759986	2013-04-26 09:04:03.539019	2013-04-26 09:04:03.533984
2	chae	Ky	kelly.chae@gmail.com	$2a$10$V4JVq5e/AvRVI9CPBh4YwOFEL6FUY6FnG73PryyDjwo/aWkUWPtv.	\N	\N	\N	\N	2013-04-21 06:28:58.582567	2013-04-23 05:41:50.355982	2013-04-23 05:41:50.351726
1	Han	Lee	han.lee0707@gmail.com	$2a$10$HdIePXL6gED6pnpGPSMZCOE1LajTddz2uxc4z5O6NrTInSIiJhcw2	\N	\N	\N	\N	2013-04-21 02:29:44.763097	2013-04-23 06:37:43.612651	2013-04-23 06:37:43.60826
4	test	user	drctrek@gmail.com	$2a$10$TUdKCm8HY8bzXqfK/CwSDuV8FnxYSrpoWpm9kPFrCEUhAFhcBib7.	\N	\N	xFqvYsfsMUV5jGTNQ9POmQ	2013-04-23 00:31:37.619294	2013-04-21 06:50:21.711961	2013-04-27 11:15:51.490941	2013-04-27 11:15:50.538216
7	Woomin	Seo	reality23bites@gmail.com	$2a$10$A.wTd3y7KuW9iJXRUa0mxe9VshQAmEHnligGzSh5NThPJBM2A8Q8K	\N	\N	\N	\N	2013-04-26 06:59:34.800699	2013-04-26 07:00:24.223679	2013-04-26 07:00:24.218302
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 7, true);


--
-- PostgreSQL database dump complete
--

