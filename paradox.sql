--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6 (Ubuntu 12.6-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.6 (Ubuntu 12.6-0ubuntu0.20.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: player_buddy_win_poses; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_buddy_win_poses (
    id integer NOT NULL,
    player_id integer NOT NULL,
    buddy_id integer NOT NULL,
    win_pose_id integer NOT NULL,
    status integer DEFAULT 0
);


ALTER TABLE public.player_buddy_win_poses OWNER TO paradox;

--
-- Name: buddy_win_poses_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.buddy_win_poses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buddy_win_poses_id_seq OWNER TO paradox;

--
-- Name: buddy_win_poses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.buddy_win_poses_id_seq OWNED BY public.player_buddy_win_poses.id;


--
-- Name: player_mecha_colors; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_mecha_colors (
    id integer NOT NULL,
    player_id integer NOT NULL,
    mecha_color_id integer NOT NULL,
    status integer DEFAULT 0
);


ALTER TABLE public.player_mecha_colors OWNER TO paradox;

--
-- Name: mecha_colors_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.mecha_colors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mecha_colors_id_seq OWNER TO paradox;

--
-- Name: mecha_colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.mecha_colors_id_seq OWNED BY public.player_mecha_colors.id;


--
-- Name: player; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player (
    player_id integer NOT NULL,
    nesys_id character varying(22) NOT NULL,
    player_name character varying(50) DEFAULT 'ＮｏＮａｍｅ'::character varying,
    rank_id integer DEFAULT 0,
    rank_id_2on2 integer DEFAULT 0,
    title_id integer DEFAULT 0,
    title_id_2on2 integer DEFAULT 0,
    buddy_id smallint DEFAULT 0,
    buddy_intimacy smallint DEFAULT 0,
    line_color_id integer DEFAULT 0,
    ranking_pref_name character varying(30) DEFAULT '東京'::character varying,
    last_ranking_pref_name character varying(30) DEFAULT '東京'::character varying,
    match_mode_id integer DEFAULT 0,
    violation_point integer DEFAULT 0,
    emblem_id integer DEFAULT 0,
    line_color_id_2on2 integer DEFAULT 0,
    emblem_id_2on2 integer DEFAULT 0,
    birth_day integer DEFAULT 1,
    birth_month integer DEFAULT 1,
    mecha_set_id integer DEFAULT 0,
    side_weapon_id integer DEFAULT 0,
    mecha_preset_id integer DEFAULT 0,
    rank_point integer DEFAULT 0,
    max_rank_id integer DEFAULT 0,
    rank_point_2on2 integer DEFAULT 0,
    max_rank_id_2on2 integer DEFAULT 0
);


ALTER TABLE public.player OWNER TO paradox;

--
-- Name: player_buddies; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_buddies (
    id integer NOT NULL,
    player_id integer NOT NULL,
    buddy_id integer NOT NULL,
    buddy_key character varying(35) NOT NULL,
    buddy_value character varying(35) DEFAULT 0
);


ALTER TABLE public.player_buddies OWNER TO paradox;

--
-- Name: player_buddies_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_buddies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_buddies_id_seq OWNER TO paradox;

--
-- Name: player_buddies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_buddies_id_seq OWNED BY public.player_buddies.id;


--
-- Name: player_emblem_parts; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_emblem_parts (
    id integer NOT NULL,
    player_id integer NOT NULL,
    part_id integer NOT NULL,
    status integer DEFAULT 0
);


ALTER TABLE public.player_emblem_parts OWNER TO paradox;

--
-- Name: player_emblem_parts_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_emblem_parts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_emblem_parts_id_seq OWNER TO paradox;

--
-- Name: player_emblem_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_emblem_parts_id_seq OWNED BY public.player_emblem_parts.id;


--
-- Name: player_emblems; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_emblems (
    id integer NOT NULL,
    player_id integer NOT NULL,
    emblem_id integer NOT NULL,
    outline_part_id integer NOT NULL,
    outline_offset_x integer NOT NULL,
    outline_offset_y integer NOT NULL,
    outline_scale_x integer NOT NULL,
    outline_scale_y integer NOT NULL,
    outline_angle integer NOT NULL,
    main_design_part_id integer NOT NULL,
    main_design_offset_x integer NOT NULL,
    main_design_offset_y integer NOT NULL,
    main_design_scale_x integer NOT NULL,
    main_design_scale_y integer NOT NULL,
    main_design_angle integer NOT NULL,
    sub_design_part_id integer NOT NULL,
    sub_design_offset_x integer NOT NULL,
    sub_design_offset_y integer NOT NULL,
    sub_design_scale_x integer NOT NULL,
    sub_design_scale_y integer NOT NULL,
    sub_design_angle integer NOT NULL,
    status integer DEFAULT 0,
    editable boolean DEFAULT false
);


ALTER TABLE public.player_emblems OWNER TO paradox;

--
-- Name: player_emblems_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_emblems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_emblems_id_seq OWNER TO paradox;

--
-- Name: player_emblems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_emblems_id_seq OWNED BY public.player_emblems.id;


--
-- Name: player_line_colors; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_line_colors (
    id integer NOT NULL,
    player_id integer NOT NULL,
    line_color_id integer NOT NULL,
    status integer DEFAULT 0
);


ALTER TABLE public.player_line_colors OWNER TO paradox;

--
-- Name: player_line_colors_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_line_colors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_line_colors_id_seq OWNER TO paradox;

--
-- Name: player_line_colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_line_colors_id_seq OWNED BY public.player_line_colors.id;


--
-- Name: player_logins; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_logins (
    id integer NOT NULL,
    player_id integer NOT NULL,
    ip_addr inet NOT NULL,
    location_id integer DEFAULT 0,
    client_version integer DEFAULT 0,
    data_version integer DEFAULT 0,
    ts_when timestamp without time zone NOT NULL
);


ALTER TABLE public.player_logins OWNER TO paradox;

--
-- Name: player_logins_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_logins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_logins_id_seq OWNER TO paradox;

--
-- Name: player_logins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_logins_id_seq OWNED BY public.player_logins.id;


--
-- Name: player_mecha_set_parts; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_mecha_set_parts (
    id integer NOT NULL,
    player_id integer NOT NULL,
    mecha_set_id integer NOT NULL,
    part_id integer NOT NULL,
    mecha_id integer NOT NULL,
    design_id integer DEFAULT 0,
    color_id integer DEFAULT 0
);


ALTER TABLE public.player_mecha_set_parts OWNER TO paradox;

--
-- Name: player_mecha_set_parts_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_mecha_set_parts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_mecha_set_parts_id_seq OWNER TO paradox;

--
-- Name: player_mecha_set_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_mecha_set_parts_id_seq OWNED BY public.player_mecha_set_parts.id;


--
-- Name: player_mecha_sets; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_mecha_sets (
    id integer NOT NULL,
    player_id integer NOT NULL,
    mecha_set_id integer NOT NULL,
    mecha_setbonus_id integer NOT NULL,
    weapon_set_id integer NOT NULL,
    is_decal boolean DEFAULT false,
    favorite boolean DEFAULT false,
    use_count integer DEFAULT 0,
    use_time integer DEFAULT 0,
    status integer DEFAULT 0,
    win_count integer DEFAULT 0,
    winning_streaks integer DEFAULT 0
);


ALTER TABLE public.player_mecha_sets OWNER TO paradox;

--
-- Name: player_mecha_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_mecha_sets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_mecha_sets_id_seq OWNER TO paradox;

--
-- Name: player_mecha_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_mecha_sets_id_seq OWNED BY public.player_mecha_sets.id;


--
-- Name: player_missions; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_missions (
    id integer NOT NULL,
    player_id integer NOT NULL,
    mission_id integer NOT NULL,
    clear_count integer DEFAULT 0,
    clear_num integer DEFAULT 0,
    status integer DEFAULT 0,
    mission_status integer DEFAULT 0
);


ALTER TABLE public.player_missions OWNER TO paradox;

--
-- Name: player_missions_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_missions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_missions_id_seq OWNER TO paradox;

--
-- Name: player_missions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_missions_id_seq OWNED BY public.player_missions.id;


--
-- Name: player_options; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_options (
    id integer NOT NULL,
    player_id integer NOT NULL,
    option_key character varying(35) NOT NULL,
    value_num integer DEFAULT 0
);


ALTER TABLE public.player_options OWNER TO paradox;

--
-- Name: player_options_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_options_id_seq OWNER TO paradox;

--
-- Name: player_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_options_id_seq OWNED BY public.player_options.id;


--
-- Name: player_player_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_player_id_seq OWNER TO paradox;

--
-- Name: player_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_player_id_seq OWNED BY public.player.player_id;


--
-- Name: player_progress; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_progress (
    id integer NOT NULL,
    player_id integer NOT NULL,
    progress_key character varying(35) NOT NULL,
    status smallint DEFAULT 0
);


ALTER TABLE public.player_progress OWNER TO paradox;

--
-- Name: player_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_progress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_progress_id_seq OWNER TO paradox;

--
-- Name: player_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_progress_id_seq OWNED BY public.player_progress.id;


--
-- Name: player_side_weapons; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_side_weapons (
    id integer NOT NULL,
    player_id integer NOT NULL,
    side_weapon_id integer NOT NULL,
    use_count integer DEFAULT 0,
    use_time integer DEFAULT 0,
    status integer DEFAULT 0
);


ALTER TABLE public.player_side_weapons OWNER TO paradox;

--
-- Name: player_side_weapons_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_side_weapons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_side_weapons_id_seq OWNER TO paradox;

--
-- Name: player_side_weapons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_side_weapons_id_seq OWNED BY public.player_side_weapons.id;


--
-- Name: player_titles; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_titles (
    id integer NOT NULL,
    player_id integer NOT NULL,
    title_id integer NOT NULL,
    status integer DEFAULT 0
);


ALTER TABLE public.player_titles OWNER TO paradox;

--
-- Name: player_titles_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_titles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_titles_id_seq OWNER TO paradox;

--
-- Name: player_titles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_titles_id_seq OWNED BY public.player_titles.id;


--
-- Name: player_weapon_set; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_weapon_set (
    id integer NOT NULL,
    player_id integer NOT NULL,
    weapon_set_id integer NOT NULL,
    use_count integer DEFAULT 0,
    use_time integer DEFAULT 0,
    status integer DEFAULT 0
);


ALTER TABLE public.player_weapon_set OWNER TO paradox;

--
-- Name: player_weapon_set_slots; Type: TABLE; Schema: public; Owner: paradox
--

CREATE TABLE public.player_weapon_set_slots (
    id integer NOT NULL,
    player_id integer NOT NULL,
    weapon_set_id integer NOT NULL,
    slot_id integer NOT NULL,
    weapon_id integer NOT NULL,
    use_count integer DEFAULT 0,
    use_time integer DEFAULT 0
);


ALTER TABLE public.player_weapon_set_slots OWNER TO paradox;

--
-- Name: player_weapon_set_slots_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.player_weapon_set_slots_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_weapon_set_slots_id_seq OWNER TO paradox;

--
-- Name: player_weapon_set_slots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.player_weapon_set_slots_id_seq OWNED BY public.player_weapon_set_slots.id;


--
-- Name: weapon_set_id_seq; Type: SEQUENCE; Schema: public; Owner: paradox
--

CREATE SEQUENCE public.weapon_set_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.weapon_set_id_seq OWNER TO paradox;

--
-- Name: weapon_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paradox
--

ALTER SEQUENCE public.weapon_set_id_seq OWNED BY public.player_weapon_set.id;


--
-- Name: player player_id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player ALTER COLUMN player_id SET DEFAULT nextval('public.player_player_id_seq'::regclass);


--
-- Name: player_buddies id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_buddies ALTER COLUMN id SET DEFAULT nextval('public.player_buddies_id_seq'::regclass);


--
-- Name: player_buddy_win_poses id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_buddy_win_poses ALTER COLUMN id SET DEFAULT nextval('public.buddy_win_poses_id_seq'::regclass);


--
-- Name: player_emblem_parts id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_emblem_parts ALTER COLUMN id SET DEFAULT nextval('public.player_emblem_parts_id_seq'::regclass);


--
-- Name: player_emblems id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_emblems ALTER COLUMN id SET DEFAULT nextval('public.player_emblems_id_seq'::regclass);


--
-- Name: player_line_colors id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_line_colors ALTER COLUMN id SET DEFAULT nextval('public.player_line_colors_id_seq'::regclass);


--
-- Name: player_logins id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_logins ALTER COLUMN id SET DEFAULT nextval('public.player_logins_id_seq'::regclass);


--
-- Name: player_mecha_colors id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_mecha_colors ALTER COLUMN id SET DEFAULT nextval('public.mecha_colors_id_seq'::regclass);


--
-- Name: player_mecha_set_parts id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_mecha_set_parts ALTER COLUMN id SET DEFAULT nextval('public.player_mecha_set_parts_id_seq'::regclass);


--
-- Name: player_mecha_sets id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_mecha_sets ALTER COLUMN id SET DEFAULT nextval('public.player_mecha_sets_id_seq'::regclass);


--
-- Name: player_missions id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_missions ALTER COLUMN id SET DEFAULT nextval('public.player_missions_id_seq'::regclass);


--
-- Name: player_options id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_options ALTER COLUMN id SET DEFAULT nextval('public.player_options_id_seq'::regclass);


--
-- Name: player_progress id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_progress ALTER COLUMN id SET DEFAULT nextval('public.player_progress_id_seq'::regclass);


--
-- Name: player_side_weapons id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_side_weapons ALTER COLUMN id SET DEFAULT nextval('public.player_side_weapons_id_seq'::regclass);


--
-- Name: player_titles id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_titles ALTER COLUMN id SET DEFAULT nextval('public.player_titles_id_seq'::regclass);


--
-- Name: player_weapon_set id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_weapon_set ALTER COLUMN id SET DEFAULT nextval('public.weapon_set_id_seq'::regclass);


--
-- Name: player_weapon_set_slots id; Type: DEFAULT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_weapon_set_slots ALTER COLUMN id SET DEFAULT nextval('public.player_weapon_set_slots_id_seq'::regclass);


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player (player_id, nesys_id, player_name, rank_id, rank_id_2on2, title_id, title_id_2on2, buddy_id, buddy_intimacy, line_color_id, ranking_pref_name, last_ranking_pref_name, match_mode_id, violation_point, emblem_id, line_color_id_2on2, emblem_id_2on2, birth_day, birth_month, mecha_set_id, side_weapon_id, mecha_preset_id, rank_point, max_rank_id, rank_point_2on2, max_rank_id_2on2) FROM stdin;
10011	7020392000000001	Lord Cereth	10	10	0	100000	2	0	1	東京	東京	0	0	1	100001	0	1	1	1001	2	0	0	0	300	0
10010	7020392000000000	ArcadeMachinist	20	20	100001	100001	5	2	1	東京	東京	0	0	1	100002	1	1	1	1001	2	0	0	0	300	0
\.


--
-- Data for Name: player_buddies; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_buddies (id, player_id, buddy_id, buddy_key, buddy_value) FROM stdin;
1525	10010	6	skill_id3	0
1529	10010	6	login_days	0
1533	10010	6	winning_streaks_2on2	0
1534	10010	6	status	4
1441	10010	1	intimacy_level_id	1
1442	10010	1	intimacy	0
1445	10010	1	skill_id3	0
1446	10010	1	win_pose_id	1
4899	10011	1	skill_id1	14
4900	10011	1	skill_id2	0
1453	10010	1	winning_streaks_2on2	0
1454	10010	1	status	4
4903	10011	1	win_pose_2on2_id	11
4904	10011	1	use_count	0
1461	10010	2	skill_id3	0
1462	10010	2	win_pose_id	1
4907	10011	1	memorial_login_days	0
4908	10011	1	winning_streaks	0
4911	10011	1	is_first	false
4912	10011	1	high_touch_continue_count	0
1449	10010	1	login_days	0
1450	10010	1	use_time	0
1457	10010	2	intimacy_level_id	1
1458	10010	2	intimacy	0
4913	10011	2	intimacy_level_id	1
4914	10011	2	intimacy	0
1469	10010	2	winning_streaks_2on2	0
1470	10010	2	status	4
1473	10010	3	intimacy_level_id	1
1474	10010	3	intimacy	0
1477	10010	3	skill_id3	0
1478	10010	3	win_pose_id	1
1481	10010	3	login_days	0
1482	10010	3	use_time	0
1485	10010	3	winning_streaks_2on2	0
1486	10010	3	status	4
1489	10010	4	intimacy_level_id	1
1490	10010	4	intimacy	0
1493	10010	4	skill_id3	0
1494	10010	4	win_pose_id	1
1497	10010	4	login_days	0
1498	10010	4	use_time	0
1501	10010	4	winning_streaks_2on2	0
1502	10010	4	status	4
1503	10010	4	is_first	false
1505	10010	5	intimacy_level_id	1
1506	10010	5	intimacy	0
1509	10010	5	skill_id3	0
1510	10010	5	win_pose_id	1
1513	10010	5	login_days	0
1514	10010	5	use_time	0
1517	10010	5	winning_streaks_2on2	0
1518	10010	5	status	4
1521	10010	6	intimacy_level_id	1
1522	10010	6	intimacy	0
1526	10010	6	win_pose_id	1
1527	10010	6	win_pose_2on2_id	11
1530	10010	6	use_time	0
1531	10010	6	memorial_login_days	0
1451	10010	1	memorial_login_days	0
1452	10010	1	winning_streaks	0
1465	10010	2	login_days	0
1443	10010	1	skill_id1	14
1444	10010	1	skill_id2	0
4901	10011	1	skill_id3	0
4902	10011	1	win_pose_id	1
4905	10011	1	login_days	0
4906	10011	1	use_time	0
1463	10010	2	win_pose_2on2_id	11
4909	10011	1	winning_streaks_2on2	0
1459	10010	2	skill_id1	14
1460	10010	2	skill_id2	0
1466	10010	2	use_time	0
1467	10010	2	memorial_login_days	0
1483	10010	3	memorial_login_days	0
1484	10010	3	winning_streaks	0
1491	10010	4	skill_id1	14
1492	10010	4	skill_id2	0
1495	10010	4	win_pose_2on2_id	11
1496	10010	4	use_count	0
1499	10010	4	memorial_login_days	0
1500	10010	4	winning_streaks	0
1504	10010	4	high_touch_continue_count	0
1507	10010	5	skill_id1	14
1508	10010	5	skill_id2	0
1511	10010	5	win_pose_2on2_id	11
1512	10010	5	use_count	0
1515	10010	5	memorial_login_days	0
1523	10010	6	skill_id1	14
1524	10010	6	skill_id2	0
1528	10010	6	use_count	0
1532	10010	6	winning_streaks	0
1535	10010	6	is_first	false
1536	10010	6	high_touch_continue_count	0
1464	10010	2	use_count	0
1468	10010	2	winning_streaks	0
1475	10010	3	skill_id1	14
1476	10010	3	skill_id2	0
1479	10010	3	win_pose_2on2_id	11
1480	10010	3	use_count	0
1516	10010	5	winning_streaks	0
1487	10010	3	is_first	false
1519	10010	5	is_first	true
1520	10010	5	high_touch_continue_count	0
4910	10011	1	status	4
1488	10010	3	high_touch_continue_count	0
1447	10010	1	win_pose_2on2_id	11
1448	10010	1	use_count	0
4897	10011	1	intimacy_level_id	1
4898	10011	1	intimacy	0
1471	10010	2	is_first	false
1455	10010	1	is_first	false
1456	10010	1	high_touch_continue_count	0
1472	10010	2	high_touch_continue_count	0
4939	10011	3	memorial_login_days	0
4940	10011	3	winning_streaks	0
4941	10011	3	winning_streaks_2on2	0
4942	10011	3	status	4
4943	10011	3	is_first	false
4944	10011	3	high_touch_continue_count	0
4981	10011	6	skill_id3	0
4982	10011	6	win_pose_id	1
4983	10011	6	win_pose_2on2_id	11
4984	10011	6	use_count	0
4985	10011	6	login_days	0
4986	10011	6	use_time	0
4987	10011	6	memorial_login_days	0
4945	10011	4	intimacy_level_id	1
4946	10011	4	intimacy	0
4947	10011	4	skill_id1	14
4988	10011	6	winning_streaks	0
4989	10011	6	winning_streaks_2on2	0
4948	10011	4	skill_id2	0
4949	10011	4	skill_id3	0
4950	10011	4	win_pose_id	1
4951	10011	4	win_pose_2on2_id	11
4952	10011	4	use_count	0
4953	10011	4	login_days	0
4954	10011	4	use_time	0
4955	10011	4	memorial_login_days	0
4956	10011	4	winning_streaks	0
4957	10011	4	winning_streaks_2on2	0
4958	10011	4	status	4
4959	10011	4	is_first	false
4960	10011	4	high_touch_continue_count	0
4961	10011	5	intimacy_level_id	1
4962	10011	5	intimacy	0
4963	10011	5	skill_id1	14
4964	10011	5	skill_id2	0
4965	10011	5	skill_id3	0
4966	10011	5	win_pose_id	1
4967	10011	5	win_pose_2on2_id	11
4968	10011	5	use_count	0
4969	10011	5	login_days	0
4970	10011	5	use_time	0
4971	10011	5	memorial_login_days	0
4972	10011	5	winning_streaks	0
4973	10011	5	winning_streaks_2on2	0
4974	10011	5	status	4
4975	10011	5	is_first	false
4976	10011	5	high_touch_continue_count	0
4977	10011	6	intimacy_level_id	1
4978	10011	6	intimacy	0
4979	10011	6	skill_id1	14
4990	10011	6	status	4
4991	10011	6	is_first	false
4992	10011	6	high_touch_continue_count	0
4915	10011	2	skill_id1	14
4916	10011	2	skill_id2	0
4917	10011	2	skill_id3	0
4918	10011	2	win_pose_id	1
4919	10011	2	win_pose_2on2_id	11
4920	10011	2	use_count	0
4921	10011	2	login_days	0
4922	10011	2	use_time	0
4923	10011	2	memorial_login_days	0
4924	10011	2	winning_streaks	0
4925	10011	2	winning_streaks_2on2	0
4926	10011	2	status	4
4927	10011	2	is_first	true
4928	10011	2	high_touch_continue_count	0
4929	10011	3	intimacy_level_id	1
4930	10011	3	intimacy	0
4931	10011	3	skill_id1	14
4932	10011	3	skill_id2	0
4933	10011	3	skill_id3	0
4934	10011	3	win_pose_id	1
4935	10011	3	win_pose_2on2_id	11
4936	10011	3	use_count	0
4937	10011	3	login_days	0
4938	10011	3	use_time	0
4980	10011	6	skill_id2	0
\.


--
-- Data for Name: player_buddy_win_poses; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_buddy_win_poses (id, player_id, buddy_id, win_pose_id, status) FROM stdin;
7	10010	1	11	4
8	10010	1	12	4
13	10011	1	11	4
14	10011	1	12	4
\.


--
-- Data for Name: player_emblem_parts; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_emblem_parts (id, player_id, part_id, status) FROM stdin;
31	10010	110001	4
32	10010	120090	4
33	10010	120091	4
34	10010	120175	4
35	10010	130001	4
36	10010	130009	4
55	10011	110001	4
56	10011	120090	4
57	10011	120091	4
58	10011	120175	4
59	10011	130001	4
60	10011	130009	4
\.


--
-- Data for Name: player_emblems; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_emblems (id, player_id, emblem_id, outline_part_id, outline_offset_x, outline_offset_y, outline_scale_x, outline_scale_y, outline_angle, main_design_part_id, main_design_offset_x, main_design_offset_y, main_design_scale_x, main_design_scale_y, main_design_angle, sub_design_part_id, sub_design_offset_x, sub_design_offset_y, sub_design_scale_x, sub_design_scale_y, sub_design_angle, status, editable) FROM stdin;
13	10010	2	0	0	0	1	1	0	120091	0	0	1	1	0	0	0	0	1	1	0	4	f
14	10010	3	110001	0	0	1	1	0	100000	0	0	1	1	0	130001	0	0	1	1	0	4	t
19	10010	4	110001	0	0	1	1	0	120090	0	0	1	1	0	130009	0	0	1	1	0	4	t
23	10011	2	0	0	0	1	1	0	120091	0	0	1	1	0	0	0	0	1	1	0	2	f
24	10011	3	110001	0	0	1	1	0	100000	0	0	1	1	0	130001	0	0	1	1	0	4	t
\.


--
-- Data for Name: player_line_colors; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_line_colors (id, player_id, line_color_id, status) FROM stdin;
1	10009	100001	4
2	10009	100002	4
3	10009	100015	4
7	10010	100001	4
8	10010	100002	4
9	10010	100015	4
13	10011	100001	4
14	10011	100002	4
15	10011	100015	4
\.


--
-- Data for Name: player_logins; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_logins (id, player_id, ip_addr, location_id, client_version, data_version, ts_when) FROM stdin;
17	10010	98.249.155.160	77	70571	70571	2021-12-04 05:05:35.315216
18	10010	98.249.155.160	77	70571	70571	2021-12-04 05:19:17.230917
19	10009	98.249.155.160	\N	\N	\N	2021-12-04 05:41:36.847662
20	10009	98.249.155.160	\N	\N	\N	2021-12-04 05:44:04.23483
21	10009	98.249.155.160	\N	\N	\N	2021-12-04 05:44:30.318923
22	10009	98.249.155.160	\N	\N	\N	2021-12-04 05:46:27.372176
23	10009	98.249.155.160	\N	\N	\N	2021-12-04 05:46:35.394266
24	10009	98.249.155.160	\N	\N	\N	2021-12-04 05:46:51.909777
25	10009	98.249.155.160	\N	\N	\N	2021-12-04 05:47:25.891538
26	10009	98.249.155.160	\N	\N	\N	2021-12-04 05:48:14.619732
27	10010	98.249.155.160	\N	\N	\N	2021-12-04 05:48:39.712366
28	10010	98.249.155.160	\N	\N	\N	2021-12-04 05:49:45.92822
29	10010	98.249.155.160	\N	\N	\N	2021-12-04 05:52:08.115882
30	10010	98.249.155.160	77	70571	70571	2021-12-04 05:55:18.874478
31	10010	98.249.155.160	77	70571	70571	2021-12-04 06:54:40.74806
32	10010	98.249.155.160	77	70571	70571	2021-12-04 07:10:10.280496
33	10010	98.249.155.160	\N	\N	\N	2021-12-04 07:27:31.861562
34	10010	98.249.155.160	77	70571	70571	2021-12-04 07:47:14.870774
35	10010	98.249.155.160	77	70571	70571	2021-12-04 07:58:11.1177
36	10010	98.249.155.160	77	70571	70571	2021-12-04 08:01:16.085435
37	10010	98.249.155.160	77	70571	70571	2021-12-04 08:09:15.4353
38	10010	98.249.155.160	77	70571	70571	2021-12-04 09:21:48.697514
39	10010	98.249.155.160	77	70571	70571	2021-12-04 09:24:47.655195
40	10010	98.249.155.160	77	70571	70571	2021-12-04 09:26:36.550377
41	10010	98.249.155.160	77	70571	70571	2021-12-04 10:06:17.621215
42	10010	98.249.155.160	77	70571	70571	2021-12-04 11:06:09.88406
43	10010	98.249.155.160	77	70571	70571	2021-12-04 11:08:09.712194
44	10010	98.249.155.160	77	70571	70571	2021-12-04 11:17:19.683738
45	10010	98.249.155.160	77	70571	70571	2021-12-04 11:25:47.293593
46	10010	98.249.155.160	77	70571	70571	2021-12-04 11:33:57.319182
47	10010	98.249.155.160	77	70571	70571	2021-12-04 11:58:10.557772
48	10010	98.249.155.160	77	70571	70571	2021-12-04 12:08:05.012997
49	10010	98.249.155.160	77	70571	70571	2021-12-04 20:15:02.656413
50	10010	98.249.155.160	77	70571	70571	2021-12-04 20:16:39.884811
51	10010	98.249.155.160	77	70571	70571	2021-12-05 00:05:10.196744
52	10010	98.249.155.160	77	70571	70571	2021-12-05 00:21:28.7087
53	10010	98.249.155.160	77	70571	70571	2021-12-05 00:25:20.843904
54	10010	98.249.155.160	77	70571	70571	2021-12-05 00:43:16.93077
55	10010	98.249.155.160	77	70571	70571	2021-12-05 03:14:30.98249
56	10010	98.249.155.160	77	70571	70571	2021-12-05 04:10:59.133097
57	10011	98.249.155.160	77	70571	70571	2021-12-05 04:38:51.711051
58	10011	98.249.155.160	77	70571	70571	2021-12-05 04:51:27.319603
59	10010	98.249.155.160	77	70571	70571	2021-12-05 04:52:06.886521
60	10010	98.249.155.160	77	70571	70571	2021-12-05 06:02:19.221189
61	10010	98.249.155.160	77	70571	70571	2021-12-05 06:15:51.167762
62	10010	98.249.155.160	77	70571	70571	2021-12-05 06:20:01.941333
63	10010	98.249.155.160	77	70571	70571	2021-12-05 06:30:54.577823
64	10010	98.249.155.160	77	70571	70571	2021-12-05 06:36:51.520269
65	10010	98.249.155.160	77	70571	70571	2021-12-05 06:37:24.991926
66	10010	98.249.155.160	77	70571	70571	2021-12-05 06:42:46.918004
67	10010	98.249.155.160	77	70571	70571	2021-12-05 06:43:54.449664
68	10010	98.249.155.160	77	70571	70571	2021-12-05 06:54:11.564061
69	10010	98.249.155.160	77	70571	70571	2021-12-05 06:56:09.640717
70	10010	98.249.155.160	77	70571	70571	2021-12-05 07:05:08.687911
71	10010	98.249.155.160	77	70571	70571	2021-12-05 07:22:00.467863
72	10010	98.249.155.160	77	70571	70571	2021-12-05 07:32:37.745084
73	10010	98.249.155.160	77	70571	70571	2021-12-05 07:34:17.957397
74	10010	98.249.155.160	77	70571	70571	2021-12-05 07:36:23.018917
75	10010	98.249.155.160	77	70571	70571	2021-12-05 07:38:52.233225
76	10010	98.249.155.160	77	70571	70571	2021-12-05 07:39:02.773458
77	10010	98.249.155.160	77	70571	70571	2021-12-05 07:57:47.907429
78	10010	98.249.155.160	77	70571	70571	2021-12-05 08:00:57.242214
79	10010	98.249.155.160	77	70571	70571	2021-12-05 08:03:44.303781
80	10010	98.249.155.160	77	70571	70571	2021-12-05 08:06:27.659159
81	10010	98.249.155.160	77	70571	70571	2021-12-05 08:19:42.603514
82	10010	98.249.155.160	77	70571	70571	2021-12-05 08:21:26.055102
83	10010	98.249.155.160	77	70571	70571	2021-12-05 08:30:42.774258
84	10010	98.249.155.160	77	70571	70571	2021-12-05 08:36:42.271855
85	10010	98.249.155.160	77	70571	70571	2021-12-05 08:48:41.49006
86	10010	98.249.155.160	77	70571	70571	2021-12-05 09:06:35.486483
87	10010	98.249.155.160	77	70571	70571	2021-12-05 09:10:23.294071
88	10010	98.249.155.160	77	70571	70571	2021-12-05 09:19:48.903602
89	10010	98.249.155.160	77	70571	70571	2021-12-06 00:55:35.982797
90	10010	98.249.155.160	77	70571	70571	2021-12-06 01:01:20.076582
91	10010	98.249.155.160	77	70571	70571	2021-12-06 01:23:50.504842
92	10010	98.249.155.160	77	70571	70571	2021-12-06 01:47:26.059198
93	10010	98.249.155.160	77	70571	70571	2021-12-06 02:03:56.788327
94	10010	98.249.155.160	77	70571	70571	2021-12-06 02:51:07.998806
95	10010	98.249.155.160	77	70571	70571	2021-12-06 02:52:51.64598
96	10010	98.249.155.160	77	70571	70571	2021-12-06 02:54:44.650067
97	10010	98.249.155.160	77	70571	70571	2021-12-06 02:58:18.611939
98	10010	98.249.155.160	77	70571	70571	2021-12-06 03:00:52.748349
99	10010	98.249.155.160	77	70571	70571	2021-12-06 03:03:32.173589
100	10010	98.249.155.160	77	70571	70571	2021-12-06 03:06:48.714386
101	10010	98.249.155.160	77	70571	70571	2021-12-06 03:11:27.822204
102	10010	98.249.155.160	77	70571	70571	2021-12-06 03:14:18.34746
103	10010	98.249.155.160	77	70571	70571	2021-12-06 03:15:13.673136
104	10010	98.249.155.160	77	70571	70571	2021-12-06 03:18:02.918333
105	10010	98.249.155.160	77	70571	70571	2021-12-06 03:20:19.512336
106	10010	98.249.155.160	77	70571	70571	2021-12-06 03:23:38.531234
107	10010	98.249.155.160	77	70571	70571	2021-12-06 03:27:37.359904
108	10010	98.249.155.160	77	70571	70571	2021-12-06 03:35:18.535412
109	10010	98.249.155.160	77	70571	70571	2021-12-06 03:41:14.791885
110	10010	98.249.155.160	77	70571	70571	2021-12-06 03:47:37.686819
111	10010	98.249.155.160	77	70571	70571	2021-12-06 03:50:18.648333
112	10010	98.249.155.160	77	70571	70571	2021-12-06 03:55:08.890047
113	10010	98.249.155.160	77	70571	70571	2021-12-06 04:01:13.568881
114	10010	98.249.155.160	77	70571	70571	2021-12-06 04:02:02.252098
115	10010	98.249.155.160	77	70571	70571	2021-12-06 04:06:30.095331
116	10010	98.249.155.160	77	70571	70571	2021-12-06 04:15:21.266012
117	10011	98.249.155.160	77	70571	70571	2021-12-06 04:16:06.721362
118	10010	98.249.155.160	77	70571	70571	2021-12-06 04:20:31.009309
119	10011	98.249.155.160	77	70571	70571	2021-12-06 04:20:31.444206
120	10010	98.249.155.160	77	70571	70571	2021-12-06 04:23:29.083657
121	10011	98.249.155.160	77	70571	70571	2021-12-06 04:23:31.984596
122	10010	98.249.155.160	77	70571	70571	2021-12-06 04:53:17.53007
123	10011	98.249.155.160	77	70571	70571	2021-12-06 04:53:18.133678
124	10010	98.249.155.160	77	70571	70571	2021-12-06 04:58:55.087972
125	10011	98.249.155.160	77	70571	70571	2021-12-06 04:58:55.704131
126	10011	98.249.155.160	77	70571	70571	2021-12-06 05:01:36.687213
127	10011	98.249.155.160	77	70571	70571	2021-12-06 05:08:28.415437
128	10010	98.249.155.160	77	70571	70571	2021-12-06 05:08:29.329845
129	10011	98.249.155.160	77	70571	70571	2021-12-06 05:16:08.302496
130	10010	98.249.155.160	77	70571	70571	2021-12-06 05:16:09.056108
131	10011	98.249.155.160	77	70571	70571	2021-12-06 05:38:55.746898
132	10010	98.249.155.160	77	70571	70571	2021-12-06 05:39:04.78985
133	10011	98.249.155.160	77	70571	70571	2021-12-06 05:42:14.622883
134	10010	98.249.155.160	77	70571	70571	2021-12-06 05:42:18.940789
135	10011	98.249.155.160	77	70571	70571	2021-12-06 05:47:12.002858
136	10010	98.249.155.160	77	70571	70571	2021-12-06 05:47:15.578892
137	10011	98.249.155.160	77	70571	70571	2021-12-06 05:50:29.92093
138	10010	98.249.155.160	77	70571	70571	2021-12-06 05:50:34.069644
139	10010	98.249.155.160	77	70571	70571	2021-12-06 05:55:40.70067
140	10011	98.249.155.160	77	70571	70571	2021-12-06 05:55:50.226038
141	10011	98.249.155.160	77	70571	70571	2021-12-06 06:20:10.572977
142	10010	98.249.155.160	77	70571	70571	2021-12-06 06:20:11.252143
143	10011	98.249.155.160	77	70571	70571	2021-12-06 06:23:44.042495
144	10010	98.249.155.160	77	70571	70571	2021-12-06 06:24:02.076696
145	10011	98.249.155.160	77	70571	70571	2021-12-06 06:30:36.549338
146	10010	98.249.155.160	77	70571	70571	2021-12-06 06:30:42.699445
147	10011	98.249.155.160	77	70571	70571	2021-12-06 06:33:26.922622
148	10010	98.249.155.160	77	70571	70571	2021-12-06 06:33:36.990784
149	10011	98.249.155.160	77	70571	70571	2021-12-06 06:42:10.112151
150	10010	98.249.155.160	77	70571	70571	2021-12-06 06:42:20.430362
151	10011	98.249.155.160	77	70571	70571	2021-12-06 06:57:34.873424
152	10010	98.249.155.160	77	70571	70571	2021-12-06 06:57:40.243027
153	10011	98.249.155.160	77	70571	70571	2021-12-06 07:15:21.117599
154	10010	98.249.155.160	77	70571	70571	2021-12-06 07:15:21.160568
155	10011	98.249.155.160	77	70571	70571	2021-12-06 07:24:56.920984
156	10010	98.249.155.160	77	70571	70571	2021-12-06 07:26:03.743489
157	10011	98.249.155.160	77	70571	70571	2021-12-06 07:32:48.627797
158	10010	98.249.155.160	77	70571	70571	2021-12-06 07:32:59.035535
159	10010	98.249.155.160	77	70571	70571	2021-12-06 08:21:49.42438
160	10010	98.249.155.160	77	70571	70571	2021-12-06 08:24:13.080224
161	10011	98.249.155.160	77	70571	70571	2021-12-06 08:25:17.84388
162	10010	98.249.155.160	77	70571	70571	2021-12-06 08:29:35.556345
163	10011	98.249.155.160	77	70571	70571	2021-12-06 08:29:56.822989
164	10010	98.249.155.160	77	70571	70571	2021-12-07 19:19:48.651169
165	10010	98.249.155.160	77	70571	70571	2021-12-07 19:25:24.503461
166	10010	73.85.65.26	77	70571	70571	2022-04-05 17:38:00.81122
\.


--
-- Data for Name: player_mecha_colors; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_mecha_colors (id, player_id, mecha_color_id, status) FROM stdin;
71	10011	0	4
72	10011	1	4
73	10011	3	4
74	10011	4	4
75	10011	8	4
76	10011	14	4
77	10011	19	4
78	10011	25	4
79	10011	26	4
80	10011	28	4
81	10011	29	4
82	10011	31	4
83	10011	32	4
84	10011	33	4
29	10010	0	4
30	10010	1	4
31	10010	3	4
32	10010	4	4
33	10010	8	4
34	10010	14	4
35	10010	19	4
36	10010	25	4
37	10010	26	4
38	10010	28	4
39	10010	29	4
40	10010	31	4
41	10010	32	4
42	10010	33	4
\.


--
-- Data for Name: player_mecha_set_parts; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_mecha_set_parts (id, player_id, mecha_set_id, part_id, mecha_id, design_id, color_id) FROM stdin;
561	10011	1001	1	1	1	0
562	10011	1001	2	1	1	0
563	10011	1001	3	1	1	0
564	10011	1001	4	1	1	0
565	10011	1001	5	1	1	0
566	10011	2002	1	2	2	0
567	10011	2002	2	2	2	0
568	10011	2002	3	2	2	0
569	10011	2002	4	2	2	0
570	10011	2002	5	2	2	0
571	10011	3003	1	3	3	0
572	10011	3003	2	3	3	0
211	10010	1001	1	1	1	0
212	10010	1001	2	1	1	0
213	10010	1001	3	1	1	0
214	10010	1001	4	1	1	0
215	10010	1001	5	1	1	0
216	10010	2002	1	2	2	0
217	10010	2002	2	2	2	0
218	10010	2002	3	2	2	0
219	10010	2002	4	2	2	0
220	10010	2002	5	2	2	0
221	10010	3003	1	3	3	0
222	10010	3003	2	3	3	0
223	10010	3003	3	3	3	0
224	10010	3003	4	3	3	0
247	10010	8008	2	8	8	0
248	10010	8008	3	8	8	0
249	10010	8008	4	8	8	0
250	10010	8008	5	8	8	0
251	10010	9009	1	9	9	0
252	10010	9009	2	9	9	0
253	10010	9009	3	9	9	0
254	10010	9009	4	9	9	0
255	10010	9009	5	9	9	0
256	10010	10010	1	10	10	0
257	10010	10010	2	10	10	0
258	10010	10010	3	10	10	0
259	10010	10010	4	10	10	0
260	10010	10010	5	10	10	0
261	10010	11011	1	11	11	0
262	10010	11011	2	11	11	0
263	10010	11011	3	11	11	0
264	10010	11011	4	11	11	0
265	10010	11011	5	11	11	0
266	10010	12012	1	12	12	0
267	10010	12012	2	12	12	0
268	10010	12012	3	12	12	0
269	10010	12012	4	12	12	0
270	10010	12012	5	12	12	0
271	10010	13013	1	13	13	0
272	10010	13013	2	13	13	0
273	10010	13013	3	13	13	0
274	10010	13013	4	13	13	0
275	10010	13013	5	13	13	0
276	10010	14014	1	14	14	0
277	10010	14014	2	14	14	0
278	10010	14014	3	14	14	0
573	10011	3003	3	3	3	0
574	10011	3003	4	3	3	0
575	10011	3003	5	3	3	0
576	10011	4004	1	4	4	0
577	10011	4004	2	4	4	0
578	10011	4004	3	4	4	0
579	10011	4004	4	4	4	0
580	10011	4004	5	4	4	0
581	10011	5005	1	5	5	0
582	10011	5005	2	5	5	0
583	10011	5005	3	5	5	0
584	10011	5005	4	5	5	0
585	10011	5005	5	5	5	0
586	10011	6006	1	6	6	0
587	10011	6006	2	6	6	0
225	10010	3003	5	3	3	0
226	10010	4004	1	4	4	0
227	10010	4004	2	4	4	0
228	10010	4004	3	4	4	0
229	10010	4004	4	4	4	0
230	10010	4004	5	4	4	0
231	10010	5005	1	5	5	0
232	10010	5005	2	5	5	0
233	10010	5005	3	5	5	0
234	10010	5005	4	5	5	0
235	10010	5005	5	5	5	0
236	10010	6006	1	6	6	0
237	10010	6006	2	6	6	0
238	10010	6006	3	6	6	0
239	10010	6006	4	6	6	0
240	10010	6006	5	6	6	0
241	10010	7007	1	7	7	0
242	10010	7007	2	7	7	0
243	10010	7007	3	7	7	0
244	10010	7007	4	7	7	0
245	10010	7007	5	7	7	0
246	10010	8008	1	8	8	0
279	10010	14014	4	14	14	0
280	10010	14014	5	14	14	0
588	10011	6006	3	6	6	0
589	10011	6006	4	6	6	0
590	10011	6006	5	6	6	0
591	10011	7007	1	7	7	0
592	10011	7007	2	7	7	0
593	10011	7007	3	7	7	0
594	10011	7007	4	7	7	0
595	10011	7007	5	7	7	0
596	10011	8008	1	8	8	0
597	10011	8008	2	8	8	0
598	10011	8008	3	8	8	0
599	10011	8008	4	8	8	0
600	10011	8008	5	8	8	0
601	10011	9009	1	9	9	0
602	10011	9009	2	9	9	0
603	10011	9009	3	9	9	0
604	10011	9009	4	9	9	0
605	10011	9009	5	9	9	0
606	10011	10010	1	10	10	0
607	10011	10010	2	10	10	0
608	10011	10010	3	10	10	0
609	10011	10010	4	10	10	0
610	10011	10010	5	10	10	0
611	10011	11011	1	11	11	0
612	10011	11011	2	11	11	0
613	10011	11011	3	11	11	0
614	10011	11011	4	11	11	0
615	10011	11011	5	11	11	0
616	10011	12012	1	12	12	0
617	10011	12012	2	12	12	0
618	10011	12012	3	12	12	0
619	10011	12012	4	12	12	0
620	10011	12012	5	12	12	0
621	10011	13013	1	13	13	0
622	10011	13013	2	13	13	0
623	10011	13013	3	13	13	0
624	10011	13013	4	13	13	0
625	10011	13013	5	13	13	0
626	10011	14014	1	14	14	0
627	10011	14014	2	14	14	0
628	10011	14014	3	14	14	0
629	10011	14014	4	14	14	0
630	10011	14014	5	14	14	0
\.


--
-- Data for Name: player_mecha_sets; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_mecha_sets (id, player_id, mecha_set_id, mecha_setbonus_id, weapon_set_id, is_decal, favorite, use_count, use_time, status, win_count, winning_streaks) FROM stdin;
43	10010	1001	1	100	f	f	0	0	4	\N	\N
44	10010	2002	1	200	f	f	0	0	2	\N	\N
45	10010	3003	1	300	f	f	0	0	2	\N	\N
46	10010	4004	1	400	f	f	0	0	4	\N	\N
47	10010	5005	1	500	f	f	0	0	4	\N	\N
48	10010	6006	1	600	f	f	0	0	4	\N	\N
49	10010	7007	1	700	f	f	0	0	2	\N	\N
50	10010	8008	1	800	f	f	0	0	4	\N	\N
51	10010	9009	1	900	f	f	0	0	2	\N	\N
52	10010	10010	1	1000	f	f	0	0	2	\N	\N
53	10010	11011	1	1100	f	f	0	0	4	\N	\N
54	10010	12012	1	1200	f	f	0	0	2	\N	\N
55	10010	13013	1	1300	f	f	0	0	4	\N	\N
56	10010	14014	1	1400	f	f	0	0	4	\N	\N
113	10011	1001	1	100	f	f	0	0	4	\N	\N
114	10011	2002	1	200	f	f	0	0	2	\N	\N
115	10011	3003	1	300	f	f	0	0	2	\N	\N
116	10011	4004	1	400	f	f	0	0	2	\N	\N
117	10011	5005	1	500	f	f	0	0	2	\N	\N
118	10011	6006	1	600	f	f	0	0	2	\N	\N
119	10011	7007	1	700	f	f	0	0	2	\N	\N
120	10011	8008	1	800	f	f	0	0	2	\N	\N
121	10011	9009	1	900	f	f	0	0	2	\N	\N
122	10011	10010	1	1000	f	f	0	0	2	\N	\N
123	10011	11011	1	1100	f	f	0	0	2	\N	\N
124	10011	12012	1	1200	f	f	0	0	2	\N	\N
125	10011	13013	1	1300	f	f	0	0	2	\N	\N
126	10011	14014	1	1400	f	f	0	0	2	\N	\N
\.


--
-- Data for Name: player_missions; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_missions (id, player_id, mission_id, clear_count, clear_num, status, mission_status) FROM stdin;
1381	10010	135003	0	2	0	201
1382	10010	136001	0	6	4	400
1400	10010	140003	0	0	0	201
1401	10010	205001	0	0	0	201
1402	10010	205002	0	0	0	201
1393	10010	138005	0	4	0	201
1394	10010	139001	0	1	0	201
1395	10010	139002	0	1	0	201
1396	10010	139003	0	1	0	201
1356	10010	126001	0	583	0	201
1357	10010	126002	0	583	0	201
1358	10010	126003	0	583	0	201
1359	10010	127001	0	4	0	201
1360	10010	127002	0	4	0	201
1361	10010	127003	0	4	0	201
1362	10010	128001	0	3	0	201
1363	10010	128002	0	3	0	201
1364	10010	128003	0	3	0	201
1365	10010	128004	0	3	0	201
1413	10010	207001	0	0	0	201
1414	10010	207002	0	0	0	201
1415	10010	207003	0	0	0	201
1416	10010	211001	0	1	4	400
1387	10010	137003	0	583	0	201
1388	10010	137004	0	583	0	201
1389	10010	138001	0	4	0	201
1390	10010	138002	0	4	0	201
1391	10010	138003	0	4	0	201
1392	10010	138004	0	4	0	201
1479	10010	98002	0	0	0	201
1480	10010	98003	0	0	0	201
1481	10010	98004	0	0	0	201
1482	10010	104001	0	0	0	201
1483	10010	104002	0	0	0	201
1478	10010	98001	0	0	0	201
1383	10010	136002	0	23	4	400
1384	10010	136003	0	36	0	201
1385	10010	137001	0	583	0	201
1386	10010	137002	0	583	0	201
1397	10010	139004	0	1	0	201
1398	10010	140001	0	0	0	201
1399	10010	140002	0	0	0	201
1366	10010	128005	0	3	4	201
1367	10010	129001	0	1	4	201
1368	10010	129002	0	1	4	201
1369	10010	129003	0	1	0	201
1370	10010	129004	0	1	0	201
1371	10010	129005	0	1	0	201
1372	10010	130001	0	25612	0	201
1373	10010	130002	0	25612	0	201
1374	10010	130003	0	25612	0	201
1375	10010	130004	0	25612	0	201
1403	10010	205003	0	0	4	201
1404	10010	205004	0	0	0	201
1405	10010	205005	0	0	0	201
1406	10010	205006	0	0	0	201
1407	10010	205007	0	0	0	201
1408	10010	206001	0	1	0	201
1484	10010	141001	0	0	0	201
1485	10010	141002	0	0	0	201
1486	10010	141003	0	0	0	201
1487	10010	141004	0	0	0	201
1488	10010	142001	0	0	0	201
1489	10010	142002	0	0	0	201
1490	10010	142003	0	0	0	201
1491	10010	142004	0	0	0	201
1409	10010	206002	0	1	0	201
1410	10010	206003	0	1	0	201
1411	10010	206004	0	1	0	201
1412	10010	206005	0	1	0	201
1376	10010	131001	0	4	0	201
1377	10010	131002	0	4	0	201
1378	10010	131003	0	4	0	201
1379	10010	135001	0	2	0	201
1380	10010	135002	0	2	0	201
1492	10010	142005	0	0	0	201
1493	10010	143001	0	0	0	201
1494	10010	143002	0	0	0	201
1495	10010	143003	0	0	0	201
1496	10010	143004	0	0	0	201
1497	10010	144001	0	0	0	201
1498	10010	144002	0	0	0	201
1499	10010	144003	0	0	0	201
1500	10010	145001	0	0	0	201
1501	10010	145002	0	0	0	201
1502	10010	145003	0	0	0	201
1503	10010	145004	0	0	0	201
1504	10010	146001	0	0	0	201
1505	10010	146002	0	0	0	201
1506	10010	146003	0	0	0	201
1507	10010	146004	0	0	0	201
1508	10010	146005	0	0	0	201
1509	10010	147001	0	0	0	201
1510	10010	147002	0	0	0	201
1511	10010	147003	0	0	0	201
1512	10010	147004	0	0	0	201
1513	10010	148001	0	0	0	201
1514	10010	148002	0	0	0	201
1515	10010	148003	0	0	0	201
1516	10010	149001	0	0	0	201
1517	10010	149002	0	0	0	201
1518	10010	149003	0	0	0	201
1519	10010	149004	0	0	0	201
1520	10010	150001	0	0	0	201
1521	10010	150002	0	0	0	201
1522	10010	150003	0	0	0	201
1523	10010	150004	0	0	0	201
1524	10010	150005	0	0	0	201
1525	10010	151001	0	0	0	201
1526	10010	151002	0	0	0	201
1527	10010	151003	0	0	0	201
1528	10010	151004	0	0	0	201
1529	10010	152001	0	0	0	201
1530	10010	152002	0	0	0	201
1531	10010	152003	0	0	0	201
1532	10010	153001	0	0	0	201
1533	10010	153002	0	0	0	201
1534	10010	153003	0	0	0	201
1535	10010	153004	0	0	0	201
1536	10010	154001	0	0	0	201
1537	10010	154002	0	0	0	201
1538	10010	154003	0	0	0	201
1539	10010	154004	0	0	0	201
1540	10010	154005	0	0	0	201
1541	10010	155001	0	0	0	201
1542	10010	155002	0	0	0	201
1543	10010	155003	0	0	0	201
1544	10010	155004	0	0	0	201
1545	10010	156001	0	0	0	201
1546	10010	156002	0	0	0	201
1547	10010	156003	0	0	0	201
1548	10010	157001	0	0	0	201
1549	10010	157002	0	0	0	201
1550	10010	157003	0	0	0	201
1551	10010	157004	0	0	0	201
1552	10010	158001	0	0	0	201
1553	10010	158002	0	0	0	201
1554	10010	158003	0	0	0	201
1555	10010	158004	0	0	0	201
1556	10010	158005	0	0	0	201
1557	10010	159001	0	0	0	201
1558	10010	159002	0	0	0	201
1559	10010	159003	0	0	0	201
1560	10010	159004	0	0	0	201
1561	10010	160001	0	0	0	201
1562	10010	160002	0	0	0	201
1563	10010	160003	0	0	0	201
1564	10010	161001	0	0	0	201
1565	10010	161002	0	0	0	201
1566	10010	161003	0	0	0	201
1567	10010	161004	0	0	0	201
1568	10010	162001	0	0	0	201
1569	10010	162002	0	0	0	201
1570	10010	162003	0	0	0	201
1571	10010	162004	0	0	0	201
1572	10010	162005	0	0	0	201
1573	10010	163001	0	0	0	201
1574	10010	163002	0	0	0	201
1575	10010	163003	0	0	0	201
1576	10010	163004	0	0	0	201
1577	10010	164001	0	0	0	201
1578	10010	164002	0	0	0	201
1579	10010	164003	0	0	0	201
1580	10010	165001	0	0	0	201
1581	10010	165002	0	0	0	201
1582	10010	165003	0	0	0	201
1583	10010	165004	0	0	0	201
1584	10010	166001	0	0	0	201
1585	10010	166002	0	0	0	201
1586	10010	166003	0	0	0	201
1587	10010	166004	0	0	0	201
1588	10010	166005	0	0	0	201
1589	10010	167001	0	0	0	201
1590	10010	167002	0	0	0	201
1591	10010	167003	0	0	0	201
1592	10010	167004	0	0	0	201
1593	10010	168001	0	0	0	201
1594	10010	168002	0	0	0	201
1595	10010	168003	0	0	0	201
1596	10010	169001	0	0	0	201
1597	10010	169002	0	0	0	201
1598	10010	169003	0	0	0	201
1599	10010	169004	0	0	0	201
1600	10010	170001	0	0	0	201
1601	10010	170002	0	0	0	201
1602	10010	170003	0	0	0	201
1603	10010	170004	0	0	0	201
1604	10010	170005	0	0	0	201
1605	10010	171001	0	0	0	201
1606	10010	171002	0	0	0	201
1607	10010	171003	0	0	0	201
1608	10010	171004	0	0	0	201
1609	10010	172001	0	0	0	201
1610	10010	172002	0	0	0	201
1611	10010	172003	0	0	0	201
1612	10010	173001	0	0	0	201
1613	10010	173002	0	0	0	201
1614	10010	173003	0	0	0	201
1615	10010	173004	0	0	0	201
1616	10010	174001	0	0	0	201
1617	10010	174002	0	0	0	201
1618	10010	174003	0	0	0	201
1619	10010	174004	0	0	0	201
1620	10010	174005	0	0	0	201
1621	10010	175001	0	0	0	201
1622	10010	175002	0	0	0	201
1623	10010	175003	0	0	0	201
1624	10010	175004	0	0	0	201
1625	10010	176001	0	0	0	201
1626	10010	176002	0	0	0	201
1627	10010	176003	0	0	0	201
1628	10010	177001	0	0	0	201
1629	10010	177002	0	0	0	201
1630	10010	177003	0	0	0	201
1631	10010	177004	0	0	0	201
1632	10010	178001	0	0	0	201
1633	10010	178002	0	0	0	201
1634	10010	178003	0	0	0	201
1635	10010	178004	0	0	0	201
1636	10010	178005	0	0	0	201
1637	10010	179001	0	0	0	201
1638	10010	179002	0	0	0	201
1639	10010	179003	0	0	0	201
1640	10010	179004	0	0	0	201
1641	10010	180001	0	0	0	201
1642	10010	180002	0	0	0	201
1643	10010	180003	0	0	0	201
1644	10010	181001	0	0	0	201
1645	10010	181002	0	0	0	201
1646	10010	181003	0	0	0	201
1647	10010	181004	0	0	0	201
1648	10010	182001	0	0	0	201
1649	10010	182002	0	0	0	201
1650	10010	182003	0	0	0	201
1651	10010	182004	0	0	0	201
1652	10010	182005	0	0	0	201
1653	10010	183001	0	0	0	201
1654	10010	183002	0	0	0	201
1655	10010	183003	0	0	0	201
1656	10010	183004	0	0	0	201
1657	10010	184001	0	0	0	201
1658	10010	184002	0	0	0	201
1659	10010	184003	0	0	0	201
1660	10010	185001	0	0	0	201
1661	10010	185002	0	0	0	201
1662	10010	185003	0	0	0	201
1663	10010	185004	0	0	0	201
1664	10010	186001	0	0	0	201
1665	10010	186002	0	0	0	201
1666	10010	186003	0	0	0	201
1667	10010	186004	0	0	0	201
1668	10010	186005	0	0	0	201
1669	10010	187001	0	0	0	201
1670	10010	187002	0	0	0	201
1671	10010	187003	0	0	0	201
1672	10010	187004	0	0	0	201
1673	10010	188001	0	0	0	201
1674	10010	188002	0	0	0	201
1675	10010	188003	0	0	0	201
1676	10010	189001	0	0	0	201
1677	10010	189002	0	0	0	201
1678	10010	189003	0	0	0	201
1679	10010	189004	0	0	0	201
1680	10010	190001	0	0	0	201
1681	10010	190002	0	0	0	201
1682	10010	190003	0	0	0	201
1683	10010	190004	0	0	0	201
1684	10010	190005	0	0	0	201
1685	10010	191001	0	0	0	201
1686	10010	191002	0	0	0	201
1687	10010	191003	0	0	0	201
1688	10010	191004	0	0	0	201
1689	10010	192001	0	0	0	201
1690	10010	192002	0	0	0	201
1691	10010	192003	0	0	0	201
1692	10010	193001	0	0	0	201
1693	10010	193002	0	0	0	201
1694	10010	193003	0	0	0	201
1695	10010	193004	0	0	0	201
1696	10010	193005	0	0	0	201
1697	10010	193006	0	0	0	201
1698	10010	193007	0	0	0	201
1699	10010	194001	0	0	0	201
1700	10010	194002	0	0	0	201
1701	10010	194003	0	0	0	201
1702	10010	194004	0	0	0	201
1703	10010	194005	0	0	0	201
1704	10010	195001	0	0	0	201
1705	10010	195002	0	0	0	201
1706	10010	195003	0	0	0	201
1707	10010	196001	0	0	0	201
1708	10010	196002	0	0	0	201
1709	10010	196003	0	0	0	201
1710	10010	196004	0	0	0	201
1711	10010	196005	0	0	0	201
1712	10010	196006	0	0	0	201
1713	10010	196007	0	0	0	201
1714	10010	197001	0	0	0	201
1715	10010	197002	0	0	0	201
1716	10010	197003	0	0	0	201
1717	10010	197004	0	0	0	201
1718	10010	197005	0	0	0	201
1719	10010	198001	0	0	0	201
1720	10010	198002	0	0	0	201
1721	10010	198003	0	0	0	201
1722	10010	199001	0	0	0	201
1723	10010	199002	0	0	0	201
1724	10010	199003	0	0	0	201
1725	10010	199004	0	0	0	201
1726	10010	199005	0	0	0	201
1727	10010	199006	0	0	0	201
1728	10010	199007	0	0	0	201
1729	10010	200001	0	0	0	201
1730	10010	200002	0	0	0	201
1731	10010	200003	0	0	0	201
1732	10010	200004	0	0	0	201
1733	10010	200005	0	0	0	201
1734	10010	201001	0	0	0	201
1735	10010	201002	0	0	0	201
1736	10010	201003	0	0	0	201
1737	10010	202001	0	0	0	201
1738	10010	202002	0	0	0	201
1739	10010	202003	0	0	0	201
1740	10010	202004	0	0	0	201
1741	10010	202005	0	0	0	201
1742	10010	202006	0	0	0	201
1743	10010	202007	0	0	0	201
1744	10010	203001	0	0	0	201
1745	10010	203002	0	0	0	201
1746	10010	203003	0	0	0	201
1747	10010	203004	0	0	0	201
1748	10010	203005	0	0	0	201
1749	10010	204001	0	0	0	201
1750	10010	204002	0	0	0	201
1751	10010	204003	0	0	0	201
1752	10010	208001	0	0	0	201
1753	10010	208002	0	0	0	201
1754	10010	208003	0	0	0	201
1755	10010	208004	0	0	0	201
1756	10010	208005	0	0	0	201
1757	10010	208006	0	0	0	201
1758	10010	208007	0	0	0	201
1759	10010	209001	0	0	0	201
1760	10010	209002	0	0	0	201
1761	10010	209003	0	0	0	201
1762	10010	209004	0	0	0	201
1763	10010	209005	0	0	0	201
1764	10010	210001	0	0	0	201
1765	10010	210002	0	0	0	201
1766	10010	210003	0	0	0	201
1767	10009	210003	0	0	0	0
2201	10011	126001	0	0	0	201
2202	10011	126002	0	0	0	201
2203	10011	126003	0	0	0	201
2204	10011	127001	0	0	0	201
2205	10011	127002	0	0	0	201
2206	10011	127003	0	0	0	201
2207	10011	128001	0	0	0	201
2208	10011	128002	0	0	0	201
2209	10011	128003	0	0	0	201
2210	10011	128004	0	0	0	201
2211	10011	128005	0	0	0	201
2212	10011	129001	0	0	0	201
2213	10011	129002	0	0	0	201
2214	10011	129003	0	0	0	201
2215	10011	129004	0	0	0	201
2216	10011	129005	0	0	0	201
2217	10011	130001	0	0	0	201
2218	10011	130002	0	0	0	201
2219	10011	130003	0	0	0	201
2220	10011	130004	0	0	0	201
2221	10011	131001	0	0	0	201
2222	10011	131002	0	0	0	201
2223	10011	131003	0	0	0	201
2224	10011	135001	0	0	0	201
2225	10011	135002	0	0	0	201
2226	10011	135003	0	0	0	201
2227	10011	136001	0	0	0	201
2228	10011	136002	0	0	0	201
2229	10011	136003	0	0	0	201
2230	10011	137001	0	0	0	201
2231	10011	137002	0	0	0	201
2232	10011	137003	0	0	0	201
2233	10011	137004	0	0	0	201
2234	10011	138001	0	0	0	201
2235	10011	138002	0	0	0	201
2236	10011	138003	0	0	0	201
2237	10011	138004	0	0	0	201
2238	10011	138005	0	0	0	201
2239	10011	139001	0	0	0	201
2240	10011	139002	0	0	0	201
2241	10011	139003	0	0	0	201
2242	10011	139004	0	0	0	201
2243	10011	140001	0	0	0	201
2244	10011	140002	0	0	0	201
2245	10011	140003	0	0	0	201
2246	10011	141001	0	0	0	201
2247	10011	141002	0	0	0	201
2248	10011	141003	0	0	0	201
2249	10011	141004	0	0	0	201
2250	10011	142001	0	0	0	201
2251	10011	142002	0	0	0	201
2252	10011	142003	0	0	0	201
2253	10011	142004	0	0	0	201
2254	10011	142005	0	0	0	201
2255	10011	143001	0	0	0	201
2256	10011	143002	0	0	0	201
2257	10011	143003	0	0	0	201
2258	10011	143004	0	0	0	201
2259	10011	144001	0	0	0	201
2260	10011	144002	0	0	0	201
2261	10011	144003	0	0	0	201
2262	10011	145001	0	0	0	201
2263	10011	145002	0	0	0	201
2264	10011	145003	0	0	0	201
2265	10011	145004	0	0	0	201
2266	10011	146001	0	0	0	201
2267	10011	146002	0	0	0	201
2268	10011	146003	0	0	0	201
2269	10011	146004	0	0	0	201
2270	10011	146005	0	0	0	201
2271	10011	147001	0	0	0	201
2272	10011	147002	0	0	0	201
2273	10011	147003	0	0	0	201
2274	10011	147004	0	0	0	201
2275	10011	148001	0	0	0	201
2276	10011	148002	0	0	0	201
2277	10011	148003	0	0	0	201
2278	10011	149001	0	0	0	201
2279	10011	149002	0	0	0	201
2280	10011	149003	0	0	0	201
2281	10011	149004	0	0	0	201
2282	10011	150001	0	0	0	201
2283	10011	150002	0	0	0	201
2284	10011	150003	0	0	0	201
2285	10011	150004	0	0	0	201
2286	10011	150005	0	0	0	201
2287	10011	151001	0	0	0	201
2288	10011	151002	0	0	0	201
2289	10011	151003	0	0	0	201
2290	10011	151004	0	0	0	201
2291	10011	152001	0	0	0	201
2292	10011	152002	0	0	0	201
2293	10011	152003	0	0	0	201
2294	10011	153001	0	0	0	201
2295	10011	153002	0	0	0	201
2296	10011	153003	0	0	0	201
2297	10011	153004	0	0	0	201
2298	10011	154001	0	0	0	201
2299	10011	154002	0	0	0	201
2300	10011	154003	0	0	0	201
2301	10011	154004	0	0	0	201
2302	10011	154005	0	0	0	201
2303	10011	155001	0	0	0	201
2304	10011	155002	0	0	0	201
2305	10011	155003	0	0	0	201
2306	10011	155004	0	0	0	201
2307	10011	156001	0	0	0	201
2308	10011	156002	0	0	0	201
2309	10011	156003	0	0	0	201
2310	10011	157001	0	0	0	201
2311	10011	157002	0	0	0	201
2312	10011	157003	0	0	0	201
2313	10011	157004	0	0	0	201
2314	10011	158001	0	0	0	201
2315	10011	158002	0	0	0	201
2316	10011	158003	0	0	0	201
2317	10011	158004	0	0	0	201
2318	10011	158005	0	0	0	201
2319	10011	159001	0	0	0	201
2320	10011	159002	0	0	0	201
2321	10011	159003	0	0	0	201
2322	10011	159004	0	0	0	201
2323	10011	160001	0	0	0	201
2324	10011	160002	0	0	0	201
2325	10011	160003	0	0	0	201
2326	10011	161001	0	0	0	201
2196	10011	98002	0	0	0	201
2197	10011	98003	0	0	0	201
2199	10011	104001	0	0	0	201
2200	10011	104002	0	0	0	201
2327	10011	161002	0	0	0	201
2328	10011	161003	0	0	0	201
2329	10011	161004	0	0	0	201
2330	10011	162001	0	0	0	201
2331	10011	162002	0	0	0	201
2332	10011	162003	0	0	0	201
2333	10011	162004	0	0	0	201
2334	10011	162005	0	0	0	201
2335	10011	163001	0	0	0	201
2336	10011	163002	0	0	0	201
2337	10011	163003	0	0	0	201
2338	10011	163004	0	0	0	201
2339	10011	164001	0	0	0	201
2340	10011	164002	0	0	0	201
2341	10011	164003	0	0	0	201
2342	10011	165001	0	0	0	201
2343	10011	165002	0	0	0	201
2344	10011	165003	0	0	0	201
2345	10011	165004	0	0	0	201
2346	10011	166001	0	0	0	201
2347	10011	166002	0	0	0	201
2348	10011	166003	0	0	0	201
2349	10011	166004	0	0	0	201
2350	10011	166005	0	0	0	201
2351	10011	167001	0	0	0	201
2352	10011	167002	0	0	0	201
2353	10011	167003	0	0	0	201
2354	10011	167004	0	0	0	201
2355	10011	168001	0	0	0	201
2356	10011	168002	0	0	0	201
2357	10011	168003	0	0	0	201
2358	10011	169001	0	0	0	201
2359	10011	169002	0	0	0	201
2360	10011	169003	0	0	0	201
2361	10011	169004	0	0	0	201
2362	10011	170001	0	0	0	201
2363	10011	170002	0	0	0	201
2364	10011	170003	0	0	0	201
2365	10011	170004	0	0	0	201
2366	10011	170005	0	0	0	201
2367	10011	171001	0	0	0	201
2368	10011	171002	0	0	0	201
2369	10011	171003	0	0	0	201
2370	10011	171004	0	0	0	201
2371	10011	172001	0	0	0	201
2372	10011	172002	0	0	0	201
2373	10011	172003	0	0	0	201
2374	10011	173001	0	0	0	201
2375	10011	173002	0	0	0	201
2376	10011	173003	0	0	0	201
2377	10011	173004	0	0	0	201
2378	10011	174001	0	0	0	201
2379	10011	174002	0	0	0	201
2380	10011	174003	0	0	0	201
2381	10011	174004	0	0	0	201
2382	10011	174005	0	0	0	201
2383	10011	175001	0	0	0	201
2384	10011	175002	0	0	0	201
2385	10011	175003	0	0	0	201
2386	10011	175004	0	0	0	201
2387	10011	176001	0	0	0	201
2388	10011	176002	0	0	0	201
2389	10011	176003	0	0	0	201
2390	10011	177001	0	0	0	201
2391	10011	177002	0	0	0	201
2392	10011	177003	0	0	0	201
2393	10011	177004	0	0	0	201
2394	10011	178001	0	0	0	201
2395	10011	178002	0	0	0	201
2396	10011	178003	0	0	0	201
2397	10011	178004	0	0	0	201
2398	10011	178005	0	0	0	201
2399	10011	179001	0	0	0	201
2400	10011	179002	0	0	0	201
2401	10011	179003	0	0	0	201
2402	10011	179004	0	0	0	201
2403	10011	180001	0	0	0	201
2404	10011	180002	0	0	0	201
2405	10011	180003	0	0	0	201
2406	10011	181001	0	0	0	201
2407	10011	181002	0	0	0	201
2408	10011	181003	0	0	0	201
2409	10011	181004	0	0	0	201
2410	10011	182001	0	0	0	201
2411	10011	182002	0	0	0	201
2412	10011	182003	0	0	0	201
2413	10011	182004	0	0	0	201
2414	10011	182005	0	0	0	201
2415	10011	183001	0	0	0	201
2416	10011	183002	0	0	0	201
2417	10011	183003	0	0	0	201
2418	10011	183004	0	0	0	201
2419	10011	184001	0	0	0	201
2420	10011	184002	0	0	0	201
2421	10011	184003	0	0	0	201
2422	10011	185001	0	0	0	201
2423	10011	185002	0	0	0	201
2424	10011	185003	0	0	0	201
2425	10011	185004	0	0	0	201
2426	10011	186001	0	0	0	201
2427	10011	186002	0	0	0	201
2428	10011	186003	0	0	0	201
2429	10011	186004	0	0	0	201
2430	10011	186005	0	0	0	201
2431	10011	187001	0	0	0	201
2432	10011	187002	0	0	0	201
2433	10011	187003	0	0	0	201
2434	10011	187004	0	0	0	201
2435	10011	188001	0	0	0	201
2436	10011	188002	0	0	0	201
2437	10011	188003	0	0	0	201
2438	10011	189001	0	0	0	201
2439	10011	189002	0	0	0	201
2440	10011	189003	0	0	0	201
2441	10011	189004	0	0	0	201
2442	10011	190001	0	0	0	201
2443	10011	190002	0	0	0	201
2444	10011	190003	0	0	0	201
2445	10011	190004	0	0	0	201
2446	10011	190005	0	0	0	201
2447	10011	191001	0	0	0	201
2448	10011	191002	0	0	0	201
2449	10011	191003	0	0	0	201
2450	10011	191004	0	0	0	201
2451	10011	192001	0	0	0	201
2452	10011	192002	0	0	0	201
2453	10011	192003	0	0	0	201
2454	10011	193001	0	0	0	201
2455	10011	193002	0	0	0	201
2456	10011	193003	0	0	0	201
2457	10011	193004	0	0	0	201
2458	10011	193005	0	0	0	201
2459	10011	193006	0	0	0	201
2460	10011	193007	0	0	0	201
2461	10011	194001	0	0	0	201
2462	10011	194002	0	0	0	201
2463	10011	194003	0	0	0	201
2464	10011	194004	0	0	0	201
2465	10011	194005	0	0	0	201
2466	10011	195001	0	0	0	201
2467	10011	195002	0	0	0	201
2468	10011	195003	0	0	0	201
2469	10011	196001	0	0	0	201
2470	10011	196002	0	0	0	201
2471	10011	196003	0	0	0	201
2472	10011	196004	0	0	0	201
2473	10011	196005	0	0	0	201
2474	10011	196006	0	0	0	201
2475	10011	196007	0	0	0	201
2476	10011	197001	0	0	0	201
2477	10011	197002	0	0	0	201
2478	10011	197003	0	0	0	201
2479	10011	197004	0	0	0	201
2480	10011	197005	0	0	0	201
2481	10011	198001	0	0	0	201
2482	10011	198002	0	0	0	201
2483	10011	198003	0	0	0	201
2484	10011	199001	0	0	0	201
2485	10011	199002	0	0	0	201
2486	10011	199003	0	0	0	201
2487	10011	199004	0	0	0	201
2488	10011	199005	0	0	0	201
2489	10011	199006	0	0	0	201
2490	10011	199007	0	0	0	201
2491	10011	200001	0	0	0	201
2492	10011	200002	0	0	0	201
2493	10011	200003	0	0	0	201
2494	10011	200004	0	0	0	201
2495	10011	200005	0	0	0	201
2496	10011	201001	0	0	0	201
2497	10011	201002	0	0	0	201
2498	10011	201003	0	0	0	201
2499	10011	202001	0	0	0	201
2500	10011	202002	0	0	0	201
2501	10011	202003	0	0	0	201
2502	10011	202004	0	0	0	201
2503	10011	202005	0	0	0	201
2504	10011	202006	0	0	0	201
2505	10011	202007	0	0	0	201
2506	10011	203001	0	0	0	201
2507	10011	203002	0	0	0	201
2508	10011	203003	0	0	0	201
2509	10011	203004	0	0	0	201
2510	10011	203005	0	0	0	201
2511	10011	204001	0	0	0	201
2512	10011	204002	0	0	0	201
2513	10011	204003	0	0	0	201
2514	10011	205001	0	0	0	201
2515	10011	205002	0	0	0	201
2516	10011	205003	0	0	0	201
2517	10011	205004	0	0	0	201
2518	10011	205005	0	0	0	201
2519	10011	205006	0	0	0	201
2520	10011	205007	0	0	0	201
2521	10011	206001	0	0	0	201
2522	10011	206002	0	0	0	201
2523	10011	206003	0	0	0	201
2524	10011	206004	0	0	0	201
2525	10011	206005	0	0	0	201
2526	10011	207001	0	0	0	201
2527	10011	207002	0	0	0	201
2528	10011	207003	0	0	0	201
2529	10011	208001	0	0	0	201
2530	10011	208002	0	0	0	201
2531	10011	208003	0	0	0	201
2532	10011	208004	0	0	0	201
2533	10011	208005	0	0	0	201
2534	10011	208006	0	0	0	201
2535	10011	208007	0	0	0	201
2536	10011	209001	0	0	0	201
2537	10011	209002	0	0	0	201
2538	10011	209003	0	0	0	201
2539	10011	209004	0	0	0	201
2540	10011	209005	0	0	0	201
2541	10011	210001	0	0	0	201
2542	10011	210002	0	0	0	201
2543	10011	210003	0	0	0	201
2544	10011	211001	0	0	0	201
2195	10011	98001	0	0	0	201
2198	10011	98004	0	0	0	201
\.


--
-- Data for Name: player_options; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_options (id, player_id, option_key, value_num) FROM stdin;
317	10010	language	0
318	10010	camera_control_parallel	0
319	10010	camera_control_vertical	1
320	10010	pedal_control	0
321	10010	chair_shake	0
322	10010	assist_control	1
323	10010	assist_show	1
324	10010	volume_bgm	9
325	10010	volume_se	9
326	10010	volume_voice	9
327	10010	vibration	1
328	10010	battle_log_show	0
329	10010	sorting_effect_display	1
330	10010	map_displa	1
331	10010	chaild_mode	0
437	10011	language	0
438	10011	camera_control_parallel	0
439	10011	camera_control_vertical	0
440	10011	pedal_control	0
441	10011	chair_shake	0
442	10011	assist_control	1
443	10011	assist_show	1
444	10011	volume_bgm	9
445	10011	volume_se	9
446	10011	volume_voice	9
447	10011	vibration	1
448	10011	battle_log_show	0
449	10011	sorting_effect_display	1
450	10011	map_displa	1
451	10011	chaild_mode	0
\.


--
-- Data for Name: player_progress; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_progress (id, player_id, progress_key, status) FROM stdin;
358	10010	main_menu	0
359	10010	present	0
360	10010	mecha_shop	0
361	10010	weapon_shop	0
362	10010	emblem_shop	2
363	10010	win_pose_shop	2
364	10010	line_color_shop	2
365	10010	symbol_chat_shop	0
366	10010	parts_color_shop	2
915	10011	tutorial_2on2	2
916	10011	tutorial_2on2_2nd	2
917	10011	tutorial_2on2_finish	0
367	10010	player_emblem_customize	0
368	10010	player_title_customize	0
369	10010	preset_customize	2
370	10010	win_pose	0
371	10010	line_color	0
372	10010	national_match	0
373	10010	coop	2
880	10011	tutorial	2
881	10011	buddy_present	0
882	10011	customize	2
883	10011	player_customize	0
884	10011	buddy_customize	2
885	10011	mecha_customize	2
886	10011	role_customize	2
887	10011	shop	0
888	10011	quest	2
889	10011	buddy_skill	2
890	10011	main_menu	0
891	10011	present	0
892	10011	mecha_shop	0
893	10011	weapon_shop	0
894	10011	emblem_shop	2
895	10011	win_pose_shop	2
896	10011	line_color_shop	0
897	10011	symbol_chat_shop	0
898	10011	parts_color_shop	2
899	10011	player_emblem_customize	0
900	10011	player_title_customize	0
901	10011	preset_customize	2
374	10010	boss	2
375	10010	mission	2
376	10010	player_customize_2on2	2
377	10010	buddy_customize_2on2	2
378	10010	mecha_customize_2on2	2
379	10010	player_emblem_customize_2on2	0
380	10010	player_title_customize_2on2	0
381	10010	coop_2on2	2
382	10010	mission_2on2	2
383	10010	tutorial_2on2	2
348	10010	tutorial	2
349	10010	buddy_present	0
350	10010	customize	2
351	10010	player_customize	0
352	10010	buddy_customize	2
353	10010	mecha_customize	2
354	10010	role_customize	2
355	10010	shop	0
356	10010	quest	2
357	10010	buddy_skill	2
384	10010	tutorial_2on2_2nd	2
385	10010	tutorial_2on2_finish	2
902	10011	win_pose	0
903	10011	line_color	0
904	10011	national_match	0
905	10011	coop	2
906	10011	boss	2
907	10011	mission	2
908	10011	player_customize_2on2	2
909	10011	buddy_customize_2on2	2
910	10011	mecha_customize_2on2	2
911	10011	player_emblem_customize_2on2	0
912	10011	player_title_customize_2on2	0
913	10011	coop_2on2	2
914	10011	mission_2on2	2
\.


--
-- Data for Name: player_side_weapons; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_side_weapons (id, player_id, side_weapon_id, use_count, use_time, status) FROM stdin;
13	10010	1	0	0	2
14	10010	2	0	0	4
15	10010	3	0	0	2
16	10010	4	0	0	2
17	10010	5	0	0	2
18	10010	6	0	0	2
19	10010	7	0	0	2
20	10010	8	0	0	2
21	10010	9	0	0	2
22	10010	10	0	0	2
23	10010	11	0	0	2
24	10010	12	0	0	2
25	10011	1	0	0	2
26	10011	2	0	0	4
27	10011	3	0	0	2
28	10011	4	0	0	2
29	10011	5	0	0	2
30	10011	6	0	0	2
31	10011	7	0	0	2
32	10011	8	0	0	2
33	10011	9	0	0	2
34	10011	10	0	0	2
35	10011	11	0	0	2
36	10011	12	0	0	2
\.


--
-- Data for Name: player_titles; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_titles (id, player_id, title_id, status) FROM stdin;
15	10010	100000	4
16	10010	100001	4
25	10011	100000	4
26	10011	100001	4
\.


--
-- Data for Name: player_weapon_set; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_weapon_set (id, player_id, weapon_set_id, use_count, use_time, status) FROM stdin;
113	10010	100	0	0	4
114	10010	101	0	0	2
115	10010	102	0	0	2
116	10010	103	0	0	2
117	10010	200	0	0	4
118	10010	201	0	0	2
119	10010	202	0	0	2
120	10010	203	0	0	2
121	10010	300	0	0	4
122	10010	301	0	0	2
123	10010	302	0	0	2
124	10010	303	0	0	2
125	10010	400	0	0	4
126	10010	401	0	0	2
127	10010	402	0	0	2
128	10010	403	0	0	2
129	10010	500	0	0	4
130	10010	501	0	0	2
131	10010	502	0	0	2
132	10010	503	0	0	2
133	10010	600	0	0	4
134	10010	601	0	0	2
135	10010	602	0	0	2
136	10010	603	0	0	2
137	10010	700	0	0	4
138	10010	701	0	0	2
139	10010	702	0	0	2
140	10010	703	0	0	2
141	10010	800	0	0	4
142	10010	801	0	0	2
143	10010	802	0	0	2
144	10010	803	0	0	2
145	10010	900	0	0	4
146	10010	901	0	0	2
147	10010	902	0	0	2
148	10010	903	0	0	2
149	10010	1000	0	0	4
150	10010	1001	0	0	2
151	10010	1002	0	0	2
152	10010	1003	0	0	2
153	10010	1100	0	0	4
154	10010	1101	0	0	2
155	10010	1102	0	0	2
156	10010	1103	0	0	2
157	10010	1200	0	0	4
158	10010	1201	0	0	2
159	10010	1202	0	0	2
160	10010	1203	0	0	2
161	10010	1300	0	0	4
162	10010	1301	0	0	2
163	10010	1302	0	0	2
164	10010	1303	0	0	2
165	10010	1400	0	0	4
166	10010	1401	0	0	2
167	10010	1402	0	0	2
168	10010	1403	0	0	2
169	10011	100	0	0	4
170	10011	101	0	0	2
171	10011	102	0	0	2
172	10011	103	0	0	2
173	10011	200	0	0	4
174	10011	201	0	0	2
175	10011	202	0	0	2
176	10011	203	0	0	2
177	10011	300	0	0	4
178	10011	301	0	0	2
179	10011	302	0	0	2
180	10011	303	0	0	2
181	10011	400	0	0	4
182	10011	401	0	0	2
183	10011	402	0	0	2
184	10011	403	0	0	2
185	10011	500	0	0	4
186	10011	501	0	0	2
187	10011	502	0	0	2
188	10011	503	0	0	2
189	10011	600	0	0	4
190	10011	601	0	0	2
191	10011	602	0	0	2
192	10011	603	0	0	2
193	10011	700	0	0	4
194	10011	701	0	0	2
195	10011	702	0	0	2
196	10011	703	0	0	2
197	10011	800	0	0	4
198	10011	801	0	0	2
199	10011	802	0	0	2
200	10011	803	0	0	2
201	10011	900	0	0	4
202	10011	901	0	0	2
203	10011	902	0	0	2
204	10011	903	0	0	2
205	10011	1000	0	0	4
206	10011	1001	0	0	2
207	10011	1002	0	0	2
208	10011	1003	0	0	2
209	10011	1100	0	0	4
210	10011	1101	0	0	2
211	10011	1102	0	0	2
212	10011	1103	0	0	2
213	10011	1200	0	0	4
214	10011	1201	0	0	2
215	10011	1202	0	0	2
216	10011	1203	0	0	2
217	10011	1300	0	0	4
218	10011	1301	0	0	2
219	10011	1302	0	0	2
220	10011	1303	0	0	2
221	10011	1400	0	0	4
222	10011	1401	0	0	2
223	10011	1402	0	0	2
224	10011	1403	0	0	2
\.


--
-- Data for Name: player_weapon_set_slots; Type: TABLE DATA; Schema: public; Owner: paradox
--

COPY public.player_weapon_set_slots (id, player_id, weapon_set_id, slot_id, weapon_id, use_count, use_time) FROM stdin;
365	10010	100	0	1	0	0
366	10010	100	1	2	0	0
367	10010	100	2	63	0	0
368	10010	101	0	219	0	0
369	10010	101	1	28	0	0
370	10010	101	2	63	0	0
371	10010	102	0	4	0	0
372	10010	102	1	203	0	0
373	10010	102	2	44	0	0
374	10010	103	0	29	0	0
375	10010	200	0	114	0	0
376	10010	200	1	60	0	0
377	10010	200	2	67	0	0
378	10010	201	0	24	0	0
379	10010	201	1	23	0	0
380	10010	201	2	67	0	0
381	10010	202	0	114	0	0
382	10010	202	1	201	0	0
383	10010	202	2	213	0	0
384	10010	202	3	60	0	0
385	10010	203	0	201	0	0
386	10010	203	1	201	0	0
387	10010	203	2	143	0	0
388	10010	203	3	60	0	0
389	10010	300	0	35	0	0
390	10010	300	1	6	0	0
391	10010	300	2	31	0	0
392	10010	301	0	211	0	0
393	10010	301	1	53	0	0
394	10010	301	2	31	0	0
395	10010	302	0	53	0	0
396	10010	302	1	53	0	0
397	10010	302	2	120	0	0
398	10010	302	3	23	0	0
399	10010	303	0	35	0	0
400	10010	303	1	52	0	0
401	10010	303	2	65	0	0
402	10010	400	0	4	0	0
403	10010	400	1	118	0	0
404	10010	400	2	42	0	0
405	10010	401	0	23	0	0
406	10010	401	1	218	0	0
407	10010	401	2	42	0	0
408	10010	402	0	119	0	0
409	10010	402	1	85	0	0
410	10010	402	2	130	0	0
411	10010	403	0	53	0	0
412	10010	403	1	218	0	0
413	10010	403	2	131	0	0
414	10010	500	0	6	0	0
415	10010	500	1	91	0	0
416	10010	500	2	64	0	0
417	10010	500	3	53	0	0
418	10010	501	0	211	0	0
419	10010	501	1	53	0	0
420	10010	501	2	64	0	0
421	10010	501	3	208	0	0
422	10010	502	0	35	0	0
423	10010	502	1	6	0	0
424	10010	502	2	26	0	0
425	10010	502	3	77	0	0
426	10010	503	0	119	0	0
427	10010	503	1	118	0	0
428	10010	503	2	26	0	0
429	10010	503	3	18	0	0
430	10010	600	0	219	0	0
431	10010	600	1	14	0	0
432	10010	600	2	69	0	0
433	10010	601	0	120	0	0
434	10010	601	1	214	0	0
435	10010	601	2	69	0	0
436	10010	602	0	27	0	0
437	10010	602	1	14	0	0
438	10010	602	2	20	0	0
439	10010	603	0	27	0	0
440	10010	603	1	76	0	0
441	10010	603	2	17	0	0
442	10010	700	0	1	0	0
443	10010	700	1	2	0	0
444	10010	700	2	129	0	0
445	10010	700	3	28	0	0
446	10010	701	0	12	0	0
447	10010	701	1	23	0	0
448	10010	701	2	129	0	0
449	10010	701	3	143	0	0
450	10010	702	0	2	0	0
451	10010	702	1	2	0	0
452	10010	702	2	12	0	0
453	10010	702	3	143	0	0
454	10010	703	0	1	0	0
455	10010	703	1	52	0	0
456	10010	703	2	70	0	0
457	10010	800	0	122	0	0
458	10010	800	1	10	0	0
459	10010	800	2	33	0	0
460	10010	801	0	107	0	0
461	10010	801	1	77	0	0
462	10010	801	2	33	0	0
463	10010	802	0	4	0	0
464	10010	802	1	118	0	0
465	10010	802	2	217	0	0
466	10010	803	0	122	0	0
467	10010	803	1	10	0	0
468	10010	803	2	47	0	0
469	10010	900	0	13	0	0
470	10010	900	1	91	0	0
471	10010	900	2	58	0	0
472	10010	900	3	9	0	0
473	10010	901	0	213	0	0
474	10010	901	1	209	0	0
475	10010	901	2	58	0	0
476	10010	901	3	80	0	0
477	10010	902	0	13	0	0
478	10010	902	1	80	0	0
479	10010	902	2	12	0	0
480	10010	902	3	9	0	0
481	10010	903	0	13	0	0
482	10010	903	1	143	0	0
483	10010	903	2	70	0	0
484	10010	1000	0	53	0	0
485	10010	1000	1	126	0	0
486	10010	1000	2	133	0	0
487	10010	1000	3	80	0	0
488	10010	1001	0	35	0	0
489	10010	1001	1	100	0	0
490	10010	1001	2	133	0	0
491	10010	1001	3	218	0	0
492	10010	1002	0	53	0	0
493	10010	1002	1	126	0	0
494	10010	1002	2	143	0	0
495	10010	1002	3	134	0	0
496	10010	1003	0	35	0	0
497	10010	1003	1	30	0	0
498	10010	1003	2	85	0	0
499	10010	1003	3	134	0	0
500	10010	1100	0	202	0	0
501	10010	1100	1	203	0	0
502	10010	1100	2	103	0	0
503	10010	1101	0	219	0	0
504	10010	1101	1	28	0	0
505	10010	1101	2	103	0	0
506	10010	1102	0	219	0	0
507	10010	1102	1	203	0	0
508	10010	1102	2	20	0	0
509	10010	1103	0	202	0	0
510	10010	1103	1	14	0	0
511	10010	1103	2	32	0	0
512	10010	1200	0	107	0	0
513	10010	1200	1	208	0	0
514	10010	1200	2	57	0	0
515	10010	1201	0	114	0	0
516	10010	1201	1	201	0	0
517	10010	1201	2	57	0	0
518	10010	1202	0	107	0	0
519	10010	1202	1	208	0	0
520	10010	1202	2	44	0	0
521	10010	1203	0	35	0	0
522	10010	1203	1	138	0	0
523	10010	1203	2	34	0	0
524	10010	1300	0	215	0	0
525	10010	1300	1	138	0	0
526	10010	1300	2	132	0	0
527	10010	1301	0	203	0	0
528	10010	1301	1	203	0	0
529	10010	1301	2	132	0	0
530	10010	1302	0	215	0	0
531	10010	1302	1	71	0	0
532	10010	1302	2	105	0	0
533	10010	1303	0	29	0	0
534	10010	1400	0	113	0	0
535	10010	1400	1	96	0	0
536	10010	1400	2	68	0	0
537	10010	1401	0	219	0	0
538	10010	1401	1	76	0	0
539	10010	1401	2	68	0	0
540	10010	1402	0	113	0	0
541	10010	1402	1	38	0	0
542	10010	1402	2	76	0	0
543	10010	1402	3	76	0	0
544	10010	1403	0	113	0	0
545	10010	1403	1	96	0	0
546	10010	1403	2	47	0	0
547	10011	100	0	1	0	0
548	10011	100	1	2	0	0
549	10011	100	2	63	0	0
550	10011	101	0	219	0	0
551	10011	101	1	28	0	0
552	10011	101	2	63	0	0
553	10011	102	0	4	0	0
554	10011	102	1	203	0	0
555	10011	102	2	44	0	0
556	10011	103	0	29	0	0
557	10011	200	0	114	0	0
558	10011	200	1	60	0	0
559	10011	200	2	67	0	0
560	10011	201	0	24	0	0
561	10011	201	1	23	0	0
562	10011	201	2	67	0	0
563	10011	202	0	114	0	0
564	10011	202	1	201	0	0
565	10011	202	2	213	0	0
566	10011	202	3	60	0	0
567	10011	203	0	201	0	0
568	10011	203	1	201	0	0
569	10011	203	2	143	0	0
570	10011	203	3	60	0	0
571	10011	300	0	35	0	0
572	10011	300	1	6	0	0
573	10011	300	2	31	0	0
574	10011	301	0	211	0	0
575	10011	301	1	53	0	0
576	10011	301	2	31	0	0
577	10011	302	0	53	0	0
578	10011	302	1	53	0	0
579	10011	302	2	120	0	0
580	10011	302	3	23	0	0
581	10011	303	0	35	0	0
582	10011	303	1	52	0	0
583	10011	303	2	65	0	0
584	10011	400	0	4	0	0
585	10011	400	1	118	0	0
586	10011	400	2	42	0	0
587	10011	401	0	23	0	0
588	10011	401	1	218	0	0
589	10011	401	2	42	0	0
590	10011	402	0	119	0	0
591	10011	402	1	85	0	0
592	10011	402	2	130	0	0
593	10011	403	0	53	0	0
594	10011	403	1	218	0	0
595	10011	403	2	131	0	0
596	10011	500	0	6	0	0
597	10011	500	1	91	0	0
598	10011	500	2	64	0	0
599	10011	500	3	53	0	0
600	10011	501	0	211	0	0
601	10011	501	1	53	0	0
602	10011	501	2	64	0	0
603	10011	501	3	208	0	0
604	10011	502	0	35	0	0
605	10011	502	1	6	0	0
606	10011	502	2	26	0	0
607	10011	502	3	77	0	0
608	10011	503	0	119	0	0
609	10011	503	1	118	0	0
610	10011	503	2	26	0	0
611	10011	503	3	18	0	0
612	10011	600	0	219	0	0
613	10011	600	1	14	0	0
614	10011	600	2	69	0	0
615	10011	601	0	120	0	0
616	10011	601	1	214	0	0
617	10011	601	2	69	0	0
618	10011	602	0	27	0	0
619	10011	602	1	14	0	0
620	10011	602	2	20	0	0
621	10011	603	0	27	0	0
622	10011	603	1	76	0	0
623	10011	603	2	17	0	0
624	10011	700	0	1	0	0
625	10011	700	1	2	0	0
626	10011	700	2	129	0	0
627	10011	700	3	28	0	0
628	10011	701	0	12	0	0
629	10011	701	1	23	0	0
630	10011	701	2	129	0	0
631	10011	701	3	143	0	0
632	10011	702	0	2	0	0
633	10011	702	1	2	0	0
634	10011	702	2	12	0	0
635	10011	702	3	143	0	0
636	10011	703	0	1	0	0
637	10011	703	1	52	0	0
638	10011	703	2	70	0	0
639	10011	800	0	122	0	0
640	10011	800	1	10	0	0
641	10011	800	2	33	0	0
642	10011	801	0	107	0	0
643	10011	801	1	77	0	0
644	10011	801	2	33	0	0
645	10011	802	0	4	0	0
646	10011	802	1	118	0	0
647	10011	802	2	217	0	0
648	10011	803	0	122	0	0
649	10011	803	1	10	0	0
650	10011	803	2	47	0	0
651	10011	900	0	13	0	0
652	10011	900	1	91	0	0
653	10011	900	2	58	0	0
654	10011	900	3	9	0	0
655	10011	901	0	213	0	0
656	10011	901	1	209	0	0
657	10011	901	2	58	0	0
658	10011	901	3	80	0	0
659	10011	902	0	13	0	0
660	10011	902	1	80	0	0
661	10011	902	2	12	0	0
662	10011	902	3	9	0	0
663	10011	903	0	13	0	0
664	10011	903	1	143	0	0
665	10011	903	2	70	0	0
666	10011	1000	0	53	0	0
667	10011	1000	1	126	0	0
668	10011	1000	2	133	0	0
669	10011	1000	3	80	0	0
670	10011	1001	0	35	0	0
671	10011	1001	1	100	0	0
672	10011	1001	2	133	0	0
673	10011	1001	3	218	0	0
674	10011	1002	0	53	0	0
675	10011	1002	1	126	0	0
676	10011	1002	2	143	0	0
677	10011	1002	3	134	0	0
678	10011	1003	0	35	0	0
679	10011	1003	1	30	0	0
680	10011	1003	2	85	0	0
681	10011	1003	3	134	0	0
682	10011	1100	0	202	0	0
683	10011	1100	1	203	0	0
684	10011	1100	2	103	0	0
685	10011	1101	0	219	0	0
686	10011	1101	1	28	0	0
687	10011	1101	2	103	0	0
688	10011	1102	0	219	0	0
689	10011	1102	1	203	0	0
690	10011	1102	2	20	0	0
691	10011	1103	0	202	0	0
692	10011	1103	1	14	0	0
693	10011	1103	2	32	0	0
694	10011	1200	0	107	0	0
695	10011	1200	1	208	0	0
696	10011	1200	2	57	0	0
697	10011	1201	0	114	0	0
698	10011	1201	1	201	0	0
699	10011	1201	2	57	0	0
700	10011	1202	0	107	0	0
701	10011	1202	1	208	0	0
702	10011	1202	2	44	0	0
703	10011	1203	0	35	0	0
704	10011	1203	1	138	0	0
705	10011	1203	2	34	0	0
706	10011	1300	0	215	0	0
707	10011	1300	1	138	0	0
708	10011	1300	2	132	0	0
709	10011	1301	0	203	0	0
710	10011	1301	1	203	0	0
711	10011	1301	2	132	0	0
712	10011	1302	0	215	0	0
713	10011	1302	1	71	0	0
714	10011	1302	2	105	0	0
715	10011	1303	0	29	0	0
716	10011	1400	0	113	0	0
717	10011	1400	1	96	0	0
718	10011	1400	2	68	0	0
719	10011	1401	0	219	0	0
720	10011	1401	1	76	0	0
721	10011	1401	2	68	0	0
722	10011	1402	0	113	0	0
723	10011	1402	1	38	0	0
724	10011	1402	2	76	0	0
725	10011	1402	3	76	0	0
726	10011	1403	0	113	0	0
727	10011	1403	1	96	0	0
728	10011	1403	2	47	0	0
\.


--
-- Name: buddy_win_poses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.buddy_win_poses_id_seq', 14, true);


--
-- Name: mecha_colors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.mecha_colors_id_seq', 84, true);


--
-- Name: player_buddies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_buddies_id_seq', 15456, true);


--
-- Name: player_emblem_parts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_emblem_parts_id_seq', 60, true);


--
-- Name: player_emblems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_emblems_id_seq', 24, true);


--
-- Name: player_line_colors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_line_colors_id_seq', 15, true);


--
-- Name: player_logins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_logins_id_seq', 166, true);


--
-- Name: player_mecha_set_parts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_mecha_set_parts_id_seq', 700, true);


--
-- Name: player_mecha_sets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_mecha_sets_id_seq', 140, true);


--
-- Name: player_missions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_missions_id_seq', 2629, true);


--
-- Name: player_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_options_id_seq', 466, true);


--
-- Name: player_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_player_id_seq', 10011, true);


--
-- Name: player_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_progress_id_seq', 4907, true);


--
-- Name: player_side_weapons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_side_weapons_id_seq', 36, true);


--
-- Name: player_titles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_titles_id_seq', 26, true);


--
-- Name: player_weapon_set_slots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.player_weapon_set_slots_id_seq', 728, true);


--
-- Name: weapon_set_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paradox
--

SELECT pg_catalog.setval('public.weapon_set_id_seq', 224, true);


--
-- Name: player_buddy_win_poses buddy_win_poses_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_buddy_win_poses
    ADD CONSTRAINT buddy_win_poses_pkey PRIMARY KEY (id);


--
-- Name: player_mecha_colors mecha_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_mecha_colors
    ADD CONSTRAINT mecha_colors_pkey PRIMARY KEY (id);


--
-- Name: player_buddies player_buddies_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_buddies
    ADD CONSTRAINT player_buddies_pkey PRIMARY KEY (id);


--
-- Name: player_emblem_parts player_emblem_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_emblem_parts
    ADD CONSTRAINT player_emblem_parts_pkey PRIMARY KEY (id);


--
-- Name: player_emblems player_emblems_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_emblems
    ADD CONSTRAINT player_emblems_pkey PRIMARY KEY (id);


--
-- Name: player_line_colors player_line_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_line_colors
    ADD CONSTRAINT player_line_colors_pkey PRIMARY KEY (id);


--
-- Name: player_logins player_logins_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_logins
    ADD CONSTRAINT player_logins_pkey PRIMARY KEY (id);


--
-- Name: player_mecha_set_parts player_mecha_set_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_mecha_set_parts
    ADD CONSTRAINT player_mecha_set_parts_pkey PRIMARY KEY (id);


--
-- Name: player_mecha_sets player_mecha_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_mecha_sets
    ADD CONSTRAINT player_mecha_sets_pkey PRIMARY KEY (id);


--
-- Name: player_missions player_missions_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_missions
    ADD CONSTRAINT player_missions_pkey PRIMARY KEY (id);


--
-- Name: player_options player_options_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_options
    ADD CONSTRAINT player_options_pkey PRIMARY KEY (id);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (player_id);


--
-- Name: player_progress player_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_progress
    ADD CONSTRAINT player_progress_pkey PRIMARY KEY (id);


--
-- Name: player_side_weapons player_side_weapons_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_side_weapons
    ADD CONSTRAINT player_side_weapons_pkey PRIMARY KEY (id);


--
-- Name: player_titles player_titles_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_titles
    ADD CONSTRAINT player_titles_pkey PRIMARY KEY (id);


--
-- Name: player_weapon_set_slots player_weapon_set_slots_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_weapon_set_slots
    ADD CONSTRAINT player_weapon_set_slots_pkey PRIMARY KEY (id);


--
-- Name: player_weapon_set weapon_set_pkey; Type: CONSTRAINT; Schema: public; Owner: paradox
--

ALTER TABLE ONLY public.player_weapon_set
    ADD CONSTRAINT weapon_set_pkey PRIMARY KEY (id);


--
-- Name: buddy_win_poses_player_id_buddy_id_win_pose_id_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX buddy_win_poses_player_id_buddy_id_win_pose_id_key ON public.player_buddy_win_poses USING btree (player_id, buddy_id, win_pose_id);


--
-- Name: mecha_colors_player_id_mecha_color_id_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX mecha_colors_player_id_mecha_color_id_key ON public.player_mecha_colors USING btree (player_id, mecha_color_id);


--
-- Name: player_buddies_player_id_buddy_id_buddy_option_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_buddies_player_id_buddy_id_buddy_option_key ON public.player_buddies USING btree (player_id, buddy_id, buddy_key);


--
-- Name: player_emblem_parts_player_id_part_id_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_emblem_parts_player_id_part_id_key ON public.player_emblem_parts USING btree (player_id, part_id);


--
-- Name: player_line_colors_player_id_side_line_color_id_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_line_colors_player_id_side_line_color_id_key ON public.player_line_colors USING btree (player_id, line_color_id);


--
-- Name: player_mecha_set_parts_player_id_mecha_set_id_part_id_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_mecha_set_parts_player_id_mecha_set_id_part_id_key ON public.player_mecha_set_parts USING btree (player_id, mecha_set_id, part_id);


--
-- Name: player_mecha_sets_player_id_mecha_set_id_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_mecha_sets_player_id_mecha_set_id_key ON public.player_mecha_sets USING btree (player_id, mecha_set_id);


--
-- Name: player_missions_player_id_mission_id_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_missions_player_id_mission_id_key ON public.player_missions USING btree (player_id, mission_id);


--
-- Name: player_options_player_id_option_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_options_player_id_option_key ON public.player_options USING btree (player_id, option_key);


--
-- Name: player_progress_player_id_progress_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_progress_player_id_progress_key ON public.player_progress USING btree (player_id, progress_key);


--
-- Name: player_side_weapons_player_id_side_weapon_id_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_side_weapons_player_id_side_weapon_id_key ON public.player_side_weapons USING btree (player_id, side_weapon_id);


--
-- Name: player_titles_player_id_emblem_id_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_titles_player_id_emblem_id_key ON public.player_emblems USING btree (player_id, emblem_id);


--
-- Name: player_titles_player_id_title_id_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_titles_player_id_title_id_key ON public.player_titles USING btree (player_id, title_id);


--
-- Name: player_weapon_set_slots_player_id_weapon_set_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX player_weapon_set_slots_player_id_weapon_set_key ON public.player_weapon_set_slots USING btree (player_id, weapon_set_id, slot_id);


--
-- Name: weapon_set_player_id_weapon_set_key; Type: INDEX; Schema: public; Owner: paradox
--

CREATE UNIQUE INDEX weapon_set_player_id_weapon_set_key ON public.player_weapon_set USING btree (player_id, weapon_set_id);


--
-- PostgreSQL database dump complete
--

