--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18 (Debian 14.18-1.pgdg120+1)
-- Dumped by pg_dump version 14.18 (Debian 14.18-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: CallType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."CallType" AS ENUM (
    'VOICE',
    'VIDEO'
);


ALTER TYPE public."CallType" OWNER TO postgres;

--
-- Name: ConnectionStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ConnectionStatus" AS ENUM (
    'PENDING',
    'ACCEPTED',
    'REJECTED'
);


ALTER TYPE public."ConnectionStatus" OWNER TO postgres;

--
-- Name: RequestStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."RequestStatus" AS ENUM (
    'PENDING',
    'ACCEPTED',
    'DECLINED'
);


ALTER TYPE public."RequestStatus" OWNER TO postgres;

--
-- Name: Role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Role" AS ENUM (
    'ADMIN',
    'USER',
    'GUEST'
);


ALTER TYPE public."Role" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Call; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Call" (
    id integer NOT NULL,
    caller_id integer NOT NULL,
    receiver_id integer NOT NULL,
    type public."CallType" NOT NULL,
    duration integer,
    started_at timestamp(3) without time zone NOT NULL,
    ended_at timestamp(3) without time zone
);


ALTER TABLE public."Call" OWNER TO postgres;

--
-- Name: Call_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Call_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Call_id_seq" OWNER TO postgres;

--
-- Name: Call_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Call_id_seq" OWNED BY public."Call".id;


--
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Category_id_seq" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: ChatRequest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ChatRequest" (
    id integer NOT NULL,
    sender_id integer NOT NULL,
    receiver_id integer NOT NULL,
    message text NOT NULL,
    status public."RequestStatus" DEFAULT 'PENDING'::public."RequestStatus" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."ChatRequest" OWNER TO postgres;

--
-- Name: ChatRequest_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ChatRequest_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ChatRequest_id_seq" OWNER TO postgres;

--
-- Name: ChatRequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ChatRequest_id_seq" OWNED BY public."ChatRequest".id;


--
-- Name: Comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comment" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    content text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Comment" OWNER TO postgres;

--
-- Name: Comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Comment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Comment_id_seq" OWNER TO postgres;

--
-- Name: Comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Comment_id_seq" OWNED BY public."Comment".id;


--
-- Name: Connection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Connection" (
    id integer NOT NULL,
    user1_id integer NOT NULL,
    user2_id integer NOT NULL,
    status public."ConnectionStatus" DEFAULT 'PENDING'::public."ConnectionStatus" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Connection" OWNER TO postgres;

--
-- Name: Connection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Connection_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Connection_id_seq" OWNER TO postgres;

--
-- Name: Connection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Connection_id_seq" OWNED BY public."Connection".id;


--
-- Name: Like; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Like" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Like" OWNER TO postgres;

--
-- Name: Like_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Like_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Like_id_seq" OWNER TO postgres;

--
-- Name: Like_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Like_id_seq" OWNED BY public."Like".id;


--
-- Name: Message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Message" (
    id integer NOT NULL,
    sender_id integer NOT NULL,
    receiver_id integer NOT NULL,
    content text NOT NULL,
    sent_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_request boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Message" OWNER TO postgres;

--
-- Name: Message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Message_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Message_id_seq" OWNER TO postgres;

--
-- Name: Message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Message_id_seq" OWNED BY public."Message".id;


--
-- Name: Otp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Otp" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    code text NOT NULL,
    expires_at timestamp(3) without time zone NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_used boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Otp" OWNER TO postgres;

--
-- Name: Otp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Otp_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Otp_id_seq" OWNER TO postgres;

--
-- Name: Otp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Otp_id_seq" OWNED BY public."Otp".id;


--
-- Name: Post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Post" (
    id integer NOT NULL,
    category_id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "authorId" integer NOT NULL
);


ALTER TABLE public."Post" OWNER TO postgres;

--
-- Name: PostImage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostImage" (
    id integer NOT NULL,
    post_id integer NOT NULL,
    image_url text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."PostImage" OWNER TO postgres;

--
-- Name: PostImage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PostImage_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PostImage_id_seq" OWNER TO postgres;

--
-- Name: PostImage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PostImage_id_seq" OWNED BY public."PostImage".id;


--
-- Name: Post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Post_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Post_id_seq" OWNER TO postgres;

--
-- Name: Post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Post_id_seq" OWNED BY public."Post".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    role public."Role" DEFAULT 'GUEST'::public."Role" NOT NULL,
    about_me text,
    date_of_birth timestamp(3) without time zone,
    last_active timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    profile_picture text,
    cover_photo text,
    knowledge_interests text[] DEFAULT ARRAY[]::text[]
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: Call id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call" ALTER COLUMN id SET DEFAULT nextval('public."Call_id_seq"'::regclass);


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: ChatRequest id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ChatRequest" ALTER COLUMN id SET DEFAULT nextval('public."ChatRequest_id_seq"'::regclass);


--
-- Name: Comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment" ALTER COLUMN id SET DEFAULT nextval('public."Comment_id_seq"'::regclass);


