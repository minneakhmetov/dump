--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7 (Debian 10.7-1.pgdg90+1)
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
-- Name: entity_state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.entity_state AS ENUM (
    'DRAFT',
    'RELEASED',
    'ARCHIVED'
);


ALTER TYPE public.entity_state OWNER TO postgres;

--
-- Name: location_key_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.location_key_enum AS ENUM (
    'CDN',
    'LOCAL_STORAGE'
);


ALTER TYPE public.location_key_enum OWNER TO postgres;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'ADMIN',
    'METHODIST',
    'STUDENT'
);


ALTER TYPE public.user_role OWNER TO postgres;

--
-- Name: user_state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_state AS ENUM (
    'ARCHIVED',
    'ACTIVE',
    'REGISTERING'
);


ALTER TYPE public.user_state OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: age_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.age_group (
    id bigint NOT NULL,
    from_age smallint NOT NULL,
    up_to_age smallint NOT NULL,
    CONSTRAINT age_group_valid_ages CHECK ((up_to_age >= from_age))
);


ALTER TABLE public.age_group OWNER TO postgres;

--
-- Name: age_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.age_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.age_group_id_seq OWNER TO postgres;

--
-- Name: age_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.age_group_id_seq OWNED BY public.age_group.id;


--
-- Name: authority_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authority_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authority_seq OWNER TO postgres;

--
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    id bigint NOT NULL,
    description text NOT NULL,
    intro text,
    title character varying(100) NOT NULL,
    state public.entity_state NOT NULL,
    age_group_id bigint,
    update_date timestamp with time zone DEFAULT now(),
    user_id bigint NOT NULL,
    archive_date timestamp with time zone
);


ALTER TABLE public.course OWNER TO postgres;

--
-- Name: course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_id_seq OWNER TO postgres;

--
-- Name: course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_id_seq OWNED BY public.course.id;


--
-- Name: course_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_skills (
    cource_id bigint NOT NULL,
    skills_id bigint NOT NULL
);


ALTER TABLE public.course_skills OWNER TO postgres;

--
-- Name: game; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game (
    id bigint NOT NULL,
    title character varying(150) NOT NULL,
    game_link text,
    is_tutorial boolean DEFAULT false NOT NULL
);


ALTER TABLE public.game OWNER TO postgres;

--
-- Name: game_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_data (
    lesson_id bigint,
    game_id bigint,
    config jsonb NOT NULL,
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    order_in_lesson bigint
);


ALTER TABLE public.game_data OWNER TO postgres;

--
-- Name: game_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_data_id_seq OWNER TO postgres;

--
-- Name: game_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_data_id_seq OWNED BY public.game_data.id;


--
-- Name: game_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_id_seq OWNER TO postgres;

--
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;


--
-- Name: game_properties_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_properties_token (
    id bigint NOT NULL,
    properties jsonb,
    token character varying(50) NOT NULL,
    game_data_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.game_properties_token OWNER TO postgres;

--
-- Name: game_properties_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_properties_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_properties_token_id_seq OWNER TO postgres;

--
-- Name: game_properties_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_properties_token_id_seq OWNED BY public.game_properties_token.id;


--
-- Name: image; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.image OWNER TO postgres;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_id_seq OWNER TO postgres;

--
-- Name: image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.image_id_seq OWNED BY public.image.id;


--
-- Name: lesson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson (
    id bigint NOT NULL,
    price integer,
    cource_id bigint NOT NULL,
    title character varying(150) NOT NULL,
    "order" integer NOT NULL,
    update_date timestamp with time zone DEFAULT now(),
    content text,
    state public.entity_state DEFAULT 'DRAFT'::public.entity_state NOT NULL,
    archive_date timestamp with time zone,
    videoid bigint,
    CONSTRAINT lesson_price_nonnegative CHECK ((price >= 0))
);


ALTER TABLE public.lesson OWNER TO postgres;

--
-- Name: lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesson_id_seq OWNER TO postgres;

--
-- Name: lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_id_seq OWNED BY public.lesson.id;


--
-- Name: lesson_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson_skills (
    lesson_id bigint NOT NULL,
    skills_id bigint NOT NULL
);


ALTER TABLE public.lesson_skills OWNER TO postgres;

--
-- Name: nextoria_user; Type: TABLE; Schema: public; Owner: postgres
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
    nickname character varying(50)
);


ALTER TABLE public.nextoria_user OWNER TO postgres;

--
-- Name: nextoria_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nextoria_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nextoria_user_id_seq OWNER TO postgres;

--
-- Name: nextoria_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nextoria_user_id_seq OWNED BY public.nextoria_user.id;


--
-- Name: skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skill (
    id bigint NOT NULL,
    metrics integer,
    title character varying(100)
);


ALTER TABLE public.skill OWNER TO postgres;

--
-- Name: skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.skill_id_seq OWNER TO postgres;

--
-- Name: skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skill_id_seq OWNED BY public.skill.id;


--
-- Name: user_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_course (
    user_id bigint NOT NULL,
    course_id bigint NOT NULL
);


ALTER TABLE public.user_course OWNER TO postgres;

--
-- Name: user_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_token (
    user_id bigint NOT NULL,
    token character varying(10) NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.user_token OWNER TO postgres;

--
-- Name: user_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_token_id_seq OWNER TO postgres;

--
-- Name: user_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_token_id_seq OWNED BY public.user_token.id;


--
-- Name: video; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.video OWNER TO postgres;

--
-- Name: video_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.video_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_id_seq OWNER TO postgres;

--
-- Name: video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.video_id_seq OWNED BY public.video.id;


--
-- Name: age_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.age_group ALTER COLUMN id SET DEFAULT nextval('public.age_group_id_seq'::regclass);


--
-- Name: course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course ALTER COLUMN id SET DEFAULT nextval('public.course_id_seq'::regclass);


--
-- Name: game id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);


--
-- Name: game_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_data ALTER COLUMN id SET DEFAULT nextval('public.game_data_id_seq'::regclass);


--
-- Name: game_properties_token id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_properties_token ALTER COLUMN id SET DEFAULT nextval('public.game_properties_token_id_seq'::regclass);


--
-- Name: image id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image ALTER COLUMN id SET DEFAULT nextval('public.image_id_seq'::regclass);


--
-- Name: lesson id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson ALTER COLUMN id SET DEFAULT nextval('public.lesson_id_seq'::regclass);


--
-- Name: nextoria_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nextoria_user ALTER COLUMN id SET DEFAULT nextval('public.nextoria_user_id_seq'::regclass);


