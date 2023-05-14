import 'package:flutter/material.dart';

import 'package:sasuki/app/resources/values_manager/app_size.dart';

import 'package:sasuki/app/shared_widgets/get_loading_state_widget.dart';


Widget loadMore<T>({
  required bool loadingMoreItems,
  required bool hidLoadingMoreItems,
  required List<T>? data,
  required BuildContext context,
  required Widget Function(List<T>? data, BuildContext context) singleItem,
}) {
  return loadingMoreItems
      ? Column(
    children: [
      singleItem(data, context),
      const SizedBox(height: AppSize.s20),
      !hidLoadingMoreItems && ((data?.length)! > 8)
          ? getLoadingStateWidget()
          : Container(),
      const SizedBox(height: AppSize.s20),
    ],
  )
      : singleItem(data, context);
}





