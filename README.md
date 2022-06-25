refresh_state provides state-management solution by eliminating redundant code, helps speed-up the development process.

## Installation
Add refresh_state to your project's pubspec.yaml:

## Refresher provides builder & listener, has id which will be used to refresh the state.

### Refresher
    Refresher<int>(
                id: 'abc',
                initialData: 0,
                initialState: AppState.blue,
                listener: (state, data) {
                  if (kDebugMode) {
                    print('listening $state $data');
                  }
                },
                builder: (context, state, data) {
                  return Center(
                      child: CircleAvatar(
                    radius: 30,
                    backgroundColor: state == AppState.red
                        ? Colors.red
                        : state == AppState.green
                            ? Colors.green
                            : Colors.blue,
                    child: Text(
                      '$data',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ));
                },
              )

### Required parameters

##### id:
id will be used to identify refresher, multiple Refresher can have same id, but if given then all the Refreshers with same id will be notified.

##### _imageBytes:
Image bytes is use to draw image in device and if image not fits in device screen then we manage background color(if you have passed colorForWhiteSpace or else White background) in image cropping screen.

##### _onImageStartLoading:
This is a callback. you have to override and show dialog or etc when image cropping is in loading state.

##### _onImageEndLoading:
This is a callback. you have to override and hide dialog or etc when image cropping is ready to show result in cropping screen.

##### _onImageDoneListener:
This is a callback. you have to override and you will get Uint8List as result.

## Optional parameters

##### ImageRatio:
This property contains ImageRatio value. You can set the initialized aspect ratio when starting the cropper by passing a value of ImageRatio. default value is `ImageRatio.FREE`

##### visibleOtherAspectRatios:
This property contains boolean value. If this properties is true then it shows all other aspect ratios in cropping screen. default value is `true`.

##### squareBorderWidth:
This property contains double value. You can change square border width by passing this value.

##### squareCircleColor:
This property contains Color value. You can change square circle color by passing this value.

#####  defaultTextColor:
This property contains Color value. By passing this property you can set aspect ratios color which are unselected.

##### selectedTextColor:
This property contains Color value. By passing this property you can set aspect ratios color which is selected.

##### colorForWhiteSpace:
This property contains Color value. By passing this property you can set background color, if screen contains blank space.


## Note:
For flutter web, copy worker.js from example folder to the project, else it will not work.
The result returns in Uint8List. so it can be lost later, you are responsible for storing it somewhere permanent (if needed).

## Guideline for contributors
Contribution towards our repository is always welcome, we request contributors to create a pull request to the develop branch only.

## Guideline to report an issue/feature request
It would be great for us if the reporter can share the below things to understand the root cause of the issue.
- Library version
- Code snippet
- Logs if applicable
- Device specification like (Manufacturer, OS version, etc)
- Screenshot/video with steps to reproduce the issue

## Library used
- [Image](https://pub.dev/packages/image "Image")

# LICENSE!
Image Cropper is [MIT-licensed](https://github.com/Mindinventory/image_cropping/blob/master/LICENSE "MIT-licensed").