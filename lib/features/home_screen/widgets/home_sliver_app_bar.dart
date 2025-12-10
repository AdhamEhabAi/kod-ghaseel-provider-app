import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/core/network/api_endpoints.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/controller/home_screen_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../tabs/home_tab/widgets/top_bar_widget.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
    this.isFilter = false,
  });

  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 300.h,
        width: double.infinity,
        child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            final cubit = context.read<HomeScreenCubit>();
            final sliderBanners = cubit.sliderBanners;

            return Stack(
              fit: StackFit.expand,
              children: [
                if (sliderBanners.isNotEmpty)
                  Positioned.fill(
                    child: CarouselSlider.builder(
                      itemCount: sliderBanners.length,
                      itemBuilder: (context, index, realIndex) {
                        final banner = sliderBanners[index];
                        return CachedNetworkImage(
                          imageUrl: APIEndpoints.domain + banner.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey.shade300,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade300,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 300.h,
                        viewportFraction: 1.0,
                        padEnds: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                        enableInfiniteScroll: true,
                        scrollDirection: Axis.horizontal,
                        enlargeCenterPage: false,
                        disableCenter: true,
                      ),
                    ),
                  )
                else if (state is HomeBannersLoading)
                  Skeletonizer(
                    enabled: true,
                    child: Container(
                      color: Colors.grey.shade300,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                else
                  Skeletonizer(
                    enabled: true,
                    child: Container(
                      color: Colors.grey.shade300,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),

                // Top bar
                SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: SizedBox(
                        height: kToolbarHeight,
                        child: const Center(
                          child: TopBarWidget(),
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom rounded color
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F4F5),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24.r),
                        topLeft: Radius.circular(24.r),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
