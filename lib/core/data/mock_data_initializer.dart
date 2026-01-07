import '../../features/home/data/datasources/mood_remote_data_source.dart';
import '../../features/home/data/datasources/activity_remote_data_source.dart';
import '../../features/home/data/models/mood_entry_model.dart';
import '../../features/home/data/models/activity_entry_model.dart';
import '../../features/wellness/data/datasources/quote_remote_data_source.dart';
import '../../features/wellness/data/datasources/sound_remote_data_source.dart';
import '../../features/wellness/data/datasources/gratitude_remote_data_source.dart';
import '../../features/wellness/data/models/quote_model.dart';
import '../../features/wellness/data/models/sound_model.dart';
import '../../features/wellness/data/models/gratitude_entry_model.dart';
import '../../features/settings/data/datasources/settings_remote_data_source.dart';
import '../../features/settings/data/models/user_settings_model.dart';

/// Initializes mock data in Hive boxes on first app launch
/// Simulates what a real API would return for a new user
class MockDataInitializer {
  final MoodRemoteDataSource moodDataSource;
  final ActivityRemoteDataSource activityDataSource;
  final QuoteRemoteDataSource quoteDataSource;
  final SoundRemoteDataSource soundDataSource;
  final GratitudeRemoteDataSource gratitudeDataSource;
  final SettingsRemoteDataSource settingsDataSource;

  MockDataInitializer({
    required this.moodDataSource,
    required this.activityDataSource,
    required this.quoteDataSource,
    required this.soundDataSource,
    required this.gratitudeDataSource,
    required this.settingsDataSource,
  });

  Future<void> initialize() async {
    await _initializeSettings();
    await _initializeMoods();
    await _initializeActivities();
    await _initializeGratitude();
    await _initializeQuotes();
    await _initializeSounds();
  }

  Future<void> _initializeSettings() async {
    final settings = UserSettingsModel(
      userName: 'Alex',
      userEmail: 'alex@example.com',
      isVip: false,
      healthSyncEnabled: false,
      dailyQuoteHour: 9,
      dailyQuoteMinute: 0,
      moodReminderHour: 20,
      moodReminderMinute: 0,
    );
    await settingsDataSource.initializeSettings(settings);
  }

  Future<void> _initializeMoods() async {
    final now = DateTime.now();

    // Generate mood entries for the past 14 days
    final moods = <MoodEntryModel>[];
    int id = 1;

    // Today's moods
    moods.add(MoodEntryModel(
      id: id++,
      score: 4,
      note: 'Feeling good after morning meditation',
      timestamp: DateTime(now.year, now.month, now.day, 8, 30),
    ));

    // Yesterday
    final yesterday = now.subtract(const Duration(days: 1));
    moods.add(MoodEntryModel(
      id: id++,
      score: 3,
      note: 'Busy day at work',
      timestamp: DateTime(yesterday.year, yesterday.month, yesterday.day, 12, 0),
    ));
    moods.add(MoodEntryModel(
      id: id++,
      score: 4,
      note: 'Nice evening walk',
      timestamp: DateTime(yesterday.year, yesterday.month, yesterday.day, 19, 30),
    ));

    // 2 days ago
    final twoDaysAgo = now.subtract(const Duration(days: 2));
    moods.add(MoodEntryModel(
      id: id++,
      score: 5,
      note: 'Great workout session!',
      timestamp: DateTime(twoDaysAgo.year, twoDaysAgo.month, twoDaysAgo.day, 7, 0),
    ));
    moods.add(MoodEntryModel(
      id: id++,
      score: 4,
      timestamp: DateTime(twoDaysAgo.year, twoDaysAgo.month, twoDaysAgo.day, 15, 0),
    ));

    // 3 days ago
    final threeDaysAgo = now.subtract(const Duration(days: 3));
    moods.add(MoodEntryModel(
      id: id++,
      score: 2,
      note: 'Stressful meeting',
      timestamp: DateTime(threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 14, 0),
    ));
    moods.add(MoodEntryModel(
      id: id++,
      score: 3,
      note: 'Feeling better after a nap',
      timestamp: DateTime(threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 18, 0),
    ));

    // 4 days ago
    final fourDaysAgo = now.subtract(const Duration(days: 4));
    moods.add(MoodEntryModel(
      id: id++,
      score: 4,
      timestamp: DateTime(fourDaysAgo.year, fourDaysAgo.month, fourDaysAgo.day, 9, 0),
    ));

    // 5 days ago
    final fiveDaysAgo = now.subtract(const Duration(days: 5));
    moods.add(MoodEntryModel(
      id: id++,
      score: 5,
      note: 'Weekend vibes!',
      timestamp: DateTime(fiveDaysAgo.year, fiveDaysAgo.month, fiveDaysAgo.day, 11, 0),
    ));
    moods.add(MoodEntryModel(
      id: id++,
      score: 5,
      note: 'Family dinner',
      timestamp: DateTime(fiveDaysAgo.year, fiveDaysAgo.month, fiveDaysAgo.day, 20, 0),
    ));

    // 6 days ago
    final sixDaysAgo = now.subtract(const Duration(days: 6));
    moods.add(MoodEntryModel(
      id: id++,
      score: 3,
      timestamp: DateTime(sixDaysAgo.year, sixDaysAgo.month, sixDaysAgo.day, 8, 0),
    ));
    moods.add(MoodEntryModel(
      id: id++,
      score: 4,
      note: 'Relaxing Saturday',
      timestamp: DateTime(sixDaysAgo.year, sixDaysAgo.month, sixDaysAgo.day, 16, 0),
    ));

    // 7 days ago
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    moods.add(MoodEntryModel(
      id: id++,
      score: 2,
      note: 'Tired from the week',
      timestamp: DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day, 22, 0),
    ));

