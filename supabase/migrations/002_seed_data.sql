-- Supabase Migration: Seed Initial Data
-- Run this after 001_create_tables.sql

-- ============================================
-- Seed: quotes
-- ============================================
INSERT INTO quotes (text, author, is_favorite) VALUES
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
  ('The journey of a thousand miles begins with a single step.', 'Lao Tzu', false)
ON CONFLICT DO NOTHING;

-- ============================================
-- Seed: sounds
-- ============================================
INSERT INTO sounds (name, icon, asset_path, is_premium) VALUES
  ('Rain', 'water_drop', 'assets/sounds/rain.mp3', false),
  ('Ocean Waves', 'waves', 'assets/sounds/ocean.mp3', false),
  ('Forest', 'forest', 'assets/sounds/forest.mp3', false),
  ('Fireplace', 'local_fire_department', 'assets/sounds/fireplace.mp3', false),
  ('White Noise', 'graphic_eq', 'assets/sounds/white_noise.mp3', false),
  ('Birds', 'flutter_dash', 'assets/sounds/birds.mp3', false),
  ('Thunder', 'thunderstorm', 'assets/sounds/thunder.mp3', true),
  ('Wind', 'air', 'assets/sounds/wind.mp3', true),
  ('Night', 'nightlight', 'assets/sounds/night.mp3', true),
  ('Stream', 'water', 'assets/sounds/stream.mp3', true)
ON CONFLICT DO NOTHING;