--
-- Name: skill id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill ALTER COLUMN id SET DEFAULT nextval('public.skill_id_seq'::regclass);


--
-- Name: user_token id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_token ALTER COLUMN id SET DEFAULT nextval('public.user_token_id_seq'::regclass);


--
-- Name: video id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video ALTER COLUMN id SET DEFAULT nextval('public.video_id_seq'::regclass);


--
-- Data for Name: age_group; Type: TABLE DATA; Schema: public; Owner: postgres
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
\.


--
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (id, description, intro, title, state, age_group_id, update_date, user_id, archive_date) FROM stdin;
95	Курс “Ментальная арифметика” должен помочь ребенку освоить счеты “абакус” и развить когнитивные способности, такие как память, внимание, многозадачность. 	<p><strong style="background-color: transparent; color: rgb(0, 0, 0);">1 этап. Теория</strong></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Дается с помощью видео и мини конспектов.</span></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">После просмотра видео и читки конспекта пользователь нажимает “Я все понял” и переходит на следующий этап. </span></p><p><br></p><p><strong style="background-color: transparent; color: rgb(0, 0, 0);">2 этап. Практика</strong></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Выполняются рад примеров с помощью запрограммированного заранее Туториала. См. ниже таблицу. После выполнения всех примеров пользователь автоматически переходит на следующий этап. Пользователь может вернуться в этап “Теория”, если он вдруг что-то не понял и обратно вернуться в “Практика” и начать с примера, с которого он остановился. </span></p><p><br></p><p><strong style="background-color: transparent; color: rgb(0, 0, 0);">3 этап. Домашнее задание (ДЗ)</strong></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Выполняется ряд примеров с помощью запрограммированных заранее игр (флеш-карта, столбцы или счет на скорость). В случае правильного выполнения более 50% примеров, пользователь может перейти на следующий урок. В случае выполнения менее 50% примеров, он получает новую порцию ДЗ и дальше тренируется. </span></p>	Ментальная арифметика	RELEASED	11	2019-05-18 15:26:22.811606+00	10	\N
96	Курс "Программирование"		Программирование	RELEASED	11	2019-06-03 13:17:09.722+00	10	\N
\.


--
-- Data for Name: course_skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_skills (cource_id, skills_id) FROM stdin;
95	54
95	55
\.


