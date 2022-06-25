# refresh_state

<a href="https://pub.dev/packages/refresh_state"><img src="https://img.shields.io/pub/v/refresh_state.svg?label=refresh_state" alt="refresh_state version"></a>

<a href="https://developer.android.com" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-android-blue">
</a>
<a href="https://developer.apple.com/ios/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-iOS-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Linux-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Mac-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-web-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Windows-blue">
</a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="MIT License"></a>

refresh_state provides state-management solution by eliminating redundant code, helps speed-up the development process

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

### parameters


##### id:
id will be used to identify refresher, multiple Refresher can have same id, but if given then all the Refreshers with same id will be notified

#### initialData:
initialData will be initial-data given in builder.

#### initialState:
initialState will be initial-state given in builder.

#### listener:
listener will be called when refresh is called.

#### builder:
builder will be called when refresh is called.

#### child:
if only want to listen use child instead of builder,
builder and child can not be used together

## Call refresh function with ID from anywhere in the app to notify Refresher.

### refresh
    refresh('abc', (state) {
                  if (state == AppState.blue) {
                    return AppState.red;
                  } else if (state == AppState.red) {
                    return AppState.green;
                  } else {
                    return AppState.blue;
                  }
                });


### parameters

#### id:
id will be used to identify refresher, multiple Refresher can have same id, but if given then all the Refreshers with same id will be notified.

#### state-callback
state-callback will have old-state in argument, and new-state will be returned.

#### data-callback
data-callback will have old-data in argument, and new-data will be returned.


## Guideline for contributors
Contribution towards our repository is always welcome, we request contributors to create a pull request to the develop branch only.

# LICENSE!
refresh_state is [MIT-licensed](https://github.com/abrarmalekji12/refresh_state/blob/master/LICENSE "MIT-licensed").
