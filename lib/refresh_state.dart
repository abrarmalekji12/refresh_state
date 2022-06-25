library refresh_state;

import 'package:flutter/material.dart';

final Map<String, List<_RefreshController>> _refresherMap = {};

/// Refresher provides optional builder and listener for the widget.
class Refresher<T> extends StatefulWidget {
  const Refresher(
      {Key? key,
      this.initialData,
      this.initialState,
      required this.id,
      this.builder,
      this.child,
      this.listener})
      : super(key: key);

  /// [id] use to differentiate refreshers, and will be used when we want to refresh.
  final String id;

  /// Initial data of the refresher.
  final T? initialData;

  /// Initial state of the refresher.
  final Enum? initialState;

  /// Builder for the refresher, if not provided then need to provide [child].
  final Widget Function(BuildContext, Enum?, T?)? builder;

  /// Child if [builder] is not provided.
  final Widget? child;

  /// [listener] for the refresher, it is optional
  final void Function(Enum?, T?)? listener;

  @override
  State<Refresher<T>> createState() => _RefresherState<T>();
}

class _RefresherState<T> extends State<Refresher<T>> {
  /// [state] is the state of the refresher.
  Enum? state;

  /// [data] is the data of the refresher.
  T? data;
  final _RefreshController<T> _refreshController = _RefreshController<T>();

  @override
  void initState() {
    super.initState();
    assert(widget.child != null || widget.builder != null);
    assert(widget.child == null || widget.builder == null);
    _refreshController.data = widget.initialData;
    _refreshController.state = widget.initialState;
    if (_refresherMap[widget.id] != null) {
      _refresherMap[widget.id]?.add(_refreshController);
    } else {
      _refresherMap[widget.id] = [_refreshController];
    }
    _refreshController.addListener(() {
      widget.listener?.call(_refreshController.state!, _refreshController.data);
    });
  }

  @override
  void dispose() {
    _refresherMap[widget.id]?.remove(_refreshController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null) {
      return AnimatedBuilder(
          animation: _refreshController,
          builder: (context, child) {
            return widget.builder!.call(
                context, _refreshController.state, _refreshController.data);
          });
    }
    return widget.child!;
  }
}

/// [refresh] is a function that will trigger builder and listener of the refresher.
void refresh<T>(String id, Enum? Function(Enum?) state,
    {T? Function(T?)? data}) {
  final refresherList = _refresherMap[id];
  assert(refresherList != null);
  for (final refresher in refresherList!) {
    refresher.refresh(state.call(refresher.state),
        data != null ? data.call(refresher.data) : refresher.data);
  }
}

class _RefreshController<T> extends ChangeNotifier {
  Enum? state;
  T? data;

  void refresh(Enum? state, T? data) {
    if (state != this.state || data != this.data) {
      this.state = state;
      this.data = data;
      notifyListeners();
    }
  }
}