--
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- Data for Name: game_data; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- Data for Name: game_properties_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_properties_token (id, properties, token, game_data_id, user_id) FROM stdin;
5	{"currentGame": 0, "currentExercise": 0}	tutorial2	8	109
6	{"currentGame": 0, "currentExercise": 0}	tutorial3	9	109
7	{"currentGame": 0, "currentExercise": 0}	tutorial4	10	109
4	{"currentExercise": 4}	tutorial1	4	109
27	{}	bg0	32	109
28	{}	bg1	33	109
29	{}	bg2	34	109
30	{}	bg3	35	109
31	{}	bg4	36	109
32	{}	bg5	37	109
15	{}	t2	17	109
14	{}	t1	16	109
16	{}	t3	18	109
17	{}	t4	19	109
18	{}	t5	20	109
19	{}	t6	21	109
20	{}	t7	22	109
21	{}	t8	23	109
22	{}	t9	24	109
23	{}	t10	25	109
24	{}	t11	26	109
25	{}	t12	27	109
26	{}	t14	28	109
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.image (id, initial_file_name, file_name, compressed_file_name, mime, initial_file_size, compressed_file_size, location_key, compressed_location_key, path, compressed_path, file_extension) FROM stdin;
23	96628be2-4299-47cd-a5fb-94e48daeef49	96628be2-4299-47cd-a5fb-94e48daeef49	1d9f3fdd-5183-412c-bf16-7f0bb6e74d60	image/jpeg	64422	7804	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/96628be2-4299-47cd-a5fb-94e48daeef49.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/1d9f3fdd-5183-412c-bf16-7f0bb6e74d60.jpeg	jpeg
2	MaqFEF	a07584d7-42b9-417f-be8d-4ed8f7952f6d	d1f69dc7-029b-4147-a65a-7483d8ac137e	image/jpeg	318581	168060	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/a07584d7-42b9-417f-be8d-4ed8f7952f6d.jpg	https://api.selcdn.ru/v1/SEL_85436/nextoria/d1f69dc7-029b-4147-a65a-7483d8ac137e.jpg	jpg
12	35e63371-4671-4b1a-bf7a-f1209a3007c9	35e63371-4671-4b1a-bf7a-f1209a3007c9	686029ab-dad4-4536-b93f-cfd79d4bcc9a	image/png	3926	3099	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/35e63371-4671-4b1a-bf7a-f1209a3007c9.png	https://api.selcdn.ru/v1/SEL_85436/nextoria/686029ab-dad4-4536-b93f-cfd79d4bcc9a.png	png
3	MaqFEF	ace43869-6e31-421c-8309-34c74d411b88	f0734f0b-24db-4c5e-9089-1cad5b49cb0c	image/jpeg	318581	168060	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/ace43869-6e31-421c-8309-34c74d411b88.jpg	https://api.selcdn.ru/v1/SEL_85436/nextoria/f0734f0b-24db-4c5e-9089-1cad5b49cb0c.jpg	jpg
4	spider	41d4e294-1e13-49a7-b096-74050c43067d	a34bf89f-9f41-4e5b-aaed-d98a8980c235	image/png	11587	13668	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/41d4e294-1e13-49a7-b096-74050c43067d.png	https://api.selcdn.ru/v1/SEL_85436/nextoria/a34bf89f-9f41-4e5b-aaed-d98a8980c235.png	png
17	792159c5-c2c0-410a-b5c4-4a2f45e693c0	792159c5-c2c0-410a-b5c4-4a2f45e693c0	a9d6189d-01c4-48bd-9a3d-8e2209bb641f	image/jpeg	6486	2066	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/792159c5-c2c0-410a-b5c4-4a2f45e693c0.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/a9d6189d-01c4-48bd-9a3d-8e2209bb641f.jpeg	jpeg
5	MaqFEF	3c183e83-4c1e-4c19-aad7-68f1c4f43213	d60266d2-67d5-4b84-b306-e16c4a4cb5eb	image/jpeg	318581	168060	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/3c183e83-4c1e-4c19-aad7-68f1c4f43213.jpg	https://api.selcdn.ru/v1/SEL_85436/nextoria/d60266d2-67d5-4b84-b306-e16c4a4cb5eb.jpg	jpg
13	8ca3b062-36ae-4c81-ba41-7d0b2322d11b	8ca3b062-36ae-4c81-ba41-7d0b2322d11b	533b92a9-c23e-4f5b-9169-1cc2e2a931cd	image/png	3926	3099	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/8ca3b062-36ae-4c81-ba41-7d0b2322d11b.png	https://api.selcdn.ru/v1/SEL_85436/nextoria/533b92a9-c23e-4f5b-9169-1cc2e2a931cd.png	png
6	MaqFEF	4b4391d8-13e4-400e-8299-77a597e53843	551898ab-3384-4c86-b579-ce3112c44c27	image/jpeg	318581	168060	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/4b4391d8-13e4-400e-8299-77a597e53843.jpg	https://api.selcdn.ru/v1/SEL_85436/nextoria/551898ab-3384-4c86-b579-ce3112c44c27.jpg	jpg
7	MaqFEF	adfcd90f-875a-49a8-9a68-bb3e904c35de	69e90175-c98b-4be3-9f52-54797476a866	image/jpeg	318581	168060	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/adfcd90f-875a-49a8-9a68-bb3e904c35de.jpg	https://api.selcdn.ru/v1/SEL_85436/nextoria/69e90175-c98b-4be3-9f52-54797476a866.jpg	jpg
8	MaqFEF	a9975408-e436-4ad4-be8c-d24917777cd3	3c8d58ac-09dd-4068-86d6-0ddfce8e2b79	image/jpeg	318581	168060	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/a9975408-e436-4ad4-be8c-d24917777cd3.jpg	https://api.selcdn.ru/v1/SEL_85436/nextoria/3c8d58ac-09dd-4068-86d6-0ddfce8e2b79.jpg	jpg
14	c4b1810c-5c7e-44dd-8dda-dcfd0067a74e	c4b1810c-5c7e-44dd-8dda-dcfd0067a74e	cfa12417-967f-41a8-b847-2a7a9096076a	image/jpeg	111269	49438	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/c4b1810c-5c7e-44dd-8dda-dcfd0067a74e.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/cfa12417-967f-41a8-b847-2a7a9096076a.jpeg	jpeg
9	spider	5a6a4a9e-8055-431c-9f39-e5dadf0936eb	b7d4df9a-ead4-4ce5-81f1-402b0405dad4	image/png	11587	13668	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/5a6a4a9e-8055-431c-9f39-e5dadf0936eb.png	https://api.selcdn.ru/v1/SEL_85436/nextoria/b7d4df9a-ead4-4ce5-81f1-402b0405dad4.png	png
10	1	21a04b59-f379-4f98-9e74-a21f52099330	008aef81-020c-4ee3-9f95-848df799a687	image/jpeg	111269	49438	\N	\N	storage/21a04b59-f379-4f98-9e74-a21f52099330.jpg	storage/008aef81-020c-4ee3-9f95-848df799a687.jpg	jpg
11	55efad14-29e8-4c30-a671-8658d73e296f	55efad14-29e8-4c30-a671-8658d73e296f	b7751161-f1d1-416f-881a-b15d8d24aec7	image/png	3926	3099	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/55efad14-29e8-4c30-a671-8658d73e296f.png	https://api.selcdn.ru/v1/SEL_85436/nextoria/b7751161-f1d1-416f-881a-b15d8d24aec7.png	png
20	8b2f3f0e-4d5b-4126-a6a1-94ce3c7d2484	8b2f3f0e-4d5b-4126-a6a1-94ce3c7d2484	aea71eda-2981-49ed-9457-16af966a8e53	image/jpeg	58423	8222	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/8b2f3f0e-4d5b-4126-a6a1-94ce3c7d2484.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/aea71eda-2981-49ed-9457-16af966a8e53.jpeg	jpeg
15	7b6ee38d-df3f-4235-95d4-807c93809374	7b6ee38d-df3f-4235-95d4-807c93809374	34c7faa2-bfb2-44e1-bd1d-efabd52573f3	image/jpeg	6486	2066	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/7b6ee38d-df3f-4235-95d4-807c93809374.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/34c7faa2-bfb2-44e1-bd1d-efabd52573f3.jpeg	jpeg
18	5bf5f6dd-2c31-47c6-97fd-42135c3d07c2	5bf5f6dd-2c31-47c6-97fd-42135c3d07c2	28a72c4c-6723-4f63-9e4d-fd55a6295aaa	image/jpeg	48705	8257	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/5bf5f6dd-2c31-47c6-97fd-42135c3d07c2.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/28a72c4c-6723-4f63-9e4d-fd55a6295aaa.jpeg	jpeg
16	b8fe6506-61aa-4367-be6e-44d843b2b43d	b8fe6506-61aa-4367-be6e-44d843b2b43d	0c4cd2b7-ad6a-4581-872a-1592d305730d	image/jpeg	6486	2066	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/b8fe6506-61aa-4367-be6e-44d843b2b43d.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/0c4cd2b7-ad6a-4581-872a-1592d305730d.jpeg	jpeg
19	afe3c9b0-7720-4bbe-aecf-f0bc3d81cb8d	afe3c9b0-7720-4bbe-aecf-f0bc3d81cb8d	49c477b8-e2d6-4863-9777-f519d495411f	image/jpeg	57486	7650	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/afe3c9b0-7720-4bbe-aecf-f0bc3d81cb8d.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/49c477b8-e2d6-4863-9777-f519d495411f.jpeg	jpeg
22	c83267f6-9094-4123-b64b-4b8b33de1aba	c83267f6-9094-4123-b64b-4b8b33de1aba	f654f82e-7979-405a-967c-d5d09549cd02	image/jpeg	7946	2054	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/c83267f6-9094-4123-b64b-4b8b33de1aba.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/f654f82e-7979-405a-967c-d5d09549cd02.jpeg	jpeg
21	a5ce56f3-7b3d-4059-9a80-59e4fd6af581	a5ce56f3-7b3d-4059-9a80-59e4fd6af581	e2ad800c-8964-4d34-9d75-76f7808ba15d	image/jpeg	38934	6518	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/a5ce56f3-7b3d-4059-9a80-59e4fd6af581.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/e2ad800c-8964-4d34-9d75-76f7808ba15d.jpeg	jpeg
24	693a9193-4563-4ee5-a23b-c64a67f3a0f1	693a9193-4563-4ee5-a23b-c64a67f3a0f1	79d2d1ec-a7fa-4b5e-941a-b8541272eee5	image/jpeg	8009	2017	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/693a9193-4563-4ee5-a23b-c64a67f3a0f1.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/79d2d1ec-a7fa-4b5e-941a-b8541272eee5.jpeg	jpeg
25	a050c8f5-66f4-41a3-b2cc-4f86f8a6ebcf	a050c8f5-66f4-41a3-b2cc-4f86f8a6ebcf	d549d26d-4f3a-4839-8c02-fd970fb338ab	image/jpeg	65774	8109	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/a050c8f5-66f4-41a3-b2cc-4f86f8a6ebcf.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/d549d26d-4f3a-4839-8c02-fd970fb338ab.jpeg	jpeg
26	c4a977a4-b3b2-491a-b19b-6ae55f520c3e	c4a977a4-b3b2-491a-b19b-6ae55f520c3e	23eafcad-7581-4a94-966a-6514134fe0e8	image/jpeg	47757	15809	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/c4a977a4-b3b2-491a-b19b-6ae55f520c3e.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/23eafcad-7581-4a94-966a-6514134fe0e8.jpeg	jpeg
27	bb08ce94-972b-4acf-b7a9-68a3ca86eea3	bb08ce94-972b-4acf-b7a9-68a3ca86eea3	06bdf1ed-e333-4eca-83c0-4f32ccfab905	image/jpeg	61841	15271	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/bb08ce94-972b-4acf-b7a9-68a3ca86eea3.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/06bdf1ed-e333-4eca-83c0-4f32ccfab905.jpeg	jpeg
28	d46240d2-a729-4542-bace-1b84bee26fb7	d46240d2-a729-4542-bace-1b84bee26fb7	fb7c62d0-ce59-499f-8d7f-1dc356dd69f5	image/jpeg	50024	13066	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/d46240d2-a729-4542-bace-1b84bee26fb7.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/fb7c62d0-ce59-499f-8d7f-1dc356dd69f5.jpeg	jpeg
29	37d5a8ee-4e0f-4973-ad5d-450ab64f0c48	37d5a8ee-4e0f-4973-ad5d-450ab64f0c48	cead7b03-8929-4741-8a47-2eeb5652483d	image/jpeg	50648	6063	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/37d5a8ee-4e0f-4973-ad5d-450ab64f0c48.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/cead7b03-8929-4741-8a47-2eeb5652483d.jpeg	jpeg
36	f27b9b3e-0151-4056-8e7c-e61d56592a7e	f27b9b3e-0151-4056-8e7c-e61d56592a7e	6fad0f9f-28b6-4b7f-949b-c8ca1edc4487	image/jpeg	54846	6870	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/f27b9b3e-0151-4056-8e7c-e61d56592a7e.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/6fad0f9f-28b6-4b7f-949b-c8ca1edc4487.jpeg	jpeg
30	bbf68675-d2e9-4dc9-a403-d68b7eb5bc16	bbf68675-d2e9-4dc9-a403-d68b7eb5bc16	843eb038-7ebc-4d0c-8222-c1d7a860c7c1	image/jpeg	61102	9324	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/bbf68675-d2e9-4dc9-a403-d68b7eb5bc16.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/843eb038-7ebc-4d0c-8222-c1d7a860c7c1.jpeg	jpeg
31	637d9049-b7db-431a-9499-c94df200a94d	637d9049-b7db-431a-9499-c94df200a94d	b7d9595a-c926-4440-845d-936e1de3563a	image/jpeg	60024	16067	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/637d9049-b7db-431a-9499-c94df200a94d.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/b7d9595a-c926-4440-845d-936e1de3563a.jpeg	jpeg
41	a5772f28-cf0a-4eee-a100-1c2d6244ea72	a5772f28-cf0a-4eee-a100-1c2d6244ea72	c343a9a7-0d26-4ba8-a6a2-4de7284a29ad	image/jpeg	57278	14433	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/a5772f28-cf0a-4eee-a100-1c2d6244ea72.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/c343a9a7-0d26-4ba8-a6a2-4de7284a29ad.jpeg	jpeg
32	aba76b12-9ba6-498b-9f79-3a137e060b1e	aba76b12-9ba6-498b-9f79-3a137e060b1e	b899bf74-8fae-4425-8a69-aa76783aafd4	image/jpeg	64556	7024	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/aba76b12-9ba6-498b-9f79-3a137e060b1e.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/b899bf74-8fae-4425-8a69-aa76783aafd4.jpeg	jpeg
37	acb84c02-e0cc-46cf-8f44-fdcf9d01131b	acb84c02-e0cc-46cf-8f44-fdcf9d01131b	97e240b4-ce2a-4053-a2e2-8638b9131f09	image/jpeg	60024	16067	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/acb84c02-e0cc-46cf-8f44-fdcf9d01131b.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/97e240b4-ce2a-4053-a2e2-8638b9131f09.jpeg	jpeg
33	7f4cbe13-7de2-491e-8d3d-dc6f0b729a46	7f4cbe13-7de2-491e-8d3d-dc6f0b729a46	dd071260-9637-48d9-921d-ae5f9b54940b	image/jpeg	60005	16071	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/7f4cbe13-7de2-491e-8d3d-dc6f0b729a46.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/dd071260-9637-48d9-921d-ae5f9b54940b.jpeg	jpeg
34	2a06df4f-aa61-457e-a9a7-4877e5510d02	2a06df4f-aa61-457e-a9a7-4877e5510d02	154f3c47-cc92-44e6-a679-7a270e6bbf34	image/jpeg	61561	15306	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/2a06df4f-aa61-457e-a9a7-4877e5510d02.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/154f3c47-cc92-44e6-a679-7a270e6bbf34.jpeg	jpeg
42	0cfb2ddb-cc93-4243-97ce-b5a489c91456	0cfb2ddb-cc93-4243-97ce-b5a489c91456	a6d54686-9cf0-4f22-b1dd-a551ffd4659f	image/jpeg	65133	5622	\N	\N	storage/0cfb2ddb-cc93-4243-97ce-b5a489c91456.jpeg	storage/a6d54686-9cf0-4f22-b1dd-a551ffd4659f.jpeg	jpeg
35	6c8a0673-038c-4f3b-8ef0-15bde331052d	6c8a0673-038c-4f3b-8ef0-15bde331052d	8a485010-9bcc-4cfd-bc5a-43c0f8f60422	image/jpeg	60024	16067	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/6c8a0673-038c-4f3b-8ef0-15bde331052d.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/8a485010-9bcc-4cfd-bc5a-43c0f8f60422.jpeg	jpeg
38	62d67dfa-6bd0-443b-a544-2a92dfde9563	62d67dfa-6bd0-443b-a544-2a92dfde9563	0efb267b-3477-491c-87cb-1ee3a0b4b585	image/jpeg	59849	6746	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/62d67dfa-6bd0-443b-a544-2a92dfde9563.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/0efb267b-3477-491c-87cb-1ee3a0b4b585.jpeg	jpeg
39	ee687518-48e6-470e-86db-99fd74e9b762	ee687518-48e6-470e-86db-99fd74e9b762	a53bcb6a-d738-4fc3-9ac0-077411d6e35e	image/jpeg	64259	6636	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/ee687518-48e6-470e-86db-99fd74e9b762.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/a53bcb6a-d738-4fc3-9ac0-077411d6e35e.jpeg	jpeg
40	f9a82cf5-66df-4277-93e6-eae52c078c3f	f9a82cf5-66df-4277-93e6-eae52c078c3f	6a94118f-b4e0-4791-a10c-e520f4159728	image/jpeg	49989	13084	CDN	CDN	https://api.selcdn.ru/v1/SEL_85436/nextoria/f9a82cf5-66df-4277-93e6-eae52c078c3f.jpeg	https://api.selcdn.ru/v1/SEL_85436/nextoria/6a94118f-b4e0-4791-a10c-e520f4159728.jpeg	jpeg
\.


