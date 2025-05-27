import 'package:aws_rekognition/models/moderation_item.dart';

class ImageResponse {
  bool imageIsPermitted;
  List<ModerationItem> moderationsList;

  ImageResponse({
    required this.imageIsPermitted,
    required this.moderationsList,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(
      imageIsPermitted: json["imageIsPermitted"],
      moderationsList: json["moderationsList"] != null
          ? List<ModerationItem>.from(
              json["moderationsList"].map(
                (item) => ModerationItem.fromJson(item),
              ),
            )
          : [],
    );
  }
}
