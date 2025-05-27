class ImageResponse {
  bool imageIsPermitted;

  ImageResponse({required this.imageIsPermitted});

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(imageIsPermitted: json["imageIsPermitted"]);
  }
}