--
-- Data for Name: lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson (id, price, cource_id, title, "order", update_date, content, state, archive_date, videoid) FROM stdin;
20	100	95	Счеты абакус. Набор чисел на абакусе.	2	2019-05-19 14:05:13.785882+00	<p><span style="color: rgb(0, 0, 0);">На прошлом уроке мы с Вами узнали, что такое ментальная арифметика и зачем она нужна. Сегодня на уроке мы познакомимся со строением счетов абакус и попробуем набрать первые числа на абакусе.</span></p><p><br></p><p><span style="color: rgb(0, 0, 0);">Конструкция счетов абакус очень просто. Он состоит из рамы. Рама разделена расчетной разделительной линейки. Также на раме есть стержни, а на стержнях бусинки. Нижние бусинки, т.е. ниже разделительной линейки – друзьями. Одна поднятая бусинка к разделительной линейке означает число 1. Максимально на первом стержне можно набрать число 4. Верхние бусинки, т.е. выше разделительной линейки мы называем братьями. Одна спущенная бусинка к разделительной линейке&nbsp;&nbsp;&nbsp;На первой стержне мы можем набрать единицы, на второй десятки, а на третьей - сотни. </span></p><p>&nbsp;</p><p><span style="color: rgb(0, 0, 0);">КАРТИНКА АБАКУСА </span></p><p><br></p><p><span style="color: rgb(0, 0, 0);">Нужно запомнить “2 золотых правила” ментальной арифметики</span></p><p><span style="color: rgb(0, 0, 0);">1 правило:</span></p><p><span style="color: rgb(0, 0, 0);">- друзей мы набираем большим пальцем, а убираем указательным. </span></p><p><span style="color: rgb(0, 0, 0);">- братьев набираем и убираем только указательным пальцем. </span></p><p><span style="color: rgb(0, 0, 0);">2 правило:</span></p><p><span style="color: rgb(0, 0, 0);">- набираем цифры мы всегда слева направо</span></p><p>&nbsp;</p><p><span style="color: rgb(0, 0, 0);">Более подробно набор разных чисел на абакусе смотрите в видео к уроку.</span></p><p><br></p><p><br></p>	DRAFT	\N	47
22	100	95	Визуализация	4	2019-05-19 14:06:40.255332+00		DRAFT	\N	\N
27	100	96	Тестовый урок. Программирование	1	2019-05-19 14:07:31.778665+00	\N	DRAFT	\N	\N
21	100	95	Просто сложение и вычитание	3	2019-05-19 14:06:24.460877+00		DRAFT	\N	\N
26	100	95	Помощь брата вычитание	6	2019-05-25 14:03:39.195786+00		DRAFT	\N	\N
23	100	95	Помощь брата сложение	5	2019-05-19 14:07:31.778665+00		DRAFT	\N	\N
19	100	95	Вводный.Знакомство с МА	1	2019-05-18 15:31:25.349548+00	<p><strong style="background-color: transparent; color: rgb(0, 0, 0);">Что такое ментальная арифметика? </strong></p><p><br></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Все знают, что такое арифметика. Арифметика - наука о числах и их вычислениях. А что же такое ментальная арифметика? Ментальная арифметика это тоже вычисления, но с помощью устного счета. Но чтобы быстро научиться считать в уме, мы сначала будем считать на древних счетах “абакус”, а потом уже перейдем на устный счет.&nbsp;</span></p><p><br></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Древние счеты “абакус” появились 2500 лет назад в Вавилоне. Их использовали астрономы, торговцы и математики. Потом абакусы заменили калькуляторы и компьютеры, но в Китае “абакус” продолжали использовать, как инструмент развития интеллекта. </span></p><p><br></p><p><strong style="background-color: transparent; color: rgb(0, 0, 0);">Вы спросите, а зачем мне ментальная арифметика? </strong></p><p><br></p><p><br></p><p><br></p><p><strong style="background-color: transparent; color: rgb(0, 0, 0);">﻿</strong></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Если Вы будете постоянно заниматься ментальной арифметикой, то уже через 2-3 месяца Вы заметите улучшение в памяти, станете более внимательным и сможете удивить окружающих быстром счетом. </span></p><p><br></p><p><span style="background-color: transparent; color: rgb(0, 0, 0);">Более подробно, как ментальная арифметика и абакус влияют на мозг смотрите в видео к этому уроку.</span></p>	DRAFT	\N	46
\.


