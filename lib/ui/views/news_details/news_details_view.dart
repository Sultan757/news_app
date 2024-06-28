import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/models/response/get_news_response.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/utils/size_util.dart';
import 'package:stacked/stacked.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import 'news_details_viewmodel.dart';

class NewsDetailsView extends StatelessWidget {
  Data? newsDetails;
  List<String> imgUrl = [];
  List<String>? videoUrl = [];
  final List<String> comments = [];
  String? blogId;

  NewsDetailsView({Key? key, this.newsDetails, this.videoUrl, this.blogId});

  @override
  Widget build(BuildContext context) {
    final argData = ModalRoute.of(context)?.settings.arguments as NewsDetailsViewArguments?;

    if (argData != null) {
      newsDetails = argData.newsDetails;
      videoUrl = argData.newsDetails?.myvideo.map((e) => e.url).toList();
      blogId = argData.blogId;
    }

    newsDetails?.image.forEach((element) {
      imgUrl.add(element.url);
    });

    return ViewModelBuilder<NewsDetailsViewModel>.reactive(
      viewModelBuilder: () => NewsDetailsViewModel(),
      onViewModelReady: (model) => model.onInit(blogId!),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
                onTap: () {
                  NavService.goBack();
                },
                child: const Icon(Icons.arrow_back_ios, color: AppColors.white)),
            backgroundColor: AppColors.black,
            iconTheme: const IconThemeData(color: AppColors.white),
            title: Text(
              'Influto Details',
              style: FontStylesConstant.font18(color: AppColors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.flexibleWidth),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.0.flexibleHeight),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.flexibleWidth),
                          child: Text(
                            '${newsDetails?.heading}',
                            style: FontStylesConstant.font14(
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 750,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: imgUrl.length + (videoUrl?.length ?? 0),
                            itemBuilder: (context, index) {
                              if (index < imgUrl.length) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      child: Container(
                                        height: 160.flexibleHeight,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.network(
                                          imgUrl[index],
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${newsDetails?.title}',
                                      style: FontStylesConstant.font12(
                                          fontWeight: FontWeight.bold, color: AppColors.primaryBlack),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20.flexibleHeight),
                                    Text(
                                      '${newsDetails?.description}',
                                      style: FontStylesConstant.font12(
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              } else {
                                int videoIndex = index - imgUrl.length;
                                return Container(
                                  height: 200.flexibleHeight,
                                  width: MediaQuery.of(context).size.width,
                                  child: ChewieVideoPlayer(url: videoUrl![videoIndex]),
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.thumb_up),
                                    label: Text('Like'),
                                  ),
                                  SizedBox(width: 8),
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.thumb_down),
                                    label: Text('Dislike'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Add New Comment',
                                style: FontStylesConstant.font18(fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
                                controller: viewModel.postCommentController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Type your comment here',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (viewModel.postCommentController.text.isNotEmpty) {
                                      viewModel.isLoading = true;
                                      viewModel.postComment(blogId!);
                                      viewModel.notifyListeners();

                                    }
                                  },
                                  child: viewModel.isLoading ? const Text("Loading") : const Text('Post'),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Showing ${viewModel.commentsList.length} comments',
                                style: FontStylesConstant.font16(),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: viewModel.commentsList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(viewModel.authorList[index], style: FontStylesConstant.font16(fontWeight: FontWeight.w500)),
                                    subtitle: Text(viewModel.commentsList[index]),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class ChewieVideoPlayer extends StatefulWidget {
  final String url;

  const ChewieVideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  _ChewieVideoPlayerState createState() => _ChewieVideoPlayerState();
}

class _ChewieVideoPlayerState extends State<ChewieVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            aspectRatio: _videoPlayerController.value.aspectRatio,
            autoPlay: false,
            looping: false,
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
      }).catchError((error) {
        setState(() {
          _isError = true;
        });
        print('Video initialization error: $error');
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isError
        ? const Center(child: Text('Failed to load video'))
        : _videoPlayerController.value.isInitialized
        ? Chewie(
      controller: _chewieController,
    )
        : const Center(child: CircularProgressIndicator());
  }
}
