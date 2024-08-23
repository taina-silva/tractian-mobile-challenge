Hey,

This app was developed as part of a challenge from TRACTIAN, which you can view [here](https://github.com/tractian/challenges/tree/main/mobile).

The goal was to create a Tree View Application that displays company assets, organized by locations, assets, and their associated components.

To populate the tree structure with data, a fake API was used, available [here](https://fake-api.tractian.com). The app retrieves data using GET methods to access companies, their locations, and assets.

Additionally, the design of the app was based on the ([Figma](https://www.figma.com/design/IP50SSLkagXsUNWiZj0PjP/%5BCareers%5D-Flutter-Challenge-v2?node-id=0-1&t=ZxowLpXDFvQxdNks-0)) provided in the challenge's README.

It is possible to check a video demonstrating the app opening for each company and selecting a filter [here](https://drive.google.com/file/d/1h5FInsqsG8Z-bMviLQVCTWpHoeaxRzmn/view?usp=sharing).

After successfully completing the challenge and implementing the desired features, it's evident that there are several areas where the application can be further enhanced to improve usability and optimization.

First and foremost, I would focus on developing a more optimized and efficient logic for constructing the tree, currently located in the assets_store.dart file, especially as the data volume increases. Additionally, I would aim to implement more efficient and optimized search methods, particularly when applying text and energy (selection) filters.

Immediately, another improvement I noticed would be the implementation of a caching mechanism for the location and asset data retrieved each time a specific company is accessed. This would prevent repeated and unnecessary API calls, significantly enhancing the application's performance.

I also would focus on refining the design of the constructed tree. Currently, the arrangement of locations, assets, and components isn't as clearly hierarchical as a tree structure should be. While I used ExpansionTile to develop the tree nodes and expand their children where applicable in an understandable way, I believe the visual representation could be noticeably better.

Another point for improvement is the separation of dependency setups managed by GetIt. In the current implementation, all dependency injections are configured in the outermost layer of the application. However, some dependencies are only used in more specific, internal layers and features. According to clean architecture principles, these should not be accessible to other features.

Additionally, the RestClient class, which abstracts external service calls using the Dio package for HTTP requests related to the mock API, could be further developed. The class could be enhanced to better handle errors and exceptions, verify authentication (if such logic is required in the future), and generally encapsulate the behavior of a service that retrieves external data.