--
-- Data for Name: lesson_skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_skills (lesson_id, skills_id) FROM stdin;
20	56
21	57
22	57
23	57
26	56
19	54
19	55
\.


--
-- Data for Name: nextoria_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nextoria_user (id, email, name, age, password_hash, role, state, surname, phone_number, last_password_reset_date, enabled, avatar_id, nickname) FROM stdin;
10	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	METHODIST	ACTIVE	newZhukovets	79196824555	\N	t	8	\N
92	\N	\N	\N	\N	STUDENT	REGISTERING	\N	79509074099	\N	f	\N	\N
94	farvaev.emil@gmail.com	Эмиль	\N	$2a$10$5kATm0XRzDx7DljwXa8dR.sONR.7TOQBOmFGNP33gPApGGszciIV6	ADMIN	ACTIVE	Фарваев	1	\N	t	\N	\N
68	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	75555556666	\N	t	\N	\N
91	petr@mm.ru	Петр	\N	$2a$10$MltJfezxLSACkyZVakWxie/CQhLxzBtO3LoAvD4Jhbr5WqLOdX0Im	STUDENT	ACTIVE	Иванов	79165338718	\N	t	38	ars
112	kotromeo6@gmail.com	Максим	\N	$2a$10$FLztRxrm/pV2pbvF2j5eBO/plJkDGjyAy8Yqzz.See9/9phdE1GzG	STUDENT	ACTIVE	Казанцев	79509074005	\N	t	28	Ник
90	\N	\N	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	REGISTERING	\N	\N	\N	f	\N	\N
102	kotromeo6@gmail.com	123	\N	$2a$10$pD1iAVwgAazs.oer0D3hhuMUE2FOPypm.wYXrnjH4xTOTAvIToFtW	STUDENT	ACTIVE	456	79000000002	\N	t	21	\N
96	radmirganiev@mail.ru	Радмир 	\N	$2a$10$eWzax0UegrxkTJ5VczDQHenE5szBg1Rz.FBu6QqSjdE/IR75216Sy	STUDENT	ACTIVE	Ганиев	79854342678	\N	t	\N	\N
3	evzhukovets@yandex.ru	newEvgeniy	11	$2a$10$qPUlagmnN4IgQrA5FyWNne.OZgf4ewjA3eRM3H4T95jfAUSy3xdkm	STUDENT	ACTIVE	newZhukovets	79456325442	\N	t	\N	\N
98	\N	\N	\N	\N	STUDENT	REGISTERING	\N	\N	\N	f	\N	\N
106	kotromeo@mail.ru	максим	\N	$2a$10$rPOt37sVetolx5kxfCJLAObgzdW6y.dEdLFVd9O6OPss2otvUgHUW	STUDENT	ACTIVE	Казанцев	79509074001	\N	t	26	123123
117	ffd@mail.ru	Блеск	\N	$2a$10$/r/b5B5.MMB.LQ9wiXW6WeWFnU7.Kqu2hHpNMFy6DS8wea20j7ka6	STUDENT	ACTIVE	Петрович	3759167307217	\N	t	40	Вахтанг
110	kotromeo6@gmail.com	Максим	\N	$2a$10$tSIlSEjPjVq8thH3SXXtbeBw6XsWg.FEczB05HjQSOX.sHcOKe5NC	STUDENT	ACTIVE	Казанцев	79509074007	\N	t	27	Korik
100	kotromeo6@gmail.com	Максим	\N	$2a$10$S5/gZ6bNFVPWsx7dzR83He7AgxJUaHxs99GvCSk0M7p1xt589HAH6	STUDENT	ACTIVE	Казанцев900	79000000000	\N	t	17	\N
104	a@bbbbb.ru	Петя	\N	$2a$10$GOLsZpvWgbcvfafDjbI3D.jmvfrs46QeD421IpObrzVRCO2NuY9OG	STUDENT	ACTIVE	Сидоров	78888888889	\N	t	24	Вася
1	em1@yandex.ru	HHH1	20	$2a$10$jw6ObQCvuBKiQ/XeXCw4IezXLldCOgpieBP5Ud/3f82cKJZLSr5F.	ADMIN	ACTIVE	HHH1	t1	\N	t	\N	\N
108	\N	\N	\N	$2a$10$AJuZeTp4zPQEILGmvwKvhuGXEt675P8bJ1fXEcL68EmX4ZvSjNCLi	STUDENT	REGISTERING	\N	3751231231231	\N	t	\N	\N
88	kotromeo6@gmail.com	Максим	\N	$2a$10$wRQFQQ17hHzD.KmXPocdoeBw2fcTsTnktpODzgdQ5Y5/ifsKOBOPe	STUDENT	ACTIVE	Казанцев	79509074004	\N	t	30	Nikl
114	art@mmmmmmm.ru	Ara	\N	$2a$10$YORqfIVlOpT4UlB4QYfqd.ZBC5UR5vuR4YVqQ7AErMotl9N6LXsoG	STUDENT	ACTIVE	Dam	9962588888966	\N	t	36	Ара
2	string	string	999	$2a$10$FC5688ya19LoI0Y8C2v61ertfwxHL9V0TSxbAc.aY2iboGt5FxNri	ADMIN	ACTIVE	string	79345632775	\N	t	\N	\N
116	chel@people.com	Chelovek	\N	$2a$10$z2O8Fg0ngDm1w98Hg1Ma3eSbMLK3OpUg4JmbzorIBeJgQ0splBVlS	METHODIST	ACTIVE	Chelovekov	2	\N	t	\N	\N
57	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	7778889901	\N	f	\N	\N
58	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	79196734563	\N	f	\N	\N
63	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	79196734562	\N	f	\N	\N
65	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	string	\N	f	\N	\N
69	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	9151234562	\N	f	\N	\N
70	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	74859346324	\N	f	\N	\N
51	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	4321	\N	t	\N	\N
72	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	74859346323	\N	f	\N	\N
52	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	9998887766	\N	f	\N	\N
53	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	9161234567	\N	f	\N	\N
54	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	7778889900	\N	f	\N	\N
73	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	74859346322	\N	f	\N	\N
74	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	748593463211	\N	f	\N	\N
89	мыло@мыльница.рф	Имя	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	METHODIST	ACTIVE	Фамилия	000	\N	t	\N	\N
93	\N	\N	\N	$2a$10$HVl9kWrdq.uGfjPlxB7dG.wX8KNdMAXaApFOj0srLHWhZfYlTNSSO	STUDENT	REGISTERING	\N	79509074098	\N	t	\N	\N
115	arre@yyyy.ty	ааа	\N	$2a$10$zujQZJkJCk/XVnQw9YgbEuu5dBHo3nVoNLOjUevwqTnvMZjaZGX7C	STUDENT	ACTIVE	бьбб	9968558556666	\N	t	37	ghk
95	\N	\N	\N	$2a$10$WE75cOaWrkFaXss36cQm6OVJ57jD1BzuqngMZNPBDDMoLj9w2dbNC	STUDENT	REGISTERING	\N	79509074404	\N	t	\N	\N
107	fdd@nmil.com	Алекс	\N	$2a$10$CowVImGUZi5R1ZBBNSrWD.KZLynWxR8JjnPmeBJkKb/kJOY15GHMy	STUDENT	ACTIVE	Пон	79167307217	\N	t	42	Ахмед
97	raritet007@mail.ru	Кукуш	\N	$2a$10$/A.BrADkrSDXQAS1CKwQXOI.bz9dLQCl6cA6iF92uZ0BDpkdZgp.2	STUDENT	ACTIVE	Марсов	79031592639	\N	t	\N	\N
109	kotromeo6@gmail.com	 Максим	\N	$2a$10$tvNzidhpf0QcRqB2heD8Q.55WjUkKdVw45P7ayv0o/vA9ZtXiGMYK	STUDENT	ACTIVE	Казанцев	79509074008	\N	t	\N	\N
75	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	748593463212	\N	f	\N	\N
77	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	74859346320	\N	f	\N	\N
11	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	79196824550	\N	t	\N	\N
81	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	74859346321	\N	f	\N	\N
111	kotromeo6@gmail.com	Максим	\N	$2a$10$FAwjni0H0NOMQ509SysW6erYsbRCPCn7s1DWKq28EJ0vyjNGsBGA.	STUDENT	ACTIVE	Казанцев	79509074003	\N	t	\N	\N
85	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	791968245323	\N	t	\N	\N
86	sidikov.marsel@gmail.com	Marsel	\N	$2a$10$LcBNMfKXbTh61d44jhUrY.FBkqM/p65GHzrwAC0eRd4Ii.RphHM1y	ADMIN	ACTIVE	Sidikov	79372824941	\N	t	\N	\N
83	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	748593463244	\N	f	12	jadeeugene
84	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	748932432	\N	f	13	\N
82	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	748593463242	\N	f	\N	jadeeugene
99	em@gfd.ru	Name	\N	$2a$10$NToSVQRsaxQbsX/eL699cuVYCxLKqihHHKexTtKhgvY9eU2IRET7m	STUDENT	ACTIVE	Surname	747532	\N	t	\N	\N
105	aaa@mmm.ru	Арткр	\N	$2a$10$hPRlEEJwi7DvQF1g.JA85et03UOhpqqBeww73fhX2aND1w1GzSqBW	STUDENT	ACTIVE	оооо	75856595198	\N	t	31	Ara
101	kotromeo6@gmail.com	123	\N	$2a$10$5AY/pqF0gEjt75F90VaWUuJy0ZIPu6GShitFRx3dQ4MnmYNXUsV5C	STUDENT	ACTIVE	456	79000000001	\N	t	20	\N
103	art@mmmm.ru	Art	\N	$2a$10$1QoRdCHHZbkmWEWtC2R6CuRr2LrcBXuyBC1pgHGvwy.modQu7CP/.	STUDENT	ACTIVE	Dambis	78888888888	\N	t	23	\N
87	evzhukovets@yandex.ru	newEvgeniy	\N	$2a$10$eGhx.nIRzbi1J08WZ4ThUeoGeQvumBYV3kJGUMQ8thQ4Eg8brmtcG	STUDENT	ACTIVE	newZhukovets	79137583453	\N	t	\N	nffff
113	radmirganiev@mail.ru	Радмир	\N	$2a$10$6MQb9PYDGqB7ChoF3EglEunLcg/VBqqHC4Fl8IxEzKJdknRZL1jPa	STUDENT	ACTIVE	Ганиев	79854345678	\N	t	34	Radmir
\.