--
-- Name: Connection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Connection" ALTER COLUMN id SET DEFAULT nextval('public."Connection_id_seq"'::regclass);


--
-- Name: Like id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Like" ALTER COLUMN id SET DEFAULT nextval('public."Like_id_seq"'::regclass);


--
-- Name: Message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message" ALTER COLUMN id SET DEFAULT nextval('public."Message_id_seq"'::regclass);


--
-- Name: Otp id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Otp" ALTER COLUMN id SET DEFAULT nextval('public."Otp_id_seq"'::regclass);


--
-- Name: Post id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Post" ALTER COLUMN id SET DEFAULT nextval('public."Post_id_seq"'::regclass);


--
-- Name: PostImage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostImage" ALTER COLUMN id SET DEFAULT nextval('public."PostImage_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Call; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Call" (id, caller_id, receiver_id, type, duration, started_at, ended_at) FROM stdin;
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" (id, name, created_at) FROM stdin;
\.


--
-- Data for Name: ChatRequest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ChatRequest" (id, sender_id, receiver_id, message, status, created_at) FROM stdin;
\.


--
-- Data for Name: Comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Comment" (id, user_id, post_id, content, created_at) FROM stdin;
\.


--
-- Data for Name: Connection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Connection" (id, user1_id, user2_id, status, created_at) FROM stdin;
\.


--
-- Data for Name: Like; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Like" (id, user_id, post_id, created_at) FROM stdin;
\.


--
-- Data for Name: Message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Message" (id, sender_id, receiver_id, content, sent_at, is_request) FROM stdin;
\.


--
-- Data for Name: Otp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Otp" (id, user_id, code, expires_at, created_at, is_used) FROM stdin;
\.


--
-- Data for Name: Post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Post" (id, category_id, title, content, created_at, "authorId") FROM stdin;
\.


--
-- Data for Name: PostImage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostImage" (id, post_id, image_url, created_at) FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, username, email, password, role, about_me, date_of_birth, last_active, created_at, profile_picture, cover_photo, knowledge_interests) FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
a67f7876-a0f1-4a61-a357-e897832e86ef	3d6714f97ea5a1a584f04ef181b664e7e1eeae0c4c1074cc8df64c62e765537a	2025-07-26 18:35:53.961206+00	20250606024451_init	\N	\N	2025-07-26 18:35:53.879202+00	1
177214df-2607-45e8-aa8d-8cad1b135b85	c21bffaad928e3a0ba1a9e93ae75fcf0d3f58478b17c06b37ab24c428c53445f	2025-07-26 18:35:54.004238+00	20250606040956_update	\N	\N	2025-07-26 18:35:53.963635+00	1
0035dd8a-f9e0-4591-b37a-52ced876a79e	122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec	2025-07-26 18:35:54.011699+00	20250606041707_new	\N	\N	2025-07-26 18:35:54.006437+00	1
178a5693-b739-47ba-9378-3164f1214db9	f4a5b1be6a1bee044bae0e86c59a8cb730b8bdb5e92aa254ecef354af0f2534f	2025-07-26 18:35:54.029775+00	20250606080345_add_post_images	\N	\N	2025-07-26 18:35:54.013977+00	1
ef70a0b8-98b0-47cc-8a82-67c95fd08f73	05471f212fa9593d8d7d3600af3b94b5300455082175c7b3e7e4acd4b34efab2	2025-07-26 18:35:54.03928+00	20250609024539_init	\N	\N	2025-07-26 18:35:54.031961+00	1
3bd87878-642c-495b-aabb-a81052d494e1	9165c768803fc25f4082f51372787cda72bbe962827588dd2cf6ba29ea6028d7	2025-07-26 18:35:54.06122+00	20250609085246_update_post_images	\N	\N	2025-07-26 18:35:54.041666+00	1
43ddb2e1-1d98-462d-a585-57fa17cf91f0	306f2a41459f8838b11e5cc4e31d1d5b66246e3473f6a72f0aa64855fdfb633a	2025-07-26 18:35:54.107455+00	20250610064625_init_profile	\N	\N	2025-07-26 18:35:54.063614+00	1
92c79155-83f2-4eaa-a33e-240e91ddc590	245f6a92d7443a048e60b5cdc3637bb1b63019a4408a9c14dbda0b478117175a	2025-07-26 18:35:54.117139+00	20250610065323_fix_knowledge_interests	\N	\N	2025-07-26 18:35:54.109683+00	1
4f4dc32d-645f-4fa6-b7c8-e83028897162	636d14eafeed020b747b4dede20202a7b607e7e3918e6fe13c2fac96874549f4	2025-07-26 18:35:54.144357+00	20250610090259_update_schema_for_chat_and_knowledge	\N	\N	2025-07-26 18:35:54.11943+00	1
\.


--
-- Name: Call_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Call_id_seq"', 1, false);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 1, false);


--
-- Name: ChatRequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ChatRequest_id_seq"', 1, false);


--
-- Name: Comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Comment_id_seq"', 1, false);


