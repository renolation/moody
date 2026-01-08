-- ============================================
-- MOOD HOLDER APP - COMPLETE DATABASE SETUP
-- ============================================
-- Copy and paste this entire script into Supabase SQL Editor:
-- https://supabase.com/dashboard/project/blhtrhpejkintvxxmfrq/sql
-- ============================================

-- ============================================
-- 1. CREATE TABLES
-- ============================================

-- Table: moods
CREATE TABLE IF NOT EXISTS moods (
  id BIGSERIAL PRIMARY KEY,
  score INTEGER NOT NULL CHECK (score >= 1 AND score <= 5),
  note TEXT,
  tags TEXT[] DEFAULT '{}',
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_moods_timestamp ON moods(timestamp DESC);

-- Table: activities
CREATE TABLE IF NOT EXISTS activities (
  id BIGSERIAL PRIMARY KEY,
  type TEXT NOT NULL,
  duration INTEGER NOT NULL,
  intensity INTEGER DEFAULT 2 CHECK (intensity >= 1 AND intensity <= 5),
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_activities_timestamp ON activities(timestamp DESC);

-- Table: gratitude
CREATE TABLE IF NOT EXISTS gratitude (
  id BIGSERIAL PRIMARY KEY,
  items TEXT[] NOT NULL,
  date DATE NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_gratitude_date ON gratitude(date DESC);

-- Table: quotes (using camelCase to match app model)
CREATE TABLE IF NOT EXISTS quotes (
  id BIGSERIAL PRIMARY KEY,
  text TEXT NOT NULL,
  author TEXT,
  "isFavorite" BOOLEAN DEFAULT FALSE
);

-- Table: sounds (using camelCase to match app model)
CREATE TABLE IF NOT EXISTS sounds (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  icon TEXT NOT NULL,
  "assetPath" TEXT NOT NULL,
  "isPremium" BOOLEAN DEFAULT FALSE
);

-- Table: settings (using camelCase to match app model)
CREATE TABLE IF NOT EXISTS settings (
  id BIGSERIAL PRIMARY KEY,
  "userName" TEXT DEFAULT 'Alex',
  "userEmail" TEXT,
  "isVip" BOOLEAN DEFAULT FALSE,
  "healthSyncEnabled" BOOLEAN DEFAULT FALSE,
  "dailyQuoteHour" INTEGER DEFAULT 8,
  "dailyQuoteMinute" INTEGER DEFAULT 0,
  "moodReminderHour" INTEGER DEFAULT 21,
  "moodReminderMinute" INTEGER DEFAULT 0,
  theme TEXT DEFAULT 'dark'
);

-- Table: users (for optional cloud sync)
-- Users only need to login if they want to sync data across devices
-- App works fully offline by default without user accounts
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  "avatarUrl" TEXT,
  "createdAt" TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- ============================================
-- 2. ENABLE ROW LEVEL SECURITY
-- ============================================

ALTER TABLE moods ENABLE ROW LEVEL SECURITY;
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE gratitude ENABLE ROW LEVEL SECURITY;
ALTER TABLE quotes ENABLE ROW LEVEL SECURITY;
ALTER TABLE sounds ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- ============================================
-- 3. RLS POLICIES (Anonymous access for dev)
-- ============================================

-- Moods
CREATE POLICY "moods_select" ON moods FOR SELECT USING (true);
CREATE POLICY "moods_insert" ON moods FOR INSERT WITH CHECK (true);
CREATE POLICY "moods_update" ON moods FOR UPDATE USING (true);
CREATE POLICY "moods_delete" ON moods FOR DELETE USING (true);

-- Activities
CREATE POLICY "activities_select" ON activities FOR SELECT USING (true);
CREATE POLICY "activities_insert" ON activities FOR INSERT WITH CHECK (true);
CREATE POLICY "activities_update" ON activities FOR UPDATE USING (true);
CREATE POLICY "activities_delete" ON activities FOR DELETE USING (true);

-- Gratitude
CREATE POLICY "gratitude_select" ON gratitude FOR SELECT USING (true);
CREATE POLICY "gratitude_insert" ON gratitude FOR INSERT WITH CHECK (true);
CREATE POLICY "gratitude_update" ON gratitude FOR UPDATE USING (true);
CREATE POLICY "gratitude_delete" ON gratitude FOR DELETE USING (true);

-- Quotes
CREATE POLICY "quotes_select" ON quotes FOR SELECT USING (true);
CREATE POLICY "quotes_insert" ON quotes FOR INSERT WITH CHECK (true);
CREATE POLICY "quotes_update" ON quotes FOR UPDATE USING (true);

-- Sounds
CREATE POLICY "sounds_select" ON sounds FOR SELECT USING (true);
CREATE POLICY "sounds_insert" ON sounds FOR INSERT WITH CHECK (true);

-- Settings
CREATE POLICY "settings_select" ON settings FOR SELECT USING (true);
CREATE POLICY "settings_insert" ON settings FOR INSERT WITH CHECK (true);
CREATE POLICY "settings_update" ON settings FOR UPDATE USING (true);
CREATE POLICY "settings_delete" ON settings FOR DELETE USING (true);

-- Users
CREATE POLICY "users_select" ON users FOR SELECT USING (true);
CREATE POLICY "users_insert" ON users FOR INSERT WITH CHECK (true);
CREATE POLICY "users_update" ON users FOR UPDATE USING (true);
CREATE POLICY "users_delete" ON users FOR DELETE USING (true);

-- ============================================
-- 4. SEED DATA
-- ============================================

-- Seed: quotes
INSERT INTO quotes (text, author, "isFavorite") VALUES
  ('The present moment is filled with joy and happiness. If you are attentive, you will see it.', 'Thich Nhat Hanh', false),
  ('Peace comes from within. Do not seek it without.', 'Buddha', false),
  ('Feelings are just visitors, let them come and go.', 'Mooji', false),
  ('Within you, there is a stillness and a sanctuary to which you can retreat at any time.', 'Hermann Hesse', false),
  ('Breathe. Let go. And remind yourself that this very moment is the only one you know you have for sure.', 'Oprah Winfrey', false),
  ('The greatest weapon against stress is our ability to choose one thought over another.', 'William James', false),
  ('Almost everything will work again if you unplug it for a few minutes, including you.', 'Anne Lamott', false),
  ('You don''t have to control your thoughts. You just have to stop letting them control you.', 'Dan Millman', false),
  ('The mind is everything. What you think you become.', 'Buddha', false),
  ('Happiness is not something ready made. It comes from your own actions.', 'Dalai Lama', false),
  ('Be where you are, not where you think you should be.', 'Unknown', false),
  ('Your calm mind is the ultimate weapon against your challenges.', 'Bryant McGill', false),
  ('In the middle of difficulty lies opportunity.', 'Albert Einstein', false),
  ('The only way to do great work is to love what you do.', 'Steve Jobs', false),
  ('Every day may not be good, but there is something good in every day.', 'Alice Morse Earle', false),
  ('You are never too old to set another goal or to dream a new dream.', 'C.S. Lewis', false),
  ('The best time to plant a tree was 20 years ago. The second best time is now.', 'Chinese Proverb', false),
  ('Self-care is not selfish. You cannot serve from an empty vessel.', 'Eleanor Brown', false),
  ('What lies behind us and what lies before us are tiny matters compared to what lies within us.', 'Ralph Waldo Emerson', false),
  ('The journey of a thousand miles begins with a single step.', 'Lao Tzu', false);

-- Seed: sounds
INSERT INTO sounds (name, icon, "assetPath", "isPremium") VALUES
  ('Rain', 'water_drop', 'assets/sounds/rain.mp3', false),
  ('Ocean Waves', 'waves', 'assets/sounds/ocean.mp3', false),
  ('Forest', 'forest', 'assets/sounds/forest.mp3', false),
  ('Fireplace', 'local_fire_department', 'assets/sounds/fireplace.mp3', false),
  ('White Noise', 'graphic_eq', 'assets/sounds/white_noise.mp3', false),
  ('Birds', 'flutter_dash', 'assets/sounds/birds.mp3', false),
  ('Thunder', 'thunderstorm', 'assets/sounds/thunder.mp3', true),
  ('Wind', 'air', 'assets/sounds/wind.mp3', true),
  ('Night', 'nightlight', 'assets/sounds/night.mp3', true),
  ('Stream', 'water', 'assets/sounds/stream.mp3', true);

-- ============================================
-- SETUP COMPLETE!
-- ============================================
-- Verify by running: SELECT * FROM quotes;
-- ============================================