    // Older entries for insights
    for (int i = 8; i <= 14; i++) {
      final date = now.subtract(Duration(days: i));
      moods.add(MoodEntryModel(
        id: id++,
        score: (i % 3) + 3, // Varies between 3-5
        timestamp: DateTime(date.year, date.month, date.day, 10, 0),
      ));
    }

    await moodDataSource.initializeMoods(moods);
  }

  Future<void> _initializeActivities() async {
    final now = DateTime.now();
    final activities = <ActivityEntryModel>[];
    int id = 1;

    // Today
    activities.add(ActivityEntryModel(
      id: id++,
      type: 'walking',
      duration: 30,
      timestamp: DateTime(now.year, now.month, now.day, 7, 0),
    ));

    // Yesterday
    final yesterday = now.subtract(const Duration(days: 1));
    activities.add(ActivityEntryModel(
      id: id++,
      type: 'yoga',
      duration: 45,
      timestamp: DateTime(yesterday.year, yesterday.month, yesterday.day, 6, 30),
    ));
    activities.add(ActivityEntryModel(
      id: id++,
      type: 'walking',
      duration: 20,
      timestamp: DateTime(yesterday.year, yesterday.month, yesterday.day, 18, 0),
    ));

    // 2 days ago
    final twoDaysAgo = now.subtract(const Duration(days: 2));
    activities.add(ActivityEntryModel(
      id: id++,
      type: 'running',
      duration: 35,
      timestamp: DateTime(twoDaysAgo.year, twoDaysAgo.month, twoDaysAgo.day, 6, 0),
    ));

    // 3 days ago - rest day

    // 4 days ago
    final fourDaysAgo = now.subtract(const Duration(days: 4));
    activities.add(ActivityEntryModel(
      id: id++,
      type: 'gym',
      duration: 60,
      timestamp: DateTime(fourDaysAgo.year, fourDaysAgo.month, fourDaysAgo.day, 17, 0),
    ));

    // 5 days ago
    final fiveDaysAgo = now.subtract(const Duration(days: 5));
    activities.add(ActivityEntryModel(
      id: id++,
      type: 'cycling',
      duration: 45,
      timestamp: DateTime(fiveDaysAgo.year, fiveDaysAgo.month, fiveDaysAgo.day, 9, 0),
    ));

    // 6 days ago
    final sixDaysAgo = now.subtract(const Duration(days: 6));
    activities.add(ActivityEntryModel(
      id: id++,
      type: 'walking',
      duration: 40,
      timestamp: DateTime(sixDaysAgo.year, sixDaysAgo.month, sixDaysAgo.day, 8, 0),
    ));
    activities.add(ActivityEntryModel(
      id: id++,
      type: 'yoga',
      duration: 30,
      timestamp: DateTime(sixDaysAgo.year, sixDaysAgo.month, sixDaysAgo.day, 19, 0),
    ));

    // 7 days ago
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    activities.add(ActivityEntryModel(
      id: id++,
      type: 'running',
      duration: 25,
      timestamp: DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day, 7, 0),
    ));

    // Older entries
    for (int i = 8; i <= 14; i++) {
      final date = now.subtract(Duration(days: i));
      if (i % 2 == 0) {
        activities.add(ActivityEntryModel(
          id: id++,
          type: ['walking', 'running', 'yoga', 'gym', 'cycling'][i % 5],
          duration: 30 + (i % 3) * 15,
          timestamp: DateTime(date.year, date.month, date.day, 8, 0),
        ));
      }
    }

    await activityDataSource.initializeActivities(activities);
  }

  Future<void> _initializeGratitude() async {
    final now = DateTime.now();
    final entries = <GratitudeEntryModel>[];
    int id = 1;

    // Yesterday
    final yesterday = now.subtract(const Duration(days: 1));
    entries.add(GratitudeEntryModel(
      id: id++,
      items: [
        'A good cup of coffee this morning',
        'My supportive family',
        'Beautiful weather today',
      ],
      date: yesterday,
    ));

    // 3 days ago
    final threeDaysAgo = now.subtract(const Duration(days: 3));
    entries.add(GratitudeEntryModel(
      id: id++,
      items: [
        'Completed an important project',
        'Had lunch with an old friend',
        'My health',
      ],
      date: threeDaysAgo,
    ));

    // 5 days ago
    final fiveDaysAgo = now.subtract(const Duration(days: 5));
    entries.add(GratitudeEntryModel(
      id: id++,
      items: [
        'A relaxing weekend',
        'Good books to read',
        'My cozy home',
      ],
      date: fiveDaysAgo,
    ));

    // 7 days ago
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    entries.add(GratitudeEntryModel(
      id: id++,
      items: [
        'New opportunities at work',
        'My morning routine',
        'Quality time with loved ones',
      ],
      date: sevenDaysAgo,
    ));

    await gratitudeDataSource.initializeEntries(entries);
  }

  Future<void> _initializeQuotes() async {
    final quotes = [
      QuoteModel(
        id: 1,
        text: 'Peace is a journey of a thousand breaths.',
        author: 'Unknown',
      ),
      QuoteModel(
        id: 2,
        text:
            'The present moment is the only moment available to us, and it is the door to all moments.',
        author: 'Thich Nhat Hanh',
      ),
      QuoteModel(
        id: 3,
        text:
            'Almost everything will work again if you unplug it for a few minutes, including you.',
        author: 'Anne Lamott',
      ),
      QuoteModel(
        id: 4,
        text: 'Feelings are just visitors, let them come and go.',
        author: 'Mooji',
      ),
      QuoteModel(
        id: 5,
        text:
            'You don\'t have to control your thoughts. You just have to stop letting them control you.',
        author: 'Dan Millman',
      ),
      QuoteModel(
        id: 6,
        text:
            'The greatest weapon against stress is our ability to choose one thought over another.',
        author: 'William James',
      ),
      QuoteModel(
        id: 7,
        text: 'Be where you are, not where you think you should be.',
        author: 'Unknown',
      ),
      QuoteModel(
        id: 8,
        text:
            'Breathe. Let go. And remind yourself that this very moment is the only one you know you have for sure.',
        author: 'Oprah Winfrey',
      ),
      QuoteModel(
        id: 9,
        text:
            'Within you, there is a stillness and a sanctuary to which you can retreat at any time.',
        author: 'Hermann Hesse',
      ),
      QuoteModel(
        id: 10,
        text: 'The mind is everything. What you think you become.',
        author: 'Buddha',
      ),
      QuoteModel(
        id: 11,
        text:
            'Happiness is not something ready made. It comes from your own actions.',
        author: 'Dalai Lama',
      ),
      QuoteModel(
        id: 12,
        text:
            'In the midst of movement and chaos, keep stillness inside of you.',
        author: 'Deepak Chopra',
      ),
      QuoteModel(
        id: 13,
        text: 'Your calm mind is the ultimate weapon against your challenges.',
        author: 'Bryant McGill',
      ),
      QuoteModel(
        id: 14,
        text:
            'Every morning we are born again. What we do today is what matters most.',
        author: 'Buddha',
      ),
      QuoteModel(
        id: 15,
        text: 'Self-care is not selfish. You cannot serve from an empty vessel.',
        author: 'Eleanor Brown',
      ),
    ];

    await quoteDataSource.initializeQuotes(quotes);
  }

  Future<void> _initializeSounds() async {
    final sounds = [
      SoundModel(
        id: 1,
        name: 'Heavy Rain',
        icon: 'water_drop',
        assetPath: 'assets/sounds/rain.mp3',
        isPremium: false,
      ),
      SoundModel(
        id: 2,
        name: 'Forest Winds',
        icon: 'forest',
        assetPath: 'assets/sounds/forest.mp3',
        isPremium: false,
      ),
      SoundModel(
        id: 3,
        name: 'Midnight Cafe',
        icon: 'coffee',
        assetPath: 'assets/sounds/cafe.mp3',
        isPremium: false,
      ),
      SoundModel(
        id: 4,
        name: 'Ocean Waves',
        icon: 'waves',
        assetPath: 'assets/sounds/ocean.mp3',
        isPremium: true,
      ),
      SoundModel(
        id: 5,
        name: 'Fireplace',
        icon: 'local_fire_department',
        assetPath: 'assets/sounds/fireplace.mp3',
        isPremium: true,
      ),
      SoundModel(
        id: 6,
        name: 'White Noise',
        icon: 'graphic_eq',
        assetPath: 'assets/sounds/whitenoise.mp3',
        isPremium: false,
      ),
    ];

    await soundDataSource.initializeSounds(sounds);
  }
}

/// Call this after Hive boxes are opened
Future<void> initializeMockData() async {
  final moodDataSource = MoodRemoteDataSourceImpl();
  final activityDataSource = ActivityRemoteDataSourceImpl();
  final quoteDataSource = QuoteRemoteDataSourceImpl();
  final soundDataSource = SoundRemoteDataSourceImpl();
  final gratitudeDataSource = GratitudeRemoteDataSourceImpl();
  final settingsDataSource = SettingsRemoteDataSourceImpl();

  final initializer = MockDataInitializer(
    moodDataSource: moodDataSource,
    activityDataSource: activityDataSource,
    quoteDataSource: quoteDataSource,
    soundDataSource: soundDataSource,
    gratitudeDataSource: gratitudeDataSource,
    settingsDataSource: settingsDataSource,
  );

  await initializer.initialize();
}
