
![earthquake 2](https://github.com/AbdelrahmanShehab/Quake/assets/36604938/6a4f58bf-535b-4a0c-b6fd-a0fb272c99eb)

# Quake App

## Introduction

Introducing **Quake App** - a module that guides you through the development of earthquake data. This app queries and presents earthquake data in an easy-to-navigate interface.

## Screenshot
<div style="display: flex; justify-content: space-between; margin: 20px;">
  <img src="https://github.com/AbdelrahmanShehab/Quake/assets/36604938/4e94c658-e7f5-48b6-88e4-2c41555ebfea" alt="quake_image1" style="width: 45%;">
  <img src="https://github.com/AbdelrahmanShehab/Quake/assets/36604938/a8e60833-16ad-4bdf-b693-3413aadce2fd" alt="quake_image2" style="width: 45%;">
</div>

## Key Features

- **Earthquakes List:** Display a navigation view containing all the earthquakes in the feed, including information such as magnitude, location, and time.
- **Individual Earthquake Deletion:** Users can delete individual earthquakes to customize their earthquake feed.
- **Reload Functionality:** Tapping the Reload button refreshes the feed and reloads earthquake data.
- **Earthquake Detail:** Explore detailed information about each earthquake, including a map of the region surrounding the event.

## Challenges Overcome

In the development of Quake App, I faced and overcame several challenges:

- **Network Client:** Developed a robust network client to download and decode data from a real-world data source.
- **Decoupling Network Dependencies:** Decoupled network dependencies from the app's code to enhance testability and simplify development.
- **Concurrency:** Implemented concurrency using Async/Await and Actors to safely and concurrently fetch and cache network data in the background, ensuring a responsive interface.
- **Map View in SwiftUI:** Created a map view in SwiftUI to visually display earthquake data.

## Key Technologies Used

- **SwiftUI:** Leveraged SwiftUI to build a modern and intuitive user interface.
- **MVVM:** Followed the Model-View-ViewModel architectural pattern for a clean and scalable codebase.
- **Concurrency (Async/Await - Actors):** Implemented asynchronous programming and utilized actors for concurrent data fetching.
- **NSCache:** Utilized NSCache for efficient in-memory caching of data.
- **Unit Testing:** Ensured code reliability and maintainability through comprehensive unit testing.

## Getting Started

To get started with Quake App, follow these steps:

1. [Clone the repository](#) to your local machine.
2. Open the project in Xcode.
3. Build and run the app on your preferred simulator or device.

Feel free to explore, customize, and contribute to the project. Your feedback and contributions are highly valued!

## License

This project is licensed under the [MIT License](LICENSE).
