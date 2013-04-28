--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: additional_texts; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE additional_texts (
    id integer NOT NULL,
    article_id integer,
    bullet text,
    location integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.additional_texts OWNER TO gist;

--
-- Name: additional_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE additional_texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.additional_texts_id_seq OWNER TO gist;

--
-- Name: additional_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE additional_texts_id_seq OWNED BY additional_texts.id;


--
-- Name: articles; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE articles (
    id integer NOT NULL,
    title character varying(255),
    city character varying(255),
    country character varying(255),
    previous_summary text,
    current_content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status character varying(255),
    contributor_id integer,
    editor_id integer,
    temporary_title character varying(255),
    instruction text,
    category character varying(255),
    published_at timestamp without time zone
);


ALTER TABLE public.articles OWNER TO gist;

--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_id_seq OWNER TO gist;

--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE articles_id_seq OWNED BY articles.id;


--
-- Name: citations; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE citations (
    id integer NOT NULL,
    article_id integer,
    author character varying(255),
    title character varying(255),
    published_date date,
    publisher character varying(255),
    link character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    accessed_date date
);


ALTER TABLE public.citations OWNER TO gist;

--
-- Name: citations_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE citations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.citations_id_seq OWNER TO gist;

--
-- Name: citations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE citations_id_seq OWNED BY citations.id;


--
-- Name: ckeditor_assets; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE ckeditor_assets (
    id integer NOT NULL,
    data_file_name character varying(255) NOT NULL,
    data_content_type character varying(255),
    data_file_size integer,
    assetable_id integer,
    assetable_type character varying(30),
    type character varying(30),
    width integer,
    height integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ckeditor_assets OWNER TO gist;

--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE ckeditor_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ckeditor_assets_id_seq OWNER TO gist;

--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE ckeditor_assets_id_seq OWNED BY ckeditor_assets.id;


--
-- Name: employee_position_types; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE employee_position_types (
    id integer NOT NULL,
    position_type character varying(255),
    number_of_levels integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.employee_position_types OWNER TO gist;

--
-- Name: employee_position_types_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE employee_position_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_position_types_id_seq OWNER TO gist;

--
-- Name: employee_position_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE employee_position_types_id_seq OWNED BY employee_position_types.id;


--
-- Name: employee_positions; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE employee_positions (
    id integer NOT NULL,
    employee_id integer,
    "position" character varying(255),
    level integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.employee_positions OWNER TO gist;

--
-- Name: employee_positions_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE employee_positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_positions_id_seq OWNER TO gist;

--
-- Name: employee_positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE employee_positions_id_seq OWNED BY employee_positions.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE employees (
    id integer NOT NULL,
    first_name character varying(255),
    email character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    password_digest character varying(255),
    last_name character varying(255),
    create_account_token character varying(255),
    create_account_sent_at timestamp without time zone,
    account_create_time timestamp without time zone,
    latest_login_at timestamp without time zone,
    password_reset_token character varying(255),
    password_reset_sent_at timestamp without time zone
);


ALTER TABLE public.employees OWNER TO gist;

--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employees_id_seq OWNER TO gist;

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE employees_id_seq OWNED BY employees.id;


--
-- Name: extra_informations; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE extra_informations (
    id integer NOT NULL,
    article_id integer,
    phrase character varying(255),
    explanation text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.extra_informations OWNER TO gist;

--
-- Name: extra_informations_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE extra_informations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extra_informations_id_seq OWNER TO gist;

--
-- Name: extra_informations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE extra_informations_id_seq OWNED BY extra_informations.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE images (
    id integer NOT NULL,
    article_id integer,
    image_name character varying(255),
    image_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    location integer
);


ALTER TABLE public.images OWNER TO gist;

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO gist;

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: numbers; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE numbers (
    id integer NOT NULL,
    article_id integer,
    value character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    explanation text
);


ALTER TABLE public.numbers OWNER TO gist;

--
-- Name: numbers_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE numbers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.numbers_id_seq OWNER TO gist;

--
-- Name: numbers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE numbers_id_seq OWNED BY numbers.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO gist;

--
-- Name: taggings; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    tagger_id integer,
    tagger_type character varying(255),
    context character varying(128),
    created_at timestamp without time zone
);


ALTER TABLE public.taggings OWNER TO gist;

--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggings_id_seq OWNER TO gist;

--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.tags OWNER TO gist;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO gist;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: user_archived_articles; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE user_archived_articles (
    id integer NOT NULL,
    user_id integer,
    article_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_archived_articles OWNER TO gist;

--
-- Name: user_archived_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE user_archived_articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_archived_articles_id_seq OWNER TO gist;

--
-- Name: user_archived_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE user_archived_articles_id_seq OWNED BY user_archived_articles.id;


--
-- Name: user_followed_articles; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE user_followed_articles (
    id integer NOT NULL,
    article_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_followed_articles OWNER TO gist;

--
-- Name: user_followed_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE user_followed_articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_followed_articles_id_seq OWNER TO gist;

--
-- Name: user_followed_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE user_followed_articles_id_seq OWNED BY user_followed_articles.id;


--
-- Name: user_read_articles; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE user_read_articles (
    id integer NOT NULL,
    article_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_read_articles OWNER TO gist;

--
-- Name: user_read_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE user_read_articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_read_articles_id_seq OWNER TO gist;

--
-- Name: user_read_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE user_read_articles_id_seq OWNED BY user_read_articles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: gist; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    password_digest character varying(255),
    create_account_token character varying(255),
    create_account_sent_at timestamp without time zone,
    password_reset_token character varying(255),
    password_reset_sent_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    latest_login_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO gist;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: gist
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO gist;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gist
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY additional_texts ALTER COLUMN id SET DEFAULT nextval('additional_texts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY articles ALTER COLUMN id SET DEFAULT nextval('articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY citations ALTER COLUMN id SET DEFAULT nextval('citations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY ckeditor_assets ALTER COLUMN id SET DEFAULT nextval('ckeditor_assets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY employee_position_types ALTER COLUMN id SET DEFAULT nextval('employee_position_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY employee_positions ALTER COLUMN id SET DEFAULT nextval('employee_positions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY employees ALTER COLUMN id SET DEFAULT nextval('employees_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY extra_informations ALTER COLUMN id SET DEFAULT nextval('extra_informations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY numbers ALTER COLUMN id SET DEFAULT nextval('numbers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY user_archived_articles ALTER COLUMN id SET DEFAULT nextval('user_archived_articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY user_followed_articles ALTER COLUMN id SET DEFAULT nextval('user_followed_articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY user_read_articles ALTER COLUMN id SET DEFAULT nextval('user_read_articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gist
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: additional_texts; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY additional_texts (id, article_id, bullet, location, created_at, updated_at) FROM stdin;
\.


--
-- Name: additional_texts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('additional_texts_id_seq', 20, true);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY articles (id, title, city, country, previous_summary, current_content, created_at, updated_at, status, contributor_id, editor_id, temporary_title, instruction, category, published_at) FROM stdin;
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('articles_id_seq', 43, true);


--
-- Data for Name: citations; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY citations (id, article_id, author, title, published_date, publisher, link, created_at, updated_at, accessed_date) FROM stdin;
\.


--
-- Name: citations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('citations_id_seq', 5, true);


--
-- Data for Name: ckeditor_assets; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY ckeditor_assets (id, data_file_name, data_content_type, data_file_size, assetable_id, assetable_type, type, width, height, created_at, updated_at) FROM stdin;
\.


--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('ckeditor_assets_id_seq', 1, false);


--
-- Data for Name: employee_position_types; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY employee_position_types (id, position_type, number_of_levels, created_at, updated_at) FROM stdin;
5	Administrator	1	2013-04-16 04:34:20.313717	2013-04-16 04:34:20.313717
6	Editor	1	2013-04-16 04:34:27.548214	2013-04-16 04:34:27.548214
7	Contributor	1	2013-04-16 04:34:34.287905	2013-04-16 04:34:34.287905
8	Intern	1	2013-04-16 04:34:42.550618	2013-04-16 04:34:42.550618
\.


--
-- Name: employee_position_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('employee_position_types_id_seq', 8, true);


--
-- Data for Name: employee_positions; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY employee_positions (id, employee_id, "position", level, created_at, updated_at) FROM stdin;
47	6	Administrator	1	2013-04-26 16:09:34.616059	2013-04-26 16:09:34.616059
48	6	Editor	1	2013-04-26 16:09:34.620116	2013-04-26 16:09:34.620116
49	6	Contributor	1	2013-04-26 16:09:34.622918	2013-04-26 16:09:34.622918
\.


--
-- Name: employee_positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('employee_positions_id_seq', 49, true);


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY employees (id, first_name, email, created_at, updated_at, password_digest, last_name, create_account_token, create_account_sent_at, account_create_time, latest_login_at, password_reset_token, password_reset_sent_at) FROM stdin;
6	Han	han.lee0707@gmail.com	2013-04-26 09:58:00.46982	2013-04-26 10:12:11.496884	$2a$10$2AGV2rmUWJv/z5sZL2LFx.SpQRcYOe6pUSRzc05R18FKyhkFA63eW	Lee	01R2NaXtiSOgaytZgO-1xQ	2013-04-26 09:58:00.586941	2013-04-26 10:03:11	\N	m6oS5aDBazYTiTzyIw1DrQ	2013-04-26 10:10:30.463056
\.


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('employees_id_seq', 8, true);


--
-- Data for Name: extra_informations; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY extra_informations (id, article_id, phrase, explanation, created_at, updated_at) FROM stdin;
\.


--
-- Name: extra_informations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('extra_informations_id_seq', 9, true);


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY images (id, article_id, image_name, image_type, created_at, updated_at, location) FROM stdin;
\.


--
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('images_id_seq', 18, true);


--
-- Data for Name: numbers; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY numbers (id, article_id, value, created_at, updated_at, explanation) FROM stdin;
\.


--
-- Name: numbers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('numbers_id_seq', 12, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: gist
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
-- Data for Name: taggings; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY taggings (id, tag_id, taggable_id, taggable_type, tagger_id, tagger_type, context, created_at) FROM stdin;
\.


--
-- Name: taggings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('taggings_id_seq', 52, true);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY tags (id, name) FROM stdin;
1	boston
2	bombing
3	asd
4	sdf
5	tag
6	solar
7	tags
8	sandoval
9	test
10	boston bombing
11	fanta
12	general
13	issue tag
14	terrorism
15	pizza
16	add
17	asdda
18	help
\.


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('tags_id_seq', 18, true);


--
-- Data for Name: user_archived_articles; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY user_archived_articles (id, user_id, article_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: user_archived_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('user_archived_articles_id_seq', 28, true);


--
-- Data for Name: user_followed_articles; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY user_followed_articles (id, article_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: user_followed_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('user_followed_articles_id_seq', 1, false);


--
-- Data for Name: user_read_articles; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY user_read_articles (id, article_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: user_read_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('user_read_articles_id_seq', 10, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: gist
--

COPY users (id, first_name, last_name, email, password_digest, create_account_token, create_account_sent_at, password_reset_token, password_reset_sent_at, created_at, updated_at, latest_login_at) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gist
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Name: additional_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY additional_texts
    ADD CONSTRAINT additional_texts_pkey PRIMARY KEY (id);


--
-- Name: archived_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY user_archived_articles
    ADD CONSTRAINT archived_articles_pkey PRIMARY KEY (id);


--
-- Name: articles_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: citations_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY citations
    ADD CONSTRAINT citations_pkey PRIMARY KEY (id);


--
-- Name: ckeditor_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY ckeditor_assets
    ADD CONSTRAINT ckeditor_assets_pkey PRIMARY KEY (id);


--
-- Name: employee_position_types_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY employee_position_types
    ADD CONSTRAINT employee_position_types_pkey PRIMARY KEY (id);


--
-- Name: employee_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY employee_positions
    ADD CONSTRAINT employee_positions_pkey PRIMARY KEY (id);


--
-- Name: employees_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: extra_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY extra_informations
    ADD CONSTRAINT extra_informations_pkey PRIMARY KEY (id);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY numbers
    ADD CONSTRAINT numbers_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: user_followed_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY user_followed_articles
    ADD CONSTRAINT user_followed_articles_pkey PRIMARY KEY (id);


--
-- Name: user_read_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY user_read_articles
    ADD CONSTRAINT user_read_articles_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: gist; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_ckeditor_assetable; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX idx_ckeditor_assetable ON ckeditor_assets USING btree (assetable_type, assetable_id);


--
-- Name: idx_ckeditor_assetable_type; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX idx_ckeditor_assetable_type ON ckeditor_assets USING btree (assetable_type, type, assetable_id);


--
-- Name: index_articles_on_contributor_id; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_articles_on_contributor_id ON articles USING btree (contributor_id);


--
-- Name: index_articles_on_editor_id; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_articles_on_editor_id ON articles USING btree (editor_id);


--
-- Name: index_employee_positions_on_employee_id; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_employee_positions_on_employee_id ON employee_positions USING btree (employee_id);


--
-- Name: index_employee_positions_on_position; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_employee_positions_on_position ON employee_positions USING btree ("position");


--
-- Name: index_employees_on_last_name; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_employees_on_last_name ON employees USING btree (last_name);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_user_archived_articles_on_article_id; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_user_archived_articles_on_article_id ON user_archived_articles USING btree (article_id);


--
-- Name: index_user_archived_articles_on_user_id; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_user_archived_articles_on_user_id ON user_archived_articles USING btree (user_id);


--
-- Name: index_user_followed_articles_on_article_id; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_user_followed_articles_on_article_id ON user_followed_articles USING btree (article_id);


--
-- Name: index_user_followed_articles_on_user_id; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_user_followed_articles_on_user_id ON user_followed_articles USING btree (user_id);


--
-- Name: index_user_read_articles_on_article_id; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_user_read_articles_on_article_id ON user_read_articles USING btree (article_id);


--
-- Name: index_user_read_articles_on_user_id; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_user_read_articles_on_user_id ON user_read_articles USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: gist; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