--
-- Data for Name: skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skill (id, metrics, title) FROM stdin;
54	0	концентрация внимания
55	0	многозадачность
56	0	Устный счет
57	0	
\.


--
-- Data for Name: user_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_course (user_id, course_id) FROM stdin;
68	95
91	95
\.


--
-- Data for Name: user_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_token (user_id, token, id) FROM stdin;
52	O5EQ98	37
53	STUKM1	38
54	YRBDV8	39
57	8JM7N7	40
58	ILVE9A	41
82	VFRUDU	42
83	Z1VJYU	43
84	L19RD6	44
85	KU4F86	45
92	17SC5H	87
108	7SMW7K	175
90	O5UM66	59
93	9GJPMS	104
3	HZSWUH	114
88	FQA58Q	229
95	56RPOW	137
98	WFF92U	147
\.


--
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.video (id, initial_file_name, file_name, compressed_file_name, mime, initial_file_size, compressed_file_size, location_key, compressed_location_key, path, compressed_path, file_extension) FROM stdin;
42	Ментальная арифметика онлайн обучение. Введение (1)	74613184-1c88-489d-b0b6-8ebe608a4895	74613184-1c88-489d-b0b6-8ebe608a4895	video/mp4	75008578	75008578	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/74613184-1c88-489d-b0b6-8ebe608a4895.mp4	storage/74613184-1c88-489d-b0b6-8ebe608a4895.mp4	mp4
43	phew	a8b20d83-f33c-4c15-a6c8-50c8bff4d8e5	a8b20d83-f33c-4c15-a6c8-50c8bff4d8e5	video/mp4	137713	137713	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/a8b20d83-f33c-4c15-a6c8-50c8bff4d8e5.mp4	storage/a8b20d83-f33c-4c15-a6c8-50c8bff4d8e5.mp4	mp4
44	phew	e76bfb53-1f69-4c12-9c0f-245c060a0bc9	e76bfb53-1f69-4c12-9c0f-245c060a0bc9	video/mp4	137713	137713	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/e76bfb53-1f69-4c12-9c0f-245c060a0bc9.mp4	storage/e76bfb53-1f69-4c12-9c0f-245c060a0bc9.mp4	mp4
45	phew	2fcfc464-5a9a-470d-9776-702358d95ea4	2fcfc464-5a9a-470d-9776-702358d95ea4	video/mp4	137713	137713	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/2fcfc464-5a9a-470d-9776-702358d95ea4.mp4	storage/2fcfc464-5a9a-470d-9776-702358d95ea4.mp4	mp4
46	phew	b439d0bf-3034-417b-be41-86db3a70f04d	b439d0bf-3034-417b-be41-86db3a70f04d	video/mp4	137713	137713	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/b439d0bf-3034-417b-be41-86db3a70f04d.mp4	storage/b439d0bf-3034-417b-be41-86db3a70f04d.mp4	mp4
47	phew	95dc39be-6246-4c89-a7bd-3cfc1a50d1bb	95dc39be-6246-4c89-a7bd-3cfc1a50d1bb	video/mp4	137713	137713	CDN	LOCAL_STORAGE	https://api.selcdn.ru/v1/SEL_85436/nextoria/95dc39be-6246-4c89-a7bd-3cfc1a50d1bb.mp4	storage/95dc39be-6246-4c89-a7bd-3cfc1a50d1bb.mp4	mp4
\.


