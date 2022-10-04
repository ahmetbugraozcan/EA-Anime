import 'package:flutter/material.dart';

extension ListViewExtension on ListView {
  Widget onLazyLoads(Future<void> Function() onPagingLoad,
      {Widget? itemLoadWidget}) {
    final delegate = childrenDelegate as SliverChildBuilderDelegate;
    final itemCount = delegate.childCount ?? 0;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          onPagingLoad();
        }
        return true;
      },
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == (itemCount - 1))
            itemLoadWidget ?? Center(child: CircularProgressIndicator());
          return delegate.builder(context, index)!;
        },
      ),
    );
  }
}
