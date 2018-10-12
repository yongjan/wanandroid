import 'package:wanandroid/model/RootModel.dart';
import 'package:wanandroid/model/homebanner/HomeBannerItemModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'HomeBannerModel.g.dart';

@JsonSerializable()
class HomeBannerModel extends RootModel<List<HomeBannerItemModel>> {
  HomeBannerModel(
      List<HomeBannerItemModel> data, int errorcode, String errormsg)
      : super(data, errorcode, errormsg);

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerModelFromJson(json);

  toJson() => _$HomeBannerModelToJson(this);
}
