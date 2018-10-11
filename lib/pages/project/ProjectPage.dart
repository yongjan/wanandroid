import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/model/project/ProjectClassifyItemModel.dart';
import 'package:wanandroid/model/project/ProjectClassifyModel.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/widget/EmptyHolder.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  List<ProjectClassifyItemModel> _list = List();
  var _maxCachePageNums = 5;
  var _cachedPageNum = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadClassifysDelay(100);
  }

  @override
  Widget build(BuildContext context) {
    if (_list.length <= 0) {
      return EmptyHolder();
    }
    return DefaultTabController(
      length: _list.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TabBar(
            labelColor: GlobalConfig.colorPrimary,
            isScrollable: true,
            unselectedLabelColor: Colors.black45,
            indicatorColor: GlobalConfig.colorPrimary,
            tabs: _buildTabs(),
          ),
          Expanded(
            child: TabBarView(children: _buildPages()),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    return _list?.map(_buildSingleTab)?.toList();
  }

  Widget _buildSingleTab(ProjectClassifyItemModel bean) {
    return Tab(
      text: bean?.name,
    );
  }

  Widget _buildSinglePage(ProjectClassifyItemModel bean) {
    return ItemListPage(
      keepAlive: _keepAlive(),
      request: (page) {
        return CommonService().getProjectListData((bean.url == null)
            ? ("${Api.PROJECT_LIST}$page/json?cid=${bean.id}")
            : ("${bean.url}$page/json"));
      },
    );
  }

  bool _keepAlive() {
    if (_cachedPageNum < _maxCachePageNums) {
      _cachedPageNum++;
      return true;
    } else {
      return false;
    }
  }

  List<Widget> _buildPages() {
    return _list?.map(_buildSinglePage)?.toList();
  }

  void _loadClassifysDelay(int delays) async {
    Future.delayed(
      Duration(milliseconds: delays),
    ).then((_) {
      _loadClassifys();
    });
  }

  void _loadClassifys() async {
    CommonService().getProjectClassify((ProjectClassifyModel _bean) {
      if (_bean.data.length > 0) {
        setState(() {
          _loadNewestProjects();
          _bean.data.forEach((_projectClassifyItemModel) {
            _list.add(_projectClassifyItemModel);
          });
        });
      }
    });
  }

  void _loadNewestProjects() {
    _list.insert(
        0, ProjectClassifyItemModel(name: "最新项目", url: Api.PROJECT_NEWEST));
  }
}
