--
-- PostgreSQL database dump
--

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA _realtime;


ALTER SCHEMA _realtime OWNER TO postgres;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA supabase_functions;


ALTER SCHEMA supabase_functions OWNER TO supabase_admin;

--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: booking_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.booking_status AS ENUM (
    'requested',
    'awaiting_hero_accept',
    'enroute',
    'arrived',
    'in_progress',
    'completed',
    'rated',
    'declined',
    'expired',
    'cancelled_by_customer',
    'cancelled_by_admin',
    'reassigned',
    'dispute',
    'refund_partial',
    'refund_full'
);


ALTER TYPE public.booking_status OWNER TO postgres;

--
-- Name: promo_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.promo_type AS ENUM (
    'amount',
    'percent'
);


ALTER TYPE public.promo_type OWNER TO postgres;

--
-- Name: ratee_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.ratee_type AS ENUM (
    'hero',
    'contractor'
);


ALTER TYPE public.ratee_type OWNER TO postgres;

--
-- Name: service_unit; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.service_unit AS ENUM (
    'fixed',
    'hourly'
);


ALTER TYPE public.service_unit OWNER TO postgres;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'customer',
    'hero',
    'admin',
    'cs',
    'finance',
    'contractor_manager'
);


ALTER TYPE public.user_role OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: convert_to_uuid(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.convert_to_uuid(text) RETURNS uuid
    LANGUAGE plpgsql
    AS $_$
BEGIN
  RETURN $1::uuid;
EXCEPTION WHEN others THEN
  RETURN NULL;
END;
$_$;


ALTER FUNCTION public.convert_to_uuid(text) OWNER TO postgres;

--
-- Name: create_booking_event(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_booking_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF OLD.status IS NULL OR NEW.status != OLD.status THEN
    INSERT INTO booking_events (booking_id, type, meta_json)
    VALUES (NEW.id, 'status_change', jsonb_build_object('from', OLD.status, 'to', NEW.status));
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.create_booking_event() OWNER TO postgres;

--
-- Name: get_available_heroes(uuid, character varying, date, time without time zone, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_available_heroes(service_id uuid, city character varying, booking_date date, booking_time time without time zone, duration_minutes integer) RETURNS TABLE(hero_id uuid, hero_name character varying, rating numeric, review_count integer, price_multiplier numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        h.id,
        h.name,
        h.rating,
        h.review_count,
        hs.price_multiplier
    FROM heroes h
    JOIN hero_services hs ON h.id = hs.hero_id
    JOIN hero_service_areas hsa ON h.id = hsa.hero_id
    WHERE 
        h.is_active = true 
        AND h.is_verified = true
        AND hs.service_id = get_available_heroes.service_id
        AND hs.is_active = true
        AND hsa.city = get_available_heroes.city
        AND hsa.is_active = true
        -- Add availability check logic here
    ORDER BY h.rating DESC, h.review_count DESC;
END;
$$;


ALTER FUNCTION public.get_available_heroes(service_id uuid, city character varying, booking_date date, booking_time time without time zone, duration_minutes integer) OWNER TO postgres;

--
-- Name: get_server_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_server_timestamp() RETURNS timestamp with time zone
    LANGUAGE sql SECURITY DEFINER
    AS $$
  SELECT NOW();
$$;


ALTER FUNCTION public.get_server_timestamp() OWNER TO postgres;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role)
  VALUES (
    NEW.id,
    NEW.email,
    'customer'  -- Default role is customer
  );
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: update_booking_status(uuid, character varying, text, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_booking_status(booking_id uuid, new_status character varying, notes text DEFAULT NULL::text, user_id uuid DEFAULT NULL::uuid) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update booking status
    UPDATE bookings 
    SET 
        status = new_status,
        updated_at = NOW(),
        confirmed_at = CASE WHEN new_status = 'confirmed' THEN NOW() ELSE confirmed_at END,
        started_at = CASE WHEN new_status = 'in_progress' THEN NOW() ELSE started_at END,
        completed_at = CASE WHEN new_status = 'completed' THEN NOW() ELSE completed_at END,
        cancelled_at = CASE WHEN new_status IN ('cancelled', 'no_show') THEN NOW() ELSE cancelled_at END
    WHERE id = booking_id;
    
    -- Insert status history record
    INSERT INTO booking_status_history (booking_id, status, notes, created_by)
    VALUES (booking_id, new_status, notes, user_id);
    
    RETURN TRUE;
END;
$$;


ALTER FUNCTION public.update_booking_status(booking_id uuid, new_status character varying, notes text, user_id uuid) OWNER TO postgres;

--
-- Name: update_hero_rating(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_hero_rating() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.ratee_type = 'hero' THEN
    UPDATE heros
    SET 
      rating_count = rating_count + 1,
      rating_avg = (rating_avg * rating_count + NEW.rating) / (rating_count + 1)
    WHERE id = NEW.ratee_id;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_hero_rating() OWNER TO postgres;

--
-- Name: update_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at() OWNER TO postgres;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
BEGIN
    RETURN query EXECUTE
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name || '/' AS name,
                    NULL::uuid AS id,
                    NULL::timestamptz AS updated_at,
                    NULL::timestamptz AS created_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%'
                AND bucket_id = $2
                AND level = $4
                AND name COLLATE "C" > $5
                ORDER BY prefixes.name COLLATE "C" LIMIT $3
            )
            UNION ALL
            (SELECT split_part(name, '/', $4) AS key,
                name,
                id,
                updated_at,
                created_at,
                metadata
            FROM storage.objects
            WHERE name COLLATE "C" LIKE $1 || '%'
                AND bucket_id = $2
                AND level = $4
                AND name COLLATE "C" > $5
            ORDER BY name COLLATE "C" LIMIT $3)
        ) obj
        ORDER BY name COLLATE "C" LIMIT $3;
        $sql$
        USING prefix, bucket_name, limits, levels, start_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
  DECLARE
    request_id bigint;
    payload jsonb;
    url text := TG_ARGV[0]::text;
    method text := TG_ARGV[1]::text;
    headers jsonb DEFAULT '{}'::jsonb;
    params jsonb DEFAULT '{}'::jsonb;
    timeout_ms integer DEFAULT 1000;
  BEGIN
    IF url IS NULL OR url = 'null' THEN
      RAISE EXCEPTION 'url argument is missing';
    END IF;

    IF method IS NULL OR method = 'null' THEN
      RAISE EXCEPTION 'method argument is missing';
    END IF;

    IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
      headers = '{"Content-Type": "application/json"}'::jsonb;
    ELSE
      headers = TG_ARGV[2]::jsonb;
    END IF;

    IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
      params = '{}'::jsonb;
    ELSE
      params = TG_ARGV[3]::jsonb;
    END IF;

    IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
      timeout_ms = 1000;
    ELSE
      timeout_ms = TG_ARGV[4]::integer;
    END IF;

    CASE
      WHEN method = 'GET' THEN
        SELECT http_get INTO request_id FROM net.http_get(
          url,
          params,
          headers,
          timeout_ms
        );
      WHEN method = 'POST' THEN
        payload = jsonb_build_object(
          'old_record', OLD,
          'record', NEW,
          'type', TG_OP,
          'table', TG_TABLE_NAME,
          'schema', TG_TABLE_SCHEMA
        );

        SELECT http_post INTO request_id FROM net.http_post(
          url,
          payload,
          params,
          headers,
          timeout_ms
        );
      ELSE
        RAISE EXCEPTION 'method argument % is invalid', method;
    END CASE;

    INSERT INTO supabase_functions.hooks
      (hook_table_id, hook_name, request_id)
    VALUES
      (TG_RELID, TG_NAME, request_id);

    RETURN NEW;
  END
$$;


ALTER FUNCTION supabase_functions.http_request() OWNER TO supabase_functions_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: extensions; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.extensions (
    id uuid NOT NULL,
    type text,
    settings jsonb,
    tenant_external_id text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _realtime.extensions OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE _realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: tenants; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.tenants (
    id uuid NOT NULL,
    name text,
    external_id text,
    jwt_secret text,
    max_concurrent_users integer DEFAULT 200 NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    max_events_per_second integer DEFAULT 100 NOT NULL,
    postgres_cdc_default text DEFAULT 'postgres_cdc_rls'::text,
    max_bytes_per_second integer DEFAULT 100000 NOT NULL,
    max_channels_per_client integer DEFAULT 100 NOT NULL,
    max_joins_per_second integer DEFAULT 500 NOT NULL,
    suspend boolean DEFAULT false,
    jwt_jwks jsonb,
    notify_private_alpha boolean DEFAULT false,
    private_only boolean DEFAULT false NOT NULL,
    migrations_ran integer DEFAULT 0,
    broadcast_adapter character varying(255) DEFAULT 'gen_rpc'::character varying,
    max_presence_events_per_second integer DEFAULT 10000,
    max_payload_size_in_kb integer DEFAULT 3000
);


ALTER TABLE _realtime.tenants OWNER TO supabase_admin;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_id text NOT NULL,
    client_secret_hash text NOT NULL,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: add_ons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.add_ons (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    service_id uuid,
    name character varying(255) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    category character varying(100),
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.add_ons OWNER TO postgres;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    label text,
    line1 text NOT NULL,
    line2 text,
    city text NOT NULL,
    province text NOT NULL,
    postal_code text NOT NULL,
    lat numeric,
    lng numeric,
    geom public.geography(Point,4326) GENERATED ALWAYS AS ((public.st_setsrid(public.st_makepoint((lng)::double precision, (lat)::double precision), 4326))::public.geography) STORED
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: booking_add_ons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking_add_ons (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    booking_id uuid,
    add_on_id uuid,
    quantity integer DEFAULT 1,
    unit_price numeric(10,2) NOT NULL,
    total_price numeric(10,2) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.booking_add_ons OWNER TO postgres;

--
-- Name: booking_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking_events (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    booking_id uuid NOT NULL,
    type text NOT NULL,
    meta_json jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.booking_events OWNER TO postgres;

--
-- Name: booking_status_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking_status_history (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    booking_id uuid,
    status character varying(20) NOT NULL,
    notes text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.booking_status_history OWNER TO postgres;

--
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    customer_id uuid NOT NULL,
    contractor_id uuid,
    hero_id uuid,
    address_id uuid,
    scheduled_at timestamp with time zone,
    duration_min integer NOT NULL,
    status public.booking_status DEFAULT 'requested'::public.booking_status NOT NULL,
    price_cents integer NOT NULL,
    currency text DEFAULT 'CAD'::text NOT NULL,
    tip_cents integer DEFAULT 0,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    service_id uuid,
    service_variant_id uuid,
    service_name character varying(255),
    variant_name character varying(255),
    scheduled_date date,
    scheduled_time text,
    duration integer,
    address_street text,
    address_city text,
    address_postal_code text,
    base_price numeric(10,2) DEFAULT 0,
    call_out_fee numeric(10,2) DEFAULT 0,
    add_on_total numeric(10,2) DEFAULT 0,
    subtotal numeric(10,2) DEFAULT 0,
    tax_amount numeric(10,2) DEFAULT 0,
    special_instructions text,
    total_amount numeric(10,2)
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- Name: COLUMN bookings.service_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bookings.service_name IS 'Denormalized service name for display purposes';


--
-- Name: COLUMN bookings.variant_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bookings.variant_name IS 'Denormalized variant name for display purposes';


--
-- Name: contractors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contractors (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    contract_terms jsonb,
    gst_number text,
    insurance_doc_url text,
    city_coverage text[] DEFAULT '{}'::text[] NOT NULL,
    categories text[] DEFAULT '{}'::text[] NOT NULL,
    commission_pct numeric(5,2) DEFAULT 15.00 NOT NULL,
    pricing_floors_json jsonb,
    sla_json jsonb,
    stripe_connect_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contractors OWNER TO postgres;

--
-- Name: cs_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cs_notes (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    subject_type text NOT NULL,
    subject_id uuid NOT NULL,
    author_user_id uuid NOT NULL,
    note text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.cs_notes OWNER TO postgres;

--
-- Name: gps_pings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gps_pings (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    booking_id uuid NOT NULL,
    hero_id uuid NOT NULL,
    lat numeric NOT NULL,
    lng numeric NOT NULL,
    speed numeric,
    ts timestamp with time zone DEFAULT now() NOT NULL,
    geom public.geography(Point,4326) GENERATED ALWAYS AS ((public.st_setsrid(public.st_makepoint((lng)::double precision, (lat)::double precision), 4326))::public.geography) STORED
);


ALTER TABLE public.gps_pings OWNER TO postgres;

--
-- Name: hero_availability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hero_availability (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    hero_id uuid,
    day_of_week integer NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.hero_availability OWNER TO postgres;

--
-- Name: hero_service_areas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hero_service_areas (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    hero_id uuid,
    city character varying(100) NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.hero_service_areas OWNER TO postgres;

--
-- Name: hero_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hero_services (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    hero_id uuid,
    service_id uuid,
    price_multiplier numeric(3,2) DEFAULT 1.0,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.hero_services OWNER TO postgres;

--
-- Name: heros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.heros (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    contractor_id uuid NOT NULL,
    user_id uuid NOT NULL,
    name text NOT NULL,
    alias text,
    photo_url text,
    skills text[] DEFAULT '{}'::text[],
    categories text[] DEFAULT '{}'::text[],
    rating_avg numeric(3,2) DEFAULT 0,
    rating_count integer DEFAULT 0,
    bio text,
    badges text[] DEFAULT '{}'::text[],
    status text DEFAULT 'pending'::text NOT NULL,
    verification_status text DEFAULT 'pending'::text NOT NULL,
    availability_json jsonb,
    docs_json jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.heros OWNER TO postgres;

--
-- Name: heroes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.heroes AS
 SELECT id,
    user_id,
    name,
    alias,
    photo_url,
    rating_avg AS rating,
    rating_count AS review_count,
    (status = 'active'::text) AS is_active,
    (verification_status = 'verified'::text) AS is_verified,
    skills,
    categories,
    bio,
    badges,
    contractor_id,
    created_at,
    updated_at
   FROM public.heros;


ALTER VIEW public.heroes OWNER TO postgres;

--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    booking_id uuid NOT NULL,
    stripe_pi text,
    amount_cents integer NOT NULL,
    currency text DEFAULT 'CAD'::text NOT NULL,
    status text NOT NULL,
    captured_at timestamp with time zone,
    refunded_cents integer DEFAULT 0,
    refund_reason text
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payouts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payouts (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    contractor_id uuid NOT NULL,
    stripe_transfer_id text,
    amount_cents integer NOT NULL,
    status text NOT NULL,
    period_start timestamp with time zone NOT NULL,
    period_end timestamp with time zone NOT NULL
);


ALTER TABLE public.payouts OWNER TO postgres;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    role public.user_role DEFAULT 'customer'::public.user_role NOT NULL,
    name text,
    email text,
    phone text,
    status text DEFAULT 'active'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: promo_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promo_codes (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    discount_type character varying(20) NOT NULL,
    discount_value numeric(10,2) NOT NULL,
    min_order_amount numeric(10,2) DEFAULT 0,
    max_discount_amount numeric(10,2),
    usage_limit integer,
    usage_count integer DEFAULT 0,
    cities text[],
    valid_from timestamp with time zone DEFAULT now(),
    valid_until timestamp with time zone,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.promo_codes OWNER TO postgres;

--
-- Name: promos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promos (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    code text NOT NULL,
    type public.promo_type NOT NULL,
    value numeric NOT NULL,
    city text,
    start_at timestamp with time zone NOT NULL,
    end_at timestamp with time zone NOT NULL,
    max_uses integer,
    used integer DEFAULT 0
);


ALTER TABLE public.promos OWNER TO postgres;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    booking_id uuid NOT NULL,
    rater_user_id uuid NOT NULL,
    ratee_type public.ratee_type NOT NULL,
    ratee_id uuid NOT NULL,
    rating integer NOT NULL,
    comment text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: service_variants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_variants (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    price numeric(10,2),
    duration integer,
    service_id uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    base_price numeric(10,2),
    default_duration integer
);


ALTER TABLE public.service_variants OWNER TO postgres;

--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    category text NOT NULL,
    title text NOT NULL,
    unit public.service_unit DEFAULT 'fixed'::public.service_unit NOT NULL,
    base_price_cents integer NOT NULL,
    city text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    slug text,
    updated_at timestamp with time zone DEFAULT now(),
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    name text,
    description text,
    icon text,
    color text
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    role public.user_role DEFAULT 'customer'::public.user_role NOT NULL,
    name text,
    email text,
    phone text,
    status text DEFAULT 'active'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2025_09_27; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_09_27 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_09_27 OWNER TO supabase_admin;

--
-- Name: messages_2025_09_28; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_09_28 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_09_28 OWNER TO supabase_admin;

--
-- Name: messages_2025_09_29; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_09_29 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_09_29 OWNER TO supabase_admin;

--
-- Name: messages_2025_09_30; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_09_30 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_09_30 OWNER TO supabase_admin;

--
-- Name: messages_2025_10_01; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_10_01 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_10_01 OWNER TO supabase_admin;

--
-- Name: messages_2025_10_02; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_10_02 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_10_02 OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: iceberg_namespaces; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.iceberg_namespaces (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.iceberg_namespaces OWNER TO supabase_storage_admin;

--
-- Name: iceberg_tables; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.iceberg_tables (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    namespace_id uuid NOT NULL,
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    location text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.iceberg_tables OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


ALTER TABLE supabase_functions.hooks OWNER TO supabase_functions_admin;

--
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: supabase_functions_admin
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE supabase_functions.hooks_id_seq OWNER TO supabase_functions_admin;

--
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE supabase_functions.migrations OWNER TO supabase_functions_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- Name: messages_2025_09_27; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_09_27 FOR VALUES FROM ('2025-09-27 00:00:00') TO ('2025-09-28 00:00:00');


--
-- Name: messages_2025_09_28; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_09_28 FOR VALUES FROM ('2025-09-28 00:00:00') TO ('2025-09-29 00:00:00');


--
-- Name: messages_2025_09_29; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_09_29 FOR VALUES FROM ('2025-09-29 00:00:00') TO ('2025-09-30 00:00:00');


--
-- Name: messages_2025_09_30; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_09_30 FOR VALUES FROM ('2025-09-30 00:00:00') TO ('2025-10-01 00:00:00');


--
-- Name: messages_2025_10_01; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_10_01 FOR VALUES FROM ('2025-10-01 00:00:00') TO ('2025-10-02 00:00:00');


--
-- Name: messages_2025_10_02; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_10_02 FOR VALUES FROM ('2025-10-02 00:00:00') TO ('2025-10-03 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.extensions (id, type, settings, tenant_external_id, inserted_at, updated_at) FROM stdin;
4fb876f1-f146-4895-9066-715d02cf8dd7	postgres_cdc_rls	{"region": "us-east-1", "db_host": "Bw42kzhyGzcGVv91d0JuP/jFCgigVjtCzOxk96y/YXg=", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}	realtime-dev	2025-09-29 19:40:11	2025-09-29 19:40:11
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.schema_migrations (version, inserted_at) FROM stdin;
20210706140551	2025-09-21 19:49:38
20220329161857	2025-09-21 19:49:38
20220410212326	2025-09-21 19:49:38
20220506102948	2025-09-21 19:49:38
20220527210857	2025-09-21 19:49:38
20220815211129	2025-09-21 19:49:38
20220815215024	2025-09-21 19:49:38
20220818141501	2025-09-21 19:49:38
20221018173709	2025-09-21 19:49:38
20221102172703	2025-09-21 19:49:38
20221223010058	2025-09-21 19:49:38
20230110180046	2025-09-21 19:49:38
20230810220907	2025-09-21 19:49:38
20230810220924	2025-09-21 19:49:38
20231024094642	2025-09-21 19:49:38
20240306114423	2025-09-21 19:49:38
20240418082835	2025-09-21 19:49:38
20240625211759	2025-09-21 19:49:38
20240704172020	2025-09-21 19:49:38
20240902173232	2025-09-21 19:49:38
20241106103258	2025-09-21 19:49:38
20250424203323	2025-09-21 19:49:38
20250613072131	2025-09-21 19:49:38
20250711044927	2025-09-21 19:49:38
20250811121559	2025-09-21 19:49:38
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.tenants (id, name, external_id, jwt_secret, max_concurrent_users, inserted_at, updated_at, max_events_per_second, postgres_cdc_default, max_bytes_per_second, max_channels_per_client, max_joins_per_second, suspend, jwt_jwks, notify_private_alpha, private_only, migrations_ran, broadcast_adapter, max_presence_events_per_second, max_payload_size_in_kb) FROM stdin;
f0a5b349-0bf7-4bbb-9cde-15cec4bd74bf	realtime-dev	realtime-dev	iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==	200	2025-09-29 19:40:11	2025-09-29 19:40:11	100	postgres_cdc_rls	100000	100	100	f	{"keys": [{"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}	f	f	63	gen_rpc	10000	3000
\.


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	34648143-ef89-4796-8769-81ba8f8b4283	{"action":"user_signedup","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-21 19:55:25.131827+00	
00000000-0000-0000-0000-000000000000	3f21683f-aa59-4175-80c0-47cd6a0e7eda	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-21 19:55:25.13564+00	
00000000-0000-0000-0000-000000000000	d6ae76ed-ddc1-410b-8922-1db3a17ce3a1	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-21 20:06:43.828529+00	
00000000-0000-0000-0000-000000000000	3f1e2fae-6410-478b-b80b-132c7b152d2d	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-21 20:33:49.66825+00	
00000000-0000-0000-0000-000000000000	df4ad4df-db2e-4476-9c8d-d75b37e5316e	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-21 20:34:29.099489+00	
00000000-0000-0000-0000-000000000000	fb7a7382-e71e-438d-97f4-b1983e40be7e	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-21 21:18:30.26442+00	
00000000-0000-0000-0000-000000000000	833a95db-7ccb-435e-856a-675b6b986e6b	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-21 21:18:53.423622+00	
00000000-0000-0000-0000-000000000000	b01c2a53-bcfe-4e7a-91fd-626b6dfe93a2	{"action":"token_refreshed","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-09-21 22:17:11.853392+00	
00000000-0000-0000-0000-000000000000	858867d0-b935-4672-84ee-2e3875bb7c49	{"action":"token_revoked","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-09-21 22:17:11.854346+00	
00000000-0000-0000-0000-000000000000	5e99fe61-b08a-4a3e-bd95-bff215a0d7bf	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-22 03:20:30.214867+00	
00000000-0000-0000-0000-000000000000	8f7f1454-9da5-46ae-880b-eccbfc0ba666	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-22 03:20:49.316085+00	
00000000-0000-0000-0000-000000000000	a8608605-6904-4417-b93b-207c950a879b	{"action":"token_refreshed","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 04:19:05.097595+00	
00000000-0000-0000-0000-000000000000	3dc35d46-1912-4b0d-9361-5ce22a0768df	{"action":"token_revoked","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 04:19:05.098732+00	
00000000-0000-0000-0000-000000000000	982e9384-963f-4a3f-a599-06c89479f203	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-28 18:37:05.544314+00	
00000000-0000-0000-0000-000000000000	04b84c96-0895-40f4-a827-9bb133187e01	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-28 18:52:18.104873+00	
00000000-0000-0000-0000-000000000000	bf04eefc-4f74-451a-be06-cf9af2ea71ca	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-28 19:00:18.575662+00	
00000000-0000-0000-0000-000000000000	79211c1b-7344-4fb1-80d5-fdc4f6337ad1	{"action":"token_refreshed","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-09-28 19:58:29.543522+00	
00000000-0000-0000-0000-000000000000	d089a023-8d27-4db1-99c3-c8446a525e56	{"action":"token_revoked","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-09-28 19:58:29.544334+00	
00000000-0000-0000-0000-000000000000	dedb5252-da7b-42e4-9da7-1221f6dec3f4	{"action":"login","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-29 18:59:25.568741+00	
00000000-0000-0000-0000-000000000000	adc48fa4-da76-4eb7-8975-6a06112b993a	{"action":"token_refreshed","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-09-29 19:57:53.942715+00	
00000000-0000-0000-0000-000000000000	1af55d18-8455-48a1-9fb4-f1f5f57c5d2a	{"action":"token_revoked","actor_id":"cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-09-29 19:57:53.943889+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	{"sub": "cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31", "email": "test@test.com", "email_verified": false, "phone_verified": false}	email	2025-09-21 19:55:25.130513+00	2025-09-21 19:55:25.130538+00	2025-09-21 19:55:25.130538+00	e5537f30-051f-419d-8bb3-881641c3295f
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
eb4c4cd3-5573-48c5-bf75-08daa6e6364e	2025-09-21 19:55:25.144215+00	2025-09-21 19:55:25.144215+00	password	0f71aa76-113b-4158-8a03-636339725756
6deecc28-70cd-4e76-98fe-69f4c47b93c6	2025-09-21 20:06:43.830475+00	2025-09-21 20:06:43.830475+00	password	e0edd7c2-de68-4ba2-a858-a73706b0bf3c
5ad90bd4-8eea-41e6-9284-e494c40767bf	2025-09-21 20:33:49.671162+00	2025-09-21 20:33:49.671162+00	password	53e2d63c-e526-4998-8c9c-c762600623bc
4b8035b0-ec33-4273-9a46-08a7b3db9888	2025-09-21 20:34:29.102341+00	2025-09-21 20:34:29.102341+00	password	ee09406b-bdb8-40cd-b0eb-be86859333f4
4fd60e6a-ab99-4b3e-b5e0-951848cf9ff3	2025-09-21 21:18:30.266767+00	2025-09-21 21:18:30.266767+00	password	dfd9f8ea-5dd0-46b6-af7f-097547a0fcb0
c9e1b274-80bf-4d3b-a329-859c359e80f0	2025-09-21 21:18:53.425063+00	2025-09-21 21:18:53.425063+00	password	391d09c8-ec68-4c50-b671-8b5f9bd74d0b
2980455b-3d7e-406c-acf2-594782e88601	2025-09-22 03:20:30.21922+00	2025-09-22 03:20:30.21922+00	password	6ba65fe0-867b-42a8-a740-dd34f294ae40
ddd8cf90-8e8d-4cfb-a04d-31c9ab42b6e7	2025-09-22 03:20:49.329611+00	2025-09-22 03:20:49.329611+00	password	5004b40b-0805-4c70-a140-a6aeacd16e3b
6dc4cc91-a12b-4f08-8b23-ae8e033c92b7	2025-09-28 18:37:05.549367+00	2025-09-28 18:37:05.549367+00	password	31ccc985-ddfc-48e6-ab2b-84f88f2e9d26
cc144dbd-f714-45fe-a7f8-5e63fb5b4508	2025-09-28 18:52:18.106995+00	2025-09-28 18:52:18.106995+00	password	66d1787f-2e34-4d8e-8691-3c8451b7053d
75ee9d0e-2a29-403a-8c37-bcac516b5c96	2025-09-28 19:00:18.577817+00	2025-09-28 19:00:18.577817+00	password	e4ff787d-b5f4-4def-afa2-b867e3f4bb77
1a917c92-5c8d-4466-989e-488c5deb0d3f	2025-09-29 18:59:25.573718+00	2025-09-29 18:59:25.573718+00	password	2544c795-b37c-45b5-bc95-bf9b53628a8a
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	pxjuvd7pyxna	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-21 19:55:25.14272+00	2025-09-21 19:55:25.14272+00	\N	eb4c4cd3-5573-48c5-bf75-08daa6e6364e
00000000-0000-0000-0000-000000000000	2	ifotw3v6wsey	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-21 20:06:43.829771+00	2025-09-21 20:06:43.829771+00	\N	6deecc28-70cd-4e76-98fe-69f4c47b93c6
00000000-0000-0000-0000-000000000000	3	j5tgwjbk2k7t	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-21 20:33:49.670333+00	2025-09-21 20:33:49.670333+00	\N	5ad90bd4-8eea-41e6-9284-e494c40767bf
00000000-0000-0000-0000-000000000000	4	przf745lptgk	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-21 20:34:29.101166+00	2025-09-21 20:34:29.101166+00	\N	4b8035b0-ec33-4273-9a46-08a7b3db9888
00000000-0000-0000-0000-000000000000	5	pywsubjikpdq	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-21 21:18:30.265958+00	2025-09-21 21:18:30.265958+00	\N	4fd60e6a-ab99-4b3e-b5e0-951848cf9ff3
00000000-0000-0000-0000-000000000000	6	o52faaqlll4z	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	t	2025-09-21 21:18:53.424533+00	2025-09-21 22:17:11.854972+00	\N	c9e1b274-80bf-4d3b-a329-859c359e80f0
00000000-0000-0000-0000-000000000000	7	lata2fqbtjjj	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-21 22:17:11.86301+00	2025-09-21 22:17:11.86301+00	o52faaqlll4z	c9e1b274-80bf-4d3b-a329-859c359e80f0
00000000-0000-0000-0000-000000000000	8	uolym5qmi7lh	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-22 03:20:30.218351+00	2025-09-22 03:20:30.218351+00	\N	2980455b-3d7e-406c-acf2-594782e88601
00000000-0000-0000-0000-000000000000	9	4muaj6icoudg	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	t	2025-09-22 03:20:49.32237+00	2025-09-22 04:19:05.099329+00	\N	ddd8cf90-8e8d-4cfb-a04d-31c9ab42b6e7
00000000-0000-0000-0000-000000000000	10	ljrmywwv3bhh	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-22 04:19:05.100455+00	2025-09-22 04:19:05.100455+00	4muaj6icoudg	ddd8cf90-8e8d-4cfb-a04d-31c9ab42b6e7
00000000-0000-0000-0000-000000000000	11	2x44pxbtag5u	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-28 18:37:05.547233+00	2025-09-28 18:37:05.547233+00	\N	6dc4cc91-a12b-4f08-8b23-ae8e033c92b7
00000000-0000-0000-0000-000000000000	12	23uq37pnzywn	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-28 18:52:18.106358+00	2025-09-28 18:52:18.106358+00	\N	cc144dbd-f714-45fe-a7f8-5e63fb5b4508
00000000-0000-0000-0000-000000000000	13	fmho7irv6jxm	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	t	2025-09-28 19:00:18.577089+00	2025-09-28 19:58:29.544818+00	\N	75ee9d0e-2a29-403a-8c37-bcac516b5c96
00000000-0000-0000-0000-000000000000	14	cvopkmcxvsxc	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-28 19:58:29.548503+00	2025-09-28 19:58:29.548503+00	fmho7irv6jxm	75ee9d0e-2a29-403a-8c37-bcac516b5c96
00000000-0000-0000-0000-000000000000	15	g4ql7wqayobu	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	t	2025-09-29 18:59:25.572292+00	2025-09-29 19:57:53.944505+00	\N	1a917c92-5c8d-4466-989e-488c5deb0d3f
00000000-0000-0000-0000-000000000000	16	h2t3vtucyd5p	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	f	2025-09-29 19:57:53.945377+00	2025-09-29 19:57:53.945377+00	g4ql7wqayobu	1a917c92-5c8d-4466-989e-488c5deb0d3f
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
eb4c4cd3-5573-48c5-bf75-08daa6e6364e	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-21 19:55:25.141512+00	2025-09-21 19:55:25.141512+00	\N	aal1	\N	\N	Expo/54.0.5 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	142.250.77.202	\N
6deecc28-70cd-4e76-98fe-69f4c47b93c6	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-21 20:06:43.829195+00	2025-09-21 20:06:43.829195+00	\N	aal1	\N	\N	Expo/54.0.5 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	142.250.77.202	\N
5ad90bd4-8eea-41e6-9284-e494c40767bf	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-21 20:33:49.669536+00	2025-09-21 20:33:49.669536+00	\N	aal1	\N	\N	Expo/54.0.5 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	142.250.77.202	\N
4b8035b0-ec33-4273-9a46-08a7b3db9888	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-21 20:34:29.100514+00	2025-09-21 20:34:29.100514+00	\N	aal1	\N	\N	Expo/54.0.5 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	142.250.77.202	\N
4fd60e6a-ab99-4b3e-b5e0-951848cf9ff3	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-21 21:18:30.265254+00	2025-09-21 21:18:30.265254+00	\N	aal1	\N	\N	Expo/54.0.5 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	142.250.77.202	\N
c9e1b274-80bf-4d3b-a329-859c359e80f0	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-21 21:18:53.42409+00	2025-09-21 22:17:11.864462+00	\N	aal1	\N	2025-09-21 22:17:11.864401	Expo/54.0.5 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	142.250.77.202	\N
2980455b-3d7e-406c-acf2-594782e88601	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-22 03:20:30.215987+00	2025-09-22 03:20:30.215987+00	\N	aal1	\N	\N	Expo/54.0.5 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	142.250.77.202	\N
ddd8cf90-8e8d-4cfb-a04d-31c9ab42b6e7	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-22 03:20:49.318998+00	2025-09-22 04:19:05.102449+00	\N	aal1	\N	2025-09-22 04:19:05.102368	Expo/54.0.5 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	142.250.77.202	\N
6dc4cc91-a12b-4f08-8b23-ae8e033c92b7	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-28 18:37:05.545905+00	2025-09-28 18:37:05.545905+00	\N	aal1	\N	\N	Expo/54.0.6 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	172.18.0.1	\N
cc144dbd-f714-45fe-a7f8-5e63fb5b4508	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-28 18:52:18.105966+00	2025-09-28 18:52:18.105966+00	\N	aal1	\N	\N	Expo/54.0.6 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	172.18.0.1	\N
75ee9d0e-2a29-403a-8c37-bcac516b5c96	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-28 19:00:18.576502+00	2025-09-28 19:58:29.549844+00	\N	aal1	\N	2025-09-28 19:58:29.549783	Expo/54.0.6 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	172.18.0.1	\N
1a917c92-5c8d-4466-989e-488c5deb0d3f	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-29 18:59:25.570657+00	2025-09-29 19:57:53.947147+00	\N	aal1	\N	2025-09-29 19:57:53.94711	Expo/54.0.6 CFNetwork/3826.500.111.2.2 Darwin/25.0.0	172.217.26.42	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\N	550e8400-e29b-41d4-a716-446655441001	\N	authenticated	hero1@example.com	\N	2025-09-29 17:53:32.010359+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	authenticated	authenticated	test@test.com	$2a$10$3wSdRi/2jn5b7MJlsRFi0uCRQczBGuwl6W5U.SZffAbinpzAsx9rG	2025-09-21 19:55:25.132287+00	\N		\N		\N			\N	2025-09-29 18:59:25.570592+00	{"provider": "email", "providers": ["email"]}	{"sub": "cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31", "email": "test@test.com", "email_verified": true, "phone_verified": false}	\N	2025-09-21 19:55:25.103497+00	2025-09-29 19:57:53.946251+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: add_ons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.add_ons (id, service_id, name, description, price, category, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id, user_id, label, line1, line2, city, province, postal_code, lat, lng) FROM stdin;
df1059b3-ae89-4a32-82f3-7a31c976653f	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	\N	123 Main Street	\N	Kelowna	BC	V1Y 2A3	49.8801	-119.4436
\.


--
-- Data for Name: booking_add_ons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking_add_ons (id, booking_id, add_on_id, quantity, unit_price, total_price, created_at) FROM stdin;
\.


--
-- Data for Name: booking_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking_events (id, booking_id, type, meta_json, created_at) FROM stdin;
\.


--
-- Data for Name: booking_status_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking_status_history (id, booking_id, status, notes, created_by, created_at) FROM stdin;
309ea213-8fdc-4ab8-99b3-3de304f08363	e82a4c37-c672-4ef7-95ab-5032b2b2e22b	requested	Booking created and payment authorized	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	2025-09-29 19:27:14.627677+00
b1901849-3f3c-4752-8cc7-180335ebaaef	51616905-9ae2-40c2-8b2e-de03e0f00549	requested	Initial status	\N	2025-09-29 19:29:58.408407+00
9e53bcbb-e526-457f-bf13-0192e851e9fd	f3fe9b6c-1a28-4e62-85e5-6218f3f2ac87	requested	Booking created and payment authorized	\N	2025-09-29 19:32:28.973288+00
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id, customer_id, contractor_id, hero_id, address_id, scheduled_at, duration_min, status, price_cents, currency, tip_cents, notes, created_at, updated_at, service_id, service_variant_id, service_name, variant_name, scheduled_date, scheduled_time, duration, address_street, address_city, address_postal_code, base_price, call_out_fee, add_on_total, subtotal, tax_amount, special_instructions, total_amount) FROM stdin;
51616905-9ae2-40c2-8b2e-de03e0f00549	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	550e8400-e29b-41d4-a716-446655440000	550e8400-e29b-41d4-a716-446655440001	df1059b3-ae89-4a32-82f3-7a31c976653f	2025-10-15 14:30:00+00	180	requested	18374	CAD	0	\N	2025-09-29 18:47:22.543162+00	2025-09-29 18:47:22.543162+00	a7e4e848-5864-47e4-8ce7-b2ef3735144d	435ffb09-41c4-475b-95ab-371c992030a3	Maid Services	Deep Cleaning	2025-10-15	14:30	\N	\N	\N	\N	0.00	0.00	0.00	0.00	0.00	Please focus on kitchen and bathrooms	\N
e82a4c37-c672-4ef7-95ab-5032b2b2e22b	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	550e8400-e29b-41d4-a716-446655440000	550e8400-e29b-41d4-a716-446655440001	\N	2025-09-29 19:27:12.522+00	180	requested	17372	CAD	0	\N	2025-09-29 19:27:12.553636+00	2025-09-29 19:27:12.553636+00	a7e4e848-5864-47e4-8ce7-b2ef3735144d	435ffb09-41c4-475b-95ab-371c992030a3	Maid Services	Deep Cleaning	2025-10-29	00:57	180	Fifth	Penticton	E456t	155.10	0.00	0.00	155.10	18.61	\N	173.72
f3fe9b6c-1a28-4e62-85e5-6218f3f2ac87	cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	550e8400-e29b-41d4-a716-446655440000	550e8400-e29b-41d4-a716-446655440001	\N	2025-09-29 19:32:26.89+00	180	requested	18102	CAD	0	\N	2025-09-29 19:32:26.922212+00	2025-09-29 19:32:26.922212+00	a7e4e848-5864-47e4-8ce7-b2ef3735144d	435ffb09-41c4-475b-95ab-371c992030a3	Maid Services	Deep Cleaning	2025-10-29	01:02	180	4r6345gc	Penticton	45t32	161.63	0.00	0.00	161.63	19.40	\N	181.02
\.


--
-- Data for Name: contractors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contractors (id, name, status, contract_terms, gst_number, insurance_doc_url, city_coverage, categories, commission_pct, pricing_floors_json, sla_json, stripe_connect_id, created_at, updated_at) FROM stdin;
550e8400-e29b-41d4-a716-446655440000	CleanPro Services	active	\N	\N	\N	{Kelowna,Vernon}	{Cleaning,Home}	15.00	\N	\N	\N	2025-09-29 17:51:36.202861+00	2025-09-29 17:51:36.202861+00
\.


--
-- Data for Name: cs_notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cs_notes (id, subject_type, subject_id, author_user_id, note, created_at) FROM stdin;
\.


--
-- Data for Name: gps_pings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gps_pings (id, booking_id, hero_id, lat, lng, speed, ts) FROM stdin;
\.


--
-- Data for Name: hero_availability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hero_availability (id, hero_id, day_of_week, start_time, end_time, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: hero_service_areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hero_service_areas (id, hero_id, city, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: hero_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hero_services (id, hero_id, service_id, price_multiplier, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: heros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.heros (id, contractor_id, user_id, name, alias, photo_url, skills, categories, rating_avg, rating_count, bio, badges, status, verification_status, availability_json, docs_json, created_at, updated_at) FROM stdin;
550e8400-e29b-41d4-a716-446655440001	550e8400-e29b-41d4-a716-446655440000	550e8400-e29b-41d4-a716-446655441001	Lisa Thompson	Lisa T.	\N	{Cleaning,Organization}	{Cleaning}	4.80	94	Professional cleaner with 5+ years of experience	{Insured,"Background Check"}	active	verified	\N	\N	2025-09-29 17:53:32.010359+00	2025-09-29 18:20:25.38255+00
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, booking_id, stripe_pi, amount_cents, currency, status, captured_at, refunded_cents, refund_reason) FROM stdin;
e3025605-d444-494a-9dcf-69b6b3f7f1a1	e82a4c37-c672-4ef7-95ab-5032b2b2e22b	pi_mock_1759174034571	17372	CAD	authorized	\N	0	\N
d9cb024b-410c-4865-adaf-f036b2c2a7ee	f3fe9b6c-1a28-4e62-85e5-6218f3f2ac87	pi_mock_1759174348938	18102	CAD	authorized	\N	0	\N
\.


--
-- Data for Name: payouts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payouts (id, contractor_id, stripe_transfer_id, amount_cents, status, period_start, period_end) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, role, name, email, phone, status, created_at, updated_at) FROM stdin;
cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	customer	\N	test@test.com	\N	active	2025-09-21 19:55:25.099474+00	2025-09-21 19:55:25.099474+00
550e8400-e29b-41d4-a716-446655441001	customer	\N	hero1@example.com	\N	active	2025-09-29 17:53:32.010359+00	2025-09-29 17:53:32.010359+00
\.


--
-- Data for Name: promo_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promo_codes (id, code, name, description, discount_type, discount_value, min_order_amount, max_discount_amount, usage_limit, usage_count, cities, valid_from, valid_until, is_active, created_at) FROM stdin;
1b15f39c-377e-4714-9b9a-6b088a9111e2	WELCOME25	Welcome Bonus	Get 25% off your first booking with HomeHeros	percentage	25.00	50.00	\N	1000	0	{Kamloops,Kelowna,Vernon,Penticton,"West Kelowna","Salmon Arm"}	2025-09-29 17:49:51.484791+00	2025-12-31 23:59:59+00	t	2025-09-29 17:49:51.484791+00
f13ab069-af57-4377-b3d2-0b13637041ee	CLEAN15	Cleaning Special	15% off any cleaning service this month	percentage	15.00	100.00	\N	500	0	{Kamloops,Kelowna,Vernon,Penticton,"West Kelowna","Salmon Arm"}	2025-09-29 17:49:51.484791+00	2025-10-31 23:59:59+00	t	2025-09-29 17:49:51.484791+00
434bc3cf-c613-468d-8465-78bb733d821d	REFER10	Refer a Friend	Get $10 credit when you refer a friend	fixed_amount	10.00	0.00	\N	\N	0	{Kamloops,Kelowna,Vernon,Penticton,"West Kelowna","Salmon Arm"}	2025-09-29 17:49:51.484791+00	\N	t	2025-09-29 17:49:51.484791+00
\.


--
-- Data for Name: promos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promos (id, code, type, value, city, start_at, end_at, max_uses, used) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, booking_id, rater_user_id, ratee_type, ratee_id, rating, comment, created_at) FROM stdin;
\.


--
-- Data for Name: service_variants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_variants (id, name, slug, description, price, duration, service_id, created_at, updated_at, base_price, default_duration) FROM stdin;
435ffb09-41c4-475b-95ab-371c992030a3	Deep Cleaning	deep-cleaning	Thorough cleaning of all areas including hard-to-reach spots	149.99	180	a7e4e848-5864-47e4-8ce7-b2ef3735144d	2025-09-29 17:50:50.386427+00	2025-09-29 17:50:50.386427+00	149.99	180
d80fd95a-3142-4715-b1a2-bfae9768ac2e	Regular Cleaning	regular-cleaning	Standard cleaning of visible areas and surfaces	89.99	120	a7e4e848-5864-47e4-8ce7-b2ef3735144d	2025-09-29 17:50:50.386427+00	2025-09-29 17:50:50.386427+00	89.99	120
ef97262a-2b18-4d0d-baea-c692fd847a8f	Move In/Out Cleaning	move-in-out	Detailed cleaning for moving in or out of a property	199.99	240	a7e4e848-5864-47e4-8ce7-b2ef3735144d	2025-09-29 17:50:50.386427+00	2025-09-29 17:50:50.386427+00	199.99	240
1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d	Personal Chef	personal-chef	Professional chef cooking in your home	120.00	180	ee14d670-dc09-462a-8cf9-e976f87b27ef	2025-09-29 18:12:26.517875+00	2025-09-29 18:12:26.517875+00	120.00	180
2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e	Event Catering	event-catering	Catering for special events	200.00	240	ee14d670-dc09-462a-8cf9-e976f87b27ef	2025-09-29 18:12:26.517875+00	2025-09-29 18:12:26.517875+00	200.00	240
3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f	Birthday Party	birthday-party	Birthday party planning and coordination	250.00	300	98475f64-5061-46a0-adb7-c71327720cca	2025-09-29 18:12:26.517875+00	2025-09-29 18:12:26.517875+00	250.00	300
4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a	Wedding Planning	wedding-planning	Complete wedding planning services	500.00	480	98475f64-5061-46a0-adb7-c71327720cca	2025-09-29 18:12:26.517875+00	2025-09-29 18:12:26.517875+00	500.00	480
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, category, title, unit, base_price_cents, city, active, slug, updated_at, is_active, created_at, name, description, icon, color) FROM stdin;
a7e4e848-5864-47e4-8ce7-b2ef3735144d	Cleaning	Maid Services	fixed	6000	Kelowna	t	maid-services	2025-09-29 19:46:01.821319+00	t	2025-09-29 18:03:53.900051+00	Maid Services	Professional cleaning services for your home	home-outline	#4CAF50
ee14d670-dc09-462a-8cf9-e976f87b27ef	Food	Cooks & Chefs	hourly	8000	Kelowna	t	cooks-chefs	2025-09-29 19:46:01.822683+00	t	2025-09-29 18:03:53.900051+00	Cooks & Chefs	Professional cooking services for events and daily meals	restaurant-outline	#FF9800
98475f64-5061-46a0-adb7-c71327720cca	Events	Event Planning	fixed	15000	Kelowna	t	event-planning	2025-09-29 19:46:01.823465+00	t	2025-09-29 18:03:53.900051+00	Event Planning	Professional event planning and coordination services	calendar-outline	#2196F3
b0a24f12-c493-4c18-8263-7d3bfb0c1b1f	Home	Handyman	hourly	7500	Kelowna	t	handyman	2025-09-29 18:20:25.370442+00	t	2025-09-29 18:03:53.900051+00	Handyman	Professional handyman services	hammer-outline	#795548
d5f5c7e3-2b88-4b9f-8a47-e91f4c6e2f0d	Auto	Car Detailing	fixed	12000	Kelowna	t	car-detailing	2025-09-29 18:20:25.370442+00	t	2025-09-29 18:03:53.900051+00	Car Detailing	Professional car detailing services	car-outline	#607D8B
f8a2b6c1-d7e3-4f9a-b0c5-e1d2c3b4a5f6	Beauty	Personal Care	hourly	9000	Kelowna	t	personal-care	2025-09-29 18:20:25.370442+00	t	2025-09-29 18:03:53.900051+00	Personal Care	Professional personal care services	person-outline	#9C27B0
a1b2c3d4-e5f6-4a5b-8c7d-9e0f1a2b3c4d	Pest	Pest Control	fixed	11000	Kelowna	t	pest-control	2025-09-29 18:20:25.370442+00	t	2025-09-29 18:03:53.900051+00	Pest Control	Professional pest control services	bug-outline	#F44336
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, role, name, email, phone, status, created_at) FROM stdin;
cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31	customer	Test User	test@test.com	+12505550000	active	2025-09-29 17:53:15.17748+00
550e8400-e29b-41d4-a716-446655441001	hero	Lisa Thompson	hero1@example.com	+12505551001	active	2025-09-29 17:53:32.010359+00
\.


--
-- Data for Name: messages_2025_09_27; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_09_27 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_09_28; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_09_28 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_09_29; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_09_29 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_09_30; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_09_30 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_10_01; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_10_01 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_10_02; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_10_02 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-09-21 19:49:38
20211116045059	2025-09-21 19:49:38
20211116050929	2025-09-21 19:49:38
20211116051442	2025-09-21 19:49:38
20211116212300	2025-09-21 19:49:38
20211116213355	2025-09-21 19:49:38
20211116213934	2025-09-21 19:49:38
20211116214523	2025-09-21 19:49:38
20211122062447	2025-09-21 19:49:38
20211124070109	2025-09-21 19:49:38
20211202204204	2025-09-21 19:49:38
20211202204605	2025-09-21 19:49:38
20211210212804	2025-09-21 19:49:38
20211228014915	2025-09-21 19:49:38
20220107221237	2025-09-21 19:49:38
20220228202821	2025-09-21 19:49:38
20220312004840	2025-09-21 19:49:38
20220603231003	2025-09-21 19:49:38
20220603232444	2025-09-21 19:49:38
20220615214548	2025-09-21 19:49:38
20220712093339	2025-09-21 19:49:38
20220908172859	2025-09-21 19:49:38
20220916233421	2025-09-21 19:49:38
20230119133233	2025-09-21 19:49:38
20230128025114	2025-09-21 19:49:38
20230128025212	2025-09-21 19:49:38
20230227211149	2025-09-21 19:49:38
20230228184745	2025-09-21 19:49:38
20230308225145	2025-09-21 19:49:38
20230328144023	2025-09-21 19:49:38
20231018144023	2025-09-21 19:49:38
20231204144023	2025-09-21 19:49:38
20231204144024	2025-09-21 19:49:38
20231204144025	2025-09-21 19:49:38
20240108234812	2025-09-21 19:49:38
20240109165339	2025-09-21 19:49:38
20240227174441	2025-09-21 19:49:38
20240311171622	2025-09-21 19:49:38
20240321100241	2025-09-21 19:49:38
20240401105812	2025-09-21 19:49:38
20240418121054	2025-09-21 19:49:38
20240523004032	2025-09-21 19:49:38
20240618124746	2025-09-21 19:49:38
20240801235015	2025-09-21 19:49:38
20240805133720	2025-09-21 19:49:38
20240827160934	2025-09-21 19:49:38
20240919163303	2025-09-21 19:49:38
20240919163305	2025-09-21 19:49:38
20241019105805	2025-09-21 19:49:38
20241030150047	2025-09-21 19:49:39
20241108114728	2025-09-21 19:49:39
20241121104152	2025-09-21 19:49:39
20241130184212	2025-09-21 19:49:39
20241220035512	2025-09-21 19:49:39
20241220123912	2025-09-21 19:49:39
20241224161212	2025-09-21 19:49:39
20250107150512	2025-09-21 19:49:39
20250110162412	2025-09-21 19:49:39
20250123174212	2025-09-21 19:49:39
20250128220012	2025-09-21 19:49:39
20250506224012	2025-09-21 19:49:39
20250523164012	2025-09-21 19:49:39
20250714121412	2025-09-21 19:49:39
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
avatars	avatars	\N	2025-09-21 19:49:40.431047+00	2025-09-21 19:49:40.431047+00	t	f	\N	\N	\N	STANDARD
documents	documents	\N	2025-09-21 19:49:40.431047+00	2025-09-21 19:49:40.431047+00	f	f	\N	\N	\N	STANDARD
booking_photos	booking_photos	\N	2025-09-21 19:49:40.431047+00	2025-09-21 19:49:40.431047+00	f	f	\N	\N	\N	STANDARD
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (id, type, format, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: iceberg_namespaces; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.iceberg_namespaces (id, bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: iceberg_tables; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.iceberg_tables (id, namespace_id, bucket_id, name, location, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-09-21 19:49:39.999992
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-09-21 19:49:40.001106
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-09-21 19:49:40.001597
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-09-21 19:49:40.004366
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-09-21 19:49:40.005847
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-09-21 19:49:40.006179
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-09-21 19:49:40.00771
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-09-21 19:49:40.008209
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-09-21 19:49:40.008528
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-09-21 19:49:40.008879
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-09-21 19:49:40.009366
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-09-21 19:49:40.010074
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-09-21 19:49:40.010588
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-09-21 19:49:40.010882
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-09-21 19:49:40.011185
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-09-21 19:49:40.014833
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-09-21 19:49:40.015329
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-09-21 19:49:40.015732
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-09-21 19:49:40.016171
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-09-21 19:49:40.016721
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-09-21 19:49:40.017027
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-09-21 19:49:40.017835
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-09-21 19:49:40.019811
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-09-21 19:49:40.021545
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-09-21 19:49:40.022111
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-09-21 19:49:40.022561
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-09-21 19:49:40.022921
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-09-21 19:49:40.025299
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-09-21 19:49:40.02635
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-09-21 19:49:40.027003
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-09-21 19:49:40.027553
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-09-21 19:49:40.028168
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-09-21 19:49:40.028911
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-09-21 19:49:40.029508
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-09-21 19:49:40.029647
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-09-21 19:49:40.030706
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-09-21 19:49:40.031008
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-09-21 19:49:40.032539
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2025-09-21 19:49:40.03302
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.hooks (id, hook_table_id, hook_name, created_at, request_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.migrations (version, inserted_at) FROM stdin;
initial	2025-09-21 19:49:28.367314+00
20210809183423_update_grants	2025-09-21 19:49:28.367314+00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name) FROM stdin;
20250101000000	{"-- Create schema for HomeHeros platform\n-- Initial migration with core tables based on QRD\n\n-- Enable PostGIS for location-based features\nCREATE EXTENSION IF NOT EXISTS postgis","-- Create enum types for various statuses\nCREATE TYPE user_role AS ENUM ('customer', 'hero', 'admin', 'cs', 'finance', 'contractor_manager')","CREATE TYPE booking_status AS ENUM ('requested', 'awaiting_hero_accept', 'enroute', 'arrived', 'in_progress', 'completed', 'rated', 'declined', 'expired', 'cancelled_by_customer', 'cancelled_by_admin', 'reassigned', 'dispute', 'refund_partial', 'refund_full')","CREATE TYPE service_unit AS ENUM ('fixed', 'hourly')","CREATE TYPE promo_type AS ENUM ('amount', 'percent')","CREATE TYPE ratee_type AS ENUM ('hero', 'contractor')","-- Create tables based on ERD from QRD\n\n-- Contractors table\nCREATE TABLE contractors (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  name TEXT NOT NULL,\n  status TEXT NOT NULL DEFAULT 'pending',\n  contract_terms JSONB,\n  gst_number TEXT,\n  insurance_doc_url TEXT,\n  city_coverage TEXT[] NOT NULL DEFAULT '{}',\n  categories TEXT[] NOT NULL DEFAULT '{}',\n  commission_pct NUMERIC(5, 2) NOT NULL DEFAULT 15.00,\n  pricing_floors_json JSONB,\n  sla_json JSONB,\n  stripe_connect_id TEXT,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()\n)","-- Users table (extends Supabase auth.users)\nCREATE TABLE users (\n  id UUID PRIMARY KEY REFERENCES auth.users(id),\n  role user_role NOT NULL DEFAULT 'customer',\n  name TEXT,\n  email TEXT UNIQUE,\n  phone TEXT UNIQUE,\n  status TEXT NOT NULL DEFAULT 'active',\n  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()\n)","-- Heros table\nCREATE TABLE heros (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  contractor_id UUID NOT NULL REFERENCES contractors(id),\n  user_id UUID NOT NULL REFERENCES users(id),\n  name TEXT NOT NULL,\n  alias TEXT,\n  photo_url TEXT,\n  skills TEXT[] DEFAULT '{}',\n  categories TEXT[] DEFAULT '{}',\n  rating_avg NUMERIC(3, 2) DEFAULT 0,\n  rating_count INTEGER DEFAULT 0,\n  bio TEXT,\n  badges TEXT[] DEFAULT '{}',\n  status TEXT NOT NULL DEFAULT 'pending',\n  verification_status TEXT NOT NULL DEFAULT 'pending',\n  availability_json JSONB,\n  docs_json JSONB,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()\n)","-- Addresses table\nCREATE TABLE addresses (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  user_id UUID NOT NULL REFERENCES users(id),\n  label TEXT,\n  line1 TEXT NOT NULL,\n  line2 TEXT,\n  city TEXT NOT NULL,\n  province TEXT NOT NULL,\n  postal_code TEXT NOT NULL,\n  lat NUMERIC,\n  lng NUMERIC,\n  geom GEOGRAPHY(POINT) GENERATED ALWAYS AS (ST_SetSRID(ST_MakePoint(lng, lat), 4326)::geography) STORED\n)","-- Services table\nCREATE TABLE services (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  category TEXT NOT NULL,\n  title TEXT NOT NULL,\n  unit service_unit NOT NULL DEFAULT 'fixed',\n  base_price_cents INTEGER NOT NULL,\n  city TEXT NOT NULL,\n  active BOOLEAN NOT NULL DEFAULT true\n)","-- Bookings table\nCREATE TABLE bookings (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  customer_id UUID NOT NULL REFERENCES users(id),\n  contractor_id UUID NOT NULL REFERENCES contractors(id),\n  hero_id UUID REFERENCES heros(id),\n  service_id UUID NOT NULL REFERENCES services(id),\n  address_id UUID NOT NULL REFERENCES addresses(id),\n  scheduled_at TIMESTAMPTZ NOT NULL,\n  duration_min INTEGER NOT NULL,\n  status booking_status NOT NULL DEFAULT 'requested',\n  price_cents INTEGER NOT NULL,\n  currency TEXT NOT NULL DEFAULT 'CAD',\n  tip_cents INTEGER DEFAULT 0,\n  notes TEXT,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()\n)","-- BookingEvents table\nCREATE TABLE booking_events (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  booking_id UUID NOT NULL REFERENCES bookings(id),\n  type TEXT NOT NULL,\n  meta_json JSONB,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()\n)","-- GpsPings table\nCREATE TABLE gps_pings (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  booking_id UUID NOT NULL REFERENCES bookings(id),\n  hero_id UUID NOT NULL REFERENCES heros(id),\n  lat NUMERIC NOT NULL,\n  lng NUMERIC NOT NULL,\n  speed NUMERIC,\n  ts TIMESTAMPTZ NOT NULL DEFAULT NOW(),\n  geom GEOGRAPHY(POINT) GENERATED ALWAYS AS (ST_SetSRID(ST_MakePoint(lng, lat), 4326)::geography) STORED\n)","-- Payments table\nCREATE TABLE payments (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  booking_id UUID NOT NULL REFERENCES bookings(id),\n  stripe_pi TEXT,\n  amount_cents INTEGER NOT NULL,\n  currency TEXT NOT NULL DEFAULT 'CAD',\n  status TEXT NOT NULL,\n  captured_at TIMESTAMPTZ,\n  refunded_cents INTEGER DEFAULT 0,\n  refund_reason TEXT\n)","-- Payouts table\nCREATE TABLE payouts (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  contractor_id UUID NOT NULL REFERENCES contractors(id),\n  stripe_transfer_id TEXT,\n  amount_cents INTEGER NOT NULL,\n  status TEXT NOT NULL,\n  period_start TIMESTAMPTZ NOT NULL,\n  period_end TIMESTAMPTZ NOT NULL\n)","-- Reviews table\nCREATE TABLE reviews (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  booking_id UUID NOT NULL REFERENCES bookings(id),\n  rater_user_id UUID NOT NULL REFERENCES users(id),\n  ratee_type ratee_type NOT NULL,\n  ratee_id UUID NOT NULL,\n  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),\n  comment TEXT,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()\n)","-- Promos table\nCREATE TABLE promos (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  code TEXT NOT NULL UNIQUE,\n  type promo_type NOT NULL,\n  value NUMERIC NOT NULL,\n  city TEXT,\n  start_at TIMESTAMPTZ NOT NULL,\n  end_at TIMESTAMPTZ NOT NULL,\n  max_uses INTEGER,\n  used INTEGER DEFAULT 0\n)","-- CSNotes table\nCREATE TABLE cs_notes (\n  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),\n  subject_type TEXT NOT NULL,\n  subject_id UUID NOT NULL,\n  author_user_id UUID NOT NULL REFERENCES users(id),\n  note TEXT NOT NULL,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()\n)","-- Create indexes for performance\nCREATE INDEX idx_heros_contractor_id ON heros(contractor_id)","CREATE INDEX idx_heros_user_id ON heros(user_id)","CREATE INDEX idx_addresses_user_id ON addresses(user_id)","CREATE INDEX idx_bookings_customer_id ON bookings(customer_id)","CREATE INDEX idx_bookings_contractor_id ON bookings(contractor_id)","CREATE INDEX idx_bookings_hero_id ON bookings(hero_id)","CREATE INDEX idx_bookings_status ON bookings(status)","CREATE INDEX idx_booking_events_booking_id ON booking_events(booking_id)","CREATE INDEX idx_gps_pings_booking_id ON gps_pings(booking_id)","CREATE INDEX idx_gps_pings_hero_id ON gps_pings(hero_id)","CREATE INDEX idx_payments_booking_id ON payments(booking_id)","CREATE INDEX idx_reviews_booking_id ON reviews(booking_id)","CREATE INDEX idx_cs_notes_subject_id ON cs_notes(subject_id)","-- Create spatial indexes for location queries\nCREATE INDEX idx_addresses_geom ON addresses USING GIST(geom)","CREATE INDEX idx_gps_pings_geom ON gps_pings USING GIST(geom)","-- Create updated_at trigger function\nCREATE OR REPLACE FUNCTION update_updated_at()\nRETURNS TRIGGER AS $$\nBEGIN\n  NEW.updated_at = NOW();\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql","-- Apply updated_at trigger to relevant tables\nCREATE TRIGGER update_contractors_updated_at\nBEFORE UPDATE ON contractors\nFOR EACH ROW EXECUTE FUNCTION update_updated_at()","CREATE TRIGGER update_heros_updated_at\nBEFORE UPDATE ON heros\nFOR EACH ROW EXECUTE FUNCTION update_updated_at()","CREATE TRIGGER update_bookings_updated_at\nBEFORE UPDATE ON bookings\nFOR EACH ROW EXECUTE FUNCTION update_updated_at()","-- Create booking event trigger\nCREATE OR REPLACE FUNCTION create_booking_event()\nRETURNS TRIGGER AS $$\nBEGIN\n  IF OLD.status IS NULL OR NEW.status != OLD.status THEN\n    INSERT INTO booking_events (booking_id, type, meta_json)\n    VALUES (NEW.id, 'status_change', jsonb_build_object('from', OLD.status, 'to', NEW.status));\n  END IF;\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql","CREATE TRIGGER booking_status_change\nAFTER UPDATE ON bookings\nFOR EACH ROW\nWHEN (OLD.status IS NULL OR NEW.status != OLD.status)\nEXECUTE FUNCTION create_booking_event()","-- Create hero rating update trigger\nCREATE OR REPLACE FUNCTION update_hero_rating()\nRETURNS TRIGGER AS $$\nBEGIN\n  IF NEW.ratee_type = 'hero' THEN\n    UPDATE heros\n    SET \n      rating_count = rating_count + 1,\n      rating_avg = (rating_avg * rating_count + NEW.rating) / (rating_count + 1)\n    WHERE id = NEW.ratee_id;\n  END IF;\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql","CREATE TRIGGER hero_rating_update\nAFTER INSERT ON reviews\nFOR EACH ROW\nWHEN (NEW.ratee_type = 'hero')\nEXECUTE FUNCTION update_hero_rating()","-- Set up Row Level Security (RLS) policies\n\n-- Enable RLS on all tables\nALTER TABLE contractors ENABLE ROW LEVEL SECURITY","ALTER TABLE users ENABLE ROW LEVEL SECURITY","ALTER TABLE heros ENABLE ROW LEVEL SECURITY","ALTER TABLE addresses ENABLE ROW LEVEL SECURITY","ALTER TABLE services ENABLE ROW LEVEL SECURITY","ALTER TABLE bookings ENABLE ROW LEVEL SECURITY","ALTER TABLE booking_events ENABLE ROW LEVEL SECURITY","ALTER TABLE gps_pings ENABLE ROW LEVEL SECURITY","ALTER TABLE payments ENABLE ROW LEVEL SECURITY","ALTER TABLE payouts ENABLE ROW LEVEL SECURITY","ALTER TABLE reviews ENABLE ROW LEVEL SECURITY","ALTER TABLE promos ENABLE ROW LEVEL SECURITY","ALTER TABLE cs_notes ENABLE ROW LEVEL SECURITY","-- Create basic policies (these will be expanded in future migrations)\n\n-- Users can read their own data\nCREATE POLICY users_read_own ON users\n  FOR SELECT USING (auth.uid() = id)","-- Customers can read hero profiles\nCREATE POLICY customers_read_heros ON heros\n  FOR SELECT USING (true)","-- Customers can read their own addresses\nCREATE POLICY customers_read_own_addresses ON addresses\n  FOR SELECT USING (auth.uid() = user_id)","-- Customers can create addresses\nCREATE POLICY customers_create_addresses ON addresses\n  FOR INSERT WITH CHECK (auth.uid() = user_id)","-- Customers can read services\nCREATE POLICY customers_read_services ON services\n  FOR SELECT USING (true)","-- Customers can read their own bookings\nCREATE POLICY customers_read_own_bookings ON bookings\n  FOR SELECT USING (auth.uid() = customer_id)","-- Heros can read bookings assigned to them\nCREATE POLICY heros_read_assigned_bookings ON bookings\n  FOR SELECT USING (\n    EXISTS (\n      SELECT 1 FROM users\n      WHERE users.id = auth.uid()\n      AND users.role = 'hero'\n      AND EXISTS (\n        SELECT 1 FROM heros\n        WHERE heros.user_id = auth.uid()\n        AND heros.id = bookings.hero_id\n      )\n    )\n  )","-- Create admin policies (admins can do everything)\nCREATE POLICY admin_all ON contractors FOR ALL USING (\n  EXISTS (\n    SELECT 1 FROM users\n    WHERE users.id = auth.uid()\n    AND users.role IN ('admin', 'cs', 'finance')\n  )\n)","CREATE POLICY admin_all ON users FOR ALL USING (\n  EXISTS (\n    SELECT 1 FROM users\n    WHERE users.id = auth.uid()\n    AND users.role IN ('admin', 'cs', 'finance')\n  )\n)","CREATE POLICY admin_all ON heros FOR ALL USING (\n  EXISTS (\n    SELECT 1 FROM users\n    WHERE users.id = auth.uid()\n    AND users.role IN ('admin', 'cs', 'finance')\n  )\n)","CREATE POLICY admin_all ON bookings FOR ALL USING (\n  EXISTS (\n    SELECT 1 FROM users\n    WHERE users.id = auth.uid()\n    AND users.role IN ('admin', 'cs', 'finance')\n  )\n)","-- Create storage buckets\nINSERT INTO storage.buckets (id, name, public) VALUES ('avatars', 'avatars', true)","INSERT INTO storage.buckets (id, name, public) VALUES ('documents', 'documents', false)","INSERT INTO storage.buckets (id, name, public) VALUES ('booking_photos', 'booking_photos', false)","-- Set up storage policies\nCREATE POLICY avatars_select_policy ON storage.objects\n  FOR SELECT USING (bucket_id = 'avatars')","CREATE POLICY documents_auth_only ON storage.objects\n  FOR SELECT USING (\n    bucket_id = 'documents' AND (\n      EXISTS (\n        SELECT 1 FROM users\n        WHERE users.id = auth.uid()\n        AND users.role IN ('admin', 'cs', 'finance', 'contractor_manager')\n      )\n    )\n  )","CREATE POLICY booking_photos_participants ON storage.objects\n  FOR SELECT USING (\n    bucket_id = 'booking_photos' AND (\n      EXISTS (\n        SELECT 1 FROM bookings\n        WHERE bookings.id::text = (storage.foldername(name))[1]\n        AND (\n          bookings.customer_id = auth.uid() OR\n          EXISTS (\n            SELECT 1 FROM heros\n            WHERE heros.id = bookings.hero_id\n            AND heros.user_id = auth.uid()\n          ) OR\n          EXISTS (\n            SELECT 1 FROM users\n            WHERE users.id = auth.uid()\n            AND users.role IN ('admin', 'cs', 'finance')\n          )\n        )\n      )\n    )\n  )"}	initial
20250122000001	{"-- HomeHeros Authentication and User Profiles Migration\n-- This migration sets up user profiles that extend Supabase Auth\n\n-- Create enum for user roles as defined in QRD (if not exists)\nDO $$ BEGIN\n    CREATE TYPE user_role AS ENUM (\n      'customer',\n      'hero', \n      'admin',\n      'cs',\n      'finance',\n      'contractor_manager'\n    );\nEXCEPTION\n    WHEN duplicate_object THEN null;\nEND $$","-- Create profiles table that extends auth.users (if not exists)\nCREATE TABLE IF NOT EXISTS public.profiles (\n  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,\n  role user_role NOT NULL DEFAULT 'customer',\n  name TEXT,\n  email TEXT,\n  phone TEXT,\n  status TEXT NOT NULL DEFAULT 'active',\n  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()\n)","-- Enable RLS on profiles table\nALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY","-- Create policies for profiles table\n\n-- Users can read their own profile\nCREATE POLICY \\"Users can read own profile\\" ON public.profiles\n  FOR SELECT USING (auth.uid() = id)","-- Users can update their own profile\nCREATE POLICY \\"Users can update own profile\\" ON public.profiles\n  FOR UPDATE USING (auth.uid() = id)","-- Admins and CS can read all profiles\nCREATE POLICY \\"Admins can read all profiles\\" ON public.profiles\n  FOR SELECT USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles\n      WHERE id = auth.uid() \n      AND role IN ('admin', 'cs', 'finance')\n    )\n  )","-- Admins can update all profiles\nCREATE POLICY \\"Admins can update all profiles\\" ON public.profiles\n  FOR UPDATE USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles\n      WHERE id = auth.uid() \n      AND role IN ('admin', 'cs')\n    )\n  )","-- Function to create profile on user signup\nCREATE OR REPLACE FUNCTION public.handle_new_user()\nRETURNS TRIGGER AS $$\nBEGIN\n  INSERT INTO public.profiles (id, email, role)\n  VALUES (\n    NEW.id,\n    NEW.email,\n    'customer'  -- Default role is customer\n  );\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER","-- Trigger to automatically create profile when user signs up\nCREATE TRIGGER on_auth_user_created\n  AFTER INSERT ON auth.users\n  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user()","-- Function to update updated_at timestamp\nCREATE OR REPLACE FUNCTION public.update_updated_at()\nRETURNS TRIGGER AS $$\nBEGIN\n  NEW.updated_at = NOW();\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql","-- Trigger to update updated_at on profile changes\nCREATE TRIGGER update_profiles_updated_at\n  BEFORE UPDATE ON public.profiles\n  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at()","-- Create indexes for better performance\nCREATE INDEX idx_profiles_role ON public.profiles(role)","CREATE INDEX idx_profiles_email ON public.profiles(email)","CREATE INDEX idx_profiles_status ON public.profiles(status)","-- Insert some test data (optional - remove in production)\n-- This will only work if you have existing auth users\n-- INSERT INTO public.profiles (id, email, role, name) \n-- VALUES \n--   ('existing-user-id-1', 'admin@homeheros.com', 'admin', 'Admin User'),\n--   ('existing-user-id-2', 'cs@homeheros.com', 'cs', 'Customer Support');\n\n-- Grant necessary permissions\nGRANT USAGE ON SCHEMA public TO anon, authenticated","GRANT ALL ON public.profiles TO authenticated","GRANT SELECT ON public.profiles TO anon"}	auth_and_profiles
20250122000002	{"-- Fix RLS policies to prevent infinite recursion\n-- This migration fixes the circular dependency in RLS policies\n\n-- Drop existing policies that cause infinite recursion\nDROP POLICY IF EXISTS \\"Admins can read all profiles\\" ON public.profiles","DROP POLICY IF EXISTS \\"Admins can update all profiles\\" ON public.profiles","-- Create simpler, non-recursive policies\n\n-- Users can read their own profile\n-- (This policy is fine as-is)\n\n-- Admins can read all profiles (simplified - no recursion)\nCREATE POLICY \\"Admins can read all profiles\\" ON public.profiles\n  FOR SELECT USING (\n    -- Allow if user has admin role (check directly in profiles table using a different approach)\n    EXISTS (\n      SELECT 1 FROM auth.users \n      WHERE auth.users.id = auth.uid() \n      AND auth.users.id IN (\n        SELECT id FROM public.profiles \n        WHERE role IN ('admin', 'cs', 'finance') \n        AND id = auth.uid()\n      )\n    )\n  )","-- Admins can update all profiles (simplified - no recursion)  \nCREATE POLICY \\"Admins can update all profiles\\" ON public.profiles\n  FOR UPDATE USING (\n    -- Allow if user has admin role (check directly without recursion)\n    EXISTS (\n      SELECT 1 FROM auth.users \n      WHERE auth.users.id = auth.uid() \n      AND auth.users.id IN (\n        SELECT id FROM public.profiles \n        WHERE role IN ('admin', 'cs') \n        AND id = auth.uid()\n      )\n    )\n  )","-- Alternative: Disable RLS temporarily for testing\n-- You can uncomment this line to disable RLS completely for testing\n-- ALTER TABLE public.profiles DISABLE ROW LEVEL SECURITY;"}	fix_rls_policies
20250122000003	{"-- Simple RLS policies without recursion\n-- This migration replaces complex policies with simple ones\n\n-- Drop all existing policies\nDROP POLICY IF EXISTS \\"Users can read own profile\\" ON public.profiles","DROP POLICY IF EXISTS \\"Users can update own profile\\" ON public.profiles","DROP POLICY IF EXISTS \\"Admins can read all profiles\\" ON public.profiles","DROP POLICY IF EXISTS \\"Admins can update all profiles\\" ON public.profiles","-- Create simple policies\n\n-- 1. Users can read their own profile\nCREATE POLICY \\"Users can read own profile\\" ON public.profiles\n  FOR SELECT USING (auth.uid() = id)","-- 2. Users can update their own profile\nCREATE POLICY \\"Users can update own profile\\" ON public.profiles\n  FOR UPDATE USING (auth.uid() = id)","-- 3. Allow INSERT for new profiles (needed for the trigger)\nCREATE POLICY \\"Allow profile creation\\" ON public.profiles\n  FOR INSERT WITH CHECK (auth.uid() = id)","-- For now, let's keep admin policies simple or disable them\n-- We can add them back later with proper implementation\n\n-- Optional: If you want to test without any admin restrictions, \n-- you can temporarily disable RLS:\n-- ALTER TABLE public.profiles DISABLE ROW LEVEL SECURITY;"}	simple_rls
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 16, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- Name: extensions extensions_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_client_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_client_id_key UNIQUE (client_id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: add_ons add_ons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.add_ons
    ADD CONSTRAINT add_ons_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: booking_add_ons booking_add_ons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_add_ons
    ADD CONSTRAINT booking_add_ons_pkey PRIMARY KEY (id);


--
-- Name: booking_events booking_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_events
    ADD CONSTRAINT booking_events_pkey PRIMARY KEY (id);


--
-- Name: booking_status_history booking_status_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_status_history
    ADD CONSTRAINT booking_status_history_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: contractors contractors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contractors
    ADD CONSTRAINT contractors_pkey PRIMARY KEY (id);


--
-- Name: cs_notes cs_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cs_notes
    ADD CONSTRAINT cs_notes_pkey PRIMARY KEY (id);


--
-- Name: gps_pings gps_pings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gps_pings
    ADD CONSTRAINT gps_pings_pkey PRIMARY KEY (id);


--
-- Name: hero_availability hero_availability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_availability
    ADD CONSTRAINT hero_availability_pkey PRIMARY KEY (id);


--
-- Name: hero_service_areas hero_service_areas_hero_id_city_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_service_areas
    ADD CONSTRAINT hero_service_areas_hero_id_city_key UNIQUE (hero_id, city);


--
-- Name: hero_service_areas hero_service_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_service_areas
    ADD CONSTRAINT hero_service_areas_pkey PRIMARY KEY (id);


--
-- Name: hero_services hero_services_hero_id_service_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_services
    ADD CONSTRAINT hero_services_hero_id_service_id_key UNIQUE (hero_id, service_id);


--
-- Name: hero_services hero_services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_services
    ADD CONSTRAINT hero_services_pkey PRIMARY KEY (id);


--
-- Name: heros heros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heros
    ADD CONSTRAINT heros_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: payouts payouts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payouts
    ADD CONSTRAINT payouts_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: promo_codes promo_codes_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_codes
    ADD CONSTRAINT promo_codes_code_key UNIQUE (code);


--
-- Name: promo_codes promo_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promo_codes
    ADD CONSTRAINT promo_codes_pkey PRIMARY KEY (id);


--
-- Name: promos promos_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promos
    ADD CONSTRAINT promos_code_key UNIQUE (code);


--
-- Name: promos promos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promos
    ADD CONSTRAINT promos_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: service_variants service_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_variants
    ADD CONSTRAINT service_variants_pkey PRIMARY KEY (id);


--
-- Name: service_variants service_variants_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_variants
    ADD CONSTRAINT service_variants_slug_key UNIQUE (slug);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: services services_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_slug_key UNIQUE (slug);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_09_27 messages_2025_09_27_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_09_27
    ADD CONSTRAINT messages_2025_09_27_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_09_28 messages_2025_09_28_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_09_28
    ADD CONSTRAINT messages_2025_09_28_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_09_29 messages_2025_09_29_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_09_29
    ADD CONSTRAINT messages_2025_09_29_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_09_30 messages_2025_09_30_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_09_30
    ADD CONSTRAINT messages_2025_09_30_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_10_01 messages_2025_10_01_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_10_01
    ADD CONSTRAINT messages_2025_10_01_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_10_02 messages_2025_10_02_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_10_02
    ADD CONSTRAINT messages_2025_10_02_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: iceberg_namespaces iceberg_namespaces_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_pkey PRIMARY KEY (id);


--
-- Name: iceberg_tables iceberg_tables_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: extensions_tenant_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE INDEX extensions_tenant_external_id_index ON _realtime.extensions USING btree (tenant_external_id);


--
-- Name: extensions_tenant_external_id_type_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX extensions_tenant_external_id_type_index ON _realtime.extensions USING btree (tenant_external_id, type);


--
-- Name: tenants_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX tenants_external_id_index ON _realtime.tenants USING btree (external_id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_clients_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_client_id_idx ON auth.oauth_clients USING btree (client_id);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_addresses_geom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_addresses_geom ON public.addresses USING gist (geom);


--
-- Name: idx_addresses_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_addresses_user_id ON public.addresses USING btree (user_id);


--
-- Name: idx_booking_events_booking_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_events_booking_id ON public.booking_events USING btree (booking_id);


--
-- Name: idx_booking_status_history_booking_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_status_history_booking_id ON public.booking_status_history USING btree (booking_id);


--
-- Name: idx_bookings_contractor_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_contractor_id ON public.bookings USING btree (contractor_id);


--
-- Name: idx_bookings_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_customer_id ON public.bookings USING btree (customer_id);


--
-- Name: idx_bookings_hero_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_hero_id ON public.bookings USING btree (hero_id);


--
-- Name: idx_bookings_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_service_id ON public.bookings USING btree (service_id);


--
-- Name: idx_bookings_service_variant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_service_variant_id ON public.bookings USING btree (service_variant_id);


--
-- Name: idx_bookings_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_status ON public.bookings USING btree (status);


--
-- Name: idx_cs_notes_subject_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cs_notes_subject_id ON public.cs_notes USING btree (subject_id);


--
-- Name: idx_gps_pings_booking_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_gps_pings_booking_id ON public.gps_pings USING btree (booking_id);


--
-- Name: idx_gps_pings_geom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_gps_pings_geom ON public.gps_pings USING gist (geom);


--
-- Name: idx_gps_pings_hero_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_gps_pings_hero_id ON public.gps_pings USING btree (hero_id);


--
-- Name: idx_hero_availability_hero_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_hero_availability_hero_id ON public.hero_availability USING btree (hero_id);


--
-- Name: idx_hero_services_hero_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_hero_services_hero_id ON public.hero_services USING btree (hero_id);


--
-- Name: idx_heros_contractor_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_heros_contractor_id ON public.heros USING btree (contractor_id);


--
-- Name: idx_heros_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_heros_user_id ON public.heros USING btree (user_id);


--
-- Name: idx_payments_booking_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payments_booking_id ON public.payments USING btree (booking_id);


--
-- Name: idx_profiles_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_email ON public.profiles USING btree (email);


--
-- Name: idx_profiles_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_role ON public.profiles USING btree (role);


--
-- Name: idx_profiles_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_status ON public.profiles USING btree (status);


--
-- Name: idx_reviews_booking_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_booking_id ON public.reviews USING btree (booking_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_iceberg_namespaces_bucket_id; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_namespaces_bucket_id ON storage.iceberg_namespaces USING btree (bucket_id, name);


--
-- Name: idx_iceberg_tables_namespace_id; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_tables_namespace_id ON storage.iceberg_tables USING btree (namespace_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- Name: messages_2025_09_27_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_09_27_pkey;


--
-- Name: messages_2025_09_28_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_09_28_pkey;


--
-- Name: messages_2025_09_29_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_09_29_pkey;


--
-- Name: messages_2025_09_30_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_09_30_pkey;


--
-- Name: messages_2025_10_01_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_10_01_pkey;


--
-- Name: messages_2025_10_02_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_10_02_pkey;


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: bookings booking_status_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER booking_status_change AFTER UPDATE ON public.bookings FOR EACH ROW WHEN (((old.status IS NULL) OR (new.status <> old.status))) EXECUTE FUNCTION public.create_booking_event();


--
-- Name: reviews hero_rating_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER hero_rating_update AFTER INSERT ON public.reviews FOR EACH ROW WHEN ((new.ratee_type = 'hero'::public.ratee_type)) EXECUTE FUNCTION public.update_hero_rating();


--
-- Name: bookings update_bookings_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON public.bookings FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: contractors update_contractors_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_contractors_updated_at BEFORE UPDATE ON public.contractors FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: heros update_heros_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_heros_updated_at BEFORE UPDATE ON public.heros FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: profiles update_profiles_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: services update_services_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_services_updated_at BEFORE UPDATE ON public.services FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: extensions extensions_tenant_external_id_fkey; Type: FK CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_tenant_external_id_fkey FOREIGN KEY (tenant_external_id) REFERENCES _realtime.tenants(external_id) ON DELETE CASCADE;


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: add_ons add_ons_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.add_ons
    ADD CONSTRAINT add_ons_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- Name: addresses addresses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: booking_add_ons booking_add_ons_add_on_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_add_ons
    ADD CONSTRAINT booking_add_ons_add_on_id_fkey FOREIGN KEY (add_on_id) REFERENCES public.add_ons(id);


--
-- Name: booking_add_ons booking_add_ons_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_add_ons
    ADD CONSTRAINT booking_add_ons_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE CASCADE;


--
-- Name: booking_events booking_events_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_events
    ADD CONSTRAINT booking_events_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: booking_status_history booking_status_history_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_status_history
    ADD CONSTRAINT booking_status_history_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE CASCADE;


--
-- Name: booking_status_history booking_status_history_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_status_history
    ADD CONSTRAINT booking_status_history_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: bookings bookings_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.addresses(id);


--
-- Name: bookings bookings_contractor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_contractor_id_fkey FOREIGN KEY (contractor_id) REFERENCES public.contractors(id);


--
-- Name: bookings bookings_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.users(id);


--
-- Name: cs_notes cs_notes_author_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cs_notes
    ADD CONSTRAINT cs_notes_author_user_id_fkey FOREIGN KEY (author_user_id) REFERENCES public.users(id);


--
-- Name: bookings fk_bookings_hero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_bookings_hero FOREIGN KEY (hero_id) REFERENCES public.heros(id);


--
-- Name: bookings fk_bookings_service; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_bookings_service FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE SET NULL;


--
-- Name: CONSTRAINT fk_bookings_service ON bookings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT fk_bookings_service ON public.bookings IS 'Foreign key to services table';


--
-- Name: bookings fk_bookings_service_variant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_bookings_service_variant FOREIGN KEY (service_variant_id) REFERENCES public.service_variants(id) ON DELETE SET NULL;


--
-- Name: CONSTRAINT fk_bookings_service_variant ON bookings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT fk_bookings_service_variant ON public.bookings IS 'Foreign key to service_variants table';


--
-- Name: gps_pings gps_pings_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gps_pings
    ADD CONSTRAINT gps_pings_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: gps_pings gps_pings_hero_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gps_pings
    ADD CONSTRAINT gps_pings_hero_id_fkey FOREIGN KEY (hero_id) REFERENCES public.heros(id);


--
-- Name: hero_services hero_services_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_services
    ADD CONSTRAINT hero_services_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- Name: heros heros_contractor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heros
    ADD CONSTRAINT heros_contractor_id_fkey FOREIGN KEY (contractor_id) REFERENCES public.contractors(id);


--
-- Name: heros heros_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heros
    ADD CONSTRAINT heros_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payments payments_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: payouts payouts_contractor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payouts
    ADD CONSTRAINT payouts_contractor_id_fkey FOREIGN KEY (contractor_id) REFERENCES public.contractors(id);


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: reviews reviews_rater_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_rater_user_id_fkey FOREIGN KEY (rater_user_id) REFERENCES public.users(id);


--
-- Name: service_variants service_variants_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_variants
    ADD CONSTRAINT service_variants_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: users users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id);


--
-- Name: iceberg_namespaces iceberg_namespaces_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_namespace_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_namespace_id_fkey FOREIGN KEY (namespace_id) REFERENCES storage.iceberg_namespaces(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles Allow profile creation; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow profile creation" ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = id));


--
-- Name: profiles Users can read own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can read own profile" ON public.profiles FOR SELECT USING ((auth.uid() = id));


--
-- Name: profiles Users can update own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- Name: addresses; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;

--
-- Name: booking_events; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.booking_events ENABLE ROW LEVEL SECURITY;

--
-- Name: bookings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;

--
-- Name: bookings bookings_all_access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY bookings_all_access ON public.bookings USING (true);


--
-- Name: cs_notes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.cs_notes ENABLE ROW LEVEL SECURITY;

--
-- Name: addresses customers_create_addresses; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customers_create_addresses ON public.addresses FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: bookings customers_create_bookings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customers_create_bookings ON public.bookings FOR INSERT TO authenticated WITH CHECK ((auth.uid() = customer_id));


--
-- Name: heros customers_read_heros; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customers_read_heros ON public.heros FOR SELECT USING (true);


--
-- Name: addresses customers_read_own_addresses; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customers_read_own_addresses ON public.addresses FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: bookings customers_read_own_bookings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customers_read_own_bookings ON public.bookings FOR SELECT USING ((auth.uid() = customer_id));


--
-- Name: services customers_read_services; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customers_read_services ON public.services FOR SELECT USING (true);


--
-- Name: gps_pings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.gps_pings ENABLE ROW LEVEL SECURITY;

--
-- Name: payments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;

--
-- Name: payments payments_all_access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY payments_all_access ON public.payments USING (true);


--
-- Name: payments payments_insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY payments_insert ON public.payments FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: payments payments_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY payments_select ON public.payments FOR SELECT TO authenticated USING (true);


--
-- Name: payments payments_update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY payments_update ON public.payments FOR UPDATE TO authenticated USING (true);


--
-- Name: payouts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.payouts ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: promos; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.promos ENABLE ROW LEVEL SECURITY;

--
-- Name: reviews; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;

--
-- Name: services; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.services ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: objects avatars_select_policy; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY avatars_select_policy ON storage.objects FOR SELECT USING ((bucket_id = 'avatars'::text));


--
-- Name: objects booking_photos_participants; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY booking_photos_participants ON storage.objects FOR SELECT USING (((bucket_id = 'booking_photos'::text) AND (EXISTS ( SELECT 1
   FROM public.bookings
  WHERE (((bookings.id)::text = (storage.foldername(objects.name))[1]) AND ((bookings.customer_id = auth.uid()) OR (EXISTS ( SELECT 1
           FROM public.heros
          WHERE ((heros.id = bookings.hero_id) AND (heros.user_id = auth.uid())))) OR (EXISTS ( SELECT 1
           FROM public.users
          WHERE ((users.id = auth.uid()) AND (users.role = ANY (ARRAY['admin'::public.user_role, 'cs'::public.user_role, 'finance'::public.user_role])))))))))));


--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: objects documents_auth_only; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY documents_auth_only ON storage.objects FOR SELECT USING (((bucket_id = 'documents'::text) AND (EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.id = auth.uid()) AND (users.role = ANY (ARRAY['admin'::public.user_role, 'cs'::public.user_role, 'finance'::public.user_role, 'contractor_manager'::public.user_role])))))));


--
-- Name: iceberg_namespaces; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.iceberg_namespaces ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_tables; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.iceberg_tables ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO supabase_admin;

--
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA net; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA net TO supabase_functions_admin;
GRANT USAGE ON SCHEMA net TO postgres;
GRANT USAGE ON SCHEMA net TO anon;
GRANT USAGE ON SCHEMA net TO authenticated;
GRANT USAGE ON SCHEMA net TO service_role;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT USAGE ON SCHEMA storage TO anon;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT USAGE ON SCHEMA storage TO authenticated;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT USAGE ON SCHEMA storage TO service_role;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT USAGE ON SCHEMA storage TO supabase_storage_admin;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT USAGE ON SCHEMA storage TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: SCHEMA supabase_functions; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA supabase_functions TO postgres;
GRANT USAGE ON SCHEMA supabase_functions TO anon;
GRANT USAGE ON SCHEMA supabase_functions TO authenticated;
GRANT USAGE ON SCHEMA supabase_functions TO service_role;
GRANT ALL ON SCHEMA supabase_functions TO supabase_functions_admin;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;
SET SESSION AUTHORIZATION postgres;
GRANT USAGE ON SCHEMA vault TO service_role;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION box2d_in(cstring); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box2d_in(cstring) TO postgres;
GRANT ALL ON FUNCTION public.box2d_in(cstring) TO anon;
GRANT ALL ON FUNCTION public.box2d_in(cstring) TO authenticated;
GRANT ALL ON FUNCTION public.box2d_in(cstring) TO service_role;


--
-- Name: FUNCTION box2d_out(public.box2d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box2d_out(public.box2d) TO postgres;
GRANT ALL ON FUNCTION public.box2d_out(public.box2d) TO anon;
GRANT ALL ON FUNCTION public.box2d_out(public.box2d) TO authenticated;
GRANT ALL ON FUNCTION public.box2d_out(public.box2d) TO service_role;


--
-- Name: FUNCTION box2df_in(cstring); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box2df_in(cstring) TO postgres;
GRANT ALL ON FUNCTION public.box2df_in(cstring) TO anon;
GRANT ALL ON FUNCTION public.box2df_in(cstring) TO authenticated;
GRANT ALL ON FUNCTION public.box2df_in(cstring) TO service_role;


--
-- Name: FUNCTION box2df_out(public.box2df); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box2df_out(public.box2df) TO postgres;
GRANT ALL ON FUNCTION public.box2df_out(public.box2df) TO anon;
GRANT ALL ON FUNCTION public.box2df_out(public.box2df) TO authenticated;
GRANT ALL ON FUNCTION public.box2df_out(public.box2df) TO service_role;


--
-- Name: FUNCTION box3d_in(cstring); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box3d_in(cstring) TO postgres;
GRANT ALL ON FUNCTION public.box3d_in(cstring) TO anon;
GRANT ALL ON FUNCTION public.box3d_in(cstring) TO authenticated;
GRANT ALL ON FUNCTION public.box3d_in(cstring) TO service_role;


--
-- Name: FUNCTION box3d_out(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box3d_out(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.box3d_out(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.box3d_out(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.box3d_out(public.box3d) TO service_role;


--
-- Name: FUNCTION geography_analyze(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_analyze(internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_analyze(internal) TO anon;
GRANT ALL ON FUNCTION public.geography_analyze(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_analyze(internal) TO service_role;


--
-- Name: FUNCTION geography_in(cstring, oid, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_in(cstring, oid, integer) TO postgres;
GRANT ALL ON FUNCTION public.geography_in(cstring, oid, integer) TO anon;
GRANT ALL ON FUNCTION public.geography_in(cstring, oid, integer) TO authenticated;
GRANT ALL ON FUNCTION public.geography_in(cstring, oid, integer) TO service_role;


--
-- Name: FUNCTION geography_out(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_out(public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geography_out(public.geography) TO anon;
GRANT ALL ON FUNCTION public.geography_out(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geography_out(public.geography) TO service_role;


--
-- Name: FUNCTION geography_recv(internal, oid, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_recv(internal, oid, integer) TO postgres;
GRANT ALL ON FUNCTION public.geography_recv(internal, oid, integer) TO anon;
GRANT ALL ON FUNCTION public.geography_recv(internal, oid, integer) TO authenticated;
GRANT ALL ON FUNCTION public.geography_recv(internal, oid, integer) TO service_role;


--
-- Name: FUNCTION geography_send(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_send(public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geography_send(public.geography) TO anon;
GRANT ALL ON FUNCTION public.geography_send(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geography_send(public.geography) TO service_role;


--
-- Name: FUNCTION geography_typmod_in(cstring[]); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_typmod_in(cstring[]) TO postgres;
GRANT ALL ON FUNCTION public.geography_typmod_in(cstring[]) TO anon;
GRANT ALL ON FUNCTION public.geography_typmod_in(cstring[]) TO authenticated;
GRANT ALL ON FUNCTION public.geography_typmod_in(cstring[]) TO service_role;


--
-- Name: FUNCTION geography_typmod_out(integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_typmod_out(integer) TO postgres;
GRANT ALL ON FUNCTION public.geography_typmod_out(integer) TO anon;
GRANT ALL ON FUNCTION public.geography_typmod_out(integer) TO authenticated;
GRANT ALL ON FUNCTION public.geography_typmod_out(integer) TO service_role;


--
-- Name: FUNCTION geometry_analyze(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_analyze(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_analyze(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_analyze(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_analyze(internal) TO service_role;


--
-- Name: FUNCTION geometry_in(cstring); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_in(cstring) TO postgres;
GRANT ALL ON FUNCTION public.geometry_in(cstring) TO anon;
GRANT ALL ON FUNCTION public.geometry_in(cstring) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_in(cstring) TO service_role;


--
-- Name: FUNCTION geometry_out(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_out(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_out(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_out(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_out(public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_recv(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_recv(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_recv(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_recv(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_recv(internal) TO service_role;


--
-- Name: FUNCTION geometry_send(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_send(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_send(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_send(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_send(public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_typmod_in(cstring[]); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_typmod_in(cstring[]) TO postgres;
GRANT ALL ON FUNCTION public.geometry_typmod_in(cstring[]) TO anon;
GRANT ALL ON FUNCTION public.geometry_typmod_in(cstring[]) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_typmod_in(cstring[]) TO service_role;


--
-- Name: FUNCTION geometry_typmod_out(integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_typmod_out(integer) TO postgres;
GRANT ALL ON FUNCTION public.geometry_typmod_out(integer) TO anon;
GRANT ALL ON FUNCTION public.geometry_typmod_out(integer) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_typmod_out(integer) TO service_role;


--
-- Name: FUNCTION gidx_in(cstring); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.gidx_in(cstring) TO postgres;
GRANT ALL ON FUNCTION public.gidx_in(cstring) TO anon;
GRANT ALL ON FUNCTION public.gidx_in(cstring) TO authenticated;
GRANT ALL ON FUNCTION public.gidx_in(cstring) TO service_role;


--
-- Name: FUNCTION gidx_out(public.gidx); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.gidx_out(public.gidx) TO postgres;
GRANT ALL ON FUNCTION public.gidx_out(public.gidx) TO anon;
GRANT ALL ON FUNCTION public.gidx_out(public.gidx) TO authenticated;
GRANT ALL ON FUNCTION public.gidx_out(public.gidx) TO service_role;


--
-- Name: FUNCTION spheroid_in(cstring); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.spheroid_in(cstring) TO postgres;
GRANT ALL ON FUNCTION public.spheroid_in(cstring) TO anon;
GRANT ALL ON FUNCTION public.spheroid_in(cstring) TO authenticated;
GRANT ALL ON FUNCTION public.spheroid_in(cstring) TO service_role;


--
-- Name: FUNCTION spheroid_out(public.spheroid); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.spheroid_out(public.spheroid) TO postgres;
GRANT ALL ON FUNCTION public.spheroid_out(public.spheroid) TO anon;
GRANT ALL ON FUNCTION public.spheroid_out(public.spheroid) TO authenticated;
GRANT ALL ON FUNCTION public.spheroid_out(public.spheroid) TO service_role;


--
-- Name: FUNCTION box3d(public.box2d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box3d(public.box2d) TO postgres;
GRANT ALL ON FUNCTION public.box3d(public.box2d) TO anon;
GRANT ALL ON FUNCTION public.box3d(public.box2d) TO authenticated;
GRANT ALL ON FUNCTION public.box3d(public.box2d) TO service_role;


--
-- Name: FUNCTION geometry(public.box2d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry(public.box2d) TO postgres;
GRANT ALL ON FUNCTION public.geometry(public.box2d) TO anon;
GRANT ALL ON FUNCTION public.geometry(public.box2d) TO authenticated;
GRANT ALL ON FUNCTION public.geometry(public.box2d) TO service_role;


--
-- Name: FUNCTION box(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.box(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.box(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.box(public.box3d) TO service_role;


--
-- Name: FUNCTION box2d(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box2d(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.box2d(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.box2d(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.box2d(public.box3d) TO service_role;


--
-- Name: FUNCTION geometry(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.geometry(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.geometry(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.geometry(public.box3d) TO service_role;


--
-- Name: FUNCTION geography(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography(bytea) TO postgres;
GRANT ALL ON FUNCTION public.geography(bytea) TO anon;
GRANT ALL ON FUNCTION public.geography(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.geography(bytea) TO service_role;


--
-- Name: FUNCTION geometry(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry(bytea) TO postgres;
GRANT ALL ON FUNCTION public.geometry(bytea) TO anon;
GRANT ALL ON FUNCTION public.geometry(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.geometry(bytea) TO service_role;


--
-- Name: FUNCTION bytea(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.bytea(public.geography) TO postgres;
GRANT ALL ON FUNCTION public.bytea(public.geography) TO anon;
GRANT ALL ON FUNCTION public.bytea(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.bytea(public.geography) TO service_role;


--
-- Name: FUNCTION geography(public.geography, integer, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography(public.geography, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.geography(public.geography, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.geography(public.geography, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.geography(public.geography, integer, boolean) TO service_role;


--
-- Name: FUNCTION geometry(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry(public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geometry(public.geography) TO anon;
GRANT ALL ON FUNCTION public.geometry(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geometry(public.geography) TO service_role;


--
-- Name: FUNCTION box(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.box(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.box(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.box(public.geometry) TO service_role;


--
-- Name: FUNCTION box2d(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box2d(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.box2d(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.box2d(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.box2d(public.geometry) TO service_role;


--
-- Name: FUNCTION box3d(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box3d(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.box3d(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.box3d(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.box3d(public.geometry) TO service_role;


--
-- Name: FUNCTION bytea(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.bytea(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.bytea(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.bytea(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.bytea(public.geometry) TO service_role;


--
-- Name: FUNCTION geography(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geography(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geography(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geography(public.geometry) TO service_role;


--
-- Name: FUNCTION geometry(public.geometry, integer, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry(public.geometry, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.geometry(public.geometry, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.geometry(public.geometry, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.geometry(public.geometry, integer, boolean) TO service_role;


--
-- Name: FUNCTION "json"(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public."json"(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public."json"(public.geometry) TO anon;
GRANT ALL ON FUNCTION public."json"(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public."json"(public.geometry) TO service_role;


--
-- Name: FUNCTION jsonb(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.jsonb(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.jsonb(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.jsonb(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.jsonb(public.geometry) TO service_role;


--
-- Name: FUNCTION path(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.path(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.path(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.path(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.path(public.geometry) TO service_role;


--
-- Name: FUNCTION point(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.point(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.point(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.point(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.point(public.geometry) TO service_role;


--
-- Name: FUNCTION polygon(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.polygon(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.polygon(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.polygon(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.polygon(public.geometry) TO service_role;


--
-- Name: FUNCTION text(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.text(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.text(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.text(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.text(public.geometry) TO service_role;


--
-- Name: FUNCTION geometry(path); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry(path) TO postgres;
GRANT ALL ON FUNCTION public.geometry(path) TO anon;
GRANT ALL ON FUNCTION public.geometry(path) TO authenticated;
GRANT ALL ON FUNCTION public.geometry(path) TO service_role;


--
-- Name: FUNCTION geometry(point); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry(point) TO postgres;
GRANT ALL ON FUNCTION public.geometry(point) TO anon;
GRANT ALL ON FUNCTION public.geometry(point) TO authenticated;
GRANT ALL ON FUNCTION public.geometry(point) TO service_role;


--
-- Name: FUNCTION geometry(polygon); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry(polygon) TO postgres;
GRANT ALL ON FUNCTION public.geometry(polygon) TO anon;
GRANT ALL ON FUNCTION public.geometry(polygon) TO authenticated;
GRANT ALL ON FUNCTION public.geometry(polygon) TO service_role;


--
-- Name: FUNCTION geometry(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry(text) TO postgres;
GRANT ALL ON FUNCTION public.geometry(text) TO anon;
GRANT ALL ON FUNCTION public.geometry(text) TO authenticated;
GRANT ALL ON FUNCTION public.geometry(text) TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- Name: FUNCTION http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION _postgis_deprecate(oldname text, newname text, version text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._postgis_deprecate(oldname text, newname text, version text) TO postgres;
GRANT ALL ON FUNCTION public._postgis_deprecate(oldname text, newname text, version text) TO anon;
GRANT ALL ON FUNCTION public._postgis_deprecate(oldname text, newname text, version text) TO authenticated;
GRANT ALL ON FUNCTION public._postgis_deprecate(oldname text, newname text, version text) TO service_role;


--
-- Name: FUNCTION _postgis_index_extent(tbl regclass, col text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._postgis_index_extent(tbl regclass, col text) TO postgres;
GRANT ALL ON FUNCTION public._postgis_index_extent(tbl regclass, col text) TO anon;
GRANT ALL ON FUNCTION public._postgis_index_extent(tbl regclass, col text) TO authenticated;
GRANT ALL ON FUNCTION public._postgis_index_extent(tbl regclass, col text) TO service_role;


--
-- Name: FUNCTION _postgis_join_selectivity(regclass, text, regclass, text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._postgis_join_selectivity(regclass, text, regclass, text, text) TO postgres;
GRANT ALL ON FUNCTION public._postgis_join_selectivity(regclass, text, regclass, text, text) TO anon;
GRANT ALL ON FUNCTION public._postgis_join_selectivity(regclass, text, regclass, text, text) TO authenticated;
GRANT ALL ON FUNCTION public._postgis_join_selectivity(regclass, text, regclass, text, text) TO service_role;


--
-- Name: FUNCTION _postgis_pgsql_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._postgis_pgsql_version() TO postgres;
GRANT ALL ON FUNCTION public._postgis_pgsql_version() TO anon;
GRANT ALL ON FUNCTION public._postgis_pgsql_version() TO authenticated;
GRANT ALL ON FUNCTION public._postgis_pgsql_version() TO service_role;


--
-- Name: FUNCTION _postgis_scripts_pgsql_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._postgis_scripts_pgsql_version() TO postgres;
GRANT ALL ON FUNCTION public._postgis_scripts_pgsql_version() TO anon;
GRANT ALL ON FUNCTION public._postgis_scripts_pgsql_version() TO authenticated;
GRANT ALL ON FUNCTION public._postgis_scripts_pgsql_version() TO service_role;


--
-- Name: FUNCTION _postgis_selectivity(tbl regclass, att_name text, geom public.geometry, mode text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._postgis_selectivity(tbl regclass, att_name text, geom public.geometry, mode text) TO postgres;
GRANT ALL ON FUNCTION public._postgis_selectivity(tbl regclass, att_name text, geom public.geometry, mode text) TO anon;
GRANT ALL ON FUNCTION public._postgis_selectivity(tbl regclass, att_name text, geom public.geometry, mode text) TO authenticated;
GRANT ALL ON FUNCTION public._postgis_selectivity(tbl regclass, att_name text, geom public.geometry, mode text) TO service_role;


--
-- Name: FUNCTION _postgis_stats(tbl regclass, att_name text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._postgis_stats(tbl regclass, att_name text, text) TO postgres;
GRANT ALL ON FUNCTION public._postgis_stats(tbl regclass, att_name text, text) TO anon;
GRANT ALL ON FUNCTION public._postgis_stats(tbl regclass, att_name text, text) TO authenticated;
GRANT ALL ON FUNCTION public._postgis_stats(tbl regclass, att_name text, text) TO service_role;


--
-- Name: FUNCTION _st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public._st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public._st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public._st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION _st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public._st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public._st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public._st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION _st_3dintersects(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_asgml(integer, public.geometry, integer, integer, text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_asgml(integer, public.geometry, integer, integer, text, text) TO postgres;
GRANT ALL ON FUNCTION public._st_asgml(integer, public.geometry, integer, integer, text, text) TO anon;
GRANT ALL ON FUNCTION public._st_asgml(integer, public.geometry, integer, integer, text, text) TO authenticated;
GRANT ALL ON FUNCTION public._st_asgml(integer, public.geometry, integer, integer, text, text) TO service_role;


--
-- Name: FUNCTION _st_asx3d(integer, public.geometry, integer, integer, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_asx3d(integer, public.geometry, integer, integer, text) TO postgres;
GRANT ALL ON FUNCTION public._st_asx3d(integer, public.geometry, integer, integer, text) TO anon;
GRANT ALL ON FUNCTION public._st_asx3d(integer, public.geometry, integer, integer, text) TO authenticated;
GRANT ALL ON FUNCTION public._st_asx3d(integer, public.geometry, integer, integer, text) TO service_role;


--
-- Name: FUNCTION _st_bestsrid(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_bestsrid(public.geography) TO postgres;
GRANT ALL ON FUNCTION public._st_bestsrid(public.geography) TO anon;
GRANT ALL ON FUNCTION public._st_bestsrid(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public._st_bestsrid(public.geography) TO service_role;


--
-- Name: FUNCTION _st_bestsrid(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_bestsrid(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public._st_bestsrid(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public._st_bestsrid(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public._st_bestsrid(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION _st_contains(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_contains(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_contains(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_contains(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_contains(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_containsproperly(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_coveredby(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_coveredby(geog1 public.geography, geog2 public.geography) TO postgres;
GRANT ALL ON FUNCTION public._st_coveredby(geog1 public.geography, geog2 public.geography) TO anon;
GRANT ALL ON FUNCTION public._st_coveredby(geog1 public.geography, geog2 public.geography) TO authenticated;
GRANT ALL ON FUNCTION public._st_coveredby(geog1 public.geography, geog2 public.geography) TO service_role;


--
-- Name: FUNCTION _st_coveredby(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_coveredby(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_coveredby(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_coveredby(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_coveredby(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_covers(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_covers(geog1 public.geography, geog2 public.geography) TO postgres;
GRANT ALL ON FUNCTION public._st_covers(geog1 public.geography, geog2 public.geography) TO anon;
GRANT ALL ON FUNCTION public._st_covers(geog1 public.geography, geog2 public.geography) TO authenticated;
GRANT ALL ON FUNCTION public._st_covers(geog1 public.geography, geog2 public.geography) TO service_role;


--
-- Name: FUNCTION _st_covers(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_covers(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_covers(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_covers(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_covers(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_crosses(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_crosses(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_crosses(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_crosses(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_crosses(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public._st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public._st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public._st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION _st_distancetree(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION _st_distancetree(public.geography, public.geography, double precision, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography, double precision, boolean) TO postgres;
GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography, double precision, boolean) TO anon;
GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography, double precision, boolean) TO authenticated;
GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography, double precision, boolean) TO service_role;


--
-- Name: FUNCTION _st_distanceuncached(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION _st_distanceuncached(public.geography, public.geography, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, boolean) TO postgres;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, boolean) TO anon;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, boolean) TO authenticated;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, boolean) TO service_role;


--
-- Name: FUNCTION _st_distanceuncached(public.geography, public.geography, double precision, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, double precision, boolean) TO postgres;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, double precision, boolean) TO anon;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, double precision, boolean) TO authenticated;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, double precision, boolean) TO service_role;


--
-- Name: FUNCTION _st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public._st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public._st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public._st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION _st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO postgres;
GRANT ALL ON FUNCTION public._st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO anon;
GRANT ALL ON FUNCTION public._st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO authenticated;
GRANT ALL ON FUNCTION public._st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO service_role;


--
-- Name: FUNCTION _st_dwithinuncached(public.geography, public.geography, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision) TO postgres;
GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision) TO anon;
GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision) TO authenticated;
GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision) TO service_role;


--
-- Name: FUNCTION _st_dwithinuncached(public.geography, public.geography, double precision, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision, boolean) TO postgres;
GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision, boolean) TO anon;
GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision, boolean) TO authenticated;
GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision, boolean) TO service_role;


--
-- Name: FUNCTION _st_equals(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_equals(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_equals(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_equals(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_equals(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_expand(public.geography, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_expand(public.geography, double precision) TO postgres;
GRANT ALL ON FUNCTION public._st_expand(public.geography, double precision) TO anon;
GRANT ALL ON FUNCTION public._st_expand(public.geography, double precision) TO authenticated;
GRANT ALL ON FUNCTION public._st_expand(public.geography, double precision) TO service_role;


--
-- Name: FUNCTION _st_geomfromgml(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_geomfromgml(text, integer) TO postgres;
GRANT ALL ON FUNCTION public._st_geomfromgml(text, integer) TO anon;
GRANT ALL ON FUNCTION public._st_geomfromgml(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public._st_geomfromgml(text, integer) TO service_role;


--
-- Name: FUNCTION _st_intersects(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_intersects(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_intersects(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_intersects(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_intersects(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_linecrossingdirection(line1 public.geometry, line2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_longestline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_longestline(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_longestline(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_longestline(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_longestline(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_maxdistance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_orderingequals(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_overlaps(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_overlaps(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_overlaps(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_overlaps(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_overlaps(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_pointoutside(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_pointoutside(public.geography) TO postgres;
GRANT ALL ON FUNCTION public._st_pointoutside(public.geography) TO anon;
GRANT ALL ON FUNCTION public._st_pointoutside(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public._st_pointoutside(public.geography) TO service_role;


--
-- Name: FUNCTION _st_sortablehash(geom public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_sortablehash(geom public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_sortablehash(geom public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_sortablehash(geom public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_sortablehash(geom public.geometry) TO service_role;


--
-- Name: FUNCTION _st_touches(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_touches(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_touches(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_touches(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_touches(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION _st_voronoi(g1 public.geometry, clip public.geometry, tolerance double precision, return_polygons boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_voronoi(g1 public.geometry, clip public.geometry, tolerance double precision, return_polygons boolean) TO postgres;
GRANT ALL ON FUNCTION public._st_voronoi(g1 public.geometry, clip public.geometry, tolerance double precision, return_polygons boolean) TO anon;
GRANT ALL ON FUNCTION public._st_voronoi(g1 public.geometry, clip public.geometry, tolerance double precision, return_polygons boolean) TO authenticated;
GRANT ALL ON FUNCTION public._st_voronoi(g1 public.geometry, clip public.geometry, tolerance double precision, return_polygons boolean) TO service_role;


--
-- Name: FUNCTION _st_within(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public._st_within(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public._st_within(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public._st_within(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public._st_within(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION addauth(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.addauth(text) TO postgres;
GRANT ALL ON FUNCTION public.addauth(text) TO anon;
GRANT ALL ON FUNCTION public.addauth(text) TO authenticated;
GRANT ALL ON FUNCTION public.addauth(text) TO service_role;


--
-- Name: FUNCTION addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres;
GRANT ALL ON FUNCTION public.addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO anon;
GRANT ALL ON FUNCTION public.addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO authenticated;
GRANT ALL ON FUNCTION public.addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO service_role;


--
-- Name: FUNCTION addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres;
GRANT ALL ON FUNCTION public.addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO anon;
GRANT ALL ON FUNCTION public.addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO authenticated;
GRANT ALL ON FUNCTION public.addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO service_role;


--
-- Name: FUNCTION addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres;
GRANT ALL ON FUNCTION public.addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean) TO anon;
GRANT ALL ON FUNCTION public.addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean) TO authenticated;
GRANT ALL ON FUNCTION public.addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean) TO service_role;


--
-- Name: FUNCTION box3dtobox(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.box3dtobox(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.box3dtobox(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.box3dtobox(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.box3dtobox(public.box3d) TO service_role;


--
-- Name: FUNCTION checkauth(text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.checkauth(text, text) TO postgres;
GRANT ALL ON FUNCTION public.checkauth(text, text) TO anon;
GRANT ALL ON FUNCTION public.checkauth(text, text) TO authenticated;
GRANT ALL ON FUNCTION public.checkauth(text, text) TO service_role;


--
-- Name: FUNCTION checkauth(text, text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.checkauth(text, text, text) TO postgres;
GRANT ALL ON FUNCTION public.checkauth(text, text, text) TO anon;
GRANT ALL ON FUNCTION public.checkauth(text, text, text) TO authenticated;
GRANT ALL ON FUNCTION public.checkauth(text, text, text) TO service_role;


--
-- Name: FUNCTION checkauthtrigger(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.checkauthtrigger() TO postgres;
GRANT ALL ON FUNCTION public.checkauthtrigger() TO anon;
GRANT ALL ON FUNCTION public.checkauthtrigger() TO authenticated;
GRANT ALL ON FUNCTION public.checkauthtrigger() TO service_role;


--
-- Name: FUNCTION contains_2d(public.box2df, public.box2df); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.box2df) TO postgres;
GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.box2df) TO anon;
GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.box2df) TO authenticated;
GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.box2df) TO service_role;


--
-- Name: FUNCTION contains_2d(public.box2df, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.geometry) TO service_role;


--
-- Name: FUNCTION contains_2d(public.geometry, public.box2df); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.contains_2d(public.geometry, public.box2df) TO postgres;
GRANT ALL ON FUNCTION public.contains_2d(public.geometry, public.box2df) TO anon;
GRANT ALL ON FUNCTION public.contains_2d(public.geometry, public.box2df) TO authenticated;
GRANT ALL ON FUNCTION public.contains_2d(public.geometry, public.box2df) TO service_role;


--
-- Name: FUNCTION convert_to_uuid(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.convert_to_uuid(text) TO anon;
GRANT ALL ON FUNCTION public.convert_to_uuid(text) TO authenticated;
GRANT ALL ON FUNCTION public.convert_to_uuid(text) TO service_role;


--
-- Name: FUNCTION create_booking_event(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_booking_event() TO anon;
GRANT ALL ON FUNCTION public.create_booking_event() TO authenticated;
GRANT ALL ON FUNCTION public.create_booking_event() TO service_role;


--
-- Name: FUNCTION disablelongtransactions(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.disablelongtransactions() TO postgres;
GRANT ALL ON FUNCTION public.disablelongtransactions() TO anon;
GRANT ALL ON FUNCTION public.disablelongtransactions() TO authenticated;
GRANT ALL ON FUNCTION public.disablelongtransactions() TO service_role;


--
-- Name: FUNCTION dropgeometrycolumn(table_name character varying, column_name character varying); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.dropgeometrycolumn(table_name character varying, column_name character varying) TO postgres;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(table_name character varying, column_name character varying) TO anon;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(table_name character varying, column_name character varying) TO authenticated;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(table_name character varying, column_name character varying) TO service_role;


--
-- Name: FUNCTION dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) TO postgres;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) TO anon;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) TO authenticated;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) TO service_role;


--
-- Name: FUNCTION dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) TO postgres;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) TO anon;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) TO authenticated;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) TO service_role;


--
-- Name: FUNCTION dropgeometrytable(table_name character varying); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.dropgeometrytable(table_name character varying) TO postgres;
GRANT ALL ON FUNCTION public.dropgeometrytable(table_name character varying) TO anon;
GRANT ALL ON FUNCTION public.dropgeometrytable(table_name character varying) TO authenticated;
GRANT ALL ON FUNCTION public.dropgeometrytable(table_name character varying) TO service_role;


--
-- Name: FUNCTION dropgeometrytable(schema_name character varying, table_name character varying); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.dropgeometrytable(schema_name character varying, table_name character varying) TO postgres;
GRANT ALL ON FUNCTION public.dropgeometrytable(schema_name character varying, table_name character varying) TO anon;
GRANT ALL ON FUNCTION public.dropgeometrytable(schema_name character varying, table_name character varying) TO authenticated;
GRANT ALL ON FUNCTION public.dropgeometrytable(schema_name character varying, table_name character varying) TO service_role;


--
-- Name: FUNCTION dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) TO postgres;
GRANT ALL ON FUNCTION public.dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) TO anon;
GRANT ALL ON FUNCTION public.dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) TO authenticated;
GRANT ALL ON FUNCTION public.dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) TO service_role;


--
-- Name: FUNCTION enablelongtransactions(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.enablelongtransactions() TO postgres;
GRANT ALL ON FUNCTION public.enablelongtransactions() TO anon;
GRANT ALL ON FUNCTION public.enablelongtransactions() TO authenticated;
GRANT ALL ON FUNCTION public.enablelongtransactions() TO service_role;


--
-- Name: FUNCTION equals(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.equals(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.equals(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.equals(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.equals(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION find_srid(character varying, character varying, character varying); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.find_srid(character varying, character varying, character varying) TO postgres;
GRANT ALL ON FUNCTION public.find_srid(character varying, character varying, character varying) TO anon;
GRANT ALL ON FUNCTION public.find_srid(character varying, character varying, character varying) TO authenticated;
GRANT ALL ON FUNCTION public.find_srid(character varying, character varying, character varying) TO service_role;


--
-- Name: FUNCTION geog_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geog_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geog_brin_inclusion_add_value(internal, internal, internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geog_brin_inclusion_add_value(internal, internal, internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geog_brin_inclusion_add_value(internal, internal, internal, internal) TO service_role;


--
-- Name: FUNCTION geography_cmp(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_cmp(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geography_cmp(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public.geography_cmp(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geography_cmp(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION geography_distance_knn(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_distance_knn(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geography_distance_knn(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public.geography_distance_knn(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geography_distance_knn(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION geography_eq(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_eq(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geography_eq(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public.geography_eq(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geography_eq(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION geography_ge(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_ge(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geography_ge(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public.geography_ge(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geography_ge(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION geography_gist_compress(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_gist_compress(internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_gist_compress(internal) TO anon;
GRANT ALL ON FUNCTION public.geography_gist_compress(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_gist_compress(internal) TO service_role;


--
-- Name: FUNCTION geography_gist_consistent(internal, public.geography, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_gist_consistent(internal, public.geography, integer) TO postgres;
GRANT ALL ON FUNCTION public.geography_gist_consistent(internal, public.geography, integer) TO anon;
GRANT ALL ON FUNCTION public.geography_gist_consistent(internal, public.geography, integer) TO authenticated;
GRANT ALL ON FUNCTION public.geography_gist_consistent(internal, public.geography, integer) TO service_role;


--
-- Name: FUNCTION geography_gist_decompress(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_gist_decompress(internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_gist_decompress(internal) TO anon;
GRANT ALL ON FUNCTION public.geography_gist_decompress(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_gist_decompress(internal) TO service_role;


--
-- Name: FUNCTION geography_gist_distance(internal, public.geography, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_gist_distance(internal, public.geography, integer) TO postgres;
GRANT ALL ON FUNCTION public.geography_gist_distance(internal, public.geography, integer) TO anon;
GRANT ALL ON FUNCTION public.geography_gist_distance(internal, public.geography, integer) TO authenticated;
GRANT ALL ON FUNCTION public.geography_gist_distance(internal, public.geography, integer) TO service_role;


--
-- Name: FUNCTION geography_gist_penalty(internal, internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_gist_penalty(internal, internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_gist_penalty(internal, internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geography_gist_penalty(internal, internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_gist_penalty(internal, internal, internal) TO service_role;


--
-- Name: FUNCTION geography_gist_picksplit(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_gist_picksplit(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_gist_picksplit(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geography_gist_picksplit(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_gist_picksplit(internal, internal) TO service_role;


--
-- Name: FUNCTION geography_gist_same(public.box2d, public.box2d, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_gist_same(public.box2d, public.box2d, internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_gist_same(public.box2d, public.box2d, internal) TO anon;
GRANT ALL ON FUNCTION public.geography_gist_same(public.box2d, public.box2d, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_gist_same(public.box2d, public.box2d, internal) TO service_role;


--
-- Name: FUNCTION geography_gist_union(bytea, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_gist_union(bytea, internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_gist_union(bytea, internal) TO anon;
GRANT ALL ON FUNCTION public.geography_gist_union(bytea, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_gist_union(bytea, internal) TO service_role;


--
-- Name: FUNCTION geography_gt(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_gt(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geography_gt(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public.geography_gt(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geography_gt(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION geography_le(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_le(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geography_le(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public.geography_le(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geography_le(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION geography_lt(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_lt(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geography_lt(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public.geography_lt(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geography_lt(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION geography_overlaps(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_overlaps(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geography_overlaps(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public.geography_overlaps(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geography_overlaps(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION geography_spgist_choose_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_spgist_choose_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_spgist_choose_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geography_spgist_choose_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_spgist_choose_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geography_spgist_compress_nd(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_spgist_compress_nd(internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_spgist_compress_nd(internal) TO anon;
GRANT ALL ON FUNCTION public.geography_spgist_compress_nd(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_spgist_compress_nd(internal) TO service_role;


--
-- Name: FUNCTION geography_spgist_config_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_spgist_config_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_spgist_config_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geography_spgist_config_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_spgist_config_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geography_spgist_inner_consistent_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_spgist_inner_consistent_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_spgist_inner_consistent_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geography_spgist_inner_consistent_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_spgist_inner_consistent_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geography_spgist_leaf_consistent_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_spgist_leaf_consistent_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_spgist_leaf_consistent_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geography_spgist_leaf_consistent_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_spgist_leaf_consistent_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geography_spgist_picksplit_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geography_spgist_picksplit_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geography_spgist_picksplit_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geography_spgist_picksplit_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geography_spgist_picksplit_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geom2d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geom2d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geom2d_brin_inclusion_add_value(internal, internal, internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geom2d_brin_inclusion_add_value(internal, internal, internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geom2d_brin_inclusion_add_value(internal, internal, internal, internal) TO service_role;


--
-- Name: FUNCTION geom3d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geom3d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geom3d_brin_inclusion_add_value(internal, internal, internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geom3d_brin_inclusion_add_value(internal, internal, internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geom3d_brin_inclusion_add_value(internal, internal, internal, internal) TO service_role;


--
-- Name: FUNCTION geom4d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geom4d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geom4d_brin_inclusion_add_value(internal, internal, internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geom4d_brin_inclusion_add_value(internal, internal, internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geom4d_brin_inclusion_add_value(internal, internal, internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_above(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_above(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_above(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_above(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_above(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_below(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_below(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_below(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_below(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_below(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_cmp(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_cmp(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_cmp(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_cmp(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_cmp(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_contained_3d(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_contained_3d(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_contained_3d(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_contained_3d(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_contained_3d(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_contains(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_contains(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_contains(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_contains(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_contains(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_contains_3d(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_contains_3d(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_contains_3d(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_contains_3d(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_contains_3d(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_contains_nd(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_contains_nd(public.geometry, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_contains_nd(public.geometry, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_contains_nd(public.geometry, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_contains_nd(public.geometry, public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_distance_box(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_distance_box(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_distance_box(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_distance_box(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_distance_box(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_distance_centroid(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_distance_centroid(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_distance_centroid(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_distance_centroid(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_distance_centroid(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_distance_centroid_nd(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_distance_centroid_nd(public.geometry, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_distance_centroid_nd(public.geometry, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_distance_centroid_nd(public.geometry, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_distance_centroid_nd(public.geometry, public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_distance_cpa(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_distance_cpa(public.geometry, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_distance_cpa(public.geometry, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_distance_cpa(public.geometry, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_distance_cpa(public.geometry, public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_eq(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_eq(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_eq(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_eq(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_eq(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_ge(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_ge(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_ge(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_ge(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_ge(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_gist_compress_2d(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_compress_2d(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_compress_2d(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_compress_2d(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_compress_2d(internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_compress_nd(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_compress_nd(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_compress_nd(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_compress_nd(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_compress_nd(internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_consistent_2d(internal, public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_consistent_2d(internal, public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_consistent_2d(internal, public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_consistent_2d(internal, public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_consistent_2d(internal, public.geometry, integer) TO service_role;


--
-- Name: FUNCTION geometry_gist_consistent_nd(internal, public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_consistent_nd(internal, public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_consistent_nd(internal, public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_consistent_nd(internal, public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_consistent_nd(internal, public.geometry, integer) TO service_role;


--
-- Name: FUNCTION geometry_gist_decompress_2d(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_decompress_2d(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_decompress_2d(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_decompress_2d(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_decompress_2d(internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_decompress_nd(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_decompress_nd(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_decompress_nd(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_decompress_nd(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_decompress_nd(internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_distance_2d(internal, public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_distance_2d(internal, public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_distance_2d(internal, public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_distance_2d(internal, public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_distance_2d(internal, public.geometry, integer) TO service_role;


--
-- Name: FUNCTION geometry_gist_distance_nd(internal, public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_distance_nd(internal, public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_distance_nd(internal, public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_distance_nd(internal, public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_distance_nd(internal, public.geometry, integer) TO service_role;


--
-- Name: FUNCTION geometry_gist_penalty_2d(internal, internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_penalty_2d(internal, internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_penalty_2d(internal, internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_penalty_2d(internal, internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_penalty_2d(internal, internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_penalty_nd(internal, internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_penalty_nd(internal, internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_penalty_nd(internal, internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_penalty_nd(internal, internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_penalty_nd(internal, internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_picksplit_2d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_picksplit_2d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_picksplit_2d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_picksplit_2d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_picksplit_2d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_picksplit_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_picksplit_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_picksplit_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_picksplit_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_picksplit_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_same_2d(geom1 public.geometry, geom2 public.geometry, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_same_2d(geom1 public.geometry, geom2 public.geometry, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_same_2d(geom1 public.geometry, geom2 public.geometry, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_same_2d(geom1 public.geometry, geom2 public.geometry, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_same_2d(geom1 public.geometry, geom2 public.geometry, internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_same_nd(public.geometry, public.geometry, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_same_nd(public.geometry, public.geometry, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_same_nd(public.geometry, public.geometry, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_same_nd(public.geometry, public.geometry, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_same_nd(public.geometry, public.geometry, internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_sortsupport_2d(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_sortsupport_2d(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_sortsupport_2d(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_sortsupport_2d(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_sortsupport_2d(internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_union_2d(bytea, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_union_2d(bytea, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_union_2d(bytea, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_union_2d(bytea, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_union_2d(bytea, internal) TO service_role;


--
-- Name: FUNCTION geometry_gist_union_nd(bytea, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gist_union_nd(bytea, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gist_union_nd(bytea, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_gist_union_nd(bytea, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gist_union_nd(bytea, internal) TO service_role;


--
-- Name: FUNCTION geometry_gt(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_gt(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_gt(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_gt(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_gt(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_hash(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_hash(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_hash(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_hash(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_hash(public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_le(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_le(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_le(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_le(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_le(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_left(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_left(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_left(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_left(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_left(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_lt(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_lt(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_lt(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_lt(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_lt(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_overabove(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_overabove(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_overabove(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_overabove(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_overabove(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_overbelow(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_overbelow(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_overbelow(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_overbelow(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_overbelow(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_overlaps(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_overlaps(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_overlaps(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_overlaps(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_overlaps(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_overlaps_3d(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_overlaps_3d(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_overlaps_3d(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_overlaps_3d(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_overlaps_3d(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_overlaps_nd(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_overlaps_nd(public.geometry, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_overlaps_nd(public.geometry, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_overlaps_nd(public.geometry, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_overlaps_nd(public.geometry, public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_overleft(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_overleft(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_overleft(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_overleft(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_overleft(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_overright(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_overright(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_overright(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_overright(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_overright(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_right(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_right(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_right(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_right(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_right(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_same(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_same(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_same(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_same(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_same(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_same_3d(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_same_3d(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_same_3d(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_same_3d(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_same_3d(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_same_nd(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_same_nd(public.geometry, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_same_nd(public.geometry, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_same_nd(public.geometry, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_same_nd(public.geometry, public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_sortsupport(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_sortsupport(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_sortsupport(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_sortsupport(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_sortsupport(internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_choose_2d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_choose_2d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_2d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_2d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_2d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_choose_3d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_choose_3d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_3d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_3d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_3d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_choose_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_choose_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_compress_2d(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_compress_2d(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_2d(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_2d(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_2d(internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_compress_3d(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_compress_3d(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_3d(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_3d(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_3d(internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_compress_nd(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_compress_nd(internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_nd(internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_nd(internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_nd(internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_config_2d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_config_2d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_config_2d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_config_2d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_config_2d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_config_3d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_config_3d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_config_3d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_config_3d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_config_3d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_config_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_config_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_config_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_config_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_config_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_inner_consistent_2d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_2d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_2d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_2d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_2d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_inner_consistent_3d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_3d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_3d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_3d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_3d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_inner_consistent_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_leaf_consistent_2d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_2d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_2d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_2d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_2d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_leaf_consistent_3d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_3d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_3d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_3d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_3d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_leaf_consistent_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_picksplit_2d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_2d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_2d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_2d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_2d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_picksplit_3d(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_3d(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_3d(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_3d(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_3d(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_spgist_picksplit_nd(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_nd(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_nd(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_nd(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_nd(internal, internal) TO service_role;


--
-- Name: FUNCTION geometry_within(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_within(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_within(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_within(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_within(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION geometry_within_nd(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometry_within_nd(public.geometry, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometry_within_nd(public.geometry, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometry_within_nd(public.geometry, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometry_within_nd(public.geometry, public.geometry) TO service_role;


--
-- Name: FUNCTION geometrytype(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometrytype(public.geography) TO postgres;
GRANT ALL ON FUNCTION public.geometrytype(public.geography) TO anon;
GRANT ALL ON FUNCTION public.geometrytype(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.geometrytype(public.geography) TO service_role;


--
-- Name: FUNCTION geometrytype(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geometrytype(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.geometrytype(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.geometrytype(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.geometrytype(public.geometry) TO service_role;


--
-- Name: FUNCTION geomfromewkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geomfromewkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.geomfromewkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.geomfromewkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.geomfromewkb(bytea) TO service_role;


--
-- Name: FUNCTION geomfromewkt(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.geomfromewkt(text) TO postgres;
GRANT ALL ON FUNCTION public.geomfromewkt(text) TO anon;
GRANT ALL ON FUNCTION public.geomfromewkt(text) TO authenticated;
GRANT ALL ON FUNCTION public.geomfromewkt(text) TO service_role;


--
-- Name: FUNCTION get_available_heroes(service_id uuid, city character varying, booking_date date, booking_time time without time zone, duration_minutes integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_available_heroes(service_id uuid, city character varying, booking_date date, booking_time time without time zone, duration_minutes integer) TO anon;
GRANT ALL ON FUNCTION public.get_available_heroes(service_id uuid, city character varying, booking_date date, booking_time time without time zone, duration_minutes integer) TO authenticated;
GRANT ALL ON FUNCTION public.get_available_heroes(service_id uuid, city character varying, booking_date date, booking_time time without time zone, duration_minutes integer) TO service_role;


--
-- Name: FUNCTION get_proj4_from_srid(integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.get_proj4_from_srid(integer) TO postgres;
GRANT ALL ON FUNCTION public.get_proj4_from_srid(integer) TO anon;
GRANT ALL ON FUNCTION public.get_proj4_from_srid(integer) TO authenticated;
GRANT ALL ON FUNCTION public.get_proj4_from_srid(integer) TO service_role;


--
-- Name: FUNCTION get_server_timestamp(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_server_timestamp() TO anon;
GRANT ALL ON FUNCTION public.get_server_timestamp() TO authenticated;
GRANT ALL ON FUNCTION public.get_server_timestamp() TO service_role;


--
-- Name: FUNCTION gettransactionid(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.gettransactionid() TO postgres;
GRANT ALL ON FUNCTION public.gettransactionid() TO anon;
GRANT ALL ON FUNCTION public.gettransactionid() TO authenticated;
GRANT ALL ON FUNCTION public.gettransactionid() TO service_role;


--
-- Name: FUNCTION gserialized_gist_joinsel_2d(internal, oid, internal, smallint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_2d(internal, oid, internal, smallint) TO postgres;
GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_2d(internal, oid, internal, smallint) TO anon;
GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_2d(internal, oid, internal, smallint) TO authenticated;
GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_2d(internal, oid, internal, smallint) TO service_role;


--
-- Name: FUNCTION gserialized_gist_joinsel_nd(internal, oid, internal, smallint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_nd(internal, oid, internal, smallint) TO postgres;
GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_nd(internal, oid, internal, smallint) TO anon;
GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_nd(internal, oid, internal, smallint) TO authenticated;
GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_nd(internal, oid, internal, smallint) TO service_role;


--
-- Name: FUNCTION gserialized_gist_sel_2d(internal, oid, internal, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.gserialized_gist_sel_2d(internal, oid, internal, integer) TO postgres;
GRANT ALL ON FUNCTION public.gserialized_gist_sel_2d(internal, oid, internal, integer) TO anon;
GRANT ALL ON FUNCTION public.gserialized_gist_sel_2d(internal, oid, internal, integer) TO authenticated;
GRANT ALL ON FUNCTION public.gserialized_gist_sel_2d(internal, oid, internal, integer) TO service_role;


--
-- Name: FUNCTION gserialized_gist_sel_nd(internal, oid, internal, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.gserialized_gist_sel_nd(internal, oid, internal, integer) TO postgres;
GRANT ALL ON FUNCTION public.gserialized_gist_sel_nd(internal, oid, internal, integer) TO anon;
GRANT ALL ON FUNCTION public.gserialized_gist_sel_nd(internal, oid, internal, integer) TO authenticated;
GRANT ALL ON FUNCTION public.gserialized_gist_sel_nd(internal, oid, internal, integer) TO service_role;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- Name: FUNCTION is_contained_2d(public.box2df, public.box2df); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.box2df) TO postgres;
GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.box2df) TO anon;
GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.box2df) TO authenticated;
GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.box2df) TO service_role;


--
-- Name: FUNCTION is_contained_2d(public.box2df, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.geometry) TO service_role;


--
-- Name: FUNCTION is_contained_2d(public.geometry, public.box2df); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.is_contained_2d(public.geometry, public.box2df) TO postgres;
GRANT ALL ON FUNCTION public.is_contained_2d(public.geometry, public.box2df) TO anon;
GRANT ALL ON FUNCTION public.is_contained_2d(public.geometry, public.box2df) TO authenticated;
GRANT ALL ON FUNCTION public.is_contained_2d(public.geometry, public.box2df) TO service_role;


--
-- Name: FUNCTION lockrow(text, text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.lockrow(text, text, text) TO postgres;
GRANT ALL ON FUNCTION public.lockrow(text, text, text) TO anon;
GRANT ALL ON FUNCTION public.lockrow(text, text, text) TO authenticated;
GRANT ALL ON FUNCTION public.lockrow(text, text, text) TO service_role;


--
-- Name: FUNCTION lockrow(text, text, text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.lockrow(text, text, text, text) TO postgres;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, text) TO anon;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, text) TO authenticated;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, text) TO service_role;


--
-- Name: FUNCTION lockrow(text, text, text, timestamp without time zone); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.lockrow(text, text, text, timestamp without time zone) TO postgres;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, timestamp without time zone) TO anon;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, timestamp without time zone) TO authenticated;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, timestamp without time zone) TO service_role;


--
-- Name: FUNCTION lockrow(text, text, text, text, timestamp without time zone); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.lockrow(text, text, text, text, timestamp without time zone) TO postgres;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, text, timestamp without time zone) TO anon;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, text, timestamp without time zone) TO authenticated;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, text, timestamp without time zone) TO service_role;


--
-- Name: FUNCTION longtransactionsenabled(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.longtransactionsenabled() TO postgres;
GRANT ALL ON FUNCTION public.longtransactionsenabled() TO anon;
GRANT ALL ON FUNCTION public.longtransactionsenabled() TO authenticated;
GRANT ALL ON FUNCTION public.longtransactionsenabled() TO service_role;


--
-- Name: FUNCTION overlaps_2d(public.box2df, public.box2df); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.box2df) TO postgres;
GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.box2df) TO anon;
GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.box2df) TO authenticated;
GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.box2df) TO service_role;


--
-- Name: FUNCTION overlaps_2d(public.box2df, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.geometry) TO service_role;


--
-- Name: FUNCTION overlaps_2d(public.geometry, public.box2df); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.overlaps_2d(public.geometry, public.box2df) TO postgres;
GRANT ALL ON FUNCTION public.overlaps_2d(public.geometry, public.box2df) TO anon;
GRANT ALL ON FUNCTION public.overlaps_2d(public.geometry, public.box2df) TO authenticated;
GRANT ALL ON FUNCTION public.overlaps_2d(public.geometry, public.box2df) TO service_role;


--
-- Name: FUNCTION overlaps_geog(public.geography, public.gidx); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.overlaps_geog(public.geography, public.gidx) TO postgres;
GRANT ALL ON FUNCTION public.overlaps_geog(public.geography, public.gidx) TO anon;
GRANT ALL ON FUNCTION public.overlaps_geog(public.geography, public.gidx) TO authenticated;
GRANT ALL ON FUNCTION public.overlaps_geog(public.geography, public.gidx) TO service_role;


--
-- Name: FUNCTION overlaps_geog(public.gidx, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.geography) TO postgres;
GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.geography) TO anon;
GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.geography) TO service_role;


--
-- Name: FUNCTION overlaps_geog(public.gidx, public.gidx); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.gidx) TO postgres;
GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.gidx) TO anon;
GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.gidx) TO authenticated;
GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.gidx) TO service_role;


--
-- Name: FUNCTION overlaps_nd(public.geometry, public.gidx); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.overlaps_nd(public.geometry, public.gidx) TO postgres;
GRANT ALL ON FUNCTION public.overlaps_nd(public.geometry, public.gidx) TO anon;
GRANT ALL ON FUNCTION public.overlaps_nd(public.geometry, public.gidx) TO authenticated;
GRANT ALL ON FUNCTION public.overlaps_nd(public.geometry, public.gidx) TO service_role;


--
-- Name: FUNCTION overlaps_nd(public.gidx, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.geometry) TO service_role;


--
-- Name: FUNCTION overlaps_nd(public.gidx, public.gidx); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.gidx) TO postgres;
GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.gidx) TO anon;
GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.gidx) TO authenticated;
GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.gidx) TO service_role;


--
-- Name: FUNCTION pgis_asflatgeobuf_finalfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_finalfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_finalfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_finalfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_finalfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement) TO anon;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement) TO service_role;


--
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean) TO anon;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean) TO service_role;


--
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text) TO anon;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text) TO service_role;


--
-- Name: FUNCTION pgis_asgeobuf_finalfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asgeobuf_finalfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_finalfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_finalfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_finalfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_asgeobuf_transfn(internal, anyelement); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement) TO anon;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement) TO service_role;


--
-- Name: FUNCTION pgis_asgeobuf_transfn(internal, anyelement, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement, text) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement, text) TO anon;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement, text) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement, text) TO service_role;


--
-- Name: FUNCTION pgis_asmvt_combinefn(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asmvt_combinefn(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asmvt_combinefn(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_asmvt_combinefn(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asmvt_combinefn(internal, internal) TO service_role;


--
-- Name: FUNCTION pgis_asmvt_deserialfn(bytea, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asmvt_deserialfn(bytea, internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asmvt_deserialfn(bytea, internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_asmvt_deserialfn(bytea, internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asmvt_deserialfn(bytea, internal) TO service_role;


--
-- Name: FUNCTION pgis_asmvt_finalfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asmvt_finalfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asmvt_finalfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_asmvt_finalfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asmvt_finalfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_asmvt_serialfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asmvt_serialfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asmvt_serialfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_asmvt_serialfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asmvt_serialfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement) TO anon;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement) TO service_role;


--
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text) TO anon;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text) TO service_role;


--
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer) TO anon;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer) TO service_role;


--
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text) TO anon;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text) TO service_role;


--
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer, text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text, text) TO postgres;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text, text) TO anon;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text, text) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text, text) TO service_role;


--
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry) TO service_role;


--
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, public.geometry, double precision, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision, integer) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision, integer) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision, integer) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision, integer) TO service_role;


--
-- Name: FUNCTION pgis_geometry_clusterintersecting_finalfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_clusterintersecting_finalfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_clusterintersecting_finalfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_clusterintersecting_finalfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_clusterintersecting_finalfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_geometry_clusterwithin_finalfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_clusterwithin_finalfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_clusterwithin_finalfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_clusterwithin_finalfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_clusterwithin_finalfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_geometry_collect_finalfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_collect_finalfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_collect_finalfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_collect_finalfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_collect_finalfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_geometry_makeline_finalfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_makeline_finalfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_makeline_finalfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_makeline_finalfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_makeline_finalfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_geometry_polygonize_finalfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_polygonize_finalfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_polygonize_finalfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_polygonize_finalfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_polygonize_finalfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_geometry_union_parallel_combinefn(internal, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_combinefn(internal, internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_combinefn(internal, internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_combinefn(internal, internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_combinefn(internal, internal) TO service_role;


--
-- Name: FUNCTION pgis_geometry_union_parallel_deserialfn(bytea, internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_deserialfn(bytea, internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_deserialfn(bytea, internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_deserialfn(bytea, internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_deserialfn(bytea, internal) TO service_role;


--
-- Name: FUNCTION pgis_geometry_union_parallel_finalfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_finalfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_finalfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_finalfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_finalfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_geometry_union_parallel_serialfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_serialfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_serialfn(internal) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_serialfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_serialfn(internal) TO service_role;


--
-- Name: FUNCTION pgis_geometry_union_parallel_transfn(internal, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_transfn(internal, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_transfn(internal, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_transfn(internal, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_transfn(internal, public.geometry) TO service_role;


--
-- Name: FUNCTION pgis_geometry_union_parallel_transfn(internal, public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_transfn(internal, public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_transfn(internal, public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_transfn(internal, public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.pgis_geometry_union_parallel_transfn(internal, public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION populate_geometry_columns(use_typmod boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.populate_geometry_columns(use_typmod boolean) TO postgres;
GRANT ALL ON FUNCTION public.populate_geometry_columns(use_typmod boolean) TO anon;
GRANT ALL ON FUNCTION public.populate_geometry_columns(use_typmod boolean) TO authenticated;
GRANT ALL ON FUNCTION public.populate_geometry_columns(use_typmod boolean) TO service_role;


--
-- Name: FUNCTION populate_geometry_columns(tbl_oid oid, use_typmod boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.populate_geometry_columns(tbl_oid oid, use_typmod boolean) TO postgres;
GRANT ALL ON FUNCTION public.populate_geometry_columns(tbl_oid oid, use_typmod boolean) TO anon;
GRANT ALL ON FUNCTION public.populate_geometry_columns(tbl_oid oid, use_typmod boolean) TO authenticated;
GRANT ALL ON FUNCTION public.populate_geometry_columns(tbl_oid oid, use_typmod boolean) TO service_role;


--
-- Name: FUNCTION postgis_addbbox(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_addbbox(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.postgis_addbbox(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.postgis_addbbox(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_addbbox(public.geometry) TO service_role;


--
-- Name: FUNCTION postgis_cache_bbox(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_cache_bbox() TO postgres;
GRANT ALL ON FUNCTION public.postgis_cache_bbox() TO anon;
GRANT ALL ON FUNCTION public.postgis_cache_bbox() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_cache_bbox() TO service_role;


--
-- Name: FUNCTION postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text) TO postgres;
GRANT ALL ON FUNCTION public.postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text) TO anon;
GRANT ALL ON FUNCTION public.postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text) TO service_role;


--
-- Name: FUNCTION postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text) TO postgres;
GRANT ALL ON FUNCTION public.postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text) TO anon;
GRANT ALL ON FUNCTION public.postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text) TO service_role;


--
-- Name: FUNCTION postgis_constraint_type(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_constraint_type(geomschema text, geomtable text, geomcolumn text) TO postgres;
GRANT ALL ON FUNCTION public.postgis_constraint_type(geomschema text, geomtable text, geomcolumn text) TO anon;
GRANT ALL ON FUNCTION public.postgis_constraint_type(geomschema text, geomtable text, geomcolumn text) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_constraint_type(geomschema text, geomtable text, geomcolumn text) TO service_role;


--
-- Name: FUNCTION postgis_dropbbox(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_dropbbox(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.postgis_dropbbox(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.postgis_dropbbox(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_dropbbox(public.geometry) TO service_role;


--
-- Name: FUNCTION postgis_extensions_upgrade(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_extensions_upgrade() TO postgres;
GRANT ALL ON FUNCTION public.postgis_extensions_upgrade() TO anon;
GRANT ALL ON FUNCTION public.postgis_extensions_upgrade() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_extensions_upgrade() TO service_role;


--
-- Name: FUNCTION postgis_full_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_full_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_full_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_full_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_full_version() TO service_role;


--
-- Name: FUNCTION postgis_geos_noop(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_geos_noop(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.postgis_geos_noop(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.postgis_geos_noop(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_geos_noop(public.geometry) TO service_role;


--
-- Name: FUNCTION postgis_geos_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_geos_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_geos_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_geos_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_geos_version() TO service_role;


--
-- Name: FUNCTION postgis_getbbox(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_getbbox(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.postgis_getbbox(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.postgis_getbbox(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_getbbox(public.geometry) TO service_role;


--
-- Name: FUNCTION postgis_hasbbox(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_hasbbox(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.postgis_hasbbox(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.postgis_hasbbox(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_hasbbox(public.geometry) TO service_role;


--
-- Name: FUNCTION postgis_index_supportfn(internal); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_index_supportfn(internal) TO postgres;
GRANT ALL ON FUNCTION public.postgis_index_supportfn(internal) TO anon;
GRANT ALL ON FUNCTION public.postgis_index_supportfn(internal) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_index_supportfn(internal) TO service_role;


--
-- Name: FUNCTION postgis_lib_build_date(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_lib_build_date() TO postgres;
GRANT ALL ON FUNCTION public.postgis_lib_build_date() TO anon;
GRANT ALL ON FUNCTION public.postgis_lib_build_date() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_lib_build_date() TO service_role;


--
-- Name: FUNCTION postgis_lib_revision(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_lib_revision() TO postgres;
GRANT ALL ON FUNCTION public.postgis_lib_revision() TO anon;
GRANT ALL ON FUNCTION public.postgis_lib_revision() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_lib_revision() TO service_role;


--
-- Name: FUNCTION postgis_lib_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_lib_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_lib_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_lib_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_lib_version() TO service_role;


--
-- Name: FUNCTION postgis_libjson_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_libjson_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_libjson_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_libjson_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_libjson_version() TO service_role;


--
-- Name: FUNCTION postgis_liblwgeom_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_liblwgeom_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_liblwgeom_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_liblwgeom_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_liblwgeom_version() TO service_role;


--
-- Name: FUNCTION postgis_libprotobuf_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_libprotobuf_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_libprotobuf_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_libprotobuf_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_libprotobuf_version() TO service_role;


--
-- Name: FUNCTION postgis_libxml_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_libxml_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_libxml_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_libxml_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_libxml_version() TO service_role;


--
-- Name: FUNCTION postgis_noop(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_noop(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.postgis_noop(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.postgis_noop(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_noop(public.geometry) TO service_role;


--
-- Name: FUNCTION postgis_proj_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_proj_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_proj_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_proj_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_proj_version() TO service_role;


--
-- Name: FUNCTION postgis_scripts_build_date(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_scripts_build_date() TO postgres;
GRANT ALL ON FUNCTION public.postgis_scripts_build_date() TO anon;
GRANT ALL ON FUNCTION public.postgis_scripts_build_date() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_scripts_build_date() TO service_role;


--
-- Name: FUNCTION postgis_scripts_installed(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_scripts_installed() TO postgres;
GRANT ALL ON FUNCTION public.postgis_scripts_installed() TO anon;
GRANT ALL ON FUNCTION public.postgis_scripts_installed() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_scripts_installed() TO service_role;


--
-- Name: FUNCTION postgis_scripts_released(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_scripts_released() TO postgres;
GRANT ALL ON FUNCTION public.postgis_scripts_released() TO anon;
GRANT ALL ON FUNCTION public.postgis_scripts_released() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_scripts_released() TO service_role;


--
-- Name: FUNCTION postgis_svn_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_svn_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_svn_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_svn_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_svn_version() TO service_role;


--
-- Name: FUNCTION postgis_transform_geometry(geom public.geometry, text, text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_transform_geometry(geom public.geometry, text, text, integer) TO postgres;
GRANT ALL ON FUNCTION public.postgis_transform_geometry(geom public.geometry, text, text, integer) TO anon;
GRANT ALL ON FUNCTION public.postgis_transform_geometry(geom public.geometry, text, text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_transform_geometry(geom public.geometry, text, text, integer) TO service_role;


--
-- Name: FUNCTION postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean) TO postgres;
GRANT ALL ON FUNCTION public.postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean) TO anon;
GRANT ALL ON FUNCTION public.postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean) TO service_role;


--
-- Name: FUNCTION postgis_typmod_dims(integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_typmod_dims(integer) TO postgres;
GRANT ALL ON FUNCTION public.postgis_typmod_dims(integer) TO anon;
GRANT ALL ON FUNCTION public.postgis_typmod_dims(integer) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_typmod_dims(integer) TO service_role;


--
-- Name: FUNCTION postgis_typmod_srid(integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_typmod_srid(integer) TO postgres;
GRANT ALL ON FUNCTION public.postgis_typmod_srid(integer) TO anon;
GRANT ALL ON FUNCTION public.postgis_typmod_srid(integer) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_typmod_srid(integer) TO service_role;


--
-- Name: FUNCTION postgis_typmod_type(integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_typmod_type(integer) TO postgres;
GRANT ALL ON FUNCTION public.postgis_typmod_type(integer) TO anon;
GRANT ALL ON FUNCTION public.postgis_typmod_type(integer) TO authenticated;
GRANT ALL ON FUNCTION public.postgis_typmod_type(integer) TO service_role;


--
-- Name: FUNCTION postgis_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_version() TO service_role;


--
-- Name: FUNCTION postgis_wagyu_version(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.postgis_wagyu_version() TO postgres;
GRANT ALL ON FUNCTION public.postgis_wagyu_version() TO anon;
GRANT ALL ON FUNCTION public.postgis_wagyu_version() TO authenticated;
GRANT ALL ON FUNCTION public.postgis_wagyu_version() TO service_role;


--
-- Name: FUNCTION st_3dclosestpoint(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3dclosestpoint(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_3dclosestpoint(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_3dclosestpoint(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_3dclosestpoint(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_3ddistance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3ddistance(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_3ddistance(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_3ddistance(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_3ddistance(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_3dintersects(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_3dlength(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3dlength(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_3dlength(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_3dlength(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_3dlength(public.geometry) TO service_role;


--
-- Name: FUNCTION st_3dlineinterpolatepoint(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3dlineinterpolatepoint(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_3dlineinterpolatepoint(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_3dlineinterpolatepoint(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_3dlineinterpolatepoint(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_3dlongestline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3dlongestline(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_3dlongestline(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_3dlongestline(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_3dlongestline(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_3dmakebox(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3dmakebox(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_3dmakebox(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_3dmakebox(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_3dmakebox(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_3dmaxdistance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3dmaxdistance(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_3dmaxdistance(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_3dmaxdistance(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_3dmaxdistance(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_3dperimeter(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3dperimeter(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_3dperimeter(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_3dperimeter(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_3dperimeter(public.geometry) TO service_role;


--
-- Name: FUNCTION st_3dshortestline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3dshortestline(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_3dshortestline(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_3dshortestline(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_3dshortestline(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_addmeasure(public.geometry, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_addmeasure(public.geometry, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_addmeasure(public.geometry, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_addmeasure(public.geometry, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_addmeasure(public.geometry, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_addpoint(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_addpoint(geom1 public.geometry, geom2 public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_angle(line1 public.geometry, line2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_angle(line1 public.geometry, line2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_angle(line1 public.geometry, line2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_angle(line1 public.geometry, line2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_angle(line1 public.geometry, line2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_angle(pt1 public.geometry, pt2 public.geometry, pt3 public.geometry, pt4 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_angle(pt1 public.geometry, pt2 public.geometry, pt3 public.geometry, pt4 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_angle(pt1 public.geometry, pt2 public.geometry, pt3 public.geometry, pt4 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_angle(pt1 public.geometry, pt2 public.geometry, pt3 public.geometry, pt4 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_angle(pt1 public.geometry, pt2 public.geometry, pt3 public.geometry, pt4 public.geometry) TO service_role;


--
-- Name: FUNCTION st_area(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_area(text) TO postgres;
GRANT ALL ON FUNCTION public.st_area(text) TO anon;
GRANT ALL ON FUNCTION public.st_area(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_area(text) TO service_role;


--
-- Name: FUNCTION st_area(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_area(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_area(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_area(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_area(public.geometry) TO service_role;


--
-- Name: FUNCTION st_area(geog public.geography, use_spheroid boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_area(geog public.geography, use_spheroid boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_area(geog public.geography, use_spheroid boolean) TO anon;
GRANT ALL ON FUNCTION public.st_area(geog public.geography, use_spheroid boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_area(geog public.geography, use_spheroid boolean) TO service_role;


--
-- Name: FUNCTION st_area2d(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_area2d(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_area2d(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_area2d(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_area2d(public.geometry) TO service_role;


--
-- Name: FUNCTION st_asbinary(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asbinary(public.geography) TO postgres;
GRANT ALL ON FUNCTION public.st_asbinary(public.geography) TO anon;
GRANT ALL ON FUNCTION public.st_asbinary(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.st_asbinary(public.geography) TO service_role;


--
-- Name: FUNCTION st_asbinary(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asbinary(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_asbinary(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_asbinary(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_asbinary(public.geometry) TO service_role;


--
-- Name: FUNCTION st_asbinary(public.geography, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asbinary(public.geography, text) TO postgres;
GRANT ALL ON FUNCTION public.st_asbinary(public.geography, text) TO anon;
GRANT ALL ON FUNCTION public.st_asbinary(public.geography, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asbinary(public.geography, text) TO service_role;


--
-- Name: FUNCTION st_asbinary(public.geometry, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asbinary(public.geometry, text) TO postgres;
GRANT ALL ON FUNCTION public.st_asbinary(public.geometry, text) TO anon;
GRANT ALL ON FUNCTION public.st_asbinary(public.geometry, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asbinary(public.geometry, text) TO service_role;


--
-- Name: FUNCTION st_asencodedpolyline(geom public.geometry, nprecision integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asencodedpolyline(geom public.geometry, nprecision integer) TO postgres;
GRANT ALL ON FUNCTION public.st_asencodedpolyline(geom public.geometry, nprecision integer) TO anon;
GRANT ALL ON FUNCTION public.st_asencodedpolyline(geom public.geometry, nprecision integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_asencodedpolyline(geom public.geometry, nprecision integer) TO service_role;


--
-- Name: FUNCTION st_asewkb(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asewkb(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_asewkb(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_asewkb(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_asewkb(public.geometry) TO service_role;


--
-- Name: FUNCTION st_asewkb(public.geometry, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asewkb(public.geometry, text) TO postgres;
GRANT ALL ON FUNCTION public.st_asewkb(public.geometry, text) TO anon;
GRANT ALL ON FUNCTION public.st_asewkb(public.geometry, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asewkb(public.geometry, text) TO service_role;


--
-- Name: FUNCTION st_asewkt(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asewkt(text) TO postgres;
GRANT ALL ON FUNCTION public.st_asewkt(text) TO anon;
GRANT ALL ON FUNCTION public.st_asewkt(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asewkt(text) TO service_role;


--
-- Name: FUNCTION st_asewkt(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asewkt(public.geography) TO postgres;
GRANT ALL ON FUNCTION public.st_asewkt(public.geography) TO anon;
GRANT ALL ON FUNCTION public.st_asewkt(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.st_asewkt(public.geography) TO service_role;


--
-- Name: FUNCTION st_asewkt(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asewkt(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_asewkt(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_asewkt(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_asewkt(public.geometry) TO service_role;


--
-- Name: FUNCTION st_asewkt(public.geography, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asewkt(public.geography, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_asewkt(public.geography, integer) TO anon;
GRANT ALL ON FUNCTION public.st_asewkt(public.geography, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_asewkt(public.geography, integer) TO service_role;


--
-- Name: FUNCTION st_asewkt(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asewkt(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_asewkt(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_asewkt(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_asewkt(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_asgeojson(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgeojson(text) TO postgres;
GRANT ALL ON FUNCTION public.st_asgeojson(text) TO anon;
GRANT ALL ON FUNCTION public.st_asgeojson(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgeojson(text) TO service_role;


--
-- Name: FUNCTION st_asgeojson(geog public.geography, maxdecimaldigits integer, options integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgeojson(geog public.geography, maxdecimaldigits integer, options integer) TO postgres;
GRANT ALL ON FUNCTION public.st_asgeojson(geog public.geography, maxdecimaldigits integer, options integer) TO anon;
GRANT ALL ON FUNCTION public.st_asgeojson(geog public.geography, maxdecimaldigits integer, options integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgeojson(geog public.geography, maxdecimaldigits integer, options integer) TO service_role;


--
-- Name: FUNCTION st_asgeojson(geom public.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgeojson(geom public.geometry, maxdecimaldigits integer, options integer) TO postgres;
GRANT ALL ON FUNCTION public.st_asgeojson(geom public.geometry, maxdecimaldigits integer, options integer) TO anon;
GRANT ALL ON FUNCTION public.st_asgeojson(geom public.geometry, maxdecimaldigits integer, options integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgeojson(geom public.geometry, maxdecimaldigits integer, options integer) TO service_role;


--
-- Name: FUNCTION st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean) TO anon;
GRANT ALL ON FUNCTION public.st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean) TO service_role;


--
-- Name: FUNCTION st_asgml(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgml(text) TO postgres;
GRANT ALL ON FUNCTION public.st_asgml(text) TO anon;
GRANT ALL ON FUNCTION public.st_asgml(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgml(text) TO service_role;


--
-- Name: FUNCTION st_asgml(geom public.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgml(geom public.geometry, maxdecimaldigits integer, options integer) TO postgres;
GRANT ALL ON FUNCTION public.st_asgml(geom public.geometry, maxdecimaldigits integer, options integer) TO anon;
GRANT ALL ON FUNCTION public.st_asgml(geom public.geometry, maxdecimaldigits integer, options integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgml(geom public.geometry, maxdecimaldigits integer, options integer) TO service_role;


--
-- Name: FUNCTION st_asgml(geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgml(geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres;
GRANT ALL ON FUNCTION public.st_asgml(geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO anon;
GRANT ALL ON FUNCTION public.st_asgml(geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgml(geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO service_role;


--
-- Name: FUNCTION st_asgml(version integer, geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgml(version integer, geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres;
GRANT ALL ON FUNCTION public.st_asgml(version integer, geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO anon;
GRANT ALL ON FUNCTION public.st_asgml(version integer, geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgml(version integer, geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO service_role;


--
-- Name: FUNCTION st_asgml(version integer, geom public.geometry, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgml(version integer, geom public.geometry, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres;
GRANT ALL ON FUNCTION public.st_asgml(version integer, geom public.geometry, maxdecimaldigits integer, options integer, nprefix text, id text) TO anon;
GRANT ALL ON FUNCTION public.st_asgml(version integer, geom public.geometry, maxdecimaldigits integer, options integer, nprefix text, id text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgml(version integer, geom public.geometry, maxdecimaldigits integer, options integer, nprefix text, id text) TO service_role;


--
-- Name: FUNCTION st_ashexewkb(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry) TO service_role;


--
-- Name: FUNCTION st_ashexewkb(public.geometry, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry, text) TO postgres;
GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry, text) TO anon;
GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry, text) TO service_role;


--
-- Name: FUNCTION st_askml(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_askml(text) TO postgres;
GRANT ALL ON FUNCTION public.st_askml(text) TO anon;
GRANT ALL ON FUNCTION public.st_askml(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_askml(text) TO service_role;


--
-- Name: FUNCTION st_askml(geog public.geography, maxdecimaldigits integer, nprefix text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_askml(geog public.geography, maxdecimaldigits integer, nprefix text) TO postgres;
GRANT ALL ON FUNCTION public.st_askml(geog public.geography, maxdecimaldigits integer, nprefix text) TO anon;
GRANT ALL ON FUNCTION public.st_askml(geog public.geography, maxdecimaldigits integer, nprefix text) TO authenticated;
GRANT ALL ON FUNCTION public.st_askml(geog public.geography, maxdecimaldigits integer, nprefix text) TO service_role;


--
-- Name: FUNCTION st_askml(geom public.geometry, maxdecimaldigits integer, nprefix text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_askml(geom public.geometry, maxdecimaldigits integer, nprefix text) TO postgres;
GRANT ALL ON FUNCTION public.st_askml(geom public.geometry, maxdecimaldigits integer, nprefix text) TO anon;
GRANT ALL ON FUNCTION public.st_askml(geom public.geometry, maxdecimaldigits integer, nprefix text) TO authenticated;
GRANT ALL ON FUNCTION public.st_askml(geom public.geometry, maxdecimaldigits integer, nprefix text) TO service_role;


--
-- Name: FUNCTION st_aslatlontext(geom public.geometry, tmpl text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_aslatlontext(geom public.geometry, tmpl text) TO postgres;
GRANT ALL ON FUNCTION public.st_aslatlontext(geom public.geometry, tmpl text) TO anon;
GRANT ALL ON FUNCTION public.st_aslatlontext(geom public.geometry, tmpl text) TO authenticated;
GRANT ALL ON FUNCTION public.st_aslatlontext(geom public.geometry, tmpl text) TO service_role;


--
-- Name: FUNCTION st_asmarc21(geom public.geometry, format text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asmarc21(geom public.geometry, format text) TO postgres;
GRANT ALL ON FUNCTION public.st_asmarc21(geom public.geometry, format text) TO anon;
GRANT ALL ON FUNCTION public.st_asmarc21(geom public.geometry, format text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asmarc21(geom public.geometry, format text) TO service_role;


--
-- Name: FUNCTION st_asmvtgeom(geom public.geometry, bounds public.box2d, extent integer, buffer integer, clip_geom boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asmvtgeom(geom public.geometry, bounds public.box2d, extent integer, buffer integer, clip_geom boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_asmvtgeom(geom public.geometry, bounds public.box2d, extent integer, buffer integer, clip_geom boolean) TO anon;
GRANT ALL ON FUNCTION public.st_asmvtgeom(geom public.geometry, bounds public.box2d, extent integer, buffer integer, clip_geom boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_asmvtgeom(geom public.geometry, bounds public.box2d, extent integer, buffer integer, clip_geom boolean) TO service_role;


--
-- Name: FUNCTION st_assvg(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_assvg(text) TO postgres;
GRANT ALL ON FUNCTION public.st_assvg(text) TO anon;
GRANT ALL ON FUNCTION public.st_assvg(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_assvg(text) TO service_role;


--
-- Name: FUNCTION st_assvg(geog public.geography, rel integer, maxdecimaldigits integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_assvg(geog public.geography, rel integer, maxdecimaldigits integer) TO postgres;
GRANT ALL ON FUNCTION public.st_assvg(geog public.geography, rel integer, maxdecimaldigits integer) TO anon;
GRANT ALL ON FUNCTION public.st_assvg(geog public.geography, rel integer, maxdecimaldigits integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_assvg(geog public.geography, rel integer, maxdecimaldigits integer) TO service_role;


--
-- Name: FUNCTION st_assvg(geom public.geometry, rel integer, maxdecimaldigits integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_assvg(geom public.geometry, rel integer, maxdecimaldigits integer) TO postgres;
GRANT ALL ON FUNCTION public.st_assvg(geom public.geometry, rel integer, maxdecimaldigits integer) TO anon;
GRANT ALL ON FUNCTION public.st_assvg(geom public.geometry, rel integer, maxdecimaldigits integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_assvg(geom public.geometry, rel integer, maxdecimaldigits integer) TO service_role;


--
-- Name: FUNCTION st_astext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_astext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_astext(text) TO anon;
GRANT ALL ON FUNCTION public.st_astext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_astext(text) TO service_role;


--
-- Name: FUNCTION st_astext(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_astext(public.geography) TO postgres;
GRANT ALL ON FUNCTION public.st_astext(public.geography) TO anon;
GRANT ALL ON FUNCTION public.st_astext(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.st_astext(public.geography) TO service_role;


--
-- Name: FUNCTION st_astext(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_astext(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_astext(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_astext(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_astext(public.geometry) TO service_role;


--
-- Name: FUNCTION st_astext(public.geography, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_astext(public.geography, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_astext(public.geography, integer) TO anon;
GRANT ALL ON FUNCTION public.st_astext(public.geography, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_astext(public.geography, integer) TO service_role;


--
-- Name: FUNCTION st_astext(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_astext(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_astext(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_astext(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_astext(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_astwkb(geom public.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO anon;
GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO service_role;


--
-- Name: FUNCTION st_astwkb(geom public.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO anon;
GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO service_role;


--
-- Name: FUNCTION st_asx3d(geom public.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asx3d(geom public.geometry, maxdecimaldigits integer, options integer) TO postgres;
GRANT ALL ON FUNCTION public.st_asx3d(geom public.geometry, maxdecimaldigits integer, options integer) TO anon;
GRANT ALL ON FUNCTION public.st_asx3d(geom public.geometry, maxdecimaldigits integer, options integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_asx3d(geom public.geometry, maxdecimaldigits integer, options integer) TO service_role;


--
-- Name: FUNCTION st_azimuth(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_azimuth(geog1 public.geography, geog2 public.geography) TO postgres;
GRANT ALL ON FUNCTION public.st_azimuth(geog1 public.geography, geog2 public.geography) TO anon;
GRANT ALL ON FUNCTION public.st_azimuth(geog1 public.geography, geog2 public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.st_azimuth(geog1 public.geography, geog2 public.geography) TO service_role;


--
-- Name: FUNCTION st_azimuth(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_azimuth(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_azimuth(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_azimuth(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_azimuth(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_bdmpolyfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_bdmpolyfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_bdmpolyfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_bdmpolyfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_bdmpolyfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_bdpolyfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_bdpolyfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_bdpolyfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_bdpolyfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_bdpolyfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_boundary(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_boundary(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_boundary(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_boundary(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_boundary(public.geometry) TO service_role;


--
-- Name: FUNCTION st_boundingdiagonal(geom public.geometry, fits boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_boundingdiagonal(geom public.geometry, fits boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_boundingdiagonal(geom public.geometry, fits boolean) TO anon;
GRANT ALL ON FUNCTION public.st_boundingdiagonal(geom public.geometry, fits boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_boundingdiagonal(geom public.geometry, fits boolean) TO service_role;


--
-- Name: FUNCTION st_box2dfromgeohash(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_box2dfromgeohash(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_box2dfromgeohash(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_box2dfromgeohash(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_box2dfromgeohash(text, integer) TO service_role;


--
-- Name: FUNCTION st_buffer(text, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_buffer(text, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision) TO service_role;


--
-- Name: FUNCTION st_buffer(public.geography, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision) TO service_role;


--
-- Name: FUNCTION st_buffer(text, double precision, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_buffer(text, double precision, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision, integer) TO anon;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision, integer) TO service_role;


--
-- Name: FUNCTION st_buffer(text, double precision, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_buffer(text, double precision, text) TO postgres;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision, text) TO anon;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision, text) TO service_role;


--
-- Name: FUNCTION st_buffer(public.geography, double precision, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, integer) TO anon;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, integer) TO service_role;


--
-- Name: FUNCTION st_buffer(public.geography, double precision, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, text) TO postgres;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, text) TO anon;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, text) TO service_role;


--
-- Name: FUNCTION st_buffer(geom public.geometry, radius double precision, quadsegs integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, quadsegs integer) TO postgres;
GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, quadsegs integer) TO anon;
GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, quadsegs integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, quadsegs integer) TO service_role;


--
-- Name: FUNCTION st_buffer(geom public.geometry, radius double precision, options text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, options text) TO postgres;
GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, options text) TO anon;
GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, options text) TO authenticated;
GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, options text) TO service_role;


--
-- Name: FUNCTION st_buildarea(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_buildarea(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_buildarea(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_buildarea(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_buildarea(public.geometry) TO service_role;


--
-- Name: FUNCTION st_centroid(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_centroid(text) TO postgres;
GRANT ALL ON FUNCTION public.st_centroid(text) TO anon;
GRANT ALL ON FUNCTION public.st_centroid(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_centroid(text) TO service_role;


--
-- Name: FUNCTION st_centroid(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_centroid(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_centroid(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_centroid(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_centroid(public.geometry) TO service_role;


--
-- Name: FUNCTION st_centroid(public.geography, use_spheroid boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_centroid(public.geography, use_spheroid boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_centroid(public.geography, use_spheroid boolean) TO anon;
GRANT ALL ON FUNCTION public.st_centroid(public.geography, use_spheroid boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_centroid(public.geography, use_spheroid boolean) TO service_role;


--
-- Name: FUNCTION st_chaikinsmoothing(public.geometry, integer, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_chaikinsmoothing(public.geometry, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_chaikinsmoothing(public.geometry, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.st_chaikinsmoothing(public.geometry, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_chaikinsmoothing(public.geometry, integer, boolean) TO service_role;


--
-- Name: FUNCTION st_cleangeometry(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_cleangeometry(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_cleangeometry(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_cleangeometry(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_cleangeometry(public.geometry) TO service_role;


--
-- Name: FUNCTION st_clipbybox2d(geom public.geometry, box public.box2d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_clipbybox2d(geom public.geometry, box public.box2d) TO postgres;
GRANT ALL ON FUNCTION public.st_clipbybox2d(geom public.geometry, box public.box2d) TO anon;
GRANT ALL ON FUNCTION public.st_clipbybox2d(geom public.geometry, box public.box2d) TO authenticated;
GRANT ALL ON FUNCTION public.st_clipbybox2d(geom public.geometry, box public.box2d) TO service_role;


--
-- Name: FUNCTION st_closestpoint(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_closestpoint(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_closestpoint(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_closestpoint(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_closestpoint(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_closestpointofapproach(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_closestpointofapproach(public.geometry, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_closestpointofapproach(public.geometry, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_closestpointofapproach(public.geometry, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_closestpointofapproach(public.geometry, public.geometry) TO service_role;


--
-- Name: FUNCTION st_clusterdbscan(public.geometry, eps double precision, minpoints integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_clusterdbscan(public.geometry, eps double precision, minpoints integer) TO postgres;
GRANT ALL ON FUNCTION public.st_clusterdbscan(public.geometry, eps double precision, minpoints integer) TO anon;
GRANT ALL ON FUNCTION public.st_clusterdbscan(public.geometry, eps double precision, minpoints integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_clusterdbscan(public.geometry, eps double precision, minpoints integer) TO service_role;


--
-- Name: FUNCTION st_clusterintersecting(public.geometry[]); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry[]) TO postgres;
GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry[]) TO anon;
GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry[]) TO authenticated;
GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry[]) TO service_role;


--
-- Name: FUNCTION st_clusterkmeans(geom public.geometry, k integer, max_radius double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_clusterkmeans(geom public.geometry, k integer, max_radius double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_clusterkmeans(geom public.geometry, k integer, max_radius double precision) TO anon;
GRANT ALL ON FUNCTION public.st_clusterkmeans(geom public.geometry, k integer, max_radius double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_clusterkmeans(geom public.geometry, k integer, max_radius double precision) TO service_role;


--
-- Name: FUNCTION st_clusterwithin(public.geometry[], double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry[], double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry[], double precision) TO anon;
GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry[], double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry[], double precision) TO service_role;


--
-- Name: FUNCTION st_collect(public.geometry[]); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_collect(public.geometry[]) TO postgres;
GRANT ALL ON FUNCTION public.st_collect(public.geometry[]) TO anon;
GRANT ALL ON FUNCTION public.st_collect(public.geometry[]) TO authenticated;
GRANT ALL ON FUNCTION public.st_collect(public.geometry[]) TO service_role;


--
-- Name: FUNCTION st_collect(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_collect(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_collect(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_collect(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_collect(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_collectionextract(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry) TO service_role;


--
-- Name: FUNCTION st_collectionextract(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_collectionhomogenize(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_collectionhomogenize(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_collectionhomogenize(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_collectionhomogenize(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_collectionhomogenize(public.geometry) TO service_role;


--
-- Name: FUNCTION st_combinebbox(public.box2d, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_combinebbox(public.box2d, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box2d, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box2d, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box2d, public.geometry) TO service_role;


--
-- Name: FUNCTION st_combinebbox(public.box3d, public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.box3d) TO anon;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.box3d) TO service_role;


--
-- Name: FUNCTION st_combinebbox(public.box3d, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.geometry) TO service_role;


--
-- Name: FUNCTION st_concavehull(param_geom public.geometry, param_pctconvex double precision, param_allow_holes boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_concavehull(param_geom public.geometry, param_pctconvex double precision, param_allow_holes boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_concavehull(param_geom public.geometry, param_pctconvex double precision, param_allow_holes boolean) TO anon;
GRANT ALL ON FUNCTION public.st_concavehull(param_geom public.geometry, param_pctconvex double precision, param_allow_holes boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_concavehull(param_geom public.geometry, param_pctconvex double precision, param_allow_holes boolean) TO service_role;


--
-- Name: FUNCTION st_contains(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_contains(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_contains(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_contains(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_contains(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_containsproperly(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_convexhull(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_convexhull(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_convexhull(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_convexhull(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_convexhull(public.geometry) TO service_role;


--
-- Name: FUNCTION st_coorddim(geometry public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_coorddim(geometry public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_coorddim(geometry public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_coorddim(geometry public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_coorddim(geometry public.geometry) TO service_role;


--
-- Name: FUNCTION st_coveredby(text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_coveredby(text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_coveredby(text, text) TO anon;
GRANT ALL ON FUNCTION public.st_coveredby(text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_coveredby(text, text) TO service_role;


--
-- Name: FUNCTION st_coveredby(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_coveredby(geog1 public.geography, geog2 public.geography) TO postgres;
GRANT ALL ON FUNCTION public.st_coveredby(geog1 public.geography, geog2 public.geography) TO anon;
GRANT ALL ON FUNCTION public.st_coveredby(geog1 public.geography, geog2 public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.st_coveredby(geog1 public.geography, geog2 public.geography) TO service_role;


--
-- Name: FUNCTION st_coveredby(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_coveredby(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_coveredby(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_coveredby(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_coveredby(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_covers(text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_covers(text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_covers(text, text) TO anon;
GRANT ALL ON FUNCTION public.st_covers(text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_covers(text, text) TO service_role;


--
-- Name: FUNCTION st_covers(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_covers(geog1 public.geography, geog2 public.geography) TO postgres;
GRANT ALL ON FUNCTION public.st_covers(geog1 public.geography, geog2 public.geography) TO anon;
GRANT ALL ON FUNCTION public.st_covers(geog1 public.geography, geog2 public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.st_covers(geog1 public.geography, geog2 public.geography) TO service_role;


--
-- Name: FUNCTION st_covers(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_covers(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_covers(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_covers(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_covers(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_cpawithin(public.geometry, public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_cpawithin(public.geometry, public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_cpawithin(public.geometry, public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_cpawithin(public.geometry, public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_cpawithin(public.geometry, public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_crosses(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_crosses(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_crosses(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_crosses(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_crosses(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_curvetoline(geom public.geometry, tol double precision, toltype integer, flags integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_curvetoline(geom public.geometry, tol double precision, toltype integer, flags integer) TO postgres;
GRANT ALL ON FUNCTION public.st_curvetoline(geom public.geometry, tol double precision, toltype integer, flags integer) TO anon;
GRANT ALL ON FUNCTION public.st_curvetoline(geom public.geometry, tol double precision, toltype integer, flags integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_curvetoline(geom public.geometry, tol double precision, toltype integer, flags integer) TO service_role;


--
-- Name: FUNCTION st_delaunaytriangles(g1 public.geometry, tolerance double precision, flags integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_delaunaytriangles(g1 public.geometry, tolerance double precision, flags integer) TO postgres;
GRANT ALL ON FUNCTION public.st_delaunaytriangles(g1 public.geometry, tolerance double precision, flags integer) TO anon;
GRANT ALL ON FUNCTION public.st_delaunaytriangles(g1 public.geometry, tolerance double precision, flags integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_delaunaytriangles(g1 public.geometry, tolerance double precision, flags integer) TO service_role;


--
-- Name: FUNCTION st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_difference(geom1 public.geometry, geom2 public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_difference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_difference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO anon;
GRANT ALL ON FUNCTION public.st_difference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_difference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO service_role;


--
-- Name: FUNCTION st_dimension(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_dimension(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_dimension(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_dimension(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_dimension(public.geometry) TO service_role;


--
-- Name: FUNCTION st_disjoint(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_disjoint(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_disjoint(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_disjoint(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_disjoint(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_distance(text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_distance(text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_distance(text, text) TO anon;
GRANT ALL ON FUNCTION public.st_distance(text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_distance(text, text) TO service_role;


--
-- Name: FUNCTION st_distance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_distance(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_distance(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_distance(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_distance(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_distance(geog1 public.geography, geog2 public.geography, use_spheroid boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_distance(geog1 public.geography, geog2 public.geography, use_spheroid boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_distance(geog1 public.geography, geog2 public.geography, use_spheroid boolean) TO anon;
GRANT ALL ON FUNCTION public.st_distance(geog1 public.geography, geog2 public.geography, use_spheroid boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_distance(geog1 public.geography, geog2 public.geography, use_spheroid boolean) TO service_role;


--
-- Name: FUNCTION st_distancecpa(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_distancecpa(public.geometry, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_distancecpa(public.geometry, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_distancecpa(public.geometry, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_distancecpa(public.geometry, public.geometry) TO service_role;


--
-- Name: FUNCTION st_distancesphere(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_distancesphere(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_distancesphere(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_distancesphere(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_distancesphere(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_distancesphere(geom1 public.geometry, geom2 public.geometry, radius double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_distancesphere(geom1 public.geometry, geom2 public.geometry, radius double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_distancesphere(geom1 public.geometry, geom2 public.geometry, radius double precision) TO anon;
GRANT ALL ON FUNCTION public.st_distancesphere(geom1 public.geometry, geom2 public.geometry, radius double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_distancesphere(geom1 public.geometry, geom2 public.geometry, radius double precision) TO service_role;


--
-- Name: FUNCTION st_distancespheroid(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_distancespheroid(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_distancespheroid(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_distancespheroid(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_distancespheroid(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_distancespheroid(geom1 public.geometry, geom2 public.geometry, public.spheroid); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_distancespheroid(geom1 public.geometry, geom2 public.geometry, public.spheroid) TO postgres;
GRANT ALL ON FUNCTION public.st_distancespheroid(geom1 public.geometry, geom2 public.geometry, public.spheroid) TO anon;
GRANT ALL ON FUNCTION public.st_distancespheroid(geom1 public.geometry, geom2 public.geometry, public.spheroid) TO authenticated;
GRANT ALL ON FUNCTION public.st_distancespheroid(geom1 public.geometry, geom2 public.geometry, public.spheroid) TO service_role;


--
-- Name: FUNCTION st_dump(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_dump(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_dump(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_dump(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_dump(public.geometry) TO service_role;


--
-- Name: FUNCTION st_dumppoints(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_dumppoints(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_dumppoints(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_dumppoints(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_dumppoints(public.geometry) TO service_role;


--
-- Name: FUNCTION st_dumprings(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_dumprings(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_dumprings(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_dumprings(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_dumprings(public.geometry) TO service_role;


--
-- Name: FUNCTION st_dumpsegments(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_dumpsegments(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_dumpsegments(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_dumpsegments(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_dumpsegments(public.geometry) TO service_role;


--
-- Name: FUNCTION st_dwithin(text, text, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_dwithin(text, text, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_dwithin(text, text, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_dwithin(text, text, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_dwithin(text, text, double precision) TO service_role;


--
-- Name: FUNCTION st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO anon;
GRANT ALL ON FUNCTION public.st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO service_role;


--
-- Name: FUNCTION st_endpoint(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_endpoint(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_endpoint(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_endpoint(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_endpoint(public.geometry) TO service_role;


--
-- Name: FUNCTION st_envelope(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_envelope(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_envelope(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_envelope(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_envelope(public.geometry) TO service_role;


--
-- Name: FUNCTION st_equals(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_equals(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_equals(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_equals(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_equals(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_estimatedextent(text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_estimatedextent(text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text) TO anon;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text) TO service_role;


--
-- Name: FUNCTION st_estimatedextent(text, text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text) TO anon;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text) TO service_role;


--
-- Name: FUNCTION st_estimatedextent(text, text, text, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text, boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text, boolean) TO anon;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text, boolean) TO service_role;


--
-- Name: FUNCTION st_expand(public.box2d, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_expand(public.box2d, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_expand(public.box2d, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_expand(public.box2d, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_expand(public.box2d, double precision) TO service_role;


--
-- Name: FUNCTION st_expand(public.box3d, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_expand(public.box3d, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_expand(public.box3d, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_expand(public.box3d, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_expand(public.box3d, double precision) TO service_role;


--
-- Name: FUNCTION st_expand(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_expand(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_expand(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_expand(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_expand(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_expand(box public.box2d, dx double precision, dy double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_expand(box public.box2d, dx double precision, dy double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_expand(box public.box2d, dx double precision, dy double precision) TO anon;
GRANT ALL ON FUNCTION public.st_expand(box public.box2d, dx double precision, dy double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_expand(box public.box2d, dx double precision, dy double precision) TO service_role;


--
-- Name: FUNCTION st_expand(box public.box3d, dx double precision, dy double precision, dz double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_expand(box public.box3d, dx double precision, dy double precision, dz double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_expand(box public.box3d, dx double precision, dy double precision, dz double precision) TO anon;
GRANT ALL ON FUNCTION public.st_expand(box public.box3d, dx double precision, dy double precision, dz double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_expand(box public.box3d, dx double precision, dy double precision, dz double precision) TO service_role;


--
-- Name: FUNCTION st_expand(geom public.geometry, dx double precision, dy double precision, dz double precision, dm double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_expand(geom public.geometry, dx double precision, dy double precision, dz double precision, dm double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_expand(geom public.geometry, dx double precision, dy double precision, dz double precision, dm double precision) TO anon;
GRANT ALL ON FUNCTION public.st_expand(geom public.geometry, dx double precision, dy double precision, dz double precision, dm double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_expand(geom public.geometry, dx double precision, dy double precision, dz double precision, dm double precision) TO service_role;


--
-- Name: FUNCTION st_exteriorring(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_exteriorring(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_exteriorring(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_exteriorring(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_exteriorring(public.geometry) TO service_role;


--
-- Name: FUNCTION st_filterbym(public.geometry, double precision, double precision, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_filterbym(public.geometry, double precision, double precision, boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_filterbym(public.geometry, double precision, double precision, boolean) TO anon;
GRANT ALL ON FUNCTION public.st_filterbym(public.geometry, double precision, double precision, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_filterbym(public.geometry, double precision, double precision, boolean) TO service_role;


--
-- Name: FUNCTION st_findextent(text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_findextent(text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_findextent(text, text) TO anon;
GRANT ALL ON FUNCTION public.st_findextent(text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_findextent(text, text) TO service_role;


--
-- Name: FUNCTION st_findextent(text, text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_findextent(text, text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_findextent(text, text, text) TO anon;
GRANT ALL ON FUNCTION public.st_findextent(text, text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_findextent(text, text, text) TO service_role;


--
-- Name: FUNCTION st_flipcoordinates(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_flipcoordinates(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_flipcoordinates(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_flipcoordinates(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_flipcoordinates(public.geometry) TO service_role;


--
-- Name: FUNCTION st_force2d(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_force2d(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_force2d(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_force2d(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_force2d(public.geometry) TO service_role;


--
-- Name: FUNCTION st_force3d(geom public.geometry, zvalue double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_force3d(geom public.geometry, zvalue double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_force3d(geom public.geometry, zvalue double precision) TO anon;
GRANT ALL ON FUNCTION public.st_force3d(geom public.geometry, zvalue double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_force3d(geom public.geometry, zvalue double precision) TO service_role;


--
-- Name: FUNCTION st_force3dm(geom public.geometry, mvalue double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_force3dm(geom public.geometry, mvalue double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_force3dm(geom public.geometry, mvalue double precision) TO anon;
GRANT ALL ON FUNCTION public.st_force3dm(geom public.geometry, mvalue double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_force3dm(geom public.geometry, mvalue double precision) TO service_role;


--
-- Name: FUNCTION st_force3dz(geom public.geometry, zvalue double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_force3dz(geom public.geometry, zvalue double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_force3dz(geom public.geometry, zvalue double precision) TO anon;
GRANT ALL ON FUNCTION public.st_force3dz(geom public.geometry, zvalue double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_force3dz(geom public.geometry, zvalue double precision) TO service_role;


--
-- Name: FUNCTION st_force4d(geom public.geometry, zvalue double precision, mvalue double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_force4d(geom public.geometry, zvalue double precision, mvalue double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_force4d(geom public.geometry, zvalue double precision, mvalue double precision) TO anon;
GRANT ALL ON FUNCTION public.st_force4d(geom public.geometry, zvalue double precision, mvalue double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_force4d(geom public.geometry, zvalue double precision, mvalue double precision) TO service_role;


--
-- Name: FUNCTION st_forcecollection(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_forcecollection(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_forcecollection(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_forcecollection(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_forcecollection(public.geometry) TO service_role;


--
-- Name: FUNCTION st_forcecurve(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_forcecurve(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_forcecurve(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_forcecurve(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_forcecurve(public.geometry) TO service_role;


--
-- Name: FUNCTION st_forcepolygonccw(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_forcepolygonccw(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_forcepolygonccw(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_forcepolygonccw(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_forcepolygonccw(public.geometry) TO service_role;


--
-- Name: FUNCTION st_forcepolygoncw(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_forcepolygoncw(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_forcepolygoncw(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_forcepolygoncw(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_forcepolygoncw(public.geometry) TO service_role;


--
-- Name: FUNCTION st_forcerhr(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_forcerhr(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_forcerhr(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_forcerhr(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_forcerhr(public.geometry) TO service_role;


--
-- Name: FUNCTION st_forcesfs(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry) TO service_role;


--
-- Name: FUNCTION st_forcesfs(public.geometry, version text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry, version text) TO postgres;
GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry, version text) TO anon;
GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry, version text) TO authenticated;
GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry, version text) TO service_role;


--
-- Name: FUNCTION st_frechetdistance(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_frechetdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_frechetdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_frechetdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_frechetdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_fromflatgeobuf(anyelement, bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_fromflatgeobuf(anyelement, bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_fromflatgeobuf(anyelement, bytea) TO anon;
GRANT ALL ON FUNCTION public.st_fromflatgeobuf(anyelement, bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_fromflatgeobuf(anyelement, bytea) TO service_role;


--
-- Name: FUNCTION st_fromflatgeobuftotable(text, text, bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_fromflatgeobuftotable(text, text, bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_fromflatgeobuftotable(text, text, bytea) TO anon;
GRANT ALL ON FUNCTION public.st_fromflatgeobuftotable(text, text, bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_fromflatgeobuftotable(text, text, bytea) TO service_role;


--
-- Name: FUNCTION st_generatepoints(area public.geometry, npoints integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer) TO postgres;
GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer) TO anon;
GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer) TO service_role;


--
-- Name: FUNCTION st_generatepoints(area public.geometry, npoints integer, seed integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer, seed integer) TO postgres;
GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer, seed integer) TO anon;
GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer, seed integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer, seed integer) TO service_role;


--
-- Name: FUNCTION st_geogfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geogfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_geogfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_geogfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_geogfromtext(text) TO service_role;


--
-- Name: FUNCTION st_geogfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geogfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_geogfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_geogfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_geogfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_geographyfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geographyfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_geographyfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_geographyfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_geographyfromtext(text) TO service_role;


--
-- Name: FUNCTION st_geohash(geog public.geography, maxchars integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geohash(geog public.geography, maxchars integer) TO postgres;
GRANT ALL ON FUNCTION public.st_geohash(geog public.geography, maxchars integer) TO anon;
GRANT ALL ON FUNCTION public.st_geohash(geog public.geography, maxchars integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_geohash(geog public.geography, maxchars integer) TO service_role;


--
-- Name: FUNCTION st_geohash(geom public.geometry, maxchars integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geohash(geom public.geometry, maxchars integer) TO postgres;
GRANT ALL ON FUNCTION public.st_geohash(geom public.geometry, maxchars integer) TO anon;
GRANT ALL ON FUNCTION public.st_geohash(geom public.geometry, maxchars integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_geohash(geom public.geometry, maxchars integer) TO service_role;


--
-- Name: FUNCTION st_geomcollfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomcollfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_geomcollfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_geomcollfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomcollfromtext(text) TO service_role;


--
-- Name: FUNCTION st_geomcollfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomcollfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_geomcollfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_geomcollfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomcollfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_geomcollfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_geomcollfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_geometricmedian(g public.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geometricmedian(g public.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_geometricmedian(g public.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean) TO anon;
GRANT ALL ON FUNCTION public.st_geometricmedian(g public.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_geometricmedian(g public.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean) TO service_role;


--
-- Name: FUNCTION st_geometryfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geometryfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_geometryfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_geometryfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_geometryfromtext(text) TO service_role;


--
-- Name: FUNCTION st_geometryfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geometryfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_geometryfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_geometryfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_geometryfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_geometryn(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geometryn(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_geometryn(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_geometryn(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_geometryn(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_geometrytype(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geometrytype(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_geometrytype(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_geometrytype(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_geometrytype(public.geometry) TO service_role;


--
-- Name: FUNCTION st_geomfromewkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromewkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromewkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromewkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromewkb(bytea) TO service_role;


--
-- Name: FUNCTION st_geomfromewkt(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromewkt(text) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromewkt(text) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromewkt(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromewkt(text) TO service_role;


--
-- Name: FUNCTION st_geomfromgeohash(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromgeohash(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromgeohash(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromgeohash(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromgeohash(text, integer) TO service_role;


--
-- Name: FUNCTION st_geomfromgeojson(json); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromgeojson(json) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(json) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(json) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(json) TO service_role;


--
-- Name: FUNCTION st_geomfromgeojson(jsonb); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromgeojson(jsonb) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(jsonb) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(jsonb) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(jsonb) TO service_role;


--
-- Name: FUNCTION st_geomfromgeojson(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromgeojson(text) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(text) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(text) TO service_role;


--
-- Name: FUNCTION st_geomfromgml(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromgml(text) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromgml(text) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromgml(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromgml(text) TO service_role;


--
-- Name: FUNCTION st_geomfromgml(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromgml(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromgml(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromgml(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromgml(text, integer) TO service_role;


--
-- Name: FUNCTION st_geomfromkml(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromkml(text) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromkml(text) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromkml(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromkml(text) TO service_role;


--
-- Name: FUNCTION st_geomfrommarc21(marc21xml text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfrommarc21(marc21xml text) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfrommarc21(marc21xml text) TO anon;
GRANT ALL ON FUNCTION public.st_geomfrommarc21(marc21xml text) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfrommarc21(marc21xml text) TO service_role;


--
-- Name: FUNCTION st_geomfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromtext(text) TO service_role;


--
-- Name: FUNCTION st_geomfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_geomfromtwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromtwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromtwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromtwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromtwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_geomfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_geomfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_gmltosql(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_gmltosql(text) TO postgres;
GRANT ALL ON FUNCTION public.st_gmltosql(text) TO anon;
GRANT ALL ON FUNCTION public.st_gmltosql(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_gmltosql(text) TO service_role;


--
-- Name: FUNCTION st_gmltosql(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_gmltosql(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_gmltosql(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_gmltosql(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_gmltosql(text, integer) TO service_role;


--
-- Name: FUNCTION st_hasarc(geometry public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_hasarc(geometry public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_hasarc(geometry public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_hasarc(geometry public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_hasarc(geometry public.geometry) TO service_role;


--
-- Name: FUNCTION st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_hexagon(size double precision, cell_i integer, cell_j integer, origin public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_hexagon(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_hexagon(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_hexagon(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_hexagon(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO service_role;


--
-- Name: FUNCTION st_hexagongrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_hexagongrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO postgres;
GRANT ALL ON FUNCTION public.st_hexagongrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO anon;
GRANT ALL ON FUNCTION public.st_hexagongrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_hexagongrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO service_role;


--
-- Name: FUNCTION st_interiorringn(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_interiorringn(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_interiorringn(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_interiorringn(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_interiorringn(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_interpolatepoint(line public.geometry, point public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_interpolatepoint(line public.geometry, point public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_interpolatepoint(line public.geometry, point public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_interpolatepoint(line public.geometry, point public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_interpolatepoint(line public.geometry, point public.geometry) TO service_role;


--
-- Name: FUNCTION st_intersection(text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_intersection(text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_intersection(text, text) TO anon;
GRANT ALL ON FUNCTION public.st_intersection(text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_intersection(text, text) TO service_role;


--
-- Name: FUNCTION st_intersection(public.geography, public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_intersection(public.geography, public.geography) TO postgres;
GRANT ALL ON FUNCTION public.st_intersection(public.geography, public.geography) TO anon;
GRANT ALL ON FUNCTION public.st_intersection(public.geography, public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.st_intersection(public.geography, public.geography) TO service_role;


--
-- Name: FUNCTION st_intersection(geom1 public.geometry, geom2 public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_intersection(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_intersection(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO anon;
GRANT ALL ON FUNCTION public.st_intersection(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_intersection(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO service_role;


--
-- Name: FUNCTION st_intersects(text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_intersects(text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_intersects(text, text) TO anon;
GRANT ALL ON FUNCTION public.st_intersects(text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_intersects(text, text) TO service_role;


--
-- Name: FUNCTION st_intersects(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_intersects(geog1 public.geography, geog2 public.geography) TO postgres;
GRANT ALL ON FUNCTION public.st_intersects(geog1 public.geography, geog2 public.geography) TO anon;
GRANT ALL ON FUNCTION public.st_intersects(geog1 public.geography, geog2 public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.st_intersects(geog1 public.geography, geog2 public.geography) TO service_role;


--
-- Name: FUNCTION st_intersects(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_intersects(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_intersects(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_intersects(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_intersects(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_isclosed(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_isclosed(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_isclosed(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_isclosed(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_isclosed(public.geometry) TO service_role;


--
-- Name: FUNCTION st_iscollection(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_iscollection(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_iscollection(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_iscollection(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_iscollection(public.geometry) TO service_role;


--
-- Name: FUNCTION st_isempty(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_isempty(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_isempty(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_isempty(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_isempty(public.geometry) TO service_role;


--
-- Name: FUNCTION st_ispolygonccw(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_ispolygonccw(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_ispolygonccw(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_ispolygonccw(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_ispolygonccw(public.geometry) TO service_role;


--
-- Name: FUNCTION st_ispolygoncw(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_ispolygoncw(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_ispolygoncw(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_ispolygoncw(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_ispolygoncw(public.geometry) TO service_role;


--
-- Name: FUNCTION st_isring(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_isring(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_isring(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_isring(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_isring(public.geometry) TO service_role;


--
-- Name: FUNCTION st_issimple(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_issimple(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_issimple(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_issimple(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_issimple(public.geometry) TO service_role;


--
-- Name: FUNCTION st_isvalid(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_isvalid(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_isvalid(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_isvalid(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_isvalid(public.geometry) TO service_role;


--
-- Name: FUNCTION st_isvalid(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_isvalid(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_isvalid(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_isvalid(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_isvalid(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_isvaliddetail(geom public.geometry, flags integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_isvaliddetail(geom public.geometry, flags integer) TO postgres;
GRANT ALL ON FUNCTION public.st_isvaliddetail(geom public.geometry, flags integer) TO anon;
GRANT ALL ON FUNCTION public.st_isvaliddetail(geom public.geometry, flags integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_isvaliddetail(geom public.geometry, flags integer) TO service_role;


--
-- Name: FUNCTION st_isvalidreason(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry) TO service_role;


--
-- Name: FUNCTION st_isvalidreason(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_isvalidtrajectory(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_isvalidtrajectory(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_isvalidtrajectory(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_isvalidtrajectory(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_isvalidtrajectory(public.geometry) TO service_role;


--
-- Name: FUNCTION st_length(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_length(text) TO postgres;
GRANT ALL ON FUNCTION public.st_length(text) TO anon;
GRANT ALL ON FUNCTION public.st_length(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_length(text) TO service_role;


--
-- Name: FUNCTION st_length(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_length(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_length(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_length(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_length(public.geometry) TO service_role;


--
-- Name: FUNCTION st_length(geog public.geography, use_spheroid boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_length(geog public.geography, use_spheroid boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_length(geog public.geography, use_spheroid boolean) TO anon;
GRANT ALL ON FUNCTION public.st_length(geog public.geography, use_spheroid boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_length(geog public.geography, use_spheroid boolean) TO service_role;


--
-- Name: FUNCTION st_length2d(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_length2d(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_length2d(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_length2d(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_length2d(public.geometry) TO service_role;


--
-- Name: FUNCTION st_length2dspheroid(public.geometry, public.spheroid); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_length2dspheroid(public.geometry, public.spheroid) TO postgres;
GRANT ALL ON FUNCTION public.st_length2dspheroid(public.geometry, public.spheroid) TO anon;
GRANT ALL ON FUNCTION public.st_length2dspheroid(public.geometry, public.spheroid) TO authenticated;
GRANT ALL ON FUNCTION public.st_length2dspheroid(public.geometry, public.spheroid) TO service_role;


--
-- Name: FUNCTION st_lengthspheroid(public.geometry, public.spheroid); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_lengthspheroid(public.geometry, public.spheroid) TO postgres;
GRANT ALL ON FUNCTION public.st_lengthspheroid(public.geometry, public.spheroid) TO anon;
GRANT ALL ON FUNCTION public.st_lengthspheroid(public.geometry, public.spheroid) TO authenticated;
GRANT ALL ON FUNCTION public.st_lengthspheroid(public.geometry, public.spheroid) TO service_role;


--
-- Name: FUNCTION st_letters(letters text, font json); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_letters(letters text, font json) TO postgres;
GRANT ALL ON FUNCTION public.st_letters(letters text, font json) TO anon;
GRANT ALL ON FUNCTION public.st_letters(letters text, font json) TO authenticated;
GRANT ALL ON FUNCTION public.st_letters(letters text, font json) TO service_role;


--
-- Name: FUNCTION st_linecrossingdirection(line1 public.geometry, line2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_linefromencodedpolyline(txtin text, nprecision integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linefromencodedpolyline(txtin text, nprecision integer) TO postgres;
GRANT ALL ON FUNCTION public.st_linefromencodedpolyline(txtin text, nprecision integer) TO anon;
GRANT ALL ON FUNCTION public.st_linefromencodedpolyline(txtin text, nprecision integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_linefromencodedpolyline(txtin text, nprecision integer) TO service_role;


--
-- Name: FUNCTION st_linefrommultipoint(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linefrommultipoint(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_linefrommultipoint(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_linefrommultipoint(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_linefrommultipoint(public.geometry) TO service_role;


--
-- Name: FUNCTION st_linefromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linefromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_linefromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_linefromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_linefromtext(text) TO service_role;


--
-- Name: FUNCTION st_linefromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linefromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_linefromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_linefromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_linefromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_linefromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linefromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_linefromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_linefromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_linefromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_linefromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linefromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_linefromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_linefromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_linefromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_lineinterpolatepoint(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_lineinterpolatepoint(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_lineinterpolatepoint(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_lineinterpolatepoint(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_lineinterpolatepoint(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_lineinterpolatepoints(public.geometry, double precision, repeat boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_lineinterpolatepoints(public.geometry, double precision, repeat boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_lineinterpolatepoints(public.geometry, double precision, repeat boolean) TO anon;
GRANT ALL ON FUNCTION public.st_lineinterpolatepoints(public.geometry, double precision, repeat boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_lineinterpolatepoints(public.geometry, double precision, repeat boolean) TO service_role;


--
-- Name: FUNCTION st_linelocatepoint(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linelocatepoint(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_linelocatepoint(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_linelocatepoint(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_linelocatepoint(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_linemerge(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linemerge(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_linemerge(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_linemerge(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_linemerge(public.geometry) TO service_role;


--
-- Name: FUNCTION st_linemerge(public.geometry, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linemerge(public.geometry, boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_linemerge(public.geometry, boolean) TO anon;
GRANT ALL ON FUNCTION public.st_linemerge(public.geometry, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_linemerge(public.geometry, boolean) TO service_role;


--
-- Name: FUNCTION st_linestringfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_linestringfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_linesubstring(public.geometry, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linesubstring(public.geometry, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_linesubstring(public.geometry, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_linesubstring(public.geometry, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_linesubstring(public.geometry, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_linetocurve(geometry public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_linetocurve(geometry public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_linetocurve(geometry public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_linetocurve(geometry public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_linetocurve(geometry public.geometry) TO service_role;


--
-- Name: FUNCTION st_locatealong(geometry public.geometry, measure double precision, leftrightoffset double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_locatealong(geometry public.geometry, measure double precision, leftrightoffset double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_locatealong(geometry public.geometry, measure double precision, leftrightoffset double precision) TO anon;
GRANT ALL ON FUNCTION public.st_locatealong(geometry public.geometry, measure double precision, leftrightoffset double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_locatealong(geometry public.geometry, measure double precision, leftrightoffset double precision) TO service_role;


--
-- Name: FUNCTION st_locatebetween(geometry public.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_locatebetween(geometry public.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_locatebetween(geometry public.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision) TO anon;
GRANT ALL ON FUNCTION public.st_locatebetween(geometry public.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_locatebetween(geometry public.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision) TO service_role;


--
-- Name: FUNCTION st_locatebetweenelevations(geometry public.geometry, fromelevation double precision, toelevation double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_locatebetweenelevations(geometry public.geometry, fromelevation double precision, toelevation double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_locatebetweenelevations(geometry public.geometry, fromelevation double precision, toelevation double precision) TO anon;
GRANT ALL ON FUNCTION public.st_locatebetweenelevations(geometry public.geometry, fromelevation double precision, toelevation double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_locatebetweenelevations(geometry public.geometry, fromelevation double precision, toelevation double precision) TO service_role;


--
-- Name: FUNCTION st_longestline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_longestline(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_longestline(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_longestline(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_longestline(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_m(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_m(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_m(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_m(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_m(public.geometry) TO service_role;


--
-- Name: FUNCTION st_makebox2d(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makebox2d(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_makebox2d(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_makebox2d(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_makebox2d(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_makeenvelope(double precision, double precision, double precision, double precision, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makeenvelope(double precision, double precision, double precision, double precision, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_makeenvelope(double precision, double precision, double precision, double precision, integer) TO anon;
GRANT ALL ON FUNCTION public.st_makeenvelope(double precision, double precision, double precision, double precision, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_makeenvelope(double precision, double precision, double precision, double precision, integer) TO service_role;


--
-- Name: FUNCTION st_makeline(public.geometry[]); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makeline(public.geometry[]) TO postgres;
GRANT ALL ON FUNCTION public.st_makeline(public.geometry[]) TO anon;
GRANT ALL ON FUNCTION public.st_makeline(public.geometry[]) TO authenticated;
GRANT ALL ON FUNCTION public.st_makeline(public.geometry[]) TO service_role;


--
-- Name: FUNCTION st_makeline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makeline(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_makeline(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_makeline(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_makeline(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_makepoint(double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_makepointm(double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makepointm(double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_makepointm(double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_makepointm(double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_makepointm(double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_makepolygon(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry) TO service_role;


--
-- Name: FUNCTION st_makepolygon(public.geometry, public.geometry[]); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry, public.geometry[]) TO postgres;
GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry, public.geometry[]) TO anon;
GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry, public.geometry[]) TO authenticated;
GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry, public.geometry[]) TO service_role;


--
-- Name: FUNCTION st_makevalid(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makevalid(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_makevalid(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_makevalid(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_makevalid(public.geometry) TO service_role;


--
-- Name: FUNCTION st_makevalid(geom public.geometry, params text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makevalid(geom public.geometry, params text) TO postgres;
GRANT ALL ON FUNCTION public.st_makevalid(geom public.geometry, params text) TO anon;
GRANT ALL ON FUNCTION public.st_makevalid(geom public.geometry, params text) TO authenticated;
GRANT ALL ON FUNCTION public.st_makevalid(geom public.geometry, params text) TO service_role;


--
-- Name: FUNCTION st_maxdistance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_maximuminscribedcircle(public.geometry, OUT center public.geometry, OUT nearest public.geometry, OUT radius double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_maximuminscribedcircle(public.geometry, OUT center public.geometry, OUT nearest public.geometry, OUT radius double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_maximuminscribedcircle(public.geometry, OUT center public.geometry, OUT nearest public.geometry, OUT radius double precision) TO anon;
GRANT ALL ON FUNCTION public.st_maximuminscribedcircle(public.geometry, OUT center public.geometry, OUT nearest public.geometry, OUT radius double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_maximuminscribedcircle(public.geometry, OUT center public.geometry, OUT nearest public.geometry, OUT radius double precision) TO service_role;


--
-- Name: FUNCTION st_memsize(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_memsize(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_memsize(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_memsize(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_memsize(public.geometry) TO service_role;


--
-- Name: FUNCTION st_minimumboundingcircle(inputgeom public.geometry, segs_per_quarter integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_minimumboundingcircle(inputgeom public.geometry, segs_per_quarter integer) TO postgres;
GRANT ALL ON FUNCTION public.st_minimumboundingcircle(inputgeom public.geometry, segs_per_quarter integer) TO anon;
GRANT ALL ON FUNCTION public.st_minimumboundingcircle(inputgeom public.geometry, segs_per_quarter integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_minimumboundingcircle(inputgeom public.geometry, segs_per_quarter integer) TO service_role;


--
-- Name: FUNCTION st_minimumboundingradius(public.geometry, OUT center public.geometry, OUT radius double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_minimumboundingradius(public.geometry, OUT center public.geometry, OUT radius double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_minimumboundingradius(public.geometry, OUT center public.geometry, OUT radius double precision) TO anon;
GRANT ALL ON FUNCTION public.st_minimumboundingradius(public.geometry, OUT center public.geometry, OUT radius double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_minimumboundingradius(public.geometry, OUT center public.geometry, OUT radius double precision) TO service_role;


--
-- Name: FUNCTION st_minimumclearance(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_minimumclearance(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_minimumclearance(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_minimumclearance(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_minimumclearance(public.geometry) TO service_role;


--
-- Name: FUNCTION st_minimumclearanceline(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_minimumclearanceline(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_minimumclearanceline(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_minimumclearanceline(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_minimumclearanceline(public.geometry) TO service_role;


--
-- Name: FUNCTION st_mlinefromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mlinefromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_mlinefromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_mlinefromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_mlinefromtext(text) TO service_role;


--
-- Name: FUNCTION st_mlinefromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mlinefromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_mlinefromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_mlinefromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_mlinefromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_mlinefromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_mlinefromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_mpointfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mpointfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_mpointfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_mpointfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_mpointfromtext(text) TO service_role;


--
-- Name: FUNCTION st_mpointfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mpointfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_mpointfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_mpointfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_mpointfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_mpointfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_mpointfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_mpolyfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mpolyfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_mpolyfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_mpolyfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_mpolyfromtext(text) TO service_role;


--
-- Name: FUNCTION st_mpolyfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mpolyfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_mpolyfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_mpolyfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_mpolyfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_mpolyfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_mpolyfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_multi(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multi(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_multi(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_multi(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_multi(public.geometry) TO service_role;


--
-- Name: FUNCTION st_multilinefromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multilinefromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_multilinefromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_multilinefromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_multilinefromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_multilinestringfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text) TO service_role;


--
-- Name: FUNCTION st_multilinestringfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_multipointfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multipointfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_multipointfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_multipointfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_multipointfromtext(text) TO service_role;


--
-- Name: FUNCTION st_multipointfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_multipointfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_multipolyfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_multipolyfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_multipolygonfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text) TO service_role;


--
-- Name: FUNCTION st_multipolygonfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_ndims(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_ndims(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_ndims(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_ndims(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_ndims(public.geometry) TO service_role;


--
-- Name: FUNCTION st_node(g public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_node(g public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_node(g public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_node(g public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_node(g public.geometry) TO service_role;


--
-- Name: FUNCTION st_normalize(geom public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_normalize(geom public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_normalize(geom public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_normalize(geom public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_normalize(geom public.geometry) TO service_role;


--
-- Name: FUNCTION st_npoints(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_npoints(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_npoints(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_npoints(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_npoints(public.geometry) TO service_role;


--
-- Name: FUNCTION st_nrings(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_nrings(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_nrings(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_nrings(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_nrings(public.geometry) TO service_role;


--
-- Name: FUNCTION st_numgeometries(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_numgeometries(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_numgeometries(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_numgeometries(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_numgeometries(public.geometry) TO service_role;


--
-- Name: FUNCTION st_numinteriorring(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_numinteriorring(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_numinteriorring(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_numinteriorring(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_numinteriorring(public.geometry) TO service_role;


--
-- Name: FUNCTION st_numinteriorrings(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_numinteriorrings(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_numinteriorrings(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_numinteriorrings(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_numinteriorrings(public.geometry) TO service_role;


--
-- Name: FUNCTION st_numpatches(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_numpatches(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_numpatches(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_numpatches(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_numpatches(public.geometry) TO service_role;


--
-- Name: FUNCTION st_numpoints(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_numpoints(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_numpoints(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_numpoints(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_numpoints(public.geometry) TO service_role;


--
-- Name: FUNCTION st_offsetcurve(line public.geometry, distance double precision, params text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_offsetcurve(line public.geometry, distance double precision, params text) TO postgres;
GRANT ALL ON FUNCTION public.st_offsetcurve(line public.geometry, distance double precision, params text) TO anon;
GRANT ALL ON FUNCTION public.st_offsetcurve(line public.geometry, distance double precision, params text) TO authenticated;
GRANT ALL ON FUNCTION public.st_offsetcurve(line public.geometry, distance double precision, params text) TO service_role;


--
-- Name: FUNCTION st_orderingequals(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_orientedenvelope(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_orientedenvelope(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_orientedenvelope(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_orientedenvelope(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_orientedenvelope(public.geometry) TO service_role;


--
-- Name: FUNCTION st_overlaps(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_overlaps(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_overlaps(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_overlaps(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_overlaps(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_patchn(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_patchn(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_patchn(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_patchn(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_patchn(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_perimeter(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_perimeter(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_perimeter(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_perimeter(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_perimeter(public.geometry) TO service_role;


--
-- Name: FUNCTION st_perimeter(geog public.geography, use_spheroid boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_perimeter(geog public.geography, use_spheroid boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_perimeter(geog public.geography, use_spheroid boolean) TO anon;
GRANT ALL ON FUNCTION public.st_perimeter(geog public.geography, use_spheroid boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_perimeter(geog public.geography, use_spheroid boolean) TO service_role;


--
-- Name: FUNCTION st_perimeter2d(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_perimeter2d(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_perimeter2d(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_perimeter2d(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_perimeter2d(public.geometry) TO service_role;


--
-- Name: FUNCTION st_point(double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_point(double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_point(double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_point(double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_point(double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_point(double precision, double precision, srid integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_point(double precision, double precision, srid integer) TO postgres;
GRANT ALL ON FUNCTION public.st_point(double precision, double precision, srid integer) TO anon;
GRANT ALL ON FUNCTION public.st_point(double precision, double precision, srid integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_point(double precision, double precision, srid integer) TO service_role;


--
-- Name: FUNCTION st_pointfromgeohash(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointfromgeohash(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_pointfromgeohash(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_pointfromgeohash(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointfromgeohash(text, integer) TO service_role;


--
-- Name: FUNCTION st_pointfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_pointfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_pointfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointfromtext(text) TO service_role;


--
-- Name: FUNCTION st_pointfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_pointfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_pointfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_pointfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_pointfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_pointinsidecircle(public.geometry, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointinsidecircle(public.geometry, double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_pointinsidecircle(public.geometry, double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_pointinsidecircle(public.geometry, double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointinsidecircle(public.geometry, double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer) TO postgres;
GRANT ALL ON FUNCTION public.st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer) TO anon;
GRANT ALL ON FUNCTION public.st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer) TO service_role;


--
-- Name: FUNCTION st_pointn(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointn(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_pointn(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_pointn(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointn(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_pointonsurface(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointonsurface(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_pointonsurface(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_pointonsurface(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointonsurface(public.geometry) TO service_role;


--
-- Name: FUNCTION st_points(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_points(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_points(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_points(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_points(public.geometry) TO service_role;


--
-- Name: FUNCTION st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer) TO postgres;
GRANT ALL ON FUNCTION public.st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer) TO anon;
GRANT ALL ON FUNCTION public.st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer) TO service_role;


--
-- Name: FUNCTION st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer) TO postgres;
GRANT ALL ON FUNCTION public.st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer) TO anon;
GRANT ALL ON FUNCTION public.st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer) TO service_role;


--
-- Name: FUNCTION st_polyfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polyfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_polyfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_polyfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_polyfromtext(text) TO service_role;


--
-- Name: FUNCTION st_polyfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polyfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_polyfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_polyfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_polyfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_polyfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_polyfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_polygon(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polygon(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_polygon(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_polygon(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_polygon(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_polygonfromtext(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polygonfromtext(text) TO postgres;
GRANT ALL ON FUNCTION public.st_polygonfromtext(text) TO anon;
GRANT ALL ON FUNCTION public.st_polygonfromtext(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_polygonfromtext(text) TO service_role;


--
-- Name: FUNCTION st_polygonfromtext(text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polygonfromtext(text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_polygonfromtext(text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_polygonfromtext(text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_polygonfromtext(text, integer) TO service_role;


--
-- Name: FUNCTION st_polygonfromwkb(bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea) TO anon;
GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea) TO service_role;


--
-- Name: FUNCTION st_polygonfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea, integer) TO anon;
GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea, integer) TO service_role;


--
-- Name: FUNCTION st_polygonize(public.geometry[]); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polygonize(public.geometry[]) TO postgres;
GRANT ALL ON FUNCTION public.st_polygonize(public.geometry[]) TO anon;
GRANT ALL ON FUNCTION public.st_polygonize(public.geometry[]) TO authenticated;
GRANT ALL ON FUNCTION public.st_polygonize(public.geometry[]) TO service_role;


--
-- Name: FUNCTION st_project(geog public.geography, distance double precision, azimuth double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_project(geog public.geography, distance double precision, azimuth double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_project(geog public.geography, distance double precision, azimuth double precision) TO anon;
GRANT ALL ON FUNCTION public.st_project(geog public.geography, distance double precision, azimuth double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_project(geog public.geography, distance double precision, azimuth double precision) TO service_role;


--
-- Name: FUNCTION st_quantizecoordinates(g public.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_quantizecoordinates(g public.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer) TO postgres;
GRANT ALL ON FUNCTION public.st_quantizecoordinates(g public.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer) TO anon;
GRANT ALL ON FUNCTION public.st_quantizecoordinates(g public.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_quantizecoordinates(g public.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer) TO service_role;


--
-- Name: FUNCTION st_reduceprecision(geom public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_reduceprecision(geom public.geometry, gridsize double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_reduceprecision(geom public.geometry, gridsize double precision) TO anon;
GRANT ALL ON FUNCTION public.st_reduceprecision(geom public.geometry, gridsize double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_reduceprecision(geom public.geometry, gridsize double precision) TO service_role;


--
-- Name: FUNCTION st_relate(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_relate(geom1 public.geometry, geom2 public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_relate(geom1 public.geometry, geom2 public.geometry, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, text) TO postgres;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, text) TO anon;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, text) TO service_role;


--
-- Name: FUNCTION st_relatematch(text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_relatematch(text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_relatematch(text, text) TO anon;
GRANT ALL ON FUNCTION public.st_relatematch(text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_relatematch(text, text) TO service_role;


--
-- Name: FUNCTION st_removepoint(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_removepoint(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_removepoint(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_removepoint(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_removepoint(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_removerepeatedpoints(geom public.geometry, tolerance double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_removerepeatedpoints(geom public.geometry, tolerance double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_removerepeatedpoints(geom public.geometry, tolerance double precision) TO anon;
GRANT ALL ON FUNCTION public.st_removerepeatedpoints(geom public.geometry, tolerance double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_removerepeatedpoints(geom public.geometry, tolerance double precision) TO service_role;


--
-- Name: FUNCTION st_reverse(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_reverse(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_reverse(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_reverse(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_reverse(public.geometry) TO service_role;


--
-- Name: FUNCTION st_rotate(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_rotate(public.geometry, double precision, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, public.geometry) TO service_role;


--
-- Name: FUNCTION st_rotate(public.geometry, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_rotatex(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_rotatex(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_rotatex(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_rotatex(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_rotatex(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_rotatey(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_rotatey(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_rotatey(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_rotatey(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_rotatey(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_rotatez(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_rotatez(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_rotatez(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_rotatez(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_rotatez(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_scale(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry) TO service_role;


--
-- Name: FUNCTION st_scale(public.geometry, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_scale(public.geometry, public.geometry, origin public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry, origin public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry, origin public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry, origin public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry, origin public.geometry) TO service_role;


--
-- Name: FUNCTION st_scale(public.geometry, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_scroll(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_scroll(public.geometry, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_scroll(public.geometry, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_scroll(public.geometry, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_scroll(public.geometry, public.geometry) TO service_role;


--
-- Name: FUNCTION st_segmentize(geog public.geography, max_segment_length double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_segmentize(geog public.geography, max_segment_length double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_segmentize(geog public.geography, max_segment_length double precision) TO anon;
GRANT ALL ON FUNCTION public.st_segmentize(geog public.geography, max_segment_length double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_segmentize(geog public.geography, max_segment_length double precision) TO service_role;


--
-- Name: FUNCTION st_segmentize(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_segmentize(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_segmentize(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_segmentize(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_segmentize(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_seteffectivearea(public.geometry, double precision, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_seteffectivearea(public.geometry, double precision, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_seteffectivearea(public.geometry, double precision, integer) TO anon;
GRANT ALL ON FUNCTION public.st_seteffectivearea(public.geometry, double precision, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_seteffectivearea(public.geometry, double precision, integer) TO service_role;


--
-- Name: FUNCTION st_setpoint(public.geometry, integer, public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_setpoint(public.geometry, integer, public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_setpoint(public.geometry, integer, public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_setpoint(public.geometry, integer, public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_setpoint(public.geometry, integer, public.geometry) TO service_role;


--
-- Name: FUNCTION st_setsrid(geog public.geography, srid integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_setsrid(geog public.geography, srid integer) TO postgres;
GRANT ALL ON FUNCTION public.st_setsrid(geog public.geography, srid integer) TO anon;
GRANT ALL ON FUNCTION public.st_setsrid(geog public.geography, srid integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_setsrid(geog public.geography, srid integer) TO service_role;


--
-- Name: FUNCTION st_setsrid(geom public.geometry, srid integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_setsrid(geom public.geometry, srid integer) TO postgres;
GRANT ALL ON FUNCTION public.st_setsrid(geom public.geometry, srid integer) TO anon;
GRANT ALL ON FUNCTION public.st_setsrid(geom public.geometry, srid integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_setsrid(geom public.geometry, srid integer) TO service_role;


--
-- Name: FUNCTION st_sharedpaths(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_sharedpaths(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_sharedpaths(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_sharedpaths(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_sharedpaths(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_shiftlongitude(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_shiftlongitude(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_shiftlongitude(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_shiftlongitude(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_shiftlongitude(public.geometry) TO service_role;


--
-- Name: FUNCTION st_shortestline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_shortestline(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_shortestline(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_shortestline(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_shortestline(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_simplify(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_simplify(public.geometry, double precision, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision, boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision, boolean) TO anon;
GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision, boolean) TO service_role;


--
-- Name: FUNCTION st_simplifypolygonhull(geom public.geometry, vertex_fraction double precision, is_outer boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_simplifypolygonhull(geom public.geometry, vertex_fraction double precision, is_outer boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_simplifypolygonhull(geom public.geometry, vertex_fraction double precision, is_outer boolean) TO anon;
GRANT ALL ON FUNCTION public.st_simplifypolygonhull(geom public.geometry, vertex_fraction double precision, is_outer boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_simplifypolygonhull(geom public.geometry, vertex_fraction double precision, is_outer boolean) TO service_role;


--
-- Name: FUNCTION st_simplifypreservetopology(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_simplifypreservetopology(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_simplifypreservetopology(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_simplifypreservetopology(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_simplifypreservetopology(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_simplifyvw(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_simplifyvw(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_simplifyvw(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_simplifyvw(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_simplifyvw(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_snap(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_snap(geom1 public.geometry, geom2 public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_snap(geom1 public.geometry, geom2 public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_snap(geom1 public.geometry, geom2 public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_snap(geom1 public.geometry, geom2 public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_snaptogrid(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_snaptogrid(public.geometry, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_snaptogrid(public.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_snaptogrid(geom1 public.geometry, geom2 public.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_snaptogrid(geom1 public.geometry, geom2 public.geometry, double precision, double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_snaptogrid(geom1 public.geometry, geom2 public.geometry, double precision, double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_snaptogrid(geom1 public.geometry, geom2 public.geometry, double precision, double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_snaptogrid(geom1 public.geometry, geom2 public.geometry, double precision, double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_split(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_split(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_split(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_split(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_split(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_square(size double precision, cell_i integer, cell_j integer, origin public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_square(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_square(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_square(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_square(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO service_role;


--
-- Name: FUNCTION st_squaregrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_squaregrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO postgres;
GRANT ALL ON FUNCTION public.st_squaregrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO anon;
GRANT ALL ON FUNCTION public.st_squaregrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_squaregrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO service_role;


--
-- Name: FUNCTION st_srid(geog public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_srid(geog public.geography) TO postgres;
GRANT ALL ON FUNCTION public.st_srid(geog public.geography) TO anon;
GRANT ALL ON FUNCTION public.st_srid(geog public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.st_srid(geog public.geography) TO service_role;


--
-- Name: FUNCTION st_srid(geom public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_srid(geom public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_srid(geom public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_srid(geom public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_srid(geom public.geometry) TO service_role;


--
-- Name: FUNCTION st_startpoint(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_startpoint(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_startpoint(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_startpoint(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_startpoint(public.geometry) TO service_role;


--
-- Name: FUNCTION st_subdivide(geom public.geometry, maxvertices integer, gridsize double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_subdivide(geom public.geometry, maxvertices integer, gridsize double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_subdivide(geom public.geometry, maxvertices integer, gridsize double precision) TO anon;
GRANT ALL ON FUNCTION public.st_subdivide(geom public.geometry, maxvertices integer, gridsize double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_subdivide(geom public.geometry, maxvertices integer, gridsize double precision) TO service_role;


--
-- Name: FUNCTION st_summary(public.geography); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_summary(public.geography) TO postgres;
GRANT ALL ON FUNCTION public.st_summary(public.geography) TO anon;
GRANT ALL ON FUNCTION public.st_summary(public.geography) TO authenticated;
GRANT ALL ON FUNCTION public.st_summary(public.geography) TO service_role;


--
-- Name: FUNCTION st_summary(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_summary(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_summary(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_summary(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_summary(public.geometry) TO service_role;


--
-- Name: FUNCTION st_swapordinates(geom public.geometry, ords cstring); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_swapordinates(geom public.geometry, ords cstring) TO postgres;
GRANT ALL ON FUNCTION public.st_swapordinates(geom public.geometry, ords cstring) TO anon;
GRANT ALL ON FUNCTION public.st_swapordinates(geom public.geometry, ords cstring) TO authenticated;
GRANT ALL ON FUNCTION public.st_swapordinates(geom public.geometry, ords cstring) TO service_role;


--
-- Name: FUNCTION st_symdifference(geom1 public.geometry, geom2 public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_symdifference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_symdifference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO anon;
GRANT ALL ON FUNCTION public.st_symdifference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_symdifference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO service_role;


--
-- Name: FUNCTION st_symmetricdifference(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_symmetricdifference(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_symmetricdifference(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_symmetricdifference(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_symmetricdifference(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_tileenvelope(zoom integer, x integer, y integer, bounds public.geometry, margin double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_tileenvelope(zoom integer, x integer, y integer, bounds public.geometry, margin double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_tileenvelope(zoom integer, x integer, y integer, bounds public.geometry, margin double precision) TO anon;
GRANT ALL ON FUNCTION public.st_tileenvelope(zoom integer, x integer, y integer, bounds public.geometry, margin double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_tileenvelope(zoom integer, x integer, y integer, bounds public.geometry, margin double precision) TO service_role;


--
-- Name: FUNCTION st_touches(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_touches(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_touches(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_touches(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_touches(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_transform(public.geometry, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_transform(public.geometry, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_transform(public.geometry, integer) TO anon;
GRANT ALL ON FUNCTION public.st_transform(public.geometry, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_transform(public.geometry, integer) TO service_role;


--
-- Name: FUNCTION st_transform(geom public.geometry, to_proj text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, to_proj text) TO postgres;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, to_proj text) TO anon;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, to_proj text) TO authenticated;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, to_proj text) TO service_role;


--
-- Name: FUNCTION st_transform(geom public.geometry, from_proj text, to_srid integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_srid integer) TO postgres;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_srid integer) TO anon;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_srid integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_srid integer) TO service_role;


--
-- Name: FUNCTION st_transform(geom public.geometry, from_proj text, to_proj text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_proj text) TO postgres;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_proj text) TO anon;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_proj text) TO authenticated;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_proj text) TO service_role;


--
-- Name: FUNCTION st_translate(public.geometry, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_translate(public.geometry, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_transscale(public.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_transscale(public.geometry, double precision, double precision, double precision, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_transscale(public.geometry, double precision, double precision, double precision, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_transscale(public.geometry, double precision, double precision, double precision, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_transscale(public.geometry, double precision, double precision, double precision, double precision) TO service_role;


--
-- Name: FUNCTION st_triangulatepolygon(g1 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_triangulatepolygon(g1 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_triangulatepolygon(g1 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_triangulatepolygon(g1 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_triangulatepolygon(g1 public.geometry) TO service_role;


--
-- Name: FUNCTION st_unaryunion(public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_unaryunion(public.geometry, gridsize double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_unaryunion(public.geometry, gridsize double precision) TO anon;
GRANT ALL ON FUNCTION public.st_unaryunion(public.geometry, gridsize double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_unaryunion(public.geometry, gridsize double precision) TO service_role;


--
-- Name: FUNCTION st_union(public.geometry[]); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_union(public.geometry[]) TO postgres;
GRANT ALL ON FUNCTION public.st_union(public.geometry[]) TO anon;
GRANT ALL ON FUNCTION public.st_union(public.geometry[]) TO authenticated;
GRANT ALL ON FUNCTION public.st_union(public.geometry[]) TO service_role;


--
-- Name: FUNCTION st_union(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_union(geom1 public.geometry, geom2 public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO anon;
GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO service_role;


--
-- Name: FUNCTION st_voronoilines(g1 public.geometry, tolerance double precision, extend_to public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_voronoilines(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_voronoilines(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_voronoilines(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_voronoilines(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO service_role;


--
-- Name: FUNCTION st_voronoipolygons(g1 public.geometry, tolerance double precision, extend_to public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_voronoipolygons(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_voronoipolygons(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_voronoipolygons(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_voronoipolygons(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO service_role;


--
-- Name: FUNCTION st_within(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_within(geom1 public.geometry, geom2 public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_within(geom1 public.geometry, geom2 public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_within(geom1 public.geometry, geom2 public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_within(geom1 public.geometry, geom2 public.geometry) TO service_role;


--
-- Name: FUNCTION st_wkbtosql(wkb bytea); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_wkbtosql(wkb bytea) TO postgres;
GRANT ALL ON FUNCTION public.st_wkbtosql(wkb bytea) TO anon;
GRANT ALL ON FUNCTION public.st_wkbtosql(wkb bytea) TO authenticated;
GRANT ALL ON FUNCTION public.st_wkbtosql(wkb bytea) TO service_role;


--
-- Name: FUNCTION st_wkttosql(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_wkttosql(text) TO postgres;
GRANT ALL ON FUNCTION public.st_wkttosql(text) TO anon;
GRANT ALL ON FUNCTION public.st_wkttosql(text) TO authenticated;
GRANT ALL ON FUNCTION public.st_wkttosql(text) TO service_role;


--
-- Name: FUNCTION st_wrapx(geom public.geometry, wrap double precision, move double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_wrapx(geom public.geometry, wrap double precision, move double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_wrapx(geom public.geometry, wrap double precision, move double precision) TO anon;
GRANT ALL ON FUNCTION public.st_wrapx(geom public.geometry, wrap double precision, move double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_wrapx(geom public.geometry, wrap double precision, move double precision) TO service_role;


--
-- Name: FUNCTION st_x(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_x(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_x(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_x(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_x(public.geometry) TO service_role;


--
-- Name: FUNCTION st_xmax(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_xmax(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.st_xmax(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.st_xmax(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.st_xmax(public.box3d) TO service_role;


--
-- Name: FUNCTION st_xmin(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_xmin(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.st_xmin(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.st_xmin(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.st_xmin(public.box3d) TO service_role;


--
-- Name: FUNCTION st_y(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_y(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_y(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_y(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_y(public.geometry) TO service_role;


--
-- Name: FUNCTION st_ymax(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_ymax(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.st_ymax(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.st_ymax(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.st_ymax(public.box3d) TO service_role;


--
-- Name: FUNCTION st_ymin(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_ymin(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.st_ymin(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.st_ymin(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.st_ymin(public.box3d) TO service_role;


--
-- Name: FUNCTION st_z(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_z(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_z(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_z(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_z(public.geometry) TO service_role;


--
-- Name: FUNCTION st_zmax(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_zmax(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.st_zmax(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.st_zmax(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.st_zmax(public.box3d) TO service_role;


--
-- Name: FUNCTION st_zmflag(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_zmflag(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_zmflag(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_zmflag(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_zmflag(public.geometry) TO service_role;


--
-- Name: FUNCTION st_zmin(public.box3d); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_zmin(public.box3d) TO postgres;
GRANT ALL ON FUNCTION public.st_zmin(public.box3d) TO anon;
GRANT ALL ON FUNCTION public.st_zmin(public.box3d) TO authenticated;
GRANT ALL ON FUNCTION public.st_zmin(public.box3d) TO service_role;


--
-- Name: FUNCTION unlockrows(text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.unlockrows(text) TO postgres;
GRANT ALL ON FUNCTION public.unlockrows(text) TO anon;
GRANT ALL ON FUNCTION public.unlockrows(text) TO authenticated;
GRANT ALL ON FUNCTION public.unlockrows(text) TO service_role;


--
-- Name: FUNCTION update_booking_status(booking_id uuid, new_status character varying, notes text, user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_booking_status(booking_id uuid, new_status character varying, notes text, user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.update_booking_status(booking_id uuid, new_status character varying, notes text, user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.update_booking_status(booking_id uuid, new_status character varying, notes text, user_id uuid) TO service_role;


--
-- Name: FUNCTION update_hero_rating(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_hero_rating() TO anon;
GRANT ALL ON FUNCTION public.update_hero_rating() TO authenticated;
GRANT ALL ON FUNCTION public.update_hero_rating() TO service_role;


--
-- Name: FUNCTION update_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at() TO service_role;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO service_role;


--
-- Name: FUNCTION updategeometrysrid(character varying, character varying, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, integer) TO postgres;
GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, integer) TO anon;
GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, integer) TO authenticated;
GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, integer) TO service_role;


--
-- Name: FUNCTION updategeometrysrid(character varying, character varying, character varying, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, character varying, integer) TO postgres;
GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, character varying, integer) TO anon;
GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, character varying, integer) TO authenticated;
GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, character varying, integer) TO service_role;


--
-- Name: FUNCTION updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) TO postgres;
GRANT ALL ON FUNCTION public.updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) TO anon;
GRANT ALL ON FUNCTION public.updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) TO authenticated;
GRANT ALL ON FUNCTION public.updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION http_request(); Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

REVOKE ALL ON FUNCTION supabase_functions.http_request() FROM PUBLIC;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO postgres;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO anon;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO authenticated;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO service_role;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;
RESET SESSION AUTHORIZATION;


--
-- Name: FUNCTION st_3dextent(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_3dextent(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_3dextent(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_3dextent(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_3dextent(public.geometry) TO service_role;


--
-- Name: FUNCTION st_asflatgeobuf(anyelement); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement) TO postgres;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement) TO anon;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement) TO authenticated;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement) TO service_role;


--
-- Name: FUNCTION st_asflatgeobuf(anyelement, boolean); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean) TO postgres;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean) TO anon;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean) TO service_role;


--
-- Name: FUNCTION st_asflatgeobuf(anyelement, boolean, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean, text) TO postgres;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean, text) TO anon;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean, text) TO service_role;


--
-- Name: FUNCTION st_asgeobuf(anyelement); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement) TO postgres;
GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement) TO anon;
GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement) TO service_role;


--
-- Name: FUNCTION st_asgeobuf(anyelement, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement, text) TO postgres;
GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement, text) TO anon;
GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement, text) TO service_role;


--
-- Name: FUNCTION st_asmvt(anyelement); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asmvt(anyelement) TO postgres;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement) TO anon;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement) TO authenticated;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement) TO service_role;


--
-- Name: FUNCTION st_asmvt(anyelement, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text) TO postgres;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text) TO anon;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text) TO service_role;


--
-- Name: FUNCTION st_asmvt(anyelement, text, integer); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer) TO postgres;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer) TO anon;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer) TO authenticated;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer) TO service_role;


--
-- Name: FUNCTION st_asmvt(anyelement, text, integer, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text) TO postgres;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text) TO anon;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text) TO service_role;


--
-- Name: FUNCTION st_asmvt(anyelement, text, integer, text, text); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text, text) TO postgres;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text, text) TO anon;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text, text) TO authenticated;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text, text) TO service_role;


--
-- Name: FUNCTION st_clusterintersecting(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry) TO service_role;


--
-- Name: FUNCTION st_clusterwithin(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry, double precision) TO service_role;


--
-- Name: FUNCTION st_collect(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_collect(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_collect(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_collect(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_collect(public.geometry) TO service_role;


--
-- Name: FUNCTION st_extent(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_extent(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_extent(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_extent(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_extent(public.geometry) TO service_role;


--
-- Name: FUNCTION st_makeline(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_makeline(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_makeline(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_makeline(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_makeline(public.geometry) TO service_role;


--
-- Name: FUNCTION st_memcollect(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_memcollect(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_memcollect(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_memcollect(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_memcollect(public.geometry) TO service_role;


--
-- Name: FUNCTION st_memunion(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_memunion(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_memunion(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_memunion(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_memunion(public.geometry) TO service_role;


--
-- Name: FUNCTION st_polygonize(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_polygonize(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_polygonize(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_polygonize(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_polygonize(public.geometry) TO service_role;


--
-- Name: FUNCTION st_union(public.geometry); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_union(public.geometry) TO postgres;
GRANT ALL ON FUNCTION public.st_union(public.geometry) TO anon;
GRANT ALL ON FUNCTION public.st_union(public.geometry) TO authenticated;
GRANT ALL ON FUNCTION public.st_union(public.geometry) TO service_role;


--
-- Name: FUNCTION st_union(public.geometry, double precision); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.st_union(public.geometry, double precision) TO postgres;
GRANT ALL ON FUNCTION public.st_union(public.geometry, double precision) TO anon;
GRANT ALL ON FUNCTION public.st_union(public.geometry, double precision) TO authenticated;
GRANT ALL ON FUNCTION public.st_union(public.geometry, double precision) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.flow_state TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.identities TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.instances TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.saml_providers TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.sessions TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.sso_domains TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.sso_providers TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT ON TABLE auth.users TO dashboard_user;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;


--
-- Name: TABLE add_ons; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.add_ons TO anon;
GRANT ALL ON TABLE public.add_ons TO authenticated;
GRANT ALL ON TABLE public.add_ons TO service_role;


--
-- Name: TABLE addresses; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.addresses TO anon;
GRANT ALL ON TABLE public.addresses TO authenticated;
GRANT ALL ON TABLE public.addresses TO service_role;


--
-- Name: TABLE booking_add_ons; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.booking_add_ons TO anon;
GRANT ALL ON TABLE public.booking_add_ons TO authenticated;
GRANT ALL ON TABLE public.booking_add_ons TO service_role;


--
-- Name: TABLE booking_events; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.booking_events TO anon;
GRANT ALL ON TABLE public.booking_events TO authenticated;
GRANT ALL ON TABLE public.booking_events TO service_role;


--
-- Name: TABLE booking_status_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.booking_status_history TO anon;
GRANT ALL ON TABLE public.booking_status_history TO authenticated;
GRANT ALL ON TABLE public.booking_status_history TO service_role;


--
-- Name: TABLE bookings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.bookings TO anon;
GRANT ALL ON TABLE public.bookings TO authenticated;
GRANT ALL ON TABLE public.bookings TO service_role;


--
-- Name: TABLE contractors; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.contractors TO anon;
GRANT ALL ON TABLE public.contractors TO authenticated;
GRANT ALL ON TABLE public.contractors TO service_role;


--
-- Name: TABLE cs_notes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cs_notes TO anon;
GRANT ALL ON TABLE public.cs_notes TO authenticated;
GRANT ALL ON TABLE public.cs_notes TO service_role;


--
-- Name: TABLE gps_pings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.gps_pings TO anon;
GRANT ALL ON TABLE public.gps_pings TO authenticated;
GRANT ALL ON TABLE public.gps_pings TO service_role;


--
-- Name: TABLE hero_availability; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hero_availability TO anon;
GRANT ALL ON TABLE public.hero_availability TO authenticated;
GRANT ALL ON TABLE public.hero_availability TO service_role;


--
-- Name: TABLE hero_service_areas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hero_service_areas TO anon;
GRANT ALL ON TABLE public.hero_service_areas TO authenticated;
GRANT ALL ON TABLE public.hero_service_areas TO service_role;


--
-- Name: TABLE hero_services; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hero_services TO anon;
GRANT ALL ON TABLE public.hero_services TO authenticated;
GRANT ALL ON TABLE public.hero_services TO service_role;


--
-- Name: TABLE heros; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.heros TO anon;
GRANT ALL ON TABLE public.heros TO authenticated;
GRANT ALL ON TABLE public.heros TO service_role;


--
-- Name: TABLE heroes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.heroes TO anon;
GRANT ALL ON TABLE public.heroes TO authenticated;
GRANT ALL ON TABLE public.heroes TO service_role;


--
-- Name: TABLE payments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payments TO anon;
GRANT ALL ON TABLE public.payments TO authenticated;
GRANT ALL ON TABLE public.payments TO service_role;


--
-- Name: TABLE payouts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payouts TO anon;
GRANT ALL ON TABLE public.payouts TO authenticated;
GRANT ALL ON TABLE public.payouts TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: TABLE promo_codes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.promo_codes TO anon;
GRANT ALL ON TABLE public.promo_codes TO authenticated;
GRANT ALL ON TABLE public.promo_codes TO service_role;


--
-- Name: TABLE promos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.promos TO anon;
GRANT ALL ON TABLE public.promos TO authenticated;
GRANT ALL ON TABLE public.promos TO service_role;


--
-- Name: TABLE reviews; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reviews TO anon;
GRANT ALL ON TABLE public.reviews TO authenticated;
GRANT ALL ON TABLE public.reviews TO service_role;


--
-- Name: TABLE service_variants; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.service_variants TO anon;
GRANT ALL ON TABLE public.service_variants TO authenticated;
GRANT ALL ON TABLE public.service_variants TO service_role;


--
-- Name: TABLE services; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.services TO anon;
GRANT ALL ON TABLE public.services TO authenticated;
GRANT ALL ON TABLE public.services TO service_role;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2025_09_27; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_09_27 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_09_27 TO dashboard_user;


--
-- Name: TABLE messages_2025_09_28; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_09_28 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_09_28 TO dashboard_user;


--
-- Name: TABLE messages_2025_09_29; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_09_29 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_09_29 TO dashboard_user;


--
-- Name: TABLE messages_2025_09_30; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_09_30 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_09_30 TO dashboard_user;


--
-- Name: TABLE messages_2025_10_01; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_10_01 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_10_01 TO dashboard_user;


--
-- Name: TABLE messages_2025_10_02; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_10_02 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_10_02 TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON TABLE storage.buckets TO anon;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON TABLE storage.buckets TO authenticated;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON TABLE storage.buckets TO service_role;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE iceberg_namespaces; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.iceberg_namespaces TO service_role;
GRANT SELECT ON TABLE storage.iceberg_namespaces TO authenticated;
GRANT SELECT ON TABLE storage.iceberg_namespaces TO anon;


--
-- Name: TABLE iceberg_tables; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.iceberg_tables TO service_role;
GRANT SELECT ON TABLE storage.iceberg_tables TO authenticated;
GRANT SELECT ON TABLE storage.iceberg_tables TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON TABLE storage.objects TO anon;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON TABLE storage.objects TO authenticated;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON TABLE storage.objects TO service_role;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.prefixes TO service_role;
GRANT ALL ON TABLE storage.prefixes TO authenticated;
GRANT ALL ON TABLE storage.prefixes TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE hooks; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.hooks TO postgres;
GRANT ALL ON TABLE supabase_functions.hooks TO anon;
GRANT ALL ON TABLE supabase_functions.hooks TO authenticated;
GRANT ALL ON TABLE supabase_functions.hooks TO service_role;


--
-- Name: SEQUENCE hooks_id_seq; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO postgres;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO anon;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO authenticated;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO service_role;


--
-- Name: TABLE migrations; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.migrations TO postgres;
GRANT ALL ON TABLE supabase_functions.migrations TO anon;
GRANT ALL ON TABLE supabase_functions.migrations TO authenticated;
GRANT ALL ON TABLE supabase_functions.migrations TO service_role;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;
RESET SESSION AUTHORIZATION;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;
SET SESSION AUTHORIZATION postgres;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;
RESET SESSION AUTHORIZATION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

