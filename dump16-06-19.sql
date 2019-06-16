--
-- nextoriaQL database dump
--

-- Dumped from database version 10.8 (Ubuntu 10.8-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: entity_state; Type: TYPE; Schema: public; Owner: nextoria
--

CREATE TYPE public.entity_state AS ENUM (
    'DRAFT',
    'RELEASED',
    'ARCHIVED'
);


ALTER TYPE public.entity_state OWNER TO nextoria;

--
-- Name: location_key_enum; Type: TYPE; Schema: public; Owner: nextoria
--

CREATE TYPE public.location_key_enum AS ENUM (
    'CDN',
    'LOCAL_STORAGE'
);


ALTER TYPE public.location_key_enum OWNER TO nextoria;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: nextoria
--

CREATE TYPE public.user_role AS ENUM (
    'ADMIN',
    'METHODIST',
    'STUDENT'
);


ALTER TYPE public.user_role OWNER TO nextoria;

--
-- Name: user_state; Type: TYPE; Schema: public; Owner: nextoria
--

CREATE TYPE public.user_state AS ENUM (
    'ARCHIVED',
    'ACTIVE',
    'REGISTERING'
);


ALTER TYPE public.user_state OWNER TO nextoria;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: age_group; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.age_group (
    id bigint NOT NULL,
    from_age smallint NOT NULL,
    up_to_age smallint NOT NULL,
    CONSTRAINT age_group_valid_ages CHECK ((up_to_age >= from_age))
);


ALTER TABLE public.age_group OWNER TO nextoria;

--
-- Name: age_group_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.age_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.age_group_id_seq OWNER TO nextoria;

--
-- Name: age_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.age_group_id_seq OWNED BY public.age_group.id;


--
-- Name: authority_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.authority_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authority_seq OWNER TO nextoria;

--
-- Name: course; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.course (
    id bigint NOT NULL,
    description text NOT NULL,
    intro text,
    title character varying(100) NOT NULL,
    state public.entity_state NOT NULL,
    age_group_id bigint,
    update_date timestamp with time zone DEFAULT now(),
    archive_date timestamp with time zone,
    wallpaper_color text,
    icon_url text
);


ALTER TABLE public.course OWNER TO nextoria;

--
-- Name: course_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_id_seq OWNER TO nextoria;

--
-- Name: course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.course_id_seq OWNED BY public.course.id;


--
-- Name: course_methodist; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.course_methodist (
    course_id bigint NOT NULL,
    methodist_id bigint NOT NULL
);


ALTER TABLE public.course_methodist OWNER TO nextoria;

--
-- Name: course_skills; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.course_skills (
    course_id bigint NOT NULL,
    skills_id bigint NOT NULL
);


ALTER TABLE public.course_skills OWNER TO nextoria;

--
-- Name: course_student; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.course_student (
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    current_percent integer
);


ALTER TABLE public.course_student OWNER TO nextoria;

--
-- Name: game; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.game (
    id bigint NOT NULL,
    title character varying(150) NOT NULL,
    game_link text,
    is_tutorial boolean DEFAULT false NOT NULL
);


ALTER TABLE public.game OWNER TO nextoria;

--
-- Name: game_data; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.game_data (
    lesson_id bigint,
    game_id bigint,
    config jsonb NOT NULL,
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    order_in_lesson bigint
);


ALTER TABLE public.game_data OWNER TO nextoria;

--
-- Name: game_data_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.game_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_data_id_seq OWNER TO nextoria;

--
-- Name: game_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.game_data_id_seq OWNED BY public.game_data.id;


--
-- Name: game_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_id_seq OWNER TO nextoria;

--
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;


--
-- Name: game_properties_token; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.game_properties_token (
    id bigint NOT NULL,
    properties jsonb,
    token character varying(50) NOT NULL,
    game_data_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.game_properties_token OWNER TO nextoria;

--
-- Name: game_properties_token_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.game_properties_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_properties_token_id_seq OWNER TO nextoria;

--
-- Name: game_properties_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.game_properties_token_id_seq OWNED BY public.game_properties_token.id;


--
-- Name: image; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.image (
    id bigint NOT NULL,
    initial_file_name character varying(200),
    file_name uuid NOT NULL,
    compressed_file_name uuid,
    mime character varying(100) NOT NULL,
    initial_file_size bigint NOT NULL,
    compressed_file_size bigint,
    location_key public.location_key_enum DEFAULT 'LOCAL_STORAGE'::public.location_key_enum,
    compressed_location_key public.location_key_enum DEFAULT 'LOCAL_STORAGE'::public.location_key_enum,
    path text NOT NULL,
    compressed_path text,
    file_extension character varying(30) NOT NULL
);


ALTER TABLE public.image OWNER TO nextoria;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_id_seq OWNER TO nextoria;

--
-- Name: image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.image_id_seq OWNED BY public.image.id;


--
-- Name: lesson; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.lesson (
    id bigint NOT NULL,
    price integer,
    course_id bigint NOT NULL,
    title character varying(150) NOT NULL,
    "order" integer NOT NULL,
    update_date timestamp with time zone DEFAULT now(),
    content text,
    state public.entity_state DEFAULT 'DRAFT'::public.entity_state NOT NULL,
    archive_date timestamp with time zone,
    video_id bigint,
    CONSTRAINT lesson_price_non_negative CHECK ((price >= 0))
);


ALTER TABLE public.lesson OWNER TO nextoria;

--
-- Name: lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.lesson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesson_id_seq OWNER TO nextoria;

--
-- Name: lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.lesson_id_seq OWNED BY public.lesson.id;


--
-- Name: nextoria_user; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.nextoria_user (
    id bigint NOT NULL,
    email character varying(60),
    name character varying(60),
    age smallint,
    password_hash character varying(1000),
    role public.user_role DEFAULT 'STUDENT'::public.user_role NOT NULL,
    state public.user_state DEFAULT 'REGISTERING'::public.user_state NOT NULL,
    surname character varying(60),
    phone_number character varying(20),
    last_password_reset_date timestamp without time zone,
    enabled boolean DEFAULT false NOT NULL,
    avatar_id bigint,
    nickname character varying(50),
    rating integer DEFAULT 0,
    awards_count integer DEFAULT 0,
    CONSTRAINT awards_count_check CHECK ((awards_count >= 0)),
    CONSTRAINT rating_check CHECK ((rating >= 0))
);


ALTER TABLE public.nextoria_user OWNER TO nextoria;

--
-- Name: nextoria_user_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.nextoria_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nextoria_user_id_seq OWNER TO nextoria;

--
-- Name: nextoria_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.nextoria_user_id_seq OWNED BY public.nextoria_user.id;


--
-- Name: skill; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.skill (
    id bigint NOT NULL,
    title character varying(100),
    color text,
    icon_url text
);


ALTER TABLE public.skill OWNER TO nextoria;

--
-- Name: skill_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.skill_id_seq OWNER TO nextoria;

--
-- Name: skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.skill_id_seq OWNED BY public.skill.id;


--
-- Name: student_skill; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.student_skill (
    user_id bigint,
    skill_id bigint,
    value integer,
    CONSTRAINT value_check CHECK (((value >= 0) AND (value <= 100) AND (value IS NOT NULL)))
);


ALTER TABLE public.student_skill OWNER TO nextoria;

--
-- Name: user_codes; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.user_codes (
    user_id bigint NOT NULL,
    token character varying(10) NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.user_codes OWNER TO nextoria;

--
-- Name: user_token_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.user_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_token_id_seq OWNER TO nextoria;

--
-- Name: user_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.user_token_id_seq OWNED BY public.user_codes.id;


--
-- Name: video; Type: TABLE; Schema: public; Owner: nextoria
--

CREATE TABLE public.video (
    id bigint NOT NULL,
    initial_file_name character varying(200) NOT NULL,
    file_name uuid NOT NULL,
    compressed_file_name uuid,
    mime character varying(100) NOT NULL,
    initial_file_size bigint NOT NULL,
    compressed_file_size bigint,
    location_key public.location_key_enum DEFAULT 'LOCAL_STORAGE'::public.location_key_enum NOT NULL,
    compressed_location_key public.location_key_enum DEFAULT 'LOCAL_STORAGE'::public.location_key_enum,
    path text NOT NULL,
    compressed_path text,
    file_extension character varying(30) NOT NULL
);


ALTER TABLE public.video OWNER TO nextoria;

--
-- Name: video_id_seq; Type: SEQUENCE; Schema: public; Owner: nextoria
--

CREATE SEQUENCE public.video_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_id_seq OWNER TO nextoria;

--
-- Name: video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nextoria
--

ALTER SEQUENCE public.video_id_seq OWNED BY public.video.id;


--
-- Name: age_group id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.age_group ALTER COLUMN id SET DEFAULT nextval('public.age_group_id_seq'::regclass);


--
-- Name: course id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.course ALTER COLUMN id SET DEFAULT nextval('public.course_id_seq'::regclass);


--
-- Name: game id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);


--
-- Name: game_data id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game_data ALTER COLUMN id SET DEFAULT nextval('public.game_data_id_seq'::regclass);


--
-- Name: game_properties_token id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game_properties_token ALTER COLUMN id SET DEFAULT nextval('public.game_properties_token_id_seq'::regclass);


--
-- Name: image id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.image ALTER COLUMN id SET DEFAULT nextval('public.image_id_seq'::regclass);


--
-- Name: lesson id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.lesson ALTER COLUMN id SET DEFAULT nextval('public.lesson_id_seq'::regclass);


--
-- Name: nextoria_user id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.nextoria_user ALTER COLUMN id SET DEFAULT nextval('public.nextoria_user_id_seq'::regclass);


--
-- Name: skill id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.skill ALTER COLUMN id SET DEFAULT nextval('public.skill_id_seq'::regclass);


--
-- Name: user_codes id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.user_codes ALTER COLUMN id SET DEFAULT nextval('public.user_token_id_seq'::regclass);


--
-- Name: video id; Type: DEFAULT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.video ALTER COLUMN id SET DEFAULT nextval('public.video_id_seq'::regclass);


--
-- Data for Name: age_group; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.age_group (id, from_age, up_to_age) FROM stdin;
63	0	0
14	2	12
64	1	2
65	1	5
66	1	10
10	8	10
11	9	11
12	9	11
13	9	11
67	0	9
69	-1	9
70	8	8
\.


--
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.course (id, description, intro, title, state, age_group_id, update_date, archive_date, wallpaper_color, icon_url) FROM stdin;
95	Курс “Ментальная арифметика” должен помочь ребенку освоить счеты “абакус” и развить когнитивные способности, такие как память, внимание, многозадачность. 	<p><strong style="background-color: transparent; color: rgb(0, 0, 0);">1 этап. Теория</strong></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Дается с помощью видео и мини конспектов.</span></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">После просмотра видео и читки конспекта пользователь нажимает “Я все понял” и переходит на следующий этап. </span></p><p><br></p><p><strong style="background-color: transparent; color: rgb(0, 0, 0);">2 этап. Практика</strong></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Выполняются рад примеров с помощью запрограммированного заранее Туториала. См. ниже таблицу. После выполнения всех примеров пользователь автоматически переходит на следующий этап. Пользователь может вернуться в этап “Теория”, если он вдруг что-то не понял и обратно вернуться в “Практика” и начать с примера, с которого он остановился. </span></p><p><br></p><p><strong style="background-color: transparent; color: rgb(0, 0, 0);">3 этап. Домашнее задание (ДЗ)</strong></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Выполняется ряд примеров с помощью запрограммированных заранее игр (флеш-карта, столбцы или счет на скорость). В случае правильного выполнения более 50% примеров, пользователь может перейти на следующий урок. В случае выполнения менее 50% примеров, он получает новую порцию ДЗ и дальше тренируется. </span></p>	Ментальная арифметика	RELEASED	11	2019-05-18 18:26:22.811606+03	\N	#CAA7A5	https://168829.selcdn.ru/hey.go/icons/course-icon-01.svg
96	Курс "Программирование"		Программирование	RELEASED	11	2019-06-03 16:17:09.722+03	\N	#E28B85	https://168829.selcdn.ru/hey.go/icons/course-icon-02.svg
104	ДЖОЖД УИУ выходит на охоту	<p><strong>Дитя белорусии</strong></p>	Джон Уик 3 / John Wick: Chapter 3 - Parabellum	RELEASED	63	2019-06-14 11:20:22.54931+03	\N	\N	\N
\.


--
-- Data for Name: course_methodist; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.course_methodist (course_id, methodist_id) FROM stdin;
\.


--
-- Data for Name: course_skills; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.course_skills (course_id, skills_id) FROM stdin;
95	65
96	65
95	67
\.


--
-- Data for Name: course_student; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.course_student (user_id, course_id, current_percent) FROM stdin;
125	95	25
125	96	30
129	95	\N
129	96	\N
131	95	\N
131	96	\N
131	104	\N
131	95	\N
131	96	\N
131	104	\N
131	95	\N
131	96	\N
131	104	\N
131	95	\N
131	96	\N
131	104	\N
131	95	\N
131	96	\N
131	104	\N
131	95	\N
131	96	\N
131	104	\N
131	95	\N
131	96	\N
131	104	\N
133	95	\N
133	96	\N
133	104	\N
134	95	\N
134	96	\N
134	104	\N
136	95	\N
136	96	\N
136	104	\N
137	95	\N
137	96	\N
137	104	\N
137	95	\N
137	96	\N
137	104	\N
138	95	\N
138	96	\N
138	104	\N
\.


--
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.game (id, title, game_link, is_tutorial) FROM stdin;
5	Флеш-карты	http://92.53.66.38/games/flash-cards	f
6	Столбцы	http://92.53.66.38/games/columns	f
8	Счет на скорость	http://92.53.66.38/games/meanar	f
4	Туториал	https://microspace.bitbucket.io/test	t
9	Программирование 0	http://92.53.66.38/games/coding0	f
10	Программирование 1	http://92.53.66.38/games/coding1	f
11	Программирование 2	http://92.53.66.38/games/coding2	f
12	Программирование 3	http://92.53.66.38/games/coding3	f
13	Программирование 4	http://92.53.66.38/games/coding4	f
14	Программирование 5	http://92.53.66.38/games/coding5	f
\.


--
-- Data for Name: game_data; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.game_data (lesson_id, game_id, config, id, course_id, order_in_lesson) FROM stdin;
21	4	{"game": [{"mode": "simple", "digits": 1, "addends": 3, "exercises": 7}, {"mode": "simple", "digits": 1, "addends": 4, "exercises": 5}, {"mode": "simple", "digits": 2, "addends": 3, "exercises": 7}, {"mode": "simple", "digits": 2, "addends": 4, "exercises": 5}], "lesson": 3, "gamemode": "tutorial"}	8	95	0
22	4	{"game": [{"mode": "simpleviz", "digits": 1, "addends": 3, "exercises": 7}, {"mode": "simpleviz", "digits": 1, "addends": 4, "exercises": 5}, {"mode": "simpleviz", "digits": 2, "addends": 3, "exercises": 7}, {"mode": "simpleviz", "digits": 2, "addends": 4, "exercises": 5}], "lesson": 4, "gamemode": "tutorial"}	9	95	0
20	4	{"game": [{"mode": "random", "digits": 1, "exercises": 10}, {"mode": "random", "digits": 2, "exercises": 10}, {"mode": "random", "digits": 3, "exercises": 10}], "lesson": 2, "gamemode": "tutorial"}	4	95	0
23	4	{"game": [{"mode": "brother+1", "digits": 2, "addends": 3, "exercises": 7}, {"mode": "brother+2", "digits": 2, "addends": 4, "exercises": 5}, {"mode": "brother+3", "digits": 2, "addends": 4, "exercises": 5}, {"mode": "brother+4", "digits": 2, "addends": 4, "exercises": 5}, {"mode": "brother+1234", "digits": 2, "addends": 5, "exercises": 5}, {"mode": "brother+1234", "digits": 2, "addends": 7, "exercises": 10}], "lesson": 5, "gamemode": "tutorial"}	10	95	0
20	5	{"terms": 1, "digits": 1, "interval": 5, "exampleCount": 10}	16	95	1
20	5	{"terms": 1, "digits": 1, "interval": 3, "exampleCount": 10}	17	95	2
20	5	{"terms": 1, "digits": 2, "interval": 5, "exampleCount": 10}	18	95	3
21	5	{"terms": 1, "digits": 1, "interval": 2, "exampleCount": 10}	19	95	1
21	5	{"terms": 1, "digits": 2, "interval": 4, "exampleCount": 10}	20	95	2
21	6	{"digits": 1, "module": 1, "simple": false, "operations": 0, "termsCount": 4, "exerciseCount": 10}	21	95	3
21	8	{"digits": 1, "limits": {"5": true, "6": true, "7": true, "8": true, "9": true}, "module": 1, "simple": true, "interval": 4, "operations": 0, "termsCount": 4, "exerciseCount": 10}	22	95	4
21	6	{"digits": 1, "module": 1, "simple": false, "operations": 1, "termsCount": 4, "exerciseCount": 10}	23	95	5
21	8	{"digits": 1, "limits": {"5": true, "6": true, "7": true, "8": true, "9": true}, "module": 1, "simple": true, "interval": 4, "operations": 1, "termsCount": 4, "exerciseCount": 10}	24	95	6
21	6	{"digits": 1, "module": 1, "simple": false, "operations": 2, "termsCount": 6, "exerciseCount": 10}	25	95	7
21	8	{"digits": 1, "limits": {"5": true, "6": true, "7": true, "8": true, "9": true}, "module": 1, "simple": true, "interval": 4, "operations": 2, "termsCount": 6, "exerciseCount": 10}	26	95	8
21	6	{"digits": 2, "module": 1, "simple": true, "operations": 2, "termsCount": 5, "exerciseCount": 10}	27	95	9
21	8	{"digits": 2, "limits": {"5": true, "6": true, "7": true, "8": true, "9": true}, "module": 1, "simple": true, "interval": 5, "operations": 2, "termsCount": 5, "exerciseCount": 10}	28	95	10
23	6	{"hello": 25}	31	95	77
27	9	{}	32	96	0
27	10	{}	33	96	1
27	11	{}	34	96	2
27	12	{}	35	96	3
27	13	{}	36	96	4
27	14	{}	37	96	5
\.


--
-- Data for Name: game_properties_token; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.game_properties_token (id, properties, token, game_data_id, user_id) FROM stdin;
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.image (id, initial_file_name, file_name, compressed_file_name, mime, initial_file_size, compressed_file_size, location_key, compressed_location_key, path, compressed_path, file_extension) FROM stdin;
51	f534d419-2983-44f2-b122-0bdcfafc254a	f534d419-2983-44f2-b122-0bdcfafc254a	c574c10e-77a6-4b13-8949-e8bb888498a4	image/jpeg	49154	15334	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/f534d419-2983-44f2-b122-0bdcfafc254a.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/c574c10e-77a6-4b13-8949-e8bb888498a4.jpeg	jpeg
53	05f18c20-6432-4aa0-a002-b4a369dcda9f	05f18c20-6432-4aa0-a002-b4a369dcda9f	72ce80aa-f9c6-4525-9dea-83b295404224	image/jpeg	58812	15782	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/05f18c20-6432-4aa0-a002-b4a369dcda9f.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/72ce80aa-f9c6-4525-9dea-83b295404224.jpeg	jpeg
52	f1843791-0e2d-49ac-9abf-64e47d2406f0	f1843791-0e2d-49ac-9abf-64e47d2406f0	0465ff71-af76-480b-b23c-16576151ff10	image/jpeg	60893	9797	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/f1843791-0e2d-49ac-9abf-64e47d2406f0.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/0465ff71-af76-480b-b23c-16576151ff10.jpeg	jpeg
54	6f2cc9b3-07b8-441e-8d96-73e25c5850bf	6f2cc9b3-07b8-441e-8d96-73e25c5850bf	219ce712-7cfd-4de9-926c-16e8b25181a3	image/jpeg	49989	13084	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/6f2cc9b3-07b8-441e-8d96-73e25c5850bf.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/219ce712-7cfd-4de9-926c-16e8b25181a3.jpeg	jpeg
43	eefba391-c399-4bee-ac7c-2e78b0d53f0d	eefba391-c399-4bee-ac7c-2e78b0d53f0d	fab2e5b8-8118-4eb1-b4a4-6d0741e1e937	image/jpeg	343575	210866	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/eefba391-c399-4bee-ac7c-2e78b0d53f0d.jpg	https://api.selcdn.ru/v1/SEL_85436/nextoria/fab2e5b8-8118-4eb1-b4a4-6d0741e1e937.jpg	jpg
46	ffed72df-d56e-450d-ba7a-c34e0ddc799a	ffed72df-d56e-450d-ba7a-c34e0ddc799a	ac0e0d11-9117-4ed9-8cf7-ee4b6a92a62a	image/jpeg	39929	13161	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/ffed72df-d56e-450d-ba7a-c34e0ddc799a.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/ac0e0d11-9117-4ed9-8cf7-ee4b6a92a62a.jpeg	jpeg
44	a5b25af4-48da-4b5c-ac06-54c0d64e422e	a5b25af4-48da-4b5c-ac06-54c0d64e422e	9019fb29-4c06-4bbf-9cc0-d67fb7ded167	image/jpeg	6125	5823	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/a5b25af4-48da-4b5c-ac06-54c0d64e422e.jpg	https://api.selcdn.ru/v1/SEL_85436/nextoria/9019fb29-4c06-4bbf-9cc0-d67fb7ded167.jpg	jpg
45	cc980629-79f4-442d-a2fc-2fff928f823c	cc980629-79f4-442d-a2fc-2fff928f823c	7a360d68-e5c0-410f-91b4-0373eef105be	image/jpeg	39929	13161	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/cc980629-79f4-442d-a2fc-2fff928f823c.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/7a360d68-e5c0-410f-91b4-0373eef105be.jpeg	jpeg
47	af58eadb-cbf8-458e-aeea-2da2e992b872	af58eadb-cbf8-458e-aeea-2da2e992b872	5c572c94-bfbb-4fca-92e3-7a2bfcfea86f	image/jpeg	39929	13161	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/af58eadb-cbf8-458e-aeea-2da2e992b872.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/5c572c94-bfbb-4fca-92e3-7a2bfcfea86f.jpeg	jpeg
48	2d8866b7-d6fd-4613-b06c-8abccadb262b	2d8866b7-d6fd-4613-b06c-8abccadb262b	8bc5e568-e92f-42e4-a425-bd2161e69a16	image/jpeg	39929	13161	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/2d8866b7-d6fd-4613-b06c-8abccadb262b.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/8bc5e568-e92f-42e4-a425-bd2161e69a16.jpeg	jpeg
49	31341efc-3c9e-4eb9-8870-783673d97ca7	31341efc-3c9e-4eb9-8870-783673d97ca7	21fdfd02-3ea9-4580-8b5c-9ec462170aff	image/jpeg	39929	13161	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/31341efc-3c9e-4eb9-8870-783673d97ca7.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/21fdfd02-3ea9-4580-8b5c-9ec462170aff.jpeg	jpeg
50	1beaf3ca-a439-41c0-94b1-44ab20fd13d4	1beaf3ca-a439-41c0-94b1-44ab20fd13d4	4891311b-e63e-42e7-9d84-cdd7a6b15269	image/jpeg	39929	13161	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/1beaf3ca-a439-41c0-94b1-44ab20fd13d4.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/4891311b-e63e-42e7-9d84-cdd7a6b15269.jpeg	jpeg
\.


--
-- Data for Name: lesson; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.lesson (id, price, course_id, title, "order", update_date, content, state, archive_date, video_id) FROM stdin;
20	100	95	Счеты абакус. Набор чисел на абакусе.	2	2019-05-19 17:05:13.785882+03	<p><span style="color: rgb(0, 0, 0);">На прошлом уроке мы с Вами узнали, что такое ментальная арифметика и зачем она нужна. Сегодня на уроке мы познакомимся со строением счетов абакус и попробуем набрать первые числа на абакусе.</span></p><p><br></p><p><span style="color: rgb(0, 0, 0);">Конструкция счетов абакус очень просто. Он состоит из рамы. Рама разделена расчетной разделительной линейки. Также на раме есть стержни, а на стержнях бусинки. Нижние бусинки, т.е. ниже разделительной линейки – друзьями. Одна поднятая бусинка к разделительной линейке означает число 1. Максимально на первом стержне можно набрать число 4. Верхние бусинки, т.е. выше разделительной линейки мы называем братьями. Одна спущенная бусинка к разделительной линейке&nbsp;&nbsp;&nbsp;На первой стержне мы можем набрать единицы, на второй десятки, а на третьей - сотни. </span></p><p>&nbsp;</p><p><span style="color: rgb(0, 0, 0);">КАРТИНКА АБАКУСА </span></p><p><br></p><p><span style="color: rgb(0, 0, 0);">Нужно запомнить “2 золотых правила” ментальной арифметики</span></p><p><span style="color: rgb(0, 0, 0);">1 правило:</span></p><p><span style="color: rgb(0, 0, 0);">- друзей мы набираем большим пальцем, а убираем указательным. </span></p><p><span style="color: rgb(0, 0, 0);">- братьев набираем и убираем только указательным пальцем. </span></p><p><span style="color: rgb(0, 0, 0);">2 правило:</span></p><p><span style="color: rgb(0, 0, 0);">- набираем цифры мы всегда слева направо</span></p><p>&nbsp;</p><p><span style="color: rgb(0, 0, 0);">Более подробно набор разных чисел на абакусе смотрите в видео к уроку.</span></p><p><br></p><p><br></p>	DRAFT	\N	47
22	100	95	Визуализация	4	2019-05-19 17:06:40.255332+03		DRAFT	\N	\N
21	100	95	Просто сложение и вычитание	3	2019-05-19 17:06:24.460877+03		DRAFT	\N	\N
26	100	95	Помощь брата вычитание	6	2019-05-25 17:03:39.195786+03		DRAFT	\N	\N
19	100	95	Вводный.Знакомство с МА	1	2019-05-18 18:31:25.349548+03	<p><strong style="background-color: transparent; color: rgb(0, 0, 0);">Что такое ментальная арифметика? </strong></p><p><br></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Все знают, что такое арифметика. Арифметика - наука о числах и их вычислениях. А что же такое ментальная арифметика? Ментальная арифметика это тоже вычисления, но с помощью устного счета. Но чтобы быстро научиться считать в уме, мы сначала будем считать на древних счетах “абакус”, а потом уже перейдем на устный счет.&nbsp;</span></p><p><br></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Древние счеты “абакус” появились 2500 лет назад в Вавилоне. Их использовали астрономы, торговцы и математики. Потом абакусы заменили калькуляторы и компьютеры, но в Китае “абакус” продолжали использовать, как инструмент развития интеллекта. </span></p><p><br></p><p><strong style="background-color: transparent; color: rgb(0, 0, 0);">Вы спросите, а зачем мне ментальная арифметика? </strong></p><p><br></p><p><br></p><p><br></p><p><strong style="background-color: transparent; color: rgb(0, 0, 0);">﻿</strong></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Если Вы будете постоянно заниматься ментальной арифметикой, то уже через 2-3 месяца Вы заметите улучшение в памяти, станете более внимательным и сможете удивить окружающих быстром счетом. </span></p><p><br></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Более подробно, как ментальная арифметика и абакус влияют на мозг смотрите в видео к этому уроку.</span></p>	DRAFT	\N	46
23	100	95	Сложение методом "Помощь брата"	5	2019-05-19 17:07:31.778665+03		DRAFT	\N	48
27	100	96	Тестовый урок. Программирование	1	2019-05-19 17:07:31.778665+03	\N	DRAFT	\N	\N
\.


--
-- Data for Name: nextoria_user; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.nextoria_user (id, email, name, age, password_hash, role, state, surname, phone_number, last_password_reset_date, enabled, avatar_id, nickname, rating, awards_count) FROM stdin;
127	admin@heygo.com	Админ	\N	$2a$10$xc3C5qbH2dD0mpxX3OqTz.hMvpfHX3UKasxSHWntBNsZbt0YpTdRi	ADMIN	ACTIVE	Админов	+79000000002	\N	t	\N	\N	0	0
137	hhh@mam.sik	Ахмед	\N	$2a$10$mx5Urwkdy5dylpvbPs3tHOy2jFqk8ohWD3K.b0GZmpwZKHawbXZhK	STUDENT	ACTIVE	Барамжян	79167307217	\N	t	54	Махмуд	0	0
126	methodist@heygo.com	Методист	\N	$2a$10$AJYnwSFNbrFOIR5Y1l/2Buv2LNfwRrOIQaTCe2LiZfcrl4KiP5mU.	METHODIST	ACTIVE	Методистов	+79000000001	\N	t	\N	\N	0	0
138	petya@gmail.com	Василий	\N	$2a$10$uKu0z8DJK66YR1VLrAwf0.7CpviieAnXc7Lh5Aow3rGz350Wua7MK	STUDENT	ACTIVE	Пупкин	79509074000	\N	t	\N	\N	0	0
130	\N	\N	\N	\N	STUDENT	REGISTERING	\N	79372824942	\N	f	\N	\N	0	0
129	test	test	\N	$2a$10$Fi/vQsny9t.bJQ0Mr0vypu7xMEOL9UPlDhoztEnbH2nwGA47USYTG	STUDENT	ACTIVE	test	79372824941	\N	t	\N	\N	0	0
131	kotromeo6@gmail.com	Максим	\N	$2a$10$E1pIZWvOW/ne6U8gScqAu.pHHqO8fyBB4PbSDa4rpEY2K.SuUxOiK	STUDENT	ACTIVE	Казанцев	79509074001	\N	t	50	nick	0	0
133	newtest@test.com	Newtest	\N	$2a$10$bobR5lyBg9qYTDO20P5JQ.175YszuEeWdfEuOv3RfcGl6Idt9Ioo2	STUDENT	ACTIVE	Newtest	239	\N	t	48	\N	0	0
134	qwe@qwe.qwe	q	\N	$2a$10$yF3oswGSN8jbXM4RrFDjWee9oxIVi0ozkcGz2q.djsGD8DJ3Wloty	STUDENT	ACTIVE	w	79509074002	\N	t	51	q	0	0
135	\N	\N	\N	$2a$10$wwDz81aR4hu8DELE57NxqOWcAKKhmY6lL2KUWaafm3/Lx8wrqnfNi	STUDENT	REGISTERING	\N	79509074005	\N	t	\N	\N	0	0
136	art@magedigital.ru	Вася	\N	$2a$10$t94M7bPVDBMhsd0MFg1RkOvZO4.yeli44tbRS.Z48uguICp6zrcx.	STUDENT	ACTIVE	Петров	79165338718	\N	t	52	Ara	0	0
125	student@heygo.com	Ученик	\N	$2a$10$DivJIk/16Y5a9SAx8s2CUORg.0gAY0tw6Tt3Ly76/Kua8cmJHLX0a	STUDENT	ACTIVE	Учеников	79509074004	\N	t	47	kotromeo	95	135
\.


--
-- Data for Name: skill; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.skill (id, title, color, icon_url) FROM stdin;
64	Память	#F26F6F	https://168829.selcdn.ru/hey.go/icons/course-icon-01.svg
68	Логика	#DECE3B	https://168829.selcdn.ru/hey.go/icons/course-icon-01.svg
67	Системное мышление	#82DE3B	https://168829.selcdn.ru/hey.go/icons/course-icon-01.svg
66	Скорость реакции	#76E2D0	https://168829.selcdn.ru/hey.go/icons/course-icon-01.svg
65	Внимание	#7E6BDF	https://168829.selcdn.ru/hey.go/icons/course-icon-01.svg
\.


--
-- Data for Name: student_skill; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.student_skill (user_id, skill_id, value) FROM stdin;
133	64	0
133	68	0
133	67	0
133	66	0
133	65	0
134	64	0
134	68	0
134	67	0
134	66	0
134	65	0
125	68	25
125	66	20
125	65	15
125	64	26
125	67	10
136	64	0
136	68	0
136	67	0
129	64	0
129	68	0
129	67	0
129	66	0
129	65	0
136	66	0
136	65	0
137	67	0
137	64	0
137	68	0
137	66	0
131	64	0
137	65	0
138	64	0
138	68	0
138	67	0
138	66	0
138	65	0
131	68	0
131	65	0
131	67	0
131	66	0
\.


--
-- Data for Name: user_codes; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.user_codes (user_id, token, id) FROM stdin;
130	CILFO0	245
135	WPUTF4	256
125	QV7YKS	258
\.


--
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: nextoria
--

COPY public.video (id, initial_file_name, file_name, compressed_file_name, mime, initial_file_size, compressed_file_size, location_key, compressed_location_key, path, compressed_path, file_extension) FROM stdin;
42	Ментальная арифметика онлайн обучение. Введение (1)	74613184-1c88-489d-b0b6-8ebe608a4895	74613184-1c88-489d-b0b6-8ebe608a4895	video/mp4	75008578	75008578	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/74613184-1c88-489d-b0b6-8ebe608a4895.mp4	storage/74613184-1c88-489d-b0b6-8ebe608a4895.mp4	mp4
43	phew	a8b20d83-f33c-4c15-a6c8-50c8bff4d8e5	a8b20d83-f33c-4c15-a6c8-50c8bff4d8e5	video/mp4	137713	137713	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/a8b20d83-f33c-4c15-a6c8-50c8bff4d8e5.mp4	storage/a8b20d83-f33c-4c15-a6c8-50c8bff4d8e5.mp4	mp4
44	phew	e76bfb53-1f69-4c12-9c0f-245c060a0bc9	e76bfb53-1f69-4c12-9c0f-245c060a0bc9	video/mp4	137713	137713	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/e76bfb53-1f69-4c12-9c0f-245c060a0bc9.mp4	storage/e76bfb53-1f69-4c12-9c0f-245c060a0bc9.mp4	mp4
45	phew	2fcfc464-5a9a-470d-9776-702358d95ea4	2fcfc464-5a9a-470d-9776-702358d95ea4	video/mp4	137713	137713	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/2fcfc464-5a9a-470d-9776-702358d95ea4.mp4	storage/2fcfc464-5a9a-470d-9776-702358d95ea4.mp4	mp4
46	phew	b439d0bf-3034-417b-be41-86db3a70f04d	b439d0bf-3034-417b-be41-86db3a70f04d	video/mp4	137713	137713	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/b439d0bf-3034-417b-be41-86db3a70f04d.mp4	storage/b439d0bf-3034-417b-be41-86db3a70f04d.mp4	mp4
47	phew	95dc39be-6246-4c89-a7bd-3cfc1a50d1bb	95dc39be-6246-4c89-a7bd-3cfc1a50d1bb	video/mp4	137713	137713	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/95dc39be-6246-4c89-a7bd-3cfc1a50d1bb.mp4	storage/95dc39be-6246-4c89-a7bd-3cfc1a50d1bb.mp4	mp4
48	2 2  Сложение с помощью брата	112858fb-f75e-42c4-aa07-229972997900	112858fb-f75e-42c4-aa07-229972997900	video/mp4	139165695	139165695	LOCAL_STORAGE	LOCAL_STORAGE	storage/112858fb-f75e-42c4-aa07-229972997900.mp4	storage/112858fb-f75e-42c4-aa07-229972997900.mp4	mp4
\.


--
-- Name: age_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.age_group_id_seq', 70, true);


--
-- Name: authority_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.authority_seq', 1, false);


--
-- Name: course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.course_id_seq', 104, true);


--
-- Name: game_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.game_data_id_seq', 41, true);


--
-- Name: game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.game_id_seq', 14, true);


--
-- Name: game_properties_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.game_properties_token_id_seq', 34, true);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.image_id_seq', 54, true);


--
-- Name: lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.lesson_id_seq', 36, true);


--
-- Name: nextoria_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.nextoria_user_id_seq', 138, true);


--
-- Name: skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.skill_id_seq', 69, true);


--
-- Name: user_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.user_token_id_seq', 261, true);


--
-- Name: video_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nextoria
--

SELECT pg_catalog.setval('public.video_id_seq', 48, true);


--
-- Name: age_group age_group_pkey; Type: CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.age_group
    ADD CONSTRAINT age_group_pkey PRIMARY KEY (id);


--
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (id);


--
-- Name: game_data game_data_pk; Type: CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game_data
    ADD CONSTRAINT game_data_pk PRIMARY KEY (id);


--
-- Name: game game_pk; Type: CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pk PRIMARY KEY (id);


--
-- Name: game_properties_token game_properties_token_pk; Type: CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game_properties_token
    ADD CONSTRAINT game_properties_token_pk PRIMARY KEY (id);


--
-- Name: image image_pk; Type: CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pk PRIMARY KEY (id);


--
-- Name: lesson lesson_pkey; Type: CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_pkey PRIMARY KEY (id);


--
-- Name: nextoria_user nextoria_user_pkey; Type: CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.nextoria_user
    ADD CONSTRAINT nextoria_user_pkey PRIMARY KEY (id);


--
-- Name: skill skill_pkey; Type: CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.skill
    ADD CONSTRAINT skill_pkey PRIMARY KEY (id);


--
-- Name: video video_pk; Type: CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pk PRIMARY KEY (id);


--
-- Name: fki_game_data_course_id_fk; Type: INDEX; Schema: public; Owner: nextoria
--

CREATE INDEX fki_game_data_course_id_fk ON public.game_data USING btree (course_id);


--
-- Name: game_data_id_uindex; Type: INDEX; Schema: public; Owner: nextoria
--

CREATE UNIQUE INDEX game_data_id_uindex ON public.game_data USING btree (id);


--
-- Name: game_id_uindex; Type: INDEX; Schema: public; Owner: nextoria
--

CREATE UNIQUE INDEX game_id_uindex ON public.game USING btree (id);


--
-- Name: game_properties_token_id_uindex; Type: INDEX; Schema: public; Owner: nextoria
--

CREATE UNIQUE INDEX game_properties_token_id_uindex ON public.game_properties_token USING btree (id);


--
-- Name: image_id_uindex; Type: INDEX; Schema: public; Owner: nextoria
--

CREATE UNIQUE INDEX image_id_uindex ON public.image USING btree (id);


--
-- Name: nextoria_user_phone_number_uindex; Type: INDEX; Schema: public; Owner: nextoria
--

CREATE UNIQUE INDEX nextoria_user_phone_number_uindex ON public.nextoria_user USING btree (phone_number);


--
-- Name: user_codes_user_id_uindex; Type: INDEX; Schema: public; Owner: nextoria
--

CREATE UNIQUE INDEX user_codes_user_id_uindex ON public.user_codes USING btree (user_id);


--
-- Name: video_id_uindex; Type: INDEX; Schema: public; Owner: nextoria
--

CREATE UNIQUE INDEX video_id_uindex ON public.video USING btree (id);


--
-- Name: course course_age_group_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_age_group_id_fk FOREIGN KEY (age_group_id) REFERENCES public.age_group(id);


--
-- Name: course_methodist course_methodist_course_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.course_methodist
    ADD CONSTRAINT course_methodist_course_fk FOREIGN KEY (course_id) REFERENCES public.course(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: course_methodist course_methodist_methodist_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.course_methodist
    ADD CONSTRAINT course_methodist_methodist_fk FOREIGN KEY (methodist_id) REFERENCES public.nextoria_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: course_skills course_skills_course_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.course_skills
    ADD CONSTRAINT course_skills_course_fk FOREIGN KEY (course_id) REFERENCES public.course(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: course_skills course_skills_skill_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.course_skills
    ADD CONSTRAINT course_skills_skill_fk FOREIGN KEY (skills_id) REFERENCES public.skill(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_data game_data_course_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game_data
    ADD CONSTRAINT game_data_course_fk FOREIGN KEY (course_id) REFERENCES public.course(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_data game_data_game_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game_data
    ADD CONSTRAINT game_data_game_fk FOREIGN KEY (game_id) REFERENCES public.game(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_data game_data_lesson_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game_data
    ADD CONSTRAINT game_data_lesson_fk FOREIGN KEY (lesson_id) REFERENCES public.lesson(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_properties_token game_properties_token_game_data_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game_properties_token
    ADD CONSTRAINT game_properties_token_game_data_fk FOREIGN KEY (game_data_id) REFERENCES public.game_data(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_properties_token game_properties_token_nextoria_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.game_properties_token
    ADD CONSTRAINT game_properties_token_nextoria_user_fk FOREIGN KEY (user_id) REFERENCES public.nextoria_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lesson lesson_course_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_course_fk FOREIGN KEY (course_id) REFERENCES public.course(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lesson lesson_video_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_video_fk FOREIGN KEY (video_id) REFERENCES public.video(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: nextoria_user nextoria_user_image_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.nextoria_user
    ADD CONSTRAINT nextoria_user_image_id_fk FOREIGN KEY (avatar_id) REFERENCES public.image(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: student_skill student_skill_skill_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.student_skill
    ADD CONSTRAINT student_skill_skill_fk FOREIGN KEY (skill_id) REFERENCES public.skill(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: student_skill student_skill_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.student_skill
    ADD CONSTRAINT student_skill_user_fk FOREIGN KEY (user_id) REFERENCES public.nextoria_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_codes user_codes_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.user_codes
    ADD CONSTRAINT user_codes_user_fk FOREIGN KEY (user_id) REFERENCES public.nextoria_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: course_student user_student_course_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.course_student
    ADD CONSTRAINT user_student_course_fk FOREIGN KEY (course_id) REFERENCES public.course(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: course_student user_student_student_fk; Type: FK CONSTRAINT; Schema: public; Owner: nextoria
--

ALTER TABLE ONLY public.course_student
    ADD CONSTRAINT user_student_student_fk FOREIGN KEY (user_id) REFERENCES public.nextoria_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TABLE age_group; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.age_group TO nextoria;


--
-- Name: SEQUENCE age_group_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.age_group_id_seq TO nextoria;


--
-- Name: SEQUENCE authority_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.authority_seq TO nextoria;


--
-- Name: TABLE course; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.course TO nextoria;


--
-- Name: SEQUENCE course_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.course_id_seq TO nextoria;


--
-- Name: TABLE course_skills; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.course_skills TO nextoria;


--
-- Name: TABLE course_student; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.course_student TO nextoria;


--
-- Name: TABLE game; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.game TO nextoria;


--
-- Name: TABLE game_data; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.game_data TO nextoria;


--
-- Name: SEQUENCE game_data_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.game_data_id_seq TO nextoria;


--
-- Name: SEQUENCE game_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.game_id_seq TO nextoria;


--
-- Name: TABLE game_properties_token; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.game_properties_token TO nextoria;


--
-- Name: SEQUENCE game_properties_token_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.game_properties_token_id_seq TO nextoria;


--
-- Name: TABLE image; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.image TO nextoria;


--
-- Name: SEQUENCE image_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.image_id_seq TO nextoria;


--
-- Name: TABLE lesson; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.lesson TO nextoria;


--
-- Name: SEQUENCE lesson_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.lesson_id_seq TO nextoria;


--
-- Name: TABLE nextoria_user; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.nextoria_user TO nextoria;


--
-- Name: SEQUENCE nextoria_user_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.nextoria_user_id_seq TO nextoria;


--
-- Name: TABLE skill; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.skill TO nextoria;


--
-- Name: SEQUENCE skill_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.skill_id_seq TO nextoria;


--
-- Name: TABLE user_codes; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.user_codes TO nextoria;


--
-- Name: SEQUENCE user_token_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.user_token_id_seq TO nextoria;


--
-- Name: TABLE video; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON TABLE public.video TO nextoria;


--
-- Name: SEQUENCE video_id_seq; Type: ACL; Schema: public; Owner: nextoria
--

GRANT ALL ON SEQUENCE public.video_id_seq TO nextoria;


--
-- nextoriaQL database dump complete
--

