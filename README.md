# gym_companion

A new Flutter project.

## Features

- Record Exercises: Add exercises that you want to perform during your workouts.
- Number of Repetitions: Set the number of repetitions for each exercise.
- Time Setting: Define the time for each exercise and rest between exercises.
- User-friendly Interface: The app has a simple and intuitive interface, making it easy to add
  exercises and customize workout parameters.

# Server and Data Storage

- This app utilizes a server for data storage, ensuring that your exercise information is securely
  stored and can be accessed across devices.

# Programming Approaches

The Gym Companion app employs the following programming approaches:

- Bloc Pattern: Utilizes the Bloc pattern for managing state and handling user interactions.

- Provider: Implements the Provider package for dependency injection and state management.

- Dependency Injection: Leverages Dependency Injection principles to manage and organize the app's
  components efficiently.

- Repository Pattern: Adopts the Repository pattern to organize data access logic. The repository is
  divided into layers, separating concerns such as data retrieval from different sources (e.g.,
  local database, remote server). This promotes a clean and structured approach to data management.

_# Project Structure:

The Gym Companion app follows a structured architecture, organizing code into distinct layers for
clarity and maintainability. Here's an overview of the primary layers:

- Data Sources:
    1. Local Data Source: Manages local data storage, such as a local database. This layer is
       responsible
       for handling CRUD (Create, Read, Update, Delete) operations on locally stored data.
    2. Remote Data Source: Interacts with a remote server to retrieve or send data. It handles
       communication with the server, ensuring seamless data synchronization between the app and the
       server.
    3. Auth Data Source: Manages authentication-related operations. This data source is responsible
       for handling user authentication, ensuring secure access to the app's features.
    4. SQLite Data Source: Specifically dedicated to SQLite database operations. It handles tasks
       related to local data storage using SQLite, providing a structured and efficient way to store
       and retrieve data on the device.

- Repository:
  The repository layer acts as an abstraction over the data sources, providing a clean API for data
  access to the rest of the application.
  Exercises Repository: Manages the logic for retrieving exercises, handling both local and remote
  data sources. This layer shields the rest of the app from the specifics of data storage and
  retrieval.

- Presentation Layer:
  BLoC (Business Logic Component): Utilizes the Bloc pattern to manage the app's state and
  business
  logic. The BLoC layer handles user interactions, such as adding exercises, setting parameters,
  and
  initiating workouts.
  UI Components: Comprises the user interface components responsible for rendering the app's
  views.
  These components interact with the BLoC layer to reflect changes in the application state.
  By structuring the app into these layers, you achieve a separation of concerns, making each
  layer
  responsible for a specific aspect of the application. This modular approach enhances code
  readability, maintainability, and testability, ensuring a robust and scalable architecture for
  the
  Gym Companion app._

## How to Use

1. Open the Gym Companion app.
2. Add exercises you want to perform during your workouts.
3. Set the number of repetitions and time for each exercise and rest between exercises.
4. Press the "Start" button to begin your workout.
5. Perform the exercises and follow the set parameters.
6. Press the "Stop" button when you finish your workout.

## License

This project is distributed under the MIT License. For more information, please see the `LICENSE`
file.

Thank you for choosing Gym Companion for your fitness training. We wish you success and great
achievements in your fitness journey!
documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
