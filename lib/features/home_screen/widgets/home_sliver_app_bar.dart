import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/core/network/api_endpoints.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/controller/home_screen_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Utilites/app_assets/assets.dart';
import '../tabs/home_tab/widgets/top_bar_widget.dart';


class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
    this.isFilter=false
  });
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 300.h,
      toolbarHeight: 110.h,
      floating: true,
      automaticallyImplyLeading: false,
      flexibleSpace: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          final cubit = context.read<HomeScreenCubit>();
          final sliderBanners = cubit.sliderBanners;

          return Stack(
            fit: StackFit.expand,
            children: [
              if (sliderBanners.isNotEmpty)
                CarouselSlider.builder(
                  itemCount: sliderBanners.length,
                  itemBuilder: (context, index, realIndex) {
                    final banner = sliderBanners[index];
                    return CachedNetworkImage(
                      imageUrl: APIEndpoints.domain + banner.imageUrl,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade300,
                        width: double.infinity,
                        height: 300.h,
                      ),
                      errorWidget: (context, url, error) => SizedBox.expand(
                        child: Container(
                          color: Colors.grey.shade300,
                          width: double.infinity,
                          height: 300.h,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 350.h,
                    viewportFraction: 1.0,
                    padEnds: false,

                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                    const Duration(milliseconds: 800),
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              else if (state is HomeBannersLoading)
                Skeletonizer(
                  enabled: true,
                  child: Container(
                    color: Colors.grey.shade300,
                    width: double.infinity,
                    height: 300.h,
                  ),
                )
              else
                Image.asset(Assets.homeBG, fit: BoxFit.fill),

              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Container(
                      height: kToolbarHeight,
                      alignment: Alignment.center,
                      child: const TopBarWidget(),
                    ),
                  ),
                ),
              ),
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
    );
  }
}