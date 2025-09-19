import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_color.dart';
import '../../../core/config/app_layout.dart';
import '../../widget/shared_widgets.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
          height: kToolbarHeight * 0.6,
          child: AppLogo(height: 28),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: PageContainer(
          maxWidth: AppLayout.pageMaxWidthWide,
          padding: AppLayout.pagePaddingTight,
          child: Obx(() {
            final range = controller.selectedRange.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Year range
                Row(
                  children: [
                    Text(
                      '${range.start.toInt()} – ${range.end.toInt()}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          showValueIndicator: ShowValueIndicator.never,
                          trackHeight: 3,
                        ),
                        child: RangeSlider(
                          values: range,
                          min: controller.yearRange.start,
                          max: controller.yearRange.end,
                          divisions:
                              (controller.yearRange.end -
                                      controller.yearRange.start)
                                  .toInt(),
                          labels: RangeLabels(
                            range.start.toInt().toString(),
                            range.end.toInt().toString(),
                          ),
                          onChanged: controller.setRange,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                // Genres chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final g in controller.genres)
                      FilterChip(
                        label: Text(g),
                        selected: controller.selectedGenres.contains(g),
                        onSelected: (_) => controller.toggleGenre(g),
                      ),
                  ],
                ),

                const SizedBox(height: 12),
                // Albums / Artists toggle
                SegmentedButton<String>(
                  segments: [
                    ButtonSegment(value: 'albums', label: Text('Albums')),
                    ButtonSegment(value: 'artists', label: Text('Artists')),
                  ],
                  selected: {controller.mode.value},
                  onSelectionChanged: (s) => controller.setMode(s.first),
                ),

                const SizedBox(height: 12),
                Expanded(
                  child: SectionCard(
                    padding: EdgeInsets.zero,
                    child: ListView.separated(
                      itemCount: 8,
                      separatorBuilder: (_, __) =>
                          Divider(color: t.divider, height: 1),
                      itemBuilder: (context, index) {
                        final isAlbum = controller.mode.value == 'albums';
                        return ListTile(
                          leading: const CircleAvatar(
                            radius: 22,
                            child: Icon(Icons.album_outlined),
                          ),
                          title: Text(isAlbum ? 'Album name' : 'Artist name'),
                          subtitle: Text(
                            isAlbum ? 'Artist • 12 songs' : '1.2M followers',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
