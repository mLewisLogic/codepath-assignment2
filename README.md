## Yelp

This is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation).

Time spent: `11`

### Features

#### Required

- [x] Search results page
- [x] Table rows should be dynamic height according to the content height
- [x] Custom cells should have the proper Auto Layout constraints
- [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [X] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
- [ ] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
- [X] The filters table should be organized into sections as in the mock.
- [X] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
- [X] Display some of the available Yelp categories (choose any 3-4 that you want).

#### Optional

- [ ] Infinite scroll for restaurant results
- [ ] Implement map view of restaurant results
- [ ] Radius filter should expand as in the real Yelp app
- [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is here: http://www.yelp.com/developers/documentation/category_list (Links to an external site.)
- [ ] Implement the restaurant detail page.
- [ ] Custom UISwitch on filters page.


Notes:
The filters page is pretty rough and not fully implemented. Pricing information is not displayed because it's not returned by the API. The filters are passed down to the YelpClient, but aren't translated into query params. This is because the API docs didn't provide a mechanism for searching by price or business features, which Yelp's API specifically do not return.

### Walkthrough

![Video Walkthrough](demo.gif)


