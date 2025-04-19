import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_widgets/advertisement_image.dart';
import 'package:dristi_open_source/core/global_widgets/network_error_alert.dart';
import 'package:dristi_open_source/features/districts/widgets/districts_app_bar.dart';
import 'package:dristi_open_source/features/districts/widgets/districts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DistrictsScreen extends ConsumerStatefulWidget {
  const DistrictsScreen({super.key});

  @override
  ConsumerState createState() => _DistrictsScreenState();
}

class _DistrictsScreenState
    extends BaseConsumerStatefulWidget<DistrictsScreen> {
  final TextEditingController _searchFieldController = TextEditingController();

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          DistrictsAppBar(),
          SliverToBoxAdapter(child: NetworkErrorAlert()),
          // _buildAdvertisement(), // For Future Usage
          DistrictsList(),
        ],
      ),
    );
  }

  // For Future Usage
  // ignore: unused_element
  Widget _buildAdvertisement() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppValues.dimen_16.r,
          right: AppValues.dimen_16.r,
          bottom: AppValues.dimen_10.r,
        ),
        child: const AdvertisementImage(),
      ),
    );
  }
}
