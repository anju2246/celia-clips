
-- Episodes table
create table episodes (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  guest_name text,
  duration_seconds float,
  raw_transcript text,
  created_at extensions.timestamptz default now()
);

-- Utterances table
create table utterances (
  id uuid default gen_random_uuid() primary key,
  episode_id uuid references episodes(id) on delete cascade not null,
  speaker text not null, -- "A" (Host) or "B" (Guest)
  text text not null,
  start_time float not null,
  end_time float not null,
  confidence float default 1.0,
  utterance_index int,
  created_at extensions.timestamptz default now()
);

-- Create index for faster transcript retrieval
create index idx_utterances_episode_id on utterances(episode_id);
create index idx_utterances_start_time on utterances(start_time);
