import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:tec_pass/models/models.dart';
import 'package:tec_pass/widgets/widgets.dart';

class AccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widgets = [
      PlaceWidget(place: Place(id: 'asdas', name: 'Oficina 401', address: 'Av. Rivadavia 2344', query: 'Av. Rivadavia 2344', floor: '3', accessType: AccessType.walk)),
      PlaceWidget(place: Place(id: 'asdas', name: 'Oficina 510', address: 'Av. Rivadavia 2344', query: 'Av. Rivadavia 2344', floor: '3', accessType: AccessType.car)),
      PlaceWidget(place: Place(id: 'asdas', name: 'Puerta Principal', address: 'Av. Rivadavia 2344', query: 'Av. Rivadavia 2344', floor: '3', accessType: AccessType.bike)),
    ];
    final showcaseWidget = PlaceWidget(
      place: Place(
        id: 'asdas',
        name: 'Puerta Principal',
        address: 'Av. Rivadavia 2344',
        query: 'Av. Rivadavia 2344',
        floor: '3',
        accessType: AccessType.walk,
      ),
      showcase: true,
    );

    final refreshController = RefreshController(initialRefresh: false);

    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(
          refreshingIcon: SizedBox(
            width: 25,
            height: 25,
            child: defaultTargetPlatform == TargetPlatform.iOS ? const CupertinoActivityIndicator() : const CircularProgressIndicator(strokeWidth: 2, color: Colors.grey),
          ),
          idleText: "Suelte para actualizar",
          completeText: "Actualizado",
          releaseText: "Suelte para actualizar",
          canTwoLevelText: "Suelte para entrar al segundo nivel",
          refreshingText: "Actualizando…",
          failedText: "Error al actualizar",
        ),
        controller: refreshController,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          refreshController.refreshCompleted();
        },
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return FadeIn(
              duration: Duration(milliseconds: 500),
              child: index == 0 ? showcaseWidget : widgets[index % 3],
            );
          },
        ),
      ),
    );
  }
}
