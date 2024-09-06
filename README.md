Hey,

This app was developed as part of a challenge from TRACTIAN, which you can view [here](https://github.com/tractian/challenges/tree/main/mobile).

The goal was to create a Tree View Application that displays company assets, organized by locations, assets, and their associated components.

To populate the tree structure with data, a fake API was used, available [here](https://fake-api.tractian.com). The app retrieves data using GET methods to access companies, their locations, and assets.

Additionally, the design of the app was based on the ([Figma](https://www.figma.com/design/IP50SSLkagXsUNWiZj0PjP/%5BCareers%5D-Flutter-Challenge-v2?node-id=0-1&t=ZxowLpXDFvQxdNks-0)) provided in the challenge's README.

It is possible to check a video demonstrating the app opening for each company and selecting a filter [here](https://drive.google.com/file/d/1h5FInsqsG8Z-bMviLQVCTWpHoeaxRzmn/view?usp=sharing).

After successfully completing the challenge and implementing the desired features, it's evident that there are several areas where the application can be further enhanced to improve usability and optimization.

First, I would focus on rendering the tree more efficiently. Dynamically and recursively rendering each item's children can lead to layout issues if their height isn’t properly managed, potentially causing performance problems. The root items are rendered dynamically, allowing their children to take up as much space as needed. However, when deeper levels of children create scrollable widgets inside scrollable containers, layout breaks can occur if the height isn’t handled correctly. To mitigate this, I initially used the `shrinkWrap: true` property to size the list according to its children.

I believe this issue could be better resolved by using `SliverList` within another `SliverList`, as it offers more efficient rendering of large lists. However, using this approach requires the children to be slivers, rather than standard widgets, which presents additional challenges for managing the tree structure.
