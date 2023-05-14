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


_prepareManagerList(ManagerListDetails? data) {
  // ignore: prefer_is_empty
  if (data?.data?.length == Constants.oneNum ||
      data?.data?.length == Constants.zeroNum) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        Duration(seconds: Constants.oneNum.toInt()),
            () => setState(() => loadFilteredManagers = Constants.falseBool),
      );
    });
  }
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Future.delayed(
      Duration(seconds: Constants.oneNum.toInt()),
          () => setState(() => hidLoadingMoreManagers =
          _managersListViewModel.totalManagers == data?.data?.length),
    );
  });
}



Widget _getManagersList() {
  return StreamBuilder<ManagerListDetails?>(
    stream: _managersListViewModel.outputManagersList,
    builder: (context, snapshot) {
      // _prepareManagerList(snapshot.data);
      // ignore: prefer_is_empty
      if (snapshot.data?.data?.length == Constants.oneNum ||
          snapshot.data?.data?.length == Constants.zeroNum) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(
            Duration(seconds: Constants.oneNum.toInt()),
                () => setState(() => loadFilteredManagers = Constants.falseBool),
          );
        });
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(
          Duration(seconds: Constants.oneNum.toInt()),
              () => setState(() {
            hidLoadingMoreManagers =
                _managersListViewModel.totalManagers == snapshot.data?.data?.length;
          }),
        );
      });

      return !loadFilteredManagers
      // ignore: prefer_is_empty
          ? snapshot.data?.data?.length != Constants.zeroNum
          ? SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        child: loadMore<SingleManagerDetails>(
          loadingMoreItems: loadingMoreManagers,
          hidLoadingMoreItems: hidLoadingMoreManagers,
          context: context,
          singleItem: _singleManager,
          data: snapshot.data?.data,
        ),
      )
          : getEmptyStateWidget(
        context,
            () {
          FocusScope.of(context).unfocus();
          setState(() => loadFilteredManagers = true);
          _managersListViewModel.refreshManagersList();
        },
      )
          : getLoadingStateWidget();
    },
  );
}
