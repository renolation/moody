-- Migration: 003_add_users_table.sql
-- Add users table for optional user accounts (cloud sync)

-- =====================================================
-- USERS TABLE
-- =====================================================
-- Stores user profiles for cloud sync functionality
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

-- =====================================================
-- ROW LEVEL SECURITY
-- =====================================================

ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- For now: allow all operations (tighten when adding auth)
CREATE POLICY "users_select" ON users FOR SELECT USING (true);
CREATE POLICY "users_insert" ON users FOR INSERT WITH CHECK (true);
CREATE POLICY "users_update" ON users FOR UPDATE USING (true);
CREATE POLICY "users_delete" ON users FOR DELETE USING (true);