--
-- Name: age_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.age_group_id_seq', 66, true);


--
-- Name: authority_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authority_seq', 1, false);


--
-- Name: course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_id_seq', 96, true);


--
-- Name: game_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_data_id_seq', 37, true);


--
-- Name: game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_id_seq', 14, true);


--
-- Name: game_properties_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_properties_token_id_seq', 32, true);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.image_id_seq', 42, true);


--
-- Name: lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_id_seq', 27, true);


--
-- Name: nextoria_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nextoria_user_id_seq', 117, true);


--
-- Name: skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skill_id_seq', 58, true);


--
-- Name: user_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_token_id_seq', 232, true);


--
-- Name: video_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.video_id_seq', 47, true);


--
-- Name: age_group age_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.age_group
    ADD CONSTRAINT age_group_pkey PRIMARY KEY (id);


--
-- Name: course cource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT cource_pkey PRIMARY KEY (id);


--
-- Name: game_data game_data_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_data
    ADD CONSTRAINT game_data_pk PRIMARY KEY (id);


--
-- Name: game game_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pk PRIMARY KEY (id);


--
-- Name: game_properties_token game_properties_token_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_properties_token
    ADD CONSTRAINT game_properties_token_pk PRIMARY KEY (id);


--
-- Name: image image_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pk PRIMARY KEY (id);


