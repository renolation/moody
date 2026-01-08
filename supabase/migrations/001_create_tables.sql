-- Supabase Migration: Create Tables for Mood Holder App
-- Run this in Supabase SQL Editor: https://supabase.com/dashboard/project/blhtrhpejkintvxxmfrq/sql

-- ============================================
-- Table: moods
-- ============================================
CREATE TABLE IF NOT EXISTS moods (
  id BIGSERIAL PRIMARY KEY,
  score INTEGER NOT NULL CHECK (score >= 1 AND score <= 5),
  note TEXT,
  tags TEXT[] DEFAULT '{}',
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  user_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for faster queries by timestamp
CREATE INDEX IF NOT EXISTS idx_moods_timestamp ON moods(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_moods_user_id ON moods(user_id);

-- ============================================
-- Table: activities
-- ============================================
CREATE TABLE IF NOT EXISTS activities (
  id BIGSERIAL PRIMARY KEY,
  type TEXT NOT NULL,
  duration INTEGER NOT NULL,
  intensity INTEGER DEFAULT 2 CHECK (intensity >= 1 AND intensity <= 5),
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  user_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for faster queries by timestamp
CREATE INDEX IF NOT EXISTS idx_activities_timestamp ON activities(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_activities_user_id ON activities(user_id);

-- ============================================
-- Table: gratitude_entries (renamed from gratitude)
-- ============================================
CREATE TABLE IF NOT EXISTS gratitude (
  id BIGSERIAL PRIMARY KEY,
  items TEXT[] NOT NULL,
  date DATE NOT NULL,
  user_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for faster queries by date
CREATE INDEX IF NOT EXISTS idx_gratitude_date ON gratitude(date DESC);
CREATE INDEX IF NOT EXISTS idx_gratitude_user_id ON gratitude(user_id);

-- ============================================
-- Table: quotes
-- ============================================
CREATE TABLE IF NOT EXISTS quotes (
  id BIGSERIAL PRIMARY KEY,
  text TEXT NOT NULL,
  author TEXT,
  is_favorite BOOLEAN DEFAULT FALSE
);

-- ============================================
-- Table: sounds
-- ============================================
CREATE TABLE IF NOT EXISTS sounds (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  icon TEXT NOT NULL,
  asset_path TEXT NOT NULL,
  is_premium BOOLEAN DEFAULT FALSE
);

-- ============================================
-- Table: settings (user settings)
-- ============================================
CREATE TABLE IF NOT EXISTS settings (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID UNIQUE REFERENCES auth.users(id),
  user_name TEXT DEFAULT 'User',
  user_email TEXT,
  is_vip BOOLEAN DEFAULT FALSE,
  health_sync_enabled BOOLEAN DEFAULT FALSE,
  daily_quote_hour INTEGER DEFAULT 9,
  daily_quote_minute INTEGER DEFAULT 0,
  mood_reminder_hour INTEGER DEFAULT 20,
  mood_reminder_minute INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for user_id
CREATE INDEX IF NOT EXISTS idx_settings_user_id ON settings(user_id);

-- ============================================
-- Table: users (for optional cloud sync)
-- ============================================
-- Users only need to login if they want to sync data across devices
-- App works fully offline by default without user accounts
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  "avatarUrl" TEXT,
  "createdAt" TIMESTAMPTZ DEFAULT NOW()
);

-- Index for email lookups
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- ============================================
-- Row Level Security (RLS) Policies
-- ============================================

-- Enable RLS on all tables
ALTER TABLE moods ENABLE ROW LEVEL SECURITY;
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE gratitude ENABLE ROW LEVEL SECURITY;
ALTER TABLE quotes ENABLE ROW LEVEL SECURITY;
ALTER TABLE sounds ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Temporary: Allow anonymous access for development
-- WARNING: Replace these with proper user-based policies before production!

-- Moods: Allow all operations for now
CREATE POLICY "Allow anonymous read moods" ON moods FOR SELECT USING (true);
CREATE POLICY "Allow anonymous insert moods" ON moods FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow anonymous update moods" ON moods FOR UPDATE USING (true);
CREATE POLICY "Allow anonymous delete moods" ON moods FOR DELETE USING (true);

-- Activities: Allow all operations for now
CREATE POLICY "Allow anonymous read activities" ON activities FOR SELECT USING (true);
CREATE POLICY "Allow anonymous insert activities" ON activities FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow anonymous update activities" ON activities FOR UPDATE USING (true);
CREATE POLICY "Allow anonymous delete activities" ON activities FOR DELETE USING (true);

-- Gratitude: Allow all operations for now
CREATE POLICY "Allow anonymous read gratitude" ON gratitude FOR SELECT USING (true);
CREATE POLICY "Allow anonymous insert gratitude" ON gratitude FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow anonymous update gratitude" ON gratitude FOR UPDATE USING (true);
CREATE POLICY "Allow anonymous delete gratitude" ON gratitude FOR DELETE USING (true);

-- Quotes: Read-only for anonymous, full access for authenticated
CREATE POLICY "Allow anonymous read quotes" ON quotes FOR SELECT USING (true);
CREATE POLICY "Allow anonymous insert quotes" ON quotes FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow anonymous update quotes" ON quotes FOR UPDATE USING (true);

-- Sounds: Read-only for anonymous
CREATE POLICY "Allow anonymous read sounds" ON sounds FOR SELECT USING (true);
CREATE POLICY "Allow anonymous insert sounds" ON sounds FOR INSERT WITH CHECK (true);

-- Settings: Allow all operations for now
CREATE POLICY "Allow anonymous read settings" ON settings FOR SELECT USING (true);
CREATE POLICY "Allow anonymous insert settings" ON settings FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow anonymous update settings" ON settings FOR UPDATE USING (true);
CREATE POLICY "Allow anonymous delete settings" ON settings FOR DELETE USING (true);

-- Users: Allow all operations for now
CREATE POLICY "Allow anonymous read users" ON users FOR SELECT USING (true);
CREATE POLICY "Allow anonymous insert users" ON users FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow anonymous update users" ON users FOR UPDATE USING (true);
CREATE POLICY "Allow anonymous delete users" ON users FOR DELETE USING (true);
