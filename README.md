# Project 2 - *Flix*

**Flix** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **13** hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User sees an app icon on the home screen and a styled launch screen.
- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.
- [X] User sees an error message when there's a networking error.
- [X] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.


Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Adding a Grid View to display movies by Genres
2. Allowing Users to mark movies as favourites and adding them to a Collection View

## Video Walkthrough

Here's a walkthrough of implemented user stories:

1. <img src='http://g.recordit.co/AwLxcxBeUP.gif' title='Network Error and Loading' width='' alt='' />

2. <img src='http://g.recordit.co/wAlhaMEDRK.gif' title='Video Walkthrough' width='' alt='' />


GIF created with [Recordit.co](https://recordit.co/).

## Notes

1. I ran accross a problem where I accidentally deleted the UIView layer and had a hard time figuring out how to add it back without affecting all other sub views. (Fixed by copying subviews and pasting it over newly added UIView)
2. Pushing to github created unwanted merge commits. (fixed with rebase or editing the README file from local repo)

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [2020] [Aayush Phuyal]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