--
-- Name: lesson lesson_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_pkey PRIMARY KEY (id);


--
-- Name: nextoria_user nextoria_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nextoria_user
    ADD CONSTRAINT nextoria_user_pkey PRIMARY KEY (id);


--
-- Name: skill skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill
    ADD CONSTRAINT skill_pkey PRIMARY KEY (id);


--
-- Name: video video_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pk PRIMARY KEY (id);


--
-- Name: fki_game_data_course_id_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_game_data_course_id_fk ON public.game_data USING btree (course_id);


--
-- Name: game_data_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX game_data_id_uindex ON public.game_data USING btree (id);


--
-- Name: game_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX game_id_uindex ON public.game USING btree (id);


--
-- Name: game_properties_token_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX game_properties_token_id_uindex ON public.game_properties_token USING btree (id);


--
-- Name: image_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX image_id_uindex ON public.image USING btree (id);


--
-- Name: nextoria_user_phone_number_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX nextoria_user_phone_number_uindex ON public.nextoria_user USING btree (phone_number);


--
-- Name: user_token_user_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_token_user_id_uindex ON public.user_token USING btree (user_id);


--
-- Name: video_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX video_id_uindex ON public.video USING btree (id);


--
-- Name: course course_age_group_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_age_group_id_fk FOREIGN KEY (age_group_id) REFERENCES public.age_group(id);


--
-- Name: course course_nextoria_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_nextoria_user_id_fk FOREIGN KEY (user_id) REFERENCES public.nextoria_user(id);


--
-- Name: course_skills fk5dt329p8lrvq9lu2nwd8tdfyc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_skills
    ADD CONSTRAINT fk5dt329p8lrvq9lu2nwd8tdfyc FOREIGN KEY (skills_id) REFERENCES public.skill(id);


--
-- Name: lesson_skills fkc0xyjf7d797iwulhy8jlj86xr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_skills
    ADD CONSTRAINT fkc0xyjf7d797iwulhy8jlj86xr FOREIGN KEY (lesson_id) REFERENCES public.lesson(id);


--
-- Name: lesson_skills fkjw2tcd0b6r0v3w2jiaaiknfa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_skills
    ADD CONSTRAINT fkjw2tcd0b6r0v3w2jiaaiknfa FOREIGN KEY (skills_id) REFERENCES public.skill(id);


--
-- Name: course_skills fktdqa9pxhlx2fi1sx7qq8528ot; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_skills
    ADD CONSTRAINT fktdqa9pxhlx2fi1sx7qq8528ot FOREIGN KEY (cource_id) REFERENCES public.course(id);


--
-- Name: game_data game_data_course_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_data
    ADD CONSTRAINT game_data_course_id_fk FOREIGN KEY (course_id) REFERENCES public.course(id);


--
-- Name: game_data game_data_game_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_data
    ADD CONSTRAINT game_data_game_id_fk FOREIGN KEY (game_id) REFERENCES public.game(id);


--
-- Name: game_data game_data_lesson_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_data
    ADD CONSTRAINT game_data_lesson_id_fk FOREIGN KEY (lesson_id) REFERENCES public.lesson(id);


--
-- Name: game_properties_token game_properties_token_game_data_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_properties_token
    ADD CONSTRAINT game_properties_token_game_data_id_fk FOREIGN KEY (game_data_id) REFERENCES public.game_data(id);


--
-- Name: game_properties_token game_properties_token_nextoria_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_properties_token
    ADD CONSTRAINT game_properties_token_nextoria_user_id_fk FOREIGN KEY (user_id) REFERENCES public.nextoria_user(id);


--
-- Name: lesson lesson_cource_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_cource_id_fk FOREIGN KEY (cource_id) REFERENCES public.course(id);


--
-- Name: lesson lesson_video_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_video_id_fk FOREIGN KEY (videoid) REFERENCES public.video(id);


--
-- Name: nextoria_user nextoria_user_image_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nextoria_user
    ADD CONSTRAINT nextoria_user_image_id_fk FOREIGN KEY (avatar_id) REFERENCES public.image(id);


--
-- Name: user_course user_course_cource_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_course
    ADD CONSTRAINT user_course_cource_id_fk FOREIGN KEY (course_id) REFERENCES public.course(id);


--
-- Name: user_course user_course_nextoria_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_course
    ADD CONSTRAINT user_course_nextoria_user_id_fk FOREIGN KEY (user_id) REFERENCES public.nextoria_user(id);


--
-- Name: user_token user_token_nextoria_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_token
    ADD CONSTRAINT user_token_nextoria_user_id_fk FOREIGN KEY (user_id) REFERENCES public.nextoria_user(id);


--
-- PostgreSQL database dump complete
--

