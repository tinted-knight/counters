# Counters

Yet not starter, but not very advanced [Flutter](https://flutter.dev/docs/get-started/install) project. Trying to implement BLoC architecture with the help of [Didier's Boelens](https://www.didierboelens.com/) aproach.

Honestly, not very excited about BLoC. Although it looks and feels pretty consistent, however needs a lot of boilerplate, and Dart as language does not try to `make it easier`. However, any architecture is better than none. `BLoC` serves it purpose, the same as `Dart`.

Not using `Isolates` in this app – there are no heavy computations. Still, a lot of `async/await`.

### Contacts

Telegram: @pinq_punk

Facebook:

LinkedIn:

### Getting Started

No need for any tokens or other setup. Install `Flutter` and compile. Tested on `Android` device. No reason not to work on `iOS` - all used libraries declare compatability 😬

### Design notes

Neumorphism look interesting and fresh, still low contrast is not great. Attempts to add to it more contrast looks too bizzare and extravagantly (for me). So `total neumorphism` is not acceptable (for me (for now)). But in this case I let emotions to dominate over reasons and added some neumorphic design to some elements. It's far from perfect, but look pretty consistent. So, let it be. 

### Code style and architecture notes

Use this `govno-code` as you wish at your own risk. Do not expect to see here `the right way` to do things. Still, if it can help someone to learn a couple of `not to-dos`, I will be satisfied 😉

# Copyrights

### Used images

- [Dog](https://pixabay.com/illustrations/dog-sitting-pet-domestic-brown-5188108/) in TopAppBar by [Jorgeduardo](https://pixabay.com/users/Jorgeduardo-8516248/) from [Pixabay](https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=304402)

- [Sun](https://pixabay.com/vectors/sun-rays-face-stylized-solar-eyes-304402/) image by [Clker-Free-Vector-Images](https://pixabay.com/users/Clker-Free-Vector-Images-3736/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=304402) from [Pixabay](https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=304402)

## Third-party libraries

- [Didier Boelens](https://www.didierboelens.com/) web-site with great articles and `Github` links about `Flutter`. Helped me a lot to understand things. Do not forget that the one's way of tninking and explaining may not be your way. Try to search resources that are comfortable for you.

- [rxdart](https://pub.dev/packages/rxdart). People in community say that there is no necessity to use `rxdart`, having Dart streams. In my case, at the beginning there were some cases of strange behavior of build-in streams, and I ended up sticking with rxdart. 

- [shared_preferences](https://pub.dev/packages/shared_preferences). Library to store a small portions of data in `key-value` pairs.

- [sqflite](https://pub.dev/packages/sqflite). Library to work with `SQLite`.

- [path](https://pub.dev/packages/path). A string-based path manipulation library.

- [intl](https://pub.dev/packages/intl). Library for internationalization and localization by Dart team.

- [charts_flutter](https://pub.dev/packages/charts_flutter). Chart library that is easy to start with and does not look very laggy.

## Notes not to forget

- StackOverflow [answer](https://stackoverflow.com/a/59408336/8460732) about hide on scroll `FloatingActionButton`