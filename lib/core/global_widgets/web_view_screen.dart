import 'package:dristi_open_source/core/base/base_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_global_texts.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/shimmers.dart';
import 'package:dristi_open_source/domain/entities/advertisement_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    this.item,
    this.url,
    super.key,
  });

  final AdvertisementEntity? item;
  final String? url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends BaseStatefulWidget<WebViewScreen> {
  //late WebViewController controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {},
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {
    //         setState(() {
    //           loading = false;
    //         });
    //       },
    //       onWebResourceError: (WebResourceError error) {},
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(widget.url ?? widget.item?.url ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        // Sliver AppBar is not working with webView Package,
        // so here added NeverScrollableScrollPhysics()
        slivers: [
          _buildSliverAppBar(),
          SliverFillRemaining(
            child: _buildWebView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        background: _buildAppBar(),
      ),
      automaticallyImplyLeading: false,
      expandedHeight: AppValues.dimen_70.h,
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: AssetImageView(
          fileName: Assets.backward,
          height: AppValues.dimen_32.r,
          width: AppValues.dimen_32.r,
          color: uiColors.primary,
        ),
        onPressed: () async {
          // if (await controller.canGoBack()) {
          //   controller.goBack();
          // } else if (mounted) {
          //   context.pop();
          // }
        },
      ),
      title: Text(
        widget.item?.title ?? TextConstants.appName,
        style: appTextStyles.primaryNovaSemiBold16,
      ),
      centerTitle: true,
    );
  }

  Widget _buildWebView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // loading
        //     ? buildFullScreenShimmer(context)
        //     : WebViewWidget(
        //         controller: controller,
        //       ),

        buildFullScreenShimmer(context)
      ],
    );
  }
}
