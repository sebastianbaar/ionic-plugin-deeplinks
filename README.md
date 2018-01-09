ionic-plugin-deeplinks-cc
====
This plugin makes it easy to respond to deeplinks through custom URL schemes on iOS and Android. 

__WITHOUT__: Universal/App Links

## Installation

```bash
cordova plugin add ionic-plugin-deeplinks --variable URL_SCHEME=myapp
```

Fill in the appropriate values as shown below:

 * `URL_SCHEME` - the custom URL scheme you'd like to use for your app. This lets your app respond to links like `myapp://blah`

## Handling Deeplinks in JavaScript

#### Ionic/Angular 2

*note: make sure to call IonicDeeplink from a platform.ready or `deviceready` event*

Using [Ionic Native](https://github.com/ionic-team/ionic-native) (available in 1.2.4 or greater):

```javascript
import { Deeplinks } from 'ionic-native';

Deeplinks.route({
  '/about-us': AboutPage,
  '/universal-links-test': AboutPage,
  '/products/:productId': ProductPage
}).subscribe((match) => {
  // match.$route - the route we matched, which is the matched entry from the arguments to route()
  // match.$args - the args passed in the link
  // match.$link - the full link data
  console.log('Successfully matched route', match);
}, (nomatch) => {
  // nomatch.$link - the full link data
  console.error('Got a deeplink that didn\'t match', nomatch);
});
```

If you're using Ionic 2, there is a convenience method to route automatically (see the simple [Ionic 2 Deeplinks](https://github.com/ionic-team/ionic2-deeplinks-demo/blob/master/app/app.ts) demo for an example):

```javascript
Deeplinks.routeWithNavController(this.navController, {
  '/about-us': AboutPage,
  '/products/:productId': ProductPage
}).subscribe((match) => {
  // match.$route - the route we matched, which is the matched entry from the arguments to route()
  // match.$args - the args passed in the link
  // match.$link - the full link data
  console.log('Successfully matched route', match);
}, (nomatch) => {
  // nomatch.$link - the full link data
  console.error('Got a deeplink that didn\'t match', nomatch);
});

// Note: routeWithNavController returns an observable from Ionic Native so it *must* be subscribed to first in order to trigger.
```