--
-- Name: Connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Connection_id_seq"', 1, false);


--
-- Name: Like_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Like_id_seq"', 1, false);


--
-- Name: Message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Message_id_seq"', 1, false);


--
-- Name: Otp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Otp_id_seq"', 1, false);


--
-- Name: PostImage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PostImage_id_seq"', 1, false);


--
-- Name: Post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Post_id_seq"', 1, false);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, false);


--
-- Name: Call Call_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Call_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: ChatRequest ChatRequest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ChatRequest"
    ADD CONSTRAINT "ChatRequest_pkey" PRIMARY KEY (id);


--
-- Name: Comment Comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_pkey" PRIMARY KEY (id);


--
-- Name: Connection Connection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Connection"
    ADD CONSTRAINT "Connection_pkey" PRIMARY KEY (id);


--
-- Name: Like Like_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Like"
    ADD CONSTRAINT "Like_pkey" PRIMARY KEY (id);


--
-- Name: Message Message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_pkey" PRIMARY KEY (id);


--
-- Name: Otp Otp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Otp"
    ADD CONSTRAINT "Otp_pkey" PRIMARY KEY (id);


--
-- Name: PostImage PostImage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostImage"
    ADD CONSTRAINT "PostImage_pkey" PRIMARY KEY (id);


--
-- Name: Post Post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Call_caller_id_receiver_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Call_caller_id_receiver_id_idx" ON public."Call" USING btree (caller_id, receiver_id);


--
-- Name: Call_caller_id_receiver_id_started_at_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Call_caller_id_receiver_id_started_at_key" ON public."Call" USING btree (caller_id, receiver_id, started_at);


--
-- Name: Category_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Category_name_idx" ON public."Category" USING btree (name);


--
-- Name: Category_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Category_name_key" ON public."Category" USING btree (name);


--
-- Name: ChatRequest_receiver_id_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "ChatRequest_receiver_id_status_idx" ON public."ChatRequest" USING btree (receiver_id, status);


--
-- Name: ChatRequest_sender_id_receiver_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "ChatRequest_sender_id_receiver_id_key" ON public."ChatRequest" USING btree (sender_id, receiver_id);


--
-- Name: Comment_user_id_post_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Comment_user_id_post_id_idx" ON public."Comment" USING btree (user_id, post_id);


--
-- Name: Connection_user1_id_user2_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Connection_user1_id_user2_id_idx" ON public."Connection" USING btree (user1_id, user2_id);


--
-- Name: Connection_user1_id_user2_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Connection_user1_id_user2_id_key" ON public."Connection" USING btree (user1_id, user2_id);


--
-- Name: Like_user_id_post_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Like_user_id_post_id_idx" ON public."Like" USING btree (user_id, post_id);


--
-- Name: Like_user_id_post_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Like_user_id_post_id_key" ON public."Like" USING btree (user_id, post_id);


--
-- Name: Message_sender_id_receiver_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Message_sender_id_receiver_id_idx" ON public."Message" USING btree (sender_id, receiver_id);


--
-- Name: Otp_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Otp_user_id_idx" ON public."Otp" USING btree (user_id);


--
-- Name: PostImage_post_id_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "PostImage_post_id_id_key" ON public."PostImage" USING btree (post_id, id);


--
-- Name: PostImage_post_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "PostImage_post_id_idx" ON public."PostImage" USING btree (post_id);


--
-- Name: Post_authorId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Post_authorId_idx" ON public."Post" USING btree ("authorId");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: User_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_username_idx" ON public."User" USING btree (username);


--
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- Name: Call Call_caller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Call_caller_id_fkey" FOREIGN KEY (caller_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Call Call_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Call_receiver_id_fkey" FOREIGN KEY (receiver_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ChatRequest ChatRequest_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ChatRequest"
    ADD CONSTRAINT "ChatRequest_receiver_id_fkey" FOREIGN KEY (receiver_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ChatRequest ChatRequest_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ChatRequest"
    ADD CONSTRAINT "ChatRequest_sender_id_fkey" FOREIGN KEY (sender_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Comment Comment_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_post_id_fkey" FOREIGN KEY (post_id) REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Comment Comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Connection Connection_user1_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Connection"
    ADD CONSTRAINT "Connection_user1_id_fkey" FOREIGN KEY (user1_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Connection Connection_user2_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Connection"
    ADD CONSTRAINT "Connection_user2_id_fkey" FOREIGN KEY (user2_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Like Like_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Like"
    ADD CONSTRAINT "Like_post_id_fkey" FOREIGN KEY (post_id) REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Like Like_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Like"
    ADD CONSTRAINT "Like_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Message Message_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_receiver_id_fkey" FOREIGN KEY (receiver_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Message Message_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_sender_id_fkey" FOREIGN KEY (sender_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Otp Otp_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Otp"
    ADD CONSTRAINT "Otp_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PostImage PostImage_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostImage"
    ADD CONSTRAINT "PostImage_post_id_fkey" FOREIGN KEY (post_id) REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Post Post_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Post Post_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

