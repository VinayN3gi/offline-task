# Task Management App

A full-featured task management application built with Flutter for the frontend and Node.js for the backend, leveraging Drizzle ORM and PostgreSQL for efficient, type-safe database operations. The app includes features like JWT authentication, persistent login, and a clean UI with BLoC state management.

## <a name="table">Table of Contents</a>

1. [Introduction](#introduction)
2. [Tech Stack](#tech-stack)
3. [Features](#features)
4. [Installation](#installation)
5. [Usage](#usage)

## Intro

This task management application allows users to efficiently manage their tasks with a clean and intuitive UI. It provides secure user authentication via JWT and stores user data in a PostgreSQL database using Drizzle ORM for smooth interaction with the backend. The frontend is built using Flutter and follows the BLoC pattern for managing the state.

## <a name="tech-stack">Tech Stack</a>

- **Flutter**: A powerful UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Node.js**: A JavaScript runtime for building fast and scalable backend services.
- **TypeScript**: A typed superset of JavaScript that helps catch errors early and improves the development experience.
- **REST API**: A stateless web service used for communication between the frontend and backend.
- **JWT Authentication**: JSON Web Tokens for secure, stateless authentication.
- **Drizzle ORM**: An ORM designed for type-safe and efficient database interaction with PostgreSQL.
- **PostgreSQL**: A powerful, open-source relational database that handles complex queries and ensures data integrity.
- **BLoC**: A state management pattern in Flutter that separates business logic from UI code for maintainable and testable applications.

## <a name="features">Features</a>

- **Clean and Intuitive UI**: Designed with a user-friendly interface using the BLoC pattern to efficiently manage states and keep the UI responsive.
  
- **Backend Built with Node.js**: The backend is built with Node.js, ensuring scalability and efficiency for handling API requests and database operations.

- **JWT Authentication**: Secure user authentication with JSON Web Tokens (JWT), providing a stateless, secure means of verifying users.

- **Persistent Authentication**: Users stay logged in across sessions by using persistent authentication mechanisms, so they don't have to log in repeatedly.

- **Drizzle ORM Integration**: Utilizes Drizzle ORM to interact with the database, providing type-safe queries and database operations.

- **PostgreSQL Database**: Data is stored in PostgreSQL, a highly reliable relational database with strong ACID compliance, ensuring data integrity and security.

- **Task Management**: Create, update, and delete tasks with ease. Tasks are organized with due dates, priorities, and labels for better tracking.

## <a name="installation">Installation</a>

To set up the project locally, follow these steps:

### Prerequisites

Before starting, make sure you have the following installed on your machine:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Node.js](https://nodejs.org/)
- [PostgreSQL](https://www.postgresql.org/download/)
- [Git](https://git-scm.com/)

### Installation

1. Clone the repository to your local machine:
   
   ```bash
   git clone https://github.com/VinayN3gi/offline-task.git
   cd offline-task```

2. Set up your environment variables:
   Create a .env.local file in the root of the project and add the following content:
   ```env
   PORT=5000  # Change this to the desired port
   CONNECTION_STRING=postgres://user:password@localhost:5432/taskdb  # Adjust for your PostgreSQL setup
   JWT_SECRET=your-jwt-secret  # Secret key for JWT signing```

### Backend Setup(Node.js)
1. Navigate to the backend/ directory:
   ```bash
   cd backend
2. Install dependencies:
   ```bash
   npm install
3. Start the server
   ```bash
   npm run dev


### Frontend Setup(Flutter)
1. Navigate to the frontend/ directory:
   ```bash
   cd frontend
2. Install dependencies
   ```bash
   flutter pub get
3. Run the Flutter app:
   ```bash
   flutter run
   

## <a name="usage">Usage</a>
 - Authentication: Users can register, log in, and maintain persistent login sessions with JWT.

 - Task Management: Add, edit, and delete tasks. Tasks can be categorized by priority and due dates.

 - State Management: The app uses the BLoC pattern for effective state management, ensuring smooth transitions and interactions within the app.
