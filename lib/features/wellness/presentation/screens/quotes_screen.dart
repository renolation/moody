import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/background_gradient.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../providers/wellness_provider.dart';

class QuotesScreen extends ConsumerWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesAsync = ref.watch(quotesProvider);
    final quotes = quotesAsync.valueOrNull ?? [];

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: BackgroundGradient(
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(AppDimensions.screenPaddingH),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.glassBackground,
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.textMuted,
                          size: 18,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Daily Quotes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              // Quotes list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.screenPaddingH,
                  ),
                  itemCount: quotes.length,
                  itemBuilder: (context, index) {
                    final quote = quotes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GlassPanel(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quote.text,
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: AppColors.textPrimary,
                                height: 1.5,
                              ),
                            ),
                            if (quote.author != null) ...[
                              const SizedBox(height: 12),
                              Text(
                                '— ${quote.author}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color:
                                      AppColors.textMuted.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    ref
                                        .read(quotesProvider.notifier)
                                        .toggleFavorite(quote.id);
                                  },
                                  child: Icon(
                                    quote.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: quote.isFavorite
                                        ? AppColors.error
                                        : AppColors.textMuted,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
