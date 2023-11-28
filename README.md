# Images App (iOS)

### Search & Select Multiple Images
Search for images using the Pixabay API, which gives you access to over 2 million images. Select as many images as you like from the search results.

![Search & select multiple images](/res/multiple/multiple_q_multiple_selected.png)


### Scroll Endlessly
Scroll endlessly without a hitch thanks to automatic content retrieval, asynchronous image loading and caching.

![Scroll endlessly with async image loading and caching](/res/multiple/multiple_q_loading.png)


## View Selected Images in a Slideshow
View the selected images (at least 2) in a slideshow or by scrolling horizontally.

---

1. Designed the UI using Figma
2. Implemented models, decoding strategies and tests to test the decoder
3. Defined the `ImageGridViewController` using storyboard (main view controller with a search bar, collection view, and a toolbar).
4. Implemented the collection view with custom layout and custom content view (for cell registration)
5. Implemented a image loader (with caching)
6. Implemented PixabayClient and HitProvider to provide data
7. Enabled search and infinite scrolling (by fetching pages with scroll...)
8. Implemented selecting and deselecting multiple images in the collection view
8. Implemented toolbar with items that become active only in appropriate situations.
9. Implemented the detail view controller to show all the selected images (view them by scrolling horizontally).
10. Tested the application as a user and fixed a few minor bugs.

---

## Wireframes in Figma
![GridViewController](/res/GridViewController.png)
![DetailViewController](/res/DetailViewController.png)
